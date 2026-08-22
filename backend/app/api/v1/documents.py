from typing import Optional

from fastapi import APIRouter, Depends, File, Form, Query, Request, UploadFile
from fastapi.responses import Response
from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.dependencies import require_permission
from app.auth.types import AuthenticatedUser
from app.database.session import get_db
from app.services.document_service import DocumentsService
from app.utils.responses import success_envelope

router = APIRouter(prefix="/v1/documents", tags=["documents"])


@router.post("")
async def upload_document(
    request: Request,
    document_type: str = Form(...),
    related_entity_type: Optional[str] = Form(default=None),
    related_entity_id: Optional[str] = Form(default=None),
    file: UploadFile = File(...),
    user: AuthenticatedUser = Depends(require_permission("document.upload")),
    db: AsyncSession = Depends(get_db),
):
    file_bytes = await file.read()
    result = await DocumentsService(db).upload(
        user, document_type, related_entity_type, related_entity_id, file_bytes, file.filename or "upload", file.content_type or "application/octet-stream"
    )
    await db.commit()
    return success_envelope(result.model_dump(), request.state.request_id)


@router.get("/{document_id}")
async def get_document(
    document_id: str,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("document.view")),
    db: AsyncSession = Depends(get_db),
):
    result = await DocumentsService(db).get_by_id(document_id)
    return success_envelope(result.model_dump(), request.state.request_id)


@router.get("/{document_id}/download-url")
async def get_download_url(
    document_id: str,
    request: Request,
    user: AuthenticatedUser = Depends(require_permission("document.view")),
    db: AsyncSession = Depends(get_db),
):
    result = await DocumentsService(db).get_download_url(document_id)
    return success_envelope(result.model_dump(), request.state.request_id)


@router.get("/download")
async def download(token: str = Query(...), db: AsyncSession = Depends(get_db)):
    """
    Actual byte-serving endpoint the short-lived signed token points
    to. No permission dependency here -- authorization already
    happened when the token was ISSUED (via the guarded
    /download-url endpoint above); the token itself is the
    credential, verified inside the service -- 5.3 AD-FS-004.
    """
    file_bytes, file_name, mime_type = await DocumentsService(db).download_by_token(token)
    return Response(
        content=file_bytes, media_type=mime_type, headers={"Content-Disposition": f'attachment; filename="{file_name}"'}
    )
