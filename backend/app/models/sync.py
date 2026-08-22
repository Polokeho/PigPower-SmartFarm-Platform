from datetime import datetime
from typing import Optional

from sqlalchemy import DateTime, String, UniqueConstraint, func
from sqlalchemy.orm import Mapped, mapped_column

from app.database.session import Base
from app.models.mixins import UUIDPrimaryKeyMixin


class IdempotencyRecord(Base):
    """OSDS FR-OSDS-022 / IAPI FR-IAPI-027 — idempotent sync processing."""

    __tablename__ = "sync_idempotency_record"

    idempotency_key: Mapped[str] = mapped_column(String, primary_key=True)
    entity_type: Mapped[str] = mapped_column(String)
    result_status: Mapped[str] = mapped_column(String)  # CONFIRMED | REJECTED
    server_id: Mapped[Optional[str]] = mapped_column(String, nullable=True)
    error_code: Mapped[Optional[str]] = mapped_column(String, nullable=True)
    error_message: Mapped[Optional[str]] = mapped_column(String, nullable=True)
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())


class EntityMapping(Base, UUIDPrimaryKeyMixin):
    """
    OSDS §49 LocalEntityMapping, kept server-side too, so a device that
    reinstalls/resets can still resolve a previously-issued client_id ->
    server_id mapping if it re-submits the same idempotency key.
    """

    __tablename__ = "sync_entity_mapping"
    __table_args__ = (UniqueConstraint("entity_type", "client_id", "device_id"),)

    entity_type: Mapped[str] = mapped_column(String)
    client_id: Mapped[str] = mapped_column(String)
    server_id: Mapped[str] = mapped_column(String)
    device_id: Mapped[str] = mapped_column(String)
    resolved_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
