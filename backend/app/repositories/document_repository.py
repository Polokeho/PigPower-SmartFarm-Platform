from typing import Optional

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.document import Document


class DocumentRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_by_id(self, document_id) -> Optional[Document]:
        result = await self.db.execute(select(Document).where(Document.id == document_id))
        return result.scalar_one_or_none()

    async def get_by_storage_key(self, storage_key: str) -> Optional[Document]:
        result = await self.db.execute(select(Document).where(Document.storage_key == storage_key))
        return result.scalar_one_or_none()

    async def find_duplicate(
        self, sha256: str, related_farmer_id: Optional[str], related_veterinary_record_id: Optional[str]
    ) -> Optional[Document]:
        """DFM §53 duplicate detection -- same content hash already stored for this entity."""
        query = select(Document).where(Document.sha256 == sha256)
        if related_farmer_id:
            query = query.where(Document.related_farmer_id == related_farmer_id)
        if related_veterinary_record_id:
            query = query.where(Document.related_veterinary_record_id == related_veterinary_record_id)
        result = await self.db.execute(query)
        return result.scalar_one_or_none()

    async def create(self, **fields) -> Document:
        document = Document(**fields)
        self.db.add(document)
        await self.db.flush()
        return document
