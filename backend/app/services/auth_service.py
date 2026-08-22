import hashlib
import uuid
from datetime import datetime, timedelta, timezone

from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.security import create_access_token, hash_password, verify_password
from app.config import settings
from app.events.event_bus import event_bus
from app.events.event_catalog import AppEvent
from app.repositories.user_repository import UserRepository
from app.schemas.auth import TokenResponse
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException


def _hash_token(token: str) -> str:
    return hashlib.sha256(token.encode()).hexdigest()


class AuthService:
    """
    Implements IAPI §7 for Pass 1:
      - FR-IAPI-010 token-based auth with refresh
      - FR-IAPI-011 device registration
      - FR-IAPI-014 token revocation
    """

    def __init__(self, db: AsyncSession):
        self.db = db
        self.users = UserRepository(db)

    async def login(self, username: str, password: str, device_identifier: str) -> TokenResponse:
        user = await self.users.get_by_username(username)
        if not user or not verify_password(password, user.password_hash):
            raise AppException(ErrorCode.UNAUTHENTICATED, "Invalid username or password.")

        device = await self.users.upsert_device(user.id, device_identifier)
        tokens = await self._issue_token_pair(str(user.id), str(device.id))

        await event_bus.emit(AppEvent.USER_LOGGED_IN, {"user_id": str(user.id), "device_id": str(device.id)})
        return tokens

    async def refresh(self, raw_refresh_token: str) -> TokenResponse:
        token_hash = _hash_token(raw_refresh_token)
        stored = await self.users.get_refresh_token(token_hash)

        now = datetime.now(timezone.utc)
        if not stored or stored.revoked_at or stored.expires_at < now:
            raise AppException(ErrorCode.TOKEN_EXPIRED, "Refresh token is invalid or expired.")

        await self.users.revoke_refresh_token(token_hash)  # rotate
        return await self._issue_token_pair(str(stored.user_id), str(stored.device_id))

    async def logout(self, user_id: str, device_id: str) -> None:
        await self.users.revoke_all_tokens_for_user_device(user_id, device_id)
        await event_bus.emit(AppEvent.USER_LOGGED_OUT, {"user_id": user_id, "device_id": device_id})

    async def logout_all_devices(self, user_id: str) -> None:
        """IAPI FR-IAPI-014 -- lost-device / full revocation scenario."""
        await self.users.revoke_all_tokens_for_user(user_id)

    async def _issue_token_pair(self, user_id: str, device_id: str) -> TokenResponse:
        access_token = create_access_token(user_id, device_id)
        access_expires_at = datetime.now(timezone.utc) + timedelta(minutes=settings.jwt_access_expires_minutes)

        raw_refresh_token = uuid.uuid4().hex + uuid.uuid4().hex
        refresh_expires_at = datetime.now(timezone.utc) + timedelta(days=settings.jwt_refresh_expires_days)

        await self.users.create_refresh_token(
            user_id=user_id,
            device_id=device_id,
            token_hash=_hash_token(raw_refresh_token),
            expires_at=refresh_expires_at,
        )

        return TokenResponse(
            access_token=access_token,
            refresh_token=raw_refresh_token,
            access_token_expires_at=access_expires_at.isoformat(),
        )
