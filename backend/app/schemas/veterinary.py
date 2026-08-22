from datetime import datetime
from typing import Literal, Optional

from pydantic import BaseModel

VeterinaryRecordType = Literal["VACCINATION", "TREATMENT", "VISIT"]


class CreateVeterinaryRecordRequest(BaseModel):
    client_id: Optional[str] = None
    pig_id: str
    type: VeterinaryRecordType
    vaccine_type_id: Optional[str] = None
    administered_at: datetime
    document_ids: Optional[list[str]] = None
    notes: Optional[str] = None


class VeterinaryRecordResponse(BaseModel):
    record_id: str
    internal_id: str
    pig_id: str
    type: str
    administered_at: datetime
    notes: Optional[str]
    created_at: datetime
