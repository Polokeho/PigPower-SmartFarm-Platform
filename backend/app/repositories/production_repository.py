from typing import Optional

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.production import ProductionBatch


class ProductionRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_by_id(self, batch_id) -> Optional[ProductionBatch]:
        result = await self.db.execute(select(ProductionBatch).where(ProductionBatch.id == batch_id))
        return result.scalar_one_or_none()

    async def list_batches(self, cursor: Optional[str], limit: int) -> tuple[list[ProductionBatch], bool]:
        query = select(ProductionBatch).order_by(ProductionBatch.created_at.desc())
        if cursor:
            query = query.where(ProductionBatch.id > cursor)
        result = await self.db.execute(query.limit(limit + 1))
        rows = list(result.scalars().all())
        has_more = len(rows) > limit
        return (rows[:limit] if has_more else rows), has_more

    async def create(self, **fields) -> ProductionBatch:
        batch = ProductionBatch(**fields)
        self.db.add(batch)
        await self.db.flush()
        return batch

    async def update_status(self, batch: ProductionBatch, status: str) -> ProductionBatch:
        batch.status = status
        await self.db.flush()
        return batch
