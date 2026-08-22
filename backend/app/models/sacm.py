import uuid
from typing import Optional

from sqlalchemy import Boolean, ForeignKey, Integer, String, UniqueConstraint
from sqlalchemy.dialects.postgresql import JSONB, UUID
from sqlalchemy.orm import Mapped, mapped_column, relationship

from app.database.session import Base
from app.models.mixins import TimestampMixin, UUIDPrimaryKeyMixin


class Role(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "sacm_role"

    code: Mapped[str] = mapped_column(String, unique=True)  # e.g. FIELD_OFFICER, VETERINARIAN
    name: Mapped[str] = mapped_column(String)
    active: Mapped[bool] = mapped_column(Boolean, default=True)

    permissions: Mapped[list["RolePermission"]] = relationship(back_populates="role")
    users: Mapped[list["UserRole"]] = relationship(back_populates="role")


class Permission(Base, UUIDPrimaryKeyMixin):
    __tablename__ = "sacm_permission"

    code: Mapped[str] = mapped_column(String, unique=True)  # e.g. farmer.create
    module: Mapped[str] = mapped_column(String)  # groups permissions by owning module

    roles: Mapped[list["RolePermission"]] = relationship(back_populates="permission")


class RolePermission(Base):
    __tablename__ = "sacm_role_permission"

    role_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("sacm_role.id"), primary_key=True)
    permission_id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), ForeignKey("sacm_permission.id"), primary_key=True
    )

    role: Mapped["Role"] = relationship(back_populates="permissions")
    permission: Mapped["Permission"] = relationship(back_populates="roles")


class LookupTable(Base, UUIDPrimaryKeyMixin):
    """
    Generic lookup table engine (SACM FR-SACM-008) — covers districts,
    breeds, feed types, vaccine types etc. without a schema migration
    per new list.
    """

    __tablename__ = "sacm_lookup_table"

    code: Mapped[str] = mapped_column(String, unique=True)  # e.g. "district", "pig_breed"
    label: Mapped[str] = mapped_column(String)

    values: Mapped[list["LookupValue"]] = relationship(back_populates="lookup_table")


class LookupValue(Base, UUIDPrimaryKeyMixin, TimestampMixin):
    __tablename__ = "sacm_lookup_value"
    __table_args__ = (UniqueConstraint("lookup_table_id", "code"),)

    lookup_table_id: Mapped[uuid.UUID] = mapped_column(UUID(as_uuid=True), ForeignKey("sacm_lookup_table.id"))
    code: Mapped[str] = mapped_column(String)
    label: Mapped[str] = mapped_column(String)
    sort_order: Mapped[int] = mapped_column(Integer, default=0)
    active: Mapped[bool] = mapped_column(Boolean, default=True)
    metadata_json: Mapped[Optional[dict]] = mapped_column("metadata", JSONB, nullable=True)

    lookup_table: Mapped["LookupTable"] = relationship(back_populates="values")


class Sequence(Base):
    """
    SACM's numbering engine (FR-SACM-015) — authoritative ID sequences
    (e.g. FMR-000246) assigned on sync confirmation.
    """

    __tablename__ = "sacm_sequence"

    entity: Mapped[str] = mapped_column(String, primary_key=True)  # e.g. "Farmer"
    prefix: Mapped[str] = mapped_column(String)
    next_value: Mapped[int] = mapped_column(Integer, default=1)
    pad_length: Mapped[int] = mapped_column(Integer, default=6)
