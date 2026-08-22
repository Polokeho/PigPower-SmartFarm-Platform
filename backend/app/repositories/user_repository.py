from typing import Optional

from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.user import Device, RefreshToken, User


class UserRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_by_username(self, username: str) -> Optional[User]:
        result = await self.db.execute(
            select(User).where(User.username == username, User.active.is_(True), User.deleted_at.is_(None))
        )
        return result.scalar_one_or_none()

    async def get_by_id(self, user_id) -> Optional[User]:
        result = await self.db.execute(select(User).where(User.id == user_id))
        return result.scalar_one_or_none()

    async def update_profile(self, user: User, **fields) -> User:
        for key, value in fields.items():
            if value is not None:
                setattr(user, key, value)
        await self.db.flush()
        return user

    async def upsert_device(self, user_id, device_identifier: str) -> Device:
        result = await self.db.execute(select(Device).where(Device.device_id == device_identifier))
        device = result.scalar_one_or_none()
        if device:
            device.user_id = user_id
            device.revoked_at = None
        else:
            device = Device(user_id=user_id, device_id=device_identifier)
            self.db.add(device)
        await self.db.flush()
        return device

    async def create_refresh_token(self, **fields) -> RefreshToken:
        token = RefreshToken(**fields)
        self.db.add(token)
        await self.db.flush()
        return token

    async def get_refresh_token(self, token_hash: str) -> Optional[RefreshToken]:
        result = await self.db.execute(select(RefreshToken).where(RefreshToken.token_hash == token_hash))
        return result.scalar_one_or_none()

    async def revoke_refresh_token(self, token_hash: str) -> None:
        from datetime import datetime, timezone

        await self.db.execute(
            update(RefreshToken).where(RefreshToken.token_hash == token_hash).values(revoked_at=datetime.now(timezone.utc))
        )

    async def revoke_all_tokens_for_user_device(self, user_id, device_id) -> None:
        from datetime import datetime, timezone

        now = datetime.now(timezone.utc)
        await self.db.execute(
            update(RefreshToken)
            .where(RefreshToken.user_id == user_id, RefreshToken.device_id == device_id, RefreshToken.revoked_at.is_(None))
            .values(revoked_at=now)
        )

    async def revoke_all_tokens_for_user(self, user_id) -> None:
        from datetime import datetime, timezone

        now = datetime.now(timezone.utc)
        await self.db.execute(
            update(RefreshToken).where(RefreshToken.user_id == user_id, RefreshToken.revoked_at.is_(None)).values(revoked_at=now)
        )
        await self.db.execute(
            update(Device).where(Device.user_id == user_id, Device.revoked_at.is_(None)).values(revoked_at=now)
        )
