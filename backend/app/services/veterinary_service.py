from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.types import AuthenticatedUser
from app.events.event_bus import event_bus
from app.events.event_catalog import AppEvent
from app.repositories.veterinary_repository import VeterinaryRepository
from app.schemas.veterinary import CreateVeterinaryRecordRequest, VeterinaryRecordResponse
from app.services.sequence_service import SequenceService
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException


class VeterinaryService:
    """
    Implements 5.5 §7 Veterinary Module -- the module walked through in
    OSDS §23's "veterinary visit in a no-signal area" end-to-end
    scenario. Records are append-only, same reasoning as Production.
    """

    def __init__(self, db: AsyncSession):
        self.db = db
        self.veterinary = VeterinaryRepository(db)
        self.sequences = SequenceService(db)

    async def schedule(self) -> list[VeterinaryRecordResponse]:
        # Pass 1 simplification: returns recent records. A real
        # "schedule" (upcoming due vaccinations) depends on SACM's
        # configurable vaccination-schedule defaults (SACM §15) --
        # deferred to a later pass alongside the full Veterinary module.
        records = await self.veterinary.list_recent()
        return [self._to_response(r) for r in records]

    async def get_by_id(self, record_id: str) -> VeterinaryRecordResponse:
        record = await self.veterinary.get_by_id(record_id)
        if not record:
            raise AppException(ErrorCode.NOT_FOUND, "Veterinary record not found.")
        return self._to_response(record)

    async def create(self, user: AuthenticatedUser, dto: CreateVeterinaryRecordRequest) -> VeterinaryRecordResponse:
        pig = await self.veterinary.get_pig_by_id(dto.pig_id)
        if not pig:
            # Matches the exact rejection scenario illustrated in 5.5 §9 / OSDS §13
            raise AppException(
                ErrorCode.VALIDATION_FAILED, "Referenced Pig ID does not exist on server.", "pig_id"
            )

        record_number = await self.sequences.next("VeterinaryRecord", "VET")

        record = await self.veterinary.create(
            record_number=record_number,
            pig_id=pig.id,
            farm_id=pig.farm_id,
            type=dto.type,
            vaccine_lookup_value_id=dto.vaccine_type_id,
            administered_at=dto.administered_at,
            administered_by_id=user.user_id,
            notes=dto.notes,
        )

        await event_bus.emit(
            AppEvent.VETERINARY_RECORD_CREATED,
            {
                "record_id": str(record.id),
                "record_number": record.record_number,
                "pig_id": str(record.pig_id),
                "administered_by_id": user.user_id,
            },
        )
        return self._to_response(record)

    @staticmethod
    def _to_response(record) -> VeterinaryRecordResponse:
        return VeterinaryRecordResponse(
            record_id=record.record_number,
            internal_id=str(record.id),
            pig_id=str(record.pig_id),
            type=record.type,
            administered_at=record.administered_at,
            notes=record.notes,
            created_at=record.created_at,
        )
