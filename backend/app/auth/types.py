from dataclasses import dataclass, field


@dataclass
class AuthenticatedUser:
    """
    Represents the authenticated caller -- the Python equivalent of the
    NestJS AuthenticatedUser interface, attached to the request by the
    get_current_user dependency and consumed by require_permission()
    and by route handlers directly.
    """

    user_id: str
    username: str
    device_id: str
    roles: list[str] = field(default_factory=list)
    permissions: list[str] = field(default_factory=list)
    scope_district: str | None = None
