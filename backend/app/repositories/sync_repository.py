from typing import Optional

from sqlalchemy import select
from sqlalchemy.dialects.postgresql import insert as pg_insert
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.sync import EntityMapping, IdempotencyRecord


class SyncRepository:
    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_idempotency_record(self, idempotency_key: str) -> Optional[IdempotencyRecord]:
        result = await self.db.execute(
            select(IdempotencyRecord).where(IdempotencyRecord.idempotency_key == idempotency_key)
        )
        return result.scalar_one_or_none()

    async def create_idempotency_record(self, **fields) -> IdempotencyRecord:
        record = IdempotencyRecord(**fields)
        self.db.add(record)
        await self.db.flush()
        return record

    async def upsert_entity_mapping(self, entity_type: str, client_id: str, server_id: str, device_id: str) -> None:
        stmt = (
            pg_insert(EntityMapping)
            .values(entity_type=entity_type, client_id=client_id, server_id=server_id, device_id=device_id)
            .on_conflict_do_update(
                index_elements=["entity_type", "client_id", "device_id"],
                set_={"server_id": server_id},
            )
        )
        await self.db.execute(stmt)
