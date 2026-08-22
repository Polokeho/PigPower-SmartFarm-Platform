from typing import Any, Literal, Optional

from pydantic import BaseModel

SyncEntityType = Literal["Farmer", "ProductionBatch", "VeterinaryRecord"]


class SyncBatchItem(BaseModel):
    idempotency_key: str
    entity_type: SyncEntityType
    client_id: str
    operation: Literal["CREATE"]  # Pass 1 scope: append-only entities, per OSDS §11
    payload: dict[str, Any]


class SyncBatchRequest(BaseModel):
    items: list[SyncBatchItem]


class SyncItemError(BaseModel):
    code: str
    message: str


class SyncItemResult(BaseModel):
    client_id: str
    status: Literal["CONFIRMED", "REJECTED"]
    server_id: Optional[str] = None
    error: Optional[SyncItemError] = None


class SyncBatchResponse(BaseModel):
    results: list[SyncItemResult]
