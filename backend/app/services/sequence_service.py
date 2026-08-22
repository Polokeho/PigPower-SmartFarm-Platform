from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.models.sacm import Sequence


class SequenceService:
    """
    SACM's configurable numbering engine (FR-SACM-015/016). Every
    service that needs an authoritative ID (FMR-000246, PROD-004821,
    VET-004821) calls this rather than inventing its own numbering,
    per BR-SACM-001 (shared reference data, one implementation).

    Uses SELECT ... FOR UPDATE to guarantee unique, non-repeating
    values under concurrent creation (FR-SACM-016) -- the async
    equivalent of the atomic transaction the NestJS version used.
    """

    def __init__(self, db: AsyncSession):
        self.db = db

    async def next(self, entity: str, prefix: str, pad_length: int = 6) -> str:
        result = await self.db.execute(select(Sequence).where(Sequence.entity == entity).with_for_update())
        sequence = result.scalar_one_or_none()

        if sequence is None:
            sequence = Sequence(entity=entity, prefix=prefix, next_value=2, pad_length=pad_length)
            self.db.add(sequence)
            await self.db.flush()
            value = 1
        else:
            value = sequence.next_value
            sequence.next_value += 1
            await self.db.flush()

        return f"{prefix}-{str(value).zfill(pad_length)}"
