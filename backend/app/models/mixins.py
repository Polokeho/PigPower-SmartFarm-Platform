import uuid
from datetime import datetime

from sqlalchemy import DateTime, func
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column


class UUIDPrimaryKeyMixin:
    """
    UUID primary keys — 5.2 FR-DB-004: entities that may be created
    offline get a client-generatable identifier scheme, so a temporary
    client-side ID and its eventual server ID can be reconciled cleanly
    (mirrors OSDS's LocalEntityMapping pattern).
    """

    id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), primary_key=True, default=uuid.uuid4)


class TimestampMixin:
    """Audit-friendly timestamps on every table — 5.2 FR-DB-003."""

    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())
    updated_at: Mapped[datetime] = mapped_column(
        DateTime(timezone=True), server_default=func.now(), onupdate=func.now()
    )
