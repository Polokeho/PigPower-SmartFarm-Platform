from datetime import datetime, timezone
from typing import Any, Optional


def success_envelope(data: Any, request_id: str, meta: Optional[dict] = None) -> dict:
    """IAPI FR-IAPI-003 standard success envelope, applied via the
    response middleware in app/main.py so individual routes never
    construct this manually (mirrors 5.4 FR-BE-008)."""
    return {
        "success": True,
        "data": data,
        "meta": {"request_id": request_id, "timestamp": datetime.now(timezone.utc).isoformat(), **(meta or {})},
    }


def error_envelope(code: str, message: str, request_id: str, field: Optional[str] = None) -> dict:
    """IAPI FR-IAPI-004 standard error envelope."""
    return {
        "success": False,
        "error": {"code": code, "message": message, "field": field, "request_id": request_id},
    }
