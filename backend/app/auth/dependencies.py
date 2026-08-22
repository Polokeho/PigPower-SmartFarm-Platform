from fastapi import Depends, Header
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.auth.security import decode_access_token
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.models.sacm import Role, RolePermission
from app.models.user import Device, User, UserRole
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException


async def get_current_user(
    authorization: str = Header(default=""),
    db: AsyncSession = Depends(get_db),
) -> AuthenticatedUser:
    """
    The FastAPI equivalent of NestJS's AuthGuard + JwtStrategy combined
    -- 5.4 FR-BE-004. Applied per-route via Depends() rather than
    globally (FastAPI has no direct global-guard equivalent), so every
    route that needs authentication declares
    `user: AuthenticatedUser = Depends(get_current_user)`.

    Loads the user's CURRENT roles/permissions/scope fresh from the
    database on every request, rather than trusting stale claims baked
    into the token -- so a role change (SACM) or device revocation
    (IAPI FR-IAPI-014) takes effect immediately, matching the NestJS
    JwtStrategy's behaviour exactly.
    """
    if not authorization.startswith("Bearer "):
        raise AppException(ErrorCode.UNAUTHENTICATED, "Missing or malformed Authorization header.")

    token = authorization.removeprefix("Bearer ").strip()
    payload = decode_access_token(token)
    if payload is None:
        raise AppException(ErrorCode.TOKEN_EXPIRED, "Access token is invalid or expired.")

    device_result = await db.execute(select(Device).where(Device.id == payload["device_id"]))
    device = device_result.scalar_one_or_none()
    if device is None or device.revoked_at is not None:
        # IAPI FR-IAPI-014 -- revoked device/token must fail immediately
        raise AppException(ErrorCode.UNAUTHENTICATED, "Device access has been revoked.")

    user_result = await db.execute(
        select(User)
        .where(User.id == payload["sub"], User.active.is_(True), User.deleted_at.is_(None))
        .options(
            selectinload(User.roles)
            .selectinload(UserRole.role)
            .selectinload(Role.permissions)
            .selectinload(RolePermission.permission)
        )
    )
    user = user_result.scalar_one_or_none()
    if user is None:
        raise AppException(ErrorCode.UNAUTHENTICATED, "User not found or inactive.")

    roles = [ur.role.code for ur in user.roles]
    permissions = sorted({rp.permission.code for ur in user.roles for rp in ur.role.permissions})

    # Fire-and-forget-style update -- OSDS FR-OSDS-034 stale device detection
    from datetime import datetime, timezone

    device.last_seen_at = datetime.now(timezone.utc)
    await db.flush()

    return AuthenticatedUser(
        user_id=str(user.id),
        username=user.username,
        device_id=str(device.id),
        roles=roles,
        permissions=permissions,
        scope_district=user.scope_district,
    )


def require_permission(permission: str):
    """
    The FastAPI equivalent of @RequirePermission() + PermissionsGuard
    -- 5.4 FR-BE-005. Used as:
        Depends(require_permission("farmer.create"))
    """

    async def checker(user: AuthenticatedUser = Depends(get_current_user)) -> AuthenticatedUser:
        if permission not in user.permissions:
            raise AppException(ErrorCode.FORBIDDEN, f"Missing required permission: {permission}")
        return user

    return checker
