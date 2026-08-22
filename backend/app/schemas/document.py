from datetime import datetime
from typing import Optional

from pydantic import BaseModel


class DocumentResponse(BaseModel):
    document_id: str
    internal_id: str
    document_type: str
    file_name: str
    mime_type: str
    file_size_bytes: int
    confidentiality_level: str
    uploaded_at: datetime
    status: str


class DownloadUrlResponse(BaseModel):
    url: str
    expires_at: str
