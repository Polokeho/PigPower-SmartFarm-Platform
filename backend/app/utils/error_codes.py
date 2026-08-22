from enum import Enum


class ErrorCode(str, Enum):
    """
    Standard error code catalog -- 5.5 API Architecture §2.5. Every
    raised AppException should use one of these, so the mobile client
    always receives a predictable, actionable error shape
    (IAPI FR-IAPI-004) regardless of backend language.
    """

    UNAUTHENTICATED = "UNAUTHENTICATED"
    TOKEN_EXPIRED = "TOKEN_EXPIRED"
    FORBIDDEN = "FORBIDDEN"
    NOT_FOUND = "NOT_FOUND"
    VALIDATION_FAILED = "VALIDATION_FAILED"
    CONFLICT = "CONFLICT"
    IDEMPOTENT_REPLAY = "IDEMPOTENT_REPLAY"
    RATE_LIMITED = "RATE_LIMITED"
    SEGREGATION_OF_DUTIES_VIOLATION = "SEGREGATION_OF_DUTIES_VIOLATION"
    INTERNAL_ERROR = "INTERNAL_ERROR"
