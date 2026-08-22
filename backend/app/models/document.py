import uuid
from datetime import datetime
from typing import Optional

from sqlalchemy import DateTime, ForeignKey, Integer, String, func
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column

from app.database.session import Base
from app.models.mixins import UUIDPrimaryKeyMixin


class Document(Base, UUIDPrimaryKeyMixin):
    """
    Pass 1 core slice — full DFM module (versioning, approval workflow,
    retention) expands this later.
    """

    __tablename__ = "document"

    document_number: Mapped[str] = mapped_column(String, unique=True)
    document_type: Mapped[str] = mapped_column(String)  # e.g. VACCINATION_CERTIFICATE
    storage_key: Mapped[str] = mapped_column(String)  # 5.3 FR-FS-001 path convention
    file_name: Mapped[str] = mapped_column(String)
    mime_type: Mapped[str] = mapped_column(String)
    file_size_bytes: Mapped[int] = mapped_column(Integer)
    sha256: Mapped[str] = mapped_column(String)  # DFM §53 duplicate detection / integrity
    confidentiality_level: Mapped[str] = mapped_column(String, default="INTERNAL")
    related_farmer_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True), ForeignKey("farmer.id"), nullable=True
    )
    related_veterinary_record_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True), ForeignKey("veterinary_record.id"), nullable=True
    )
    uploaded_by_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("user.id"))
    uploaded_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    status: Mapped[str] = mapped_column(String, default="APPROVED")  # simplified for Pass 1
