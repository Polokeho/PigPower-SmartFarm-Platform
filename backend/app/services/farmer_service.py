from typing import Optional

from sqlalchemy.ext.asyncio import AsyncSession

from app.auth.types import AuthenticatedUser
from app.events.event_bus import event_bus
from app.events.event_catalog import AppEvent
from app.repositories.farmer_repository import FarmerRepository
from app.repositories.lookup_repository import LookupRepository
from app.schemas.farmer import ChangeFarmerStatusRequest, CreateFarmerRequest, FarmerResponse, UpdateFarmerRequest
from app.services.sequence_service import SequenceService
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException

_SCOPE_EXEMPT_ROLES = {"SUPER_ADMIN", "ADMINISTRATOR", "CEO"}


class FarmerService:
    """
    Implements 5.5 §5 Farmer Module. Scope enforcement here is the
    "data-access level" enforcement point required by IAPI FR-IAPI-013
    -- not merely hiding rows client-side.
    """

    def __init__(self, db: AsyncSession):
        self.db = db
        self.farmers = FarmerRepository(db)
        self.lookups = LookupRepository(db)
        self.sequences = SequenceService(db)

    async def list_farmers(self, user: AuthenticatedUser, cursor: Optional[str], limit: int = 20):
        district_id = await self._resolve_scope_district_id(user)
        rows, has_more = await self.farmers.list_farmers(district_id, cursor, limit)
        return {
            "items": [self._to_response(f) for f in rows],
            "meta": {"next_cursor": str(rows[-1].id) if has_more and rows else None, "has_more": has_more},
        }

    async def get_by_id(self, user: AuthenticatedUser, farmer_id: str) -> FarmerResponse:
        farmer = await self.farmers.get_by_id(farmer_id)
        if not farmer:
            raise AppException(ErrorCode.NOT_FOUND, "Farmer not found.")
        await self._assert_in_scope(user, str(farmer.district_lookup_value_id))
        return self._to_response(farmer)

    async def create(self, user: AuthenticatedUser, dto: CreateFarmerRequest) -> FarmerResponse:
        district = await self.lookups.get_value_by_code("district", dto.district)
        if not district:
            raise AppException(ErrorCode.VALIDATION_FAILED, "Unknown district code.", "district")

        farmer_number = await self.sequences.next("Farmer", "FMR")

        farmer = await self.farmers.create(
            farmer_number=farmer_number,
            name=dto.name,
            district_lookup_value_id=district.id,
            community=dto.community,
            phone=dto.phone,
            assigned_officer_id=user.user_id,
        )

        if dto.farm:
            await self.farmers.create_farm(
                farm_number=f"{farmer_number}-F1",
                farmer_id=farmer.id,
                pigsty_count=dto.farm.pigsty_count or 1,
                location_lat=dto.farm.lat,
                location_lng=dto.farm.lng,
            )

        await event_bus.emit(
            AppEvent.FARMER_CREATED,
            {"farmer_id": str(farmer.id), "farmer_number": farmer.farmer_number, "created_by_id": user.user_id},
        )

        return self._to_response(farmer)

    async def update(self, user: AuthenticatedUser, farmer_id: str, dto: UpdateFarmerRequest) -> FarmerResponse:
        farmer = await self.farmers.get_by_id(farmer_id)
        if not farmer:
            raise AppException(ErrorCode.NOT_FOUND, "Farmer not found.")
        await self._assert_in_scope(user, str(farmer.district_lookup_value_id))

        farmer = await self.farmers.update(farmer, name=dto.name, community=dto.community, phone=dto.phone)
        return self._to_response(farmer)

    async def change_status(
        self, user: AuthenticatedUser, farmer_id: str, dto: ChangeFarmerStatusRequest
    ) -> FarmerResponse:
        farmer = await self.farmers.get_by_id(farmer_id)
        if not farmer:
            raise AppException(ErrorCode.NOT_FOUND, "Farmer not found.")

        previous_status = farmer.status
        farmer = await self.farmers.update(farmer, status=dto.status)

        await event_bus.emit(
            AppEvent.FARMER_STATUS_CHANGED,
            {
                "farmer_id": str(farmer.id),
                "previous_status": previous_status,
                "new_status": dto.status,
                "changed_by_id": user.user_id,
            },
        )
        return self._to_response(farmer)

    async def _assert_in_scope(self, user: AuthenticatedUser, district_lookup_value_id: str) -> None:
        if set(user.roles) & _SCOPE_EXEMPT_ROLES or not user.scope_district:
            return
        district = await self.lookups.get_value_by_id(district_lookup_value_id)
        if not district or district.code != user.scope_district:
            raise AppException(ErrorCode.NOT_FOUND, "Farmer not found.")  # 404, not 403 -- avoid leaking existence

    async def _resolve_scope_district_id(self, user: AuthenticatedUser) -> Optional[str]:
        if set(user.roles) & _SCOPE_EXEMPT_ROLES or not user.scope_district:
            return None
        district = await self.lookups.get_value_by_code("district", user.scope_district)
        return str(district.id) if district else None

    @staticmethod
    def _to_response(farmer) -> FarmerResponse:
        return FarmerResponse(
            farmer_id=farmer.farmer_number,
            internal_id=str(farmer.id),
            name=farmer.name,
            status=farmer.status,
            community=farmer.community,
            phone=farmer.phone,
            assigned_officer=str(farmer.assigned_officer_id) if farmer.assigned_officer_id else None,
            documentation_complete=farmer.documentation_complete,
            created_at=farmer.created_at,
            updated_at=farmer.updated_at,
        )
