import uuid
from datetime import datetime
from typing import Optional

from sqlalchemy import DateTime, ForeignKey, String, func
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column

from app.database.session import Base
from app.models.mixins import UUIDPrimaryKeyMixin


class VeterinaryRecord(Base, UUIDPrimaryKeyMixin):
    """Append-only, same reasoning as ProductionBatch (OSDS §11)."""

    __tablename__ = "veterinary_record"

    record_number: Mapped[str] = mapped_column(String, unique=True)  # VET-004821
    pig_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("pig.id"))
    farm_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("farm.id"))
    type: Mapped[str] = mapped_column(String)  # VACCINATION | TREATMENT | VISIT
    vaccine_lookup_value_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True), ForeignKey("sacm_lookup_value.id"), nullable=True
    )
    administered_at: Mapped[datetime] = mapped_column(DateTime(timezone=True))
    administered_by_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("user.id"))
    notes: Mapped[Optional[str]] = mapped_column(String, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
