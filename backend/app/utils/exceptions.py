from typing import Optional

from starlette import status

from app.utils.error_codes import ErrorCode

_STATUS_BY_CODE: dict[ErrorCode, int] = {
    ErrorCode.UNAUTHENTICATED: status.HTTP_401_UNAUTHORIZED,
    ErrorCode.TOKEN_EXPIRED: status.HTTP_401_UNAUTHORIZED,
    ErrorCode.FORBIDDEN: status.HTTP_403_FORBIDDEN,
    ErrorCode.NOT_FOUND: status.HTTP_404_NOT_FOUND,
    ErrorCode.VALIDATION_FAILED: status.HTTP_422_UNPROCESSABLE_ENTITY,
    ErrorCode.CONFLICT: status.HTTP_409_CONFLICT,
    ErrorCode.IDEMPOTENT_REPLAY: status.HTTP_200_OK,
    ErrorCode.RATE_LIMITED: status.HTTP_429_TOO_MANY_REQUESTS,
    ErrorCode.SEGREGATION_OF_DUTIES_VIOLATION: status.HTTP_409_CONFLICT,
    ErrorCode.INTERNAL_ERROR: status.HTTP_500_INTERNAL_SERVER_ERROR,
}


class AppException(Exception):
    """
    The single exception type application/business logic should raise.
    A global exception handler (see app/main.py) translates this into
    IAPI's standard error envelope, matching 5.4 FR-BE-009/024's
    "consistent error taxonomy" principle regardless of which module
    raised it.
    """

    def __init__(self, code: ErrorCode, message: str, field: Optional[str] = None):
        self.code = code
        self.message = message
        self.field = field
        self.status_code = _STATUS_BY_CODE[code]
        super().__init__(message)
