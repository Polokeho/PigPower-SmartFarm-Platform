from datetime import datetime
from typing import Optional

from pydantic import BaseModel


class CreateFarmDto(BaseModel):
    lat: Optional[float] = None
    lng: Optional[float] = None
    pigsty_count: Optional[int] = None


class CreateFarmerRequest(BaseModel):
    """5.5 §5 POST /v1/farmers request shape."""

    client_id: Optional[str] = None  # OSDS FR-OSDS-006/007 -- offline temporary ID
    name: str
    district: str  # SACM lookup_value.code for the district lookup table
    community: Optional[str] = None
    phone: Optional[str] = None
    farm: Optional[CreateFarmDto] = None


class UpdateFarmerRequest(BaseModel):
    name: Optional[str] = None
    community: Optional[str] = None
    phone: Optional[str] = None


class ChangeFarmerStatusRequest(BaseModel):
    status: str  # PROSPECT | LEAD | QUALIFIED | ACTIVE | INACTIVE | SUSPENDED | BLOCKED | TERMINATED -- CRM §9


class FarmerResponse(BaseModel):
    farmer_id: str
    internal_id: str
    name: str
    status: str
    community: Optional[str]
    phone: Optional[str]
    assigned_officer: Optional[str]
    documentation_complete: bool
    created_at: datetime
    updated_at: datetime
