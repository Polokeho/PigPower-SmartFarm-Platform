from typing import Optional

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.farmer import Pig
from app.models.veterinary import VeterinaryRecord


class VeterinaryRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_pig_by_id(self, pig_id) -> Optional[Pig]:
        result = await self.db.execute(select(Pig).where(Pig.id == pig_id))
        return result.scalar_one_or_none()

    async def get_by_id(self, record_id) -> Optional[VeterinaryRecord]:
        result = await self.db.execute(select(VeterinaryRecord).where(VeterinaryRecord.id == record_id))
        return result.scalar_one_or_none()

    async def list_recent(self, limit: int = 50) -> list[VeterinaryRecord]:
        result = await self.db.execute(
            select(VeterinaryRecord).order_by(VeterinaryRecord.administered_at.desc()).limit(limit)
        )
        return list(result.scalars().all())

    async def create(self, **fields) -> VeterinaryRecord:
        record = VeterinaryRecord(**fields)
        self.db.add(record)
        await self.db.flush()
        return record
