from datetime import datetime
from typing import Optional

from pydantic import BaseModel


class CreateProductionBatchRequest(BaseModel):
    client_id: Optional[str] = None
    farm_id: str
    pig_ids: list[str]
    recorded_at: datetime
    weight_kg: Optional[float] = None
    notes: Optional[str] = None


class ProductionBatchResponse(BaseModel):
    batch_id: str
    internal_id: str
    farm_id: str
    pig_ids: list[str]
    weight_kg: Optional[float]
    recorded_at: datetime
    status: str
    notes: Optional[str]
    created_at: datetime
