from typing import Optional

from fastapi import APIRouter, Depends, Query, Request
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.dependencies import get_current_user
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.models.farmer import Farmer
from app.models.production import ProductionBatch
from app.models.veterinary import VeterinaryRecord
from app.repositories.lookup_repository import LookupRepository
from app.schemas.sync import SyncBatchRequest
from app.services.farmer_service import FarmerService
from app.services.production_service import ProductionService
from app.services.sync_service import SyncService
from app.utils.responses import success_envelope

router = APIRouter(prefix="/v1/sync", tags=["sync"])


@router.post("/batch")
async def process_batch(
    body: SyncBatchRequest,
    request: Request,
    user: AuthenticatedUser = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    results = await SyncService(db).process_batch(user, body.items)
    await db.commit()
    return success_envelope({"results": [r.model_dump() for r in results]}, request.state.request_id)


@router.get("/changes")
async def changes(
    request: Request,
    since: Optional[str] = Query(default=None),
    entity_types: Optional[str] = Query(default=None),
    user: AuthenticatedUser = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    """
    Incremental/delta pull -- IAPI FR-IAPI-028 / OSDS FR-OSDS-035.
    Pass 1 supports Farmer, ProductionBatch and VeterinaryRecord.
    """
    from datetime import datetime, timezone

    since_dt = datetime.fromisoformat(since) if since else datetime.fromtimestamp(0, tz=timezone.utc)
    types = entity_types.split(",") if entity_types else ["Farmer", "ProductionBatch", "VeterinaryRecord"]

    farmers = []
    if "Farmer" in types:
        result = await db.execute(select(Farmer).where(Farmer.updated_at >= since_dt))
        farmers = [FarmerService._to_response(f).model_dump() for f in result.scalars().all()]

    production = []
    if "ProductionBatch" in types:
        result = await db.execute(select(ProductionBatch).where(ProductionBatch.created_at >= since_dt))
        production = [ProductionService._to_response(b).model_dump() for b in result.scalars().all()]

    veterinary = []
    if "VeterinaryRecord" in types:
        from app.services.veterinary_service import VeterinaryService

        result = await db.execute(select(VeterinaryRecord).where(VeterinaryRecord.created_at >= since_dt))
        veterinary = [VeterinaryService._to_response(v).model_dump() for v in result.scalars().all()]

    return success_envelope(
        {"farmers": farmers, "production_batches": production, "veterinary_records": veterinary}, request.state.request_id
    )


@router.get("/reference-data")
async def reference_data(
    request: Request, user: AuthenticatedUser = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    """OSDS FR-OSDS-005 -- bulk pull of SACM reference/lookup data for local caching."""
    tables = await LookupRepository(db).list_all_tables_with_values()
    data = {
        table.code: [{"code": v.code, "label": v.label, "metadata": v.metadata_json} for v in table.values if v.active]
        for table in tables
    }
    return success_envelope(data, request.state.request_id)
