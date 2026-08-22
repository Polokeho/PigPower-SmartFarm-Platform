from typing import Optional

from fastapi import APIRouter, Depends, Query, Request
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.dependencies import require_permission
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.schemas.farmer import ChangeFarmerStatusRequest, CreateFarmerRequest, UpdateFarmerRequest
from app.services.farmer_service import FarmerService
from app.utils.responses import success_envelope

router = APIRouter(prefix="/v1/farmers", tags=["farmers"])


@router.get("")
async def list_farmers(
    request: Request,
    cursor: Optional[str] = Query(default=None),
    limit: int = Query(default=20, le=100),
    user: AuthenticatedUser = Depends(require_permission("farmer.view")),
    db: AsyncSession = Depends(get_db),
):
    result = await FarmerService(db).list_farmers(user, cursor, limit)
    return success_envelope(result["items"], request.state.request_id, result["meta"])


@router.get("/{farmer_id}")
async def get_farmer(
    farmer_id: str,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("farmer.view")),
    db: AsyncSession = Depends(get_db),
):
    result = await FarmerService(db).get_by_id(user, farmer_id)
    return success_envelope(result.model_dump(), request.state.request_id)


@router.post("")
async def create_farmer(
    body: CreateFarmerRequest,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("farmer.create")),
    db: AsyncSession = Depends(get_db),
):
    result = await FarmerService(db).create(user, body)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)


@router.patch("/{farmer_id}")
async def update_farmer(
    farmer_id: str,
    body: UpdateFarmerRequest,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("farmer.edit")),
    db: AsyncSession = Depends(get_db),
):
    result = await FarmerService(db).update(user, farmer_id, body)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)


@router.post("/{farmer_id}/status")
async def change_farmer_status(
    farmer_id: str,
    body: ChangeFarmerStatusRequest,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("farmer.approve")),
    db: AsyncSession = Depends(get_db),
):
    result = await FarmerService(db).change_status(user, farmer_id, body)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)
