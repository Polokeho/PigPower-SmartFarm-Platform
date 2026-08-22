from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.sacm import LookupTable, LookupValue


class LookupRepository:
    """
    Data access for SACM's generic lookup-table engine (FR-SACM-008).
    Shared across modules per BR-SACM-001 -- operational modules read
    reference data from here rather than maintaining their own copies.
    """

    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_value_by_code(self, table_code: str, value_code: str) -> LookupValue | None:
        result = await self.db.execute(
            select(LookupValue)
            .join(LookupTable)
            .where(LookupTable.code == table_code, LookupValue.code == value_code)
        )
        return result.scalar_one_or_none()

    async def get_value_by_id(self, value_id) -> LookupValue | None:
        result = await self.db.execute(select(LookupValue).where(LookupValue.id == value_id))
        return result.scalar_one_or_none()

    async def list_all_tables_with_values(self) -> list[LookupTable]:
        """Backs GET /v1/sync/reference-data -- OSDS FR-OSDS-005."""
        result = await self.db.execute(select(LookupTable).options(selectinload(LookupTable.values)))
        return list(result.scalars().all())
