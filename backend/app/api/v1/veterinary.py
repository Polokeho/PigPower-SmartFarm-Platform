from fastapi import APIRouter, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.dependencies import require_permission
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.schemas.veterinary import CreateVeterinaryRecordRequest
from app.services.veterinary_service import VeterinaryService
from app.utils.responses import success_envelope

router = APIRouter(prefix="/v1/veterinary", tags=["veterinary"])


@router.get("/schedule")
async def schedule(
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("veterinary.view")),
    db: AsyncSession = Depends(get_db),
):
    records = await VeterinaryService(db).schedule()
    return success_envelope([r.model_dump() for r in records], request.state.request_id)


@router.get("/records/{record_id}")
async def get_record(
    record_id: str,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("veterinary.view")),
    db: AsyncSession = Depends(get_db),
):
    result = await VeterinaryService(db).get_by_id(record_id)
    return success_envelope(result.model_dump(), request.state.request_id)


@router.post("/records")
async def create_record(
    body: CreateVeterinaryRecordRequest,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("veterinary.edit")),
    db: AsyncSession = Depends(get_db),
):
    result = await VeterinaryService(db).create(user, body)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)
