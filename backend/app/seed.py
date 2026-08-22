"""
Minimal seed data for a runnable Pass 1 pilot environment -- mirrors
the NestJS version's seed script exactly (same districts, roles,
permissions, and test users), so behaviour is identical regardless of
which backend implementation is running.

Run with: python -m app.seed  (or: ./venv/bin/python -m app.seed)
"""

import asyncio

from sqlalchemy import select

from app.auth.security import hash_password
from app.database.session import AsyncSessionLocal
from app.models.sacm import LookupTable, LookupValue, Permission, Role, RolePermission
from app.models.user import User, UserRole

PERMISSION_CODES = [
    ("farmer.view", "farmer"),
    ("farmer.create", "farmer"),
    ("farmer.edit", "farmer"),
    ("farmer.approve", "farmer"),
    ("production.view", "production"),
    ("production.edit", "production"),
    ("veterinary.view", "veterinary"),
    ("veterinary.edit", "veterinary"),
    ("document.upload", "document"),
    ("document.view", "document"),
]

ROLE_DEFINITIONS = {
    "SUPER_ADMIN": [code for code, _ in PERMISSION_CODES],
    "FIELD_OFFICER": [
        "farmer.view", "farmer.create", "farmer.edit",
        "production.view", "production.edit",
        "document.upload", "document.view",
    ],
    "VETERINARIAN": ["veterinary.view", "veterinary.edit", "document.upload", "document.view"],
}

TEST_USERS = [
    {"username": "admin", "full_name": "Pilot Administrator", "role": "SUPER_ADMIN", "scope_district": None},
    {"username": "field.officer.berea", "full_name": "Berea Field Officer", "role": "FIELD_OFFICER", "scope_district": "BEREA"},
    {"username": "vet.one", "full_name": "Pilot Veterinarian", "role": "VETERINARIAN", "scope_district": None},
]


async def _get_or_create_lookup_table(db, code: str, label: str) -> LookupTable:
    result = await db.execute(select(LookupTable).where(LookupTable.code == code))
    table = result.scalar_one_or_none()
    if table:
        return table
    table = LookupTable(code=code, label=label)
    db.add(table)
    await db.flush()
    return table


async def _get_or_create_lookup_value(db, table: LookupTable, code: str, label: str) -> None:
    result = await db.execute(
        select(LookupValue).where(LookupValue.lookup_table_id == table.id, LookupValue.code == code)
    )
    if result.scalar_one_or_none():
        return
    db.add(LookupValue(lookup_table_id=table.id, code=code, label=label))


async def seed() -> None:
    async with AsyncSessionLocal() as db:
        district_table = await _get_or_create_lookup_table(db, "district", "District")
        for code, label in [("MASERU", "Maseru"), ("BEREA", "Berea")]:
            await _get_or_create_lookup_value(db, district_table, code, label)

        breed_table = await _get_or_create_lookup_table(db, "pig_breed", "Pig Breed")
        for code, label in [("LARGE_WHITE", "Large White"), ("LANDRACE", "Landrace")]:
            await _get_or_create_lookup_value(db, breed_table, code, label)

        vaccine_table = await _get_or_create_lookup_table(db, "vaccine_type", "Vaccine Type")
        await _get_or_create_lookup_value(db, vaccine_table, "CSF", "Classical Swine Fever Vaccine")

        await db.flush()

        permission_by_code: dict[str, Permission] = {}
        for code, module in PERMISSION_CODES:
            result = await db.execute(select(Permission).where(Permission.code == code))
            permission = result.scalar_one_or_none()
            if not permission:
                permission = Permission(code=code, module=module)
                db.add(permission)
                await db.flush()
            permission_by_code[code] = permission

        role_by_code: dict[str, Role] = {}
        for role_code, perms in ROLE_DEFINITIONS.items():
            result = await db.execute(select(Role).where(Role.code == role_code))
            role = result.scalar_one_or_none()
            if not role:
                role = Role(code=role_code, name=role_code.replace("_", " "))
                db.add(role)
                await db.flush()
            role_by_code[role_code] = role

            for perm_code in perms:
                result = await db.execute(
                    select(RolePermission).where(
                        RolePermission.role_id == role.id, RolePermission.permission_id == permission_by_code[perm_code].id
                    )
                )
                if not result.scalar_one_or_none():
                    db.add(RolePermission(role_id=role.id, permission_id=permission_by_code[perm_code].id))

        password_hash = hash_password("ChangeMe123!")

        for u in TEST_USERS:
            result = await db.execute(select(User).where(User.username == u["username"]))
            user = result.scalar_one_or_none()
            if not user:
                user = User(
                    username=u["username"],
                    password_hash=password_hash,
                    full_name=u["full_name"],
                    scope_district=u["scope_district"],
                )
                db.add(user)
                await db.flush()

            role = role_by_code[u["role"]]
            result = await db.execute(
                select(UserRole).where(UserRole.user_id == user.id, UserRole.role_id == role.id)
            )
            if not result.scalar_one_or_none():
                db.add(UserRole(user_id=user.id, role_id=role.id))

        await db.commit()

    print("Seed complete. Test users (password: ChangeMe123!): admin, field.officer.berea, vet.one")


if __name__ == "__main__":
    asyncio.run(seed())
