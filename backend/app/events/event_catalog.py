from enum import Enum


class AppEvent(str, Enum):
    """
    Central event catalog -- implements NCM §46's "Notification Event
    Catalog" concept in code, extended to cover audit-relevant events
    generally (per ACRM FR-ACRM-001). Modules emit these via EventBus;
    other modules (Notifications, ACRM's audit listener, future BI)
    subscribe without the emitting module needing to know who's
    listening -- 5.1 AD-SYS-004.
    """

    FARMER_CREATED = "farmer.created"
    FARMER_STATUS_CHANGED = "farmer.status_changed"

    PRODUCTION_BATCH_RECORDED = "production.batch_recorded"
    PRODUCTION_BATCH_READY = "production.batch_ready"

    VETERINARY_RECORD_CREATED = "veterinary.record_created"

    DOCUMENT_UPLOADED = "document.uploaded"

    USER_LOGGED_IN = "auth.user_logged_in"
    USER_LOGGED_OUT = "auth.user_logged_out"
