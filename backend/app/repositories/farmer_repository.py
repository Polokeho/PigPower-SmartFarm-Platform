from typing import Optional

from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.farmer import Farm, Farmer


class FarmerRepository:
    """
    Data access for the Farmer module. Per 5.4 FR-BE-003's equivalent
    principle: only this repository (and the FarmerService that owns
    it) queries the farmer/farm tables directly -- other modules go
    through FarmerService, never straight to these queries.
    """

    def __init__(self, db: AsyncSession):
        self.db = db

    async def get_by_id(self, farmer_id) -> Optional[Farmer]:
        result = await self.db.execute(select(Farmer).where(Farmer.id == farmer_id, Farmer.deleted_at.is_(None)))
        return result.scalar_one_or_none()

    async def list_farmers(
        self, district_lookup_value_id: Optional[str], cursor: Optional[str], limit: int
    ) -> tuple[list[Farmer], bool]:
        query = select(Farmer).where(Farmer.deleted_at.is_(None)).order_by(Farmer.created_at.desc())
        if district_lookup_value_id:
            query = query.where(Farmer.district_lookup_value_id == district_lookup_value_id)
        if cursor:
            # Simple keyset pagination on id for Pass 1 -- sufficient at
            # pilot scale; a created_at+id composite cursor is a
            # straightforward upgrade once ordering edge cases matter.
            query = query.where(Farmer.id > cursor)

        result = await self.db.execute(query.limit(limit + 1))
        rows = list(result.scalars().all())
        has_more = len(rows) > limit
        return (rows[:limit] if has_more else rows), has_more

    async def create(self, **fields) -> Farmer:
        farmer = Farmer(**fields)
        self.db.add(farmer)
        await self.db.flush()
        return farmer

    async def update(self, farmer: Farmer, **fields) -> Farmer:
        for key, value in fields.items():
            if value is not None:
                setattr(farmer, key, value)
        await self.db.flush()
        return farmer

    async def create_farm(self, **fields) -> Farm:
        farm = Farm(**fields)
        self.db.add(farm)
        await self.db.flush()
        return farm

    async def get_farm_by_id(self, farm_id) -> Optional[Farm]:
        result = await self.db.execute(select(Farm).where(Farm.id == farm_id))
        return result.scalar_one_or_none()
