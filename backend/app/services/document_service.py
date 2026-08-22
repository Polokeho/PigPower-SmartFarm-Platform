import hashlib
import uuid
from typing import Optional

from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.types import AuthenticatedUser
from app.events.event_bus import event_bus
from app.events.event_catalog import AppEvent
from app.repositories.document_repository import DocumentRepository
from app.schemas.document import DocumentResponse, DownloadUrlResponse
from app.storage.storage_service import storage_service
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException


class DocumentsService:
    """
    Implements 5.5 §8 Documents Module (core upload/download only --
    the full DFM lifecycle: versioning, approval workflow, retention,
    is deferred to a later pass).
    """

    def __init__(self, db: AsyncSession):
        self.db = db
        self.documents = DocumentRepository(db)

    async def upload(
        self,
        user: AuthenticatedUser,
        document_type: str,
        related_entity_type: Optional[str],
        related_entity_id: Optional[str],
        file_bytes: bytes,
        file_name: str,
        mime_type: str,
    ) -> DocumentResponse:
        document_number = f"DOC-{uuid.uuid4().hex[:8].upper()}"
        sha256 = hashlib.sha256(file_bytes).hexdigest()

        related_farmer_id = related_entity_id if related_entity_type == "Farmer" else None
        related_vet_id = related_entity_id if related_entity_type == "VeterinaryRecord" else None

        duplicate = await self.documents.find_duplicate(sha256, related_farmer_id, related_vet_id)
        if duplicate:
            return self._to_response(duplicate)

        storage_key = storage_service.build_key(
            "documents", related_entity_type or "general", related_entity_id or "unassigned", document_number, file_name
        )
        await storage_service.put(storage_key, file_bytes)

        document = await self.documents.create(
            document_number=document_number,
            document_type=document_type,
            storage_key=storage_key,
            file_name=file_name,
            mime_type=mime_type,
            file_size_bytes=len(file_bytes),
            sha256=sha256,
            uploaded_by_id=user.user_id,
            related_farmer_id=related_farmer_id,
            related_veterinary_record_id=related_vet_id,
        )

        await event_bus.emit(
            AppEvent.DOCUMENT_UPLOADED,
            {"document_id": str(document.id), "document_number": document.document_number, "uploaded_by_id": user.user_id},
        )
        return self._to_response(document)

    async def get_by_id(self, document_id: str) -> DocumentResponse:
        document = await self.documents.get_by_id(document_id)
        if not document:
            raise AppException(ErrorCode.NOT_FOUND, "Document not found.")
        return self._to_response(document)

    async def get_download_url(self, document_id: str) -> DownloadUrlResponse:
        """5.3 AD-FS-004 -- time-limited, backend-authorized access, never a permanent path."""
        document = await self.documents.get_by_id(document_id)
        if not document:
            raise AppException(ErrorCode.NOT_FOUND, "Document not found.")

        token, expires_at = storage_service.issue_signed_download_token(document.storage_key)
        from datetime import datetime, timezone

        return DownloadUrlResponse(
            url=f"/v1/documents/download?token={token}",
            expires_at=datetime.fromtimestamp(expires_at / 1000, tz=timezone.utc).isoformat(),
        )

    async def download_by_token(self, token: str) -> tuple[bytes, str, str]:
        storage_key = storage_service.verify_signed_download_token(token)
        document = await self.documents.get_by_storage_key(storage_key)
        if not document:
            raise AppException(ErrorCode.NOT_FOUND, "Document not found.")

        file_bytes = await storage_service.get(storage_key)
        return file_bytes, document.file_name, document.mime_type

    @staticmethod
    def _to_response(document) -> DocumentResponse:
        return DocumentResponse(
            document_id=document.document_number,
            internal_id=str(document.id),
            document_type=document.document_type,
            file_name=document.file_name,
            mime_type=document.mime_type,
            file_size_bytes=document.file_size_bytes,
            confidentiality_level=document.confidentiality_level,
            uploaded_at=document.uploaded_at,
            status=document.status,
        )
