import base64
import hashlib
import hmac
import time

from app.config import settings
from app.storage.drivers import LocalStorageDriver, StorageDriver
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException


class StorageService:
    """
    The single injectable Storage Service every module uses for file
    access -- 5.3 AD-FS-001. Driver selection comes from configuration
    (STORAGE_DRIVER), never hard-coded -- the same provider-abstraction
    pattern applied to storage as SACM applies to SMS/email providers
    (FR-SACM-030).
    """

    def __init__(self) -> None:
        # Pass 1 only implements the local driver; MinIO/S3-compatible
        # drivers are added here later per 5.3 AD-FS-003's growth path,
        # without any consuming module (Documents, HR, etc.) changing.
        self.driver: StorageDriver = LocalStorageDriver(settings.storage_local_path)

    @staticmethod
    def build_key(category: str, entity_type: str, entity_id: str, document_id: str, file_name: str) -> str:
        """5.3 FR-FS-001 storage key convention."""
        return f"{category}/{entity_type}/{entity_id}/{document_id}_{file_name}"

    async def put(self, key: str, data: bytes) -> str:
        return await self.driver.put(key, data)

    async def get(self, key: str) -> bytes:
        return await self.driver.get(key)

    async def delete(self, key: str) -> None:
        await self.driver.delete(key)

    def issue_signed_download_token(self, key: str) -> tuple[str, int]:
        """5.3 AD-FS-004 -- time-limited, backend-authorized access."""
        expires_at = int(time.time() * 1000) + settings.storage_signed_url_ttl_seconds * 1000
        signature = hmac.new(
            settings.storage_signed_url_secret.encode(), f"{key}:{expires_at}".encode(), hashlib.sha256
        ).hexdigest()
        raw = f"{key}:{expires_at}:{signature}".encode()
        token = base64.urlsafe_b64encode(raw).decode().rstrip("=")
        return token, expires_at

    def verify_signed_download_token(self, token: str) -> str:
        padded = token + "=" * (-len(token) % 4)
        decoded = base64.urlsafe_b64decode(padded).decode()
        key, expires_at_raw, signature = decoded.split(":", 2)
        expires_at = int(expires_at_raw)

        expected_signature = hmac.new(
            settings.storage_signed_url_secret.encode(), f"{key}:{expires_at}".encode(), hashlib.sha256
        ).hexdigest()

        if not hmac.compare_digest(signature, expected_signature) or time.time() * 1000 > expires_at:
            raise AppException(ErrorCode.FORBIDDEN, "Download link is invalid or has expired.")
        return key


storage_service = StorageService()
