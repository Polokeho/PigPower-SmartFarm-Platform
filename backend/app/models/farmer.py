import uuid
from datetime import datetime
from typing import Optional

from sqlalchemy import Boolean, DateTime, Float, ForeignKey, Integer, String, func
from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.database.session import Base
from app.models.mixins import TimestampMixin, UUIDPrimaryKeyMixin


class Farmer(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "farmer"

    farmer_number: Mapped[str] = mapped_column(String, unique=True)  # FMR-000246, from Sequence
    name: Mapped[str] = mapped_column(String)
    district_lookup_value_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("sacm_lookup_value.id"))
    community: Mapped[Optional[str]] = mapped_column(String, nullable=True)
    phone: Mapped[Optional[str]] = mapped_column(String, nullable=True)
    status: Mapped[str] = mapped_column(String, default="PROSPECT")  # CRM §9 status set, simplified for Pass 1
    assigned_officer_id: Mapped[Optional[uuid.UUID]] = mapped_column(UUID(as_uuid=True), nullable=True)
    documentation_complete: Mapped[bool] = mapped_column(Boolean, default=False)
    deleted_at: Mapped[Optional[datetime]] = mapped_column(DateTime(timezone=True), nullable=True)  # FR-DB-002

    farms: Mapped[list["Farm"]] = relationship(back_populates="farmer")


class Farm(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "farm"

    farm_number: Mapped[str] = mapped_column(String, unique=True)
    farmer_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("farmer.id"))
    pigsty_count: Mapped[int] = mapped_column(Integer, default=1)
    location_lat: Mapped[Optional[float]] = mapped_column(Float, nullable=True)
    location_lng: Mapped[Optional[float]] = mapped_column(Float, nullable=True)

    farmer: Mapped["Farmer"] = relationship(back_populates="farms")
    pigs: Mapped[list["Pig"]] = relationship(back_populates="farm")


class Pig(Base, UUIDPrimaryKeyMixin):
    """
    Minimal Pig entity — enough for Production/Veterinary to reference;
    the full Pig Management module (Chapter 4) expands this later.
    """

    __tablename__ = "pig"

    pig_number: Mapped[str] = mapped_column(String, unique=True)
    farm_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("farm.id"))
    breed_lookup_value_id: Mapped[Optional[uuid.UUID]] = mapped_column(
        UUID(as_uuid=True), ForeignKey("sacm_lookup_value.id"), nullable=True
    )
    created_at: Mapped[datetime] = mapped_column(DateTime(timezone=True), server_default=func.now())

    farm: Mapped["Farm"] = relationship(back_populates="pigs")
