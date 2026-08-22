import logging

from pydantic import ValidationError
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.types import AuthenticatedUser
from app.repositories.sync_repository import SyncRepository
from app.schemas.production import CreateProductionBatchRequest
from app.schemas.sync import SyncBatchItem, SyncItemError, SyncItemResult
from app.schemas.veterinary import CreateVeterinaryRecordRequest
from app.services.farmer_service import FarmerService
from app.services.production_service import ProductionService
from app.services.veterinary_service import VeterinaryService
from app.schemas.farmer import CreateFarmerRequest
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException

logger = logging.getLogger("pigpower.sync")


class SyncService:
    """
    Implements 5.5 §9 Sync Module -- the server side of OSDS's offline
    sync architecture, and 5.4 FR-BE-021's "orchestrating calls into
    each relevant owning module's service" design.

    Two safeguards are applied per item, matching OSDS §12:
      1. Idempotency key lookup (OSDS FR-OSDS-022) -- a retried
         submission returns the ORIGINAL result rather than
         reprocessing.
      2. Per-item try/except so one rejected item in a batch does not
         fail the whole batch (5.5 §9's response example shows exactly
         this mixed CONFIRMED/REJECTED outcome).
    """

    def __init__(self, db: AsyncSession):
        self.db = db
        self.sync_repo = SyncRepository(db)
        self.farmer_service = FarmerService(db)
        self.production_service = ProductionService(db)
        self.veterinary_service = VeterinaryService(db)

    async def process_batch(self, user: AuthenticatedUser, items: list[SyncBatchItem]) -> list[SyncItemResult]:
        results: list[SyncItemResult] = []
        # OSDS FR-OSDS-011 -- respect submitted order so a dependent
        # record (e.g. a production batch referencing a farm on a
        # farmer created earlier in the SAME batch) has its parent
        # processed first.
        for item in items:
            results.append(await self._process_item(user, item))
        return results

    async def _process_item(self, user: AuthenticatedUser, item: SyncBatchItem) -> SyncItemResult:
        existing = await self.sync_repo.get_idempotency_record(item.idempotency_key)
        if existing:
            if existing.result_status == "CONFIRMED":
                return SyncItemResult(client_id=item.client_id, status="CONFIRMED", server_id=existing.server_id)
            return SyncItemResult(
                client_id=item.client_id,
                status="REJECTED",
                error=SyncItemError(code=existing.error_code or "VALIDATION_FAILED", message=existing.error_message or "Rejected."),
            )

        # Each item gets its own SAVEPOINT: since all items in a batch
        # share one outer transaction, a failure partway through
        # dispatching one item (e.g. farmer created, then farm creation
        # fails) must not leave partial writes behind, AND must not
        # roll back items that already succeeded earlier in this same
        # batch. begin_nested() gives per-item atomicity within the
        # shared outer transaction.
        savepoint = await self.db.begin_nested()
        try:
            server_id = await self._dispatch(user, item)

            await self.sync_repo.create_idempotency_record(
                idempotency_key=item.idempotency_key, entity_type=item.entity_type, result_status="CONFIRMED", server_id=server_id
            )
            await self.sync_repo.upsert_entity_mapping(item.entity_type, item.client_id, server_id, user.device_id)
            await savepoint.commit()

            return SyncItemResult(client_id=item.client_id, status="CONFIRMED", server_id=server_id)
        except Exception as err:  # noqa: BLE001 -- intentionally broad: any failure becomes a REJECTED item, not a failed batch
            await savepoint.rollback()
            code, message = self._to_error_shape(err)

            # Validation/business-rule rejections are recorded so a
            # retried sync of the same idempotency key returns the same
            # rejection rather than re-running the operation. This
            # write happens in a fresh savepoint-free state since the
            # failed attempt above was just rolled back.
            await self.sync_repo.create_idempotency_record(
                idempotency_key=item.idempotency_key,
                entity_type=item.entity_type,
                result_status="REJECTED",
                error_code=code,
                error_message=message,
            )
            logger.warning("Sync item rejected: %s %s - %s", item.entity_type, item.client_id, message)
            return SyncItemResult(client_id=item.client_id, status="REJECTED", error=SyncItemError(code=code, message=message))

    async def _dispatch(self, user: AuthenticatedUser, item: SyncBatchItem) -> str:
        if item.entity_type == "Farmer":
            dto = self._to_validated_dto(CreateFarmerRequest, item.payload)
            created = await self.farmer_service.create(user, dto)
            return created.farmer_id

        if item.entity_type == "ProductionBatch":
            dto = self._to_validated_dto(CreateProductionBatchRequest, item.payload)
            created = await self.production_service.create(user, dto)
            return created.batch_id

        if item.entity_type == "VeterinaryRecord":
            dto = self._to_validated_dto(CreateVeterinaryRecordRequest, item.payload)
            created = await self.veterinary_service.create(user, dto)
            return created.record_id

        raise AppException(ErrorCode.VALIDATION_FAILED, f"Unsupported entity_type: {item.entity_type}")

    @staticmethod
    def _to_validated_dto(cls, payload: dict):
        try:
            return cls.model_validate(payload)
        except ValidationError as err:
            messages = "; ".join(f"{'.'.join(str(p) for p in e['loc'])}: {e['msg']}" for e in err.errors())
            raise AppException(ErrorCode.VALIDATION_FAILED, messages or "Validation failed.")

    @staticmethod
    def _to_error_shape(err: Exception) -> tuple[str, str]:
        if isinstance(err, AppException):
            return err.code.value, err.message
        logger.exception("Unexpected error processing sync item")
        return ErrorCode.INTERNAL_ERROR.value, "An unexpected error occurred processing this item."
