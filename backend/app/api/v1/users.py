from typing import Optional

from fastapi import APIRouter, Depends, Request
from pydantic import BaseModel, EmailStr
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.dependencies import get_current_user
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.repositories.user_repository import UserRepository
from app.utils.responses import success_envelope

router = APIRouter(prefix="/v1/users", tags=["users"])


class UpdateMeRequest(BaseModel):
    full_name: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[EmailStr] = None


@router.get("/me")
async def get_me(request: Request, user: AuthenticatedUser = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    record = await UserRepository(db).get_by_id(user.user_id)
    return success_envelope(
        {"user_id": str(record.id), "username": record.username, "full_name": record.full_name, "phone": record.phone, "email": record.email},
        request.state.request_id,
    )


@router.patch("/me")
async def update_me(
    body: UpdateMeRequest,
    request: Request,
    user: AuthenticatedUser = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    repo = UserRepository(db)
    record = await repo.get_by_id(user.user_id)
    record = await repo.update_profile(record, full_name=body.full_name, phone=body.phone, email=body.email)
    await db.commit()
    return success_envelope(
        {"user_id": str(record.id), "full_name": record.full_name, "phone": record.phone, "email": record.email},
        request.state.request_id,
    )
