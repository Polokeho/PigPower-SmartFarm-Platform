import uuid
from datetime import datetime
from typing import Optional

from sqlalchemy import ARRAY, DateTime, Float, ForeignKey, String, func
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column

from app.database.session import Base
from app.models.mixins import UUIDPrimaryKeyMixin


class ProductionBatch(Base, UUIDPrimaryKeyMixin):
    """
    Append-only per OSDS §11's conflict-resolution table -- "each entry
    is a new fact, not a mutation of a prior one" -- so there is
    deliberately no update path for a recorded entry.
    """

    __tablename__ = "production_batch"

    batch_number: Mapped[str] = mapped_column(String, unique=True)  # PROD-004821
    farmer_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("farmer.id"))
    farm_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("farm.id"))
    pig_ids: Mapped[list[str]] = mapped_column(ARRAY(String))
    weight_kg: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    recorded_at: Mapped[datetime] = mapped_column(DateTime(timezone=True))
    recorded_by_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("user.id"))
    status: Mapped[str] = mapped_column(String, default="RECORDED")  # RECORDED | MARKET_READY
    notes: Mapped[Optional[str]] = mapped_column(String, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
