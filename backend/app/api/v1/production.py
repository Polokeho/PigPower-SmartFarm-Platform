from typing import Optional

from fastapi import APIRouter, Depends, Query, Request
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.dependencies import require_permission
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.schemas.production import CreateProductionBatchRequest
from app.services.production_service import ProductionService
from app.utils.responses import success_envelope

router = APIRouter(prefix="/v1/production/batches", tags=["production"])


@router.get("")
async def list_batches(
    request: Request,
    cursor: Optional[str] = Query(default=None),
    limit: int = Query(default=20, le=100),
    user: AuthenticatedUser = Depends(require_permission("production.view")),
    db: AsyncSession = Depends(get_db),
):
    result = await ProductionService(db).list_batches(cursor, limit)
    return success_envelope(result["items"], request.state.request_id, result["meta"])


@router.get("/{batch_id}")
async def get_batch(
    batch_id: str,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("production.view")),
    db: AsyncSession = Depends(get_db),
):
    result = await ProductionService(db).get_by_id(batch_id)
    return success_envelope(result.model_dump(), request.state.request_id)


@router.post("")
async def create_batch(
    body: CreateProductionBatchRequest,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("production.edit")),
    db: AsyncSession = Depends(get_db),
):
    result = await ProductionService(db).create(user, body)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)


@router.post("/{batch_id}/mark-ready")
async def mark_ready(
    batch_id: str,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("production.edit")),
    db: AsyncSession = Depends(get_db),
):
    result = await ProductionService(db).mark_ready(batch_id)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)
