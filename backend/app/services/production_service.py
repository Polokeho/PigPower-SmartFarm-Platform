from typing import Optional

from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.types import AuthenticatedUser
from app.events.event_bus import event_bus
from app.events.event_catalog import AppEvent
from app.repositories.farmer_repository import FarmerRepository
from app.repositories.production_repository import ProductionRepository
from app.schemas.production import CreateProductionBatchRequest, ProductionBatchResponse
from app.services.sequence_service import SequenceService
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException


class ProductionService:
    """
    Implements 5.5 §6 Production Module. Entries are append-only
    (OSDS §11 -- "each entry is a new fact, not a mutation of a prior
    one"), so there is deliberately no update method for a recorded
    entry, only create + mark_ready (a distinct status transition).
    """

    def __init__(self, db: AsyncSession):
        self.db = db
        self.production = ProductionRepository(db)
        self.farmers = FarmerRepository(db)
        self.sequences = SequenceService(db)

    async def list_batches(self, cursor: Optional[str], limit: int = 20):
        rows, has_more = await self.production.list_batches(cursor, limit)
        return {
            "items": [self._to_response(b) for b in rows],
            "meta": {"next_cursor": str(rows[-1].id) if has_more and rows else None, "has_more": has_more},
        }

    async def get_by_id(self, batch_id: str) -> ProductionBatchResponse:
        batch = await self.production.get_by_id(batch_id)
        if not batch:
            raise AppException(ErrorCode.NOT_FOUND, "Production batch not found.")
        return self._to_response(batch)

    async def create(self, user: AuthenticatedUser, dto: CreateProductionBatchRequest) -> ProductionBatchResponse:
        farm = await self.farmers.get_farm_by_id(dto.farm_id)
        if not farm:
            raise AppException(ErrorCode.VALIDATION_FAILED, "Referenced farm does not exist.", "farm_id")

        batch_number = await self.sequences.next("ProductionBatch", "PROD")

        batch = await self.production.create(
            batch_number=batch_number,
            farmer_id=farm.farmer_id,
            farm_id=farm.id,
            pig_ids=dto.pig_ids,
            weight_kg=dto.weight_kg,
            recorded_at=dto.recorded_at,
            recorded_by_id=user.user_id,
            notes=dto.notes,
        )

        await event_bus.emit(
            AppEvent.PRODUCTION_BATCH_RECORDED,
            {"batch_id": str(batch.id), "batch_number": batch.batch_number, "farm_id": str(batch.farm_id)},
        )
        return self._to_response(batch)

    async def mark_ready(self, batch_id: str) -> ProductionBatchResponse:
        batch = await self.production.get_by_id(batch_id)
        if not batch:
            raise AppException(ErrorCode.NOT_FOUND, "Production batch not found.")

        batch = await self.production.update_status(batch, "MARKET_READY")

        # This is the event NCM §11's "Market readiness notification"
        # and 5.1 §10's end-to-end scenario both assume -- emitted once
        # here, a Notification module (added in a later pass) reacts to
        # it without ProductionService needing to know that module exists.
        await event_bus.emit(
            AppEvent.PRODUCTION_BATCH_READY,
            {
                "batch_id": str(batch.id),
                "batch_number": batch.batch_number,
                "farm_id": str(batch.farm_id),
                "farmer_id": str(batch.farmer_id),
            },
        )
        return self._to_response(batch)

    @staticmethod
    def _to_response(batch) -> ProductionBatchResponse:
        return ProductionBatchResponse(
            batch_id=batch.batch_number,
            internal_id=str(batch.id),
            farm_id=str(batch.farm_id),
            pig_ids=list(batch.pig_ids),
            weight_kg=batch.weight_kg,
            recorded_at=batch.recorded_at,
            status=batch.status,
            notes=batch.notes,
            created_at=batch.created_at,
        )
