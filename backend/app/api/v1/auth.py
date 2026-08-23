from fastapi import APIRouter, Body, Depends, Request
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.dependencies import get_current_user
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.rate_limit import limiter
from app.schemas.auth import LoginRequest, RefreshRequest
from app.services.auth_service import AuthService
from app.utils.responses import success_envelope

router = APIRouter(prefix="/v1/auth", tags=["auth"])


@router.post("/login")
@limiter.limit("5/minute")
async def login(request: Request, body: LoginRequest = Body(...), db: AsyncSession = Depends(get_db)):
    result = await AuthService(db).login(body.username, body.password, body.device_id)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)


@router.post("/refresh")
async def refresh(body: RefreshRequest, request: Request, db: AsyncSession = Depends(get_db)):
    result = await AuthService(db).refresh(body.refresh_token)
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)


@router.post("/logout")
async def logout(request: Request, user: AuthenticatedUser = Depends(get_current_user), db: AsyncSession = Depends(get_db)):
    await AuthService(db).logout(user.user_id, user.device_id)
    await db.commit()
    return success_envelope(None, request.state.request_id)


@router.post("/logout-all-devices")
async def logout_all_devices(
    request: Request, user: AuthenticatedUser = Depends(get_current_user), db: AsyncSession = Depends(get_db)
):
    await AuthService(db).logout_all_devices(user.user_id)
    await db.commit()
    return success_envelope(None, request.state.request_id)


@router.get("/me")
async def me(request: Request, user: AuthenticatedUser = Depends(get_current_user)):
    return success_envelope(
        {
            "user_id": user.user_id,
            "username": user.username,
            "roles": user.roles,
            "permissions": user.permissions,
            "scope": {"district": user.scope_district},
        },
        request.state.request_id,
    )
