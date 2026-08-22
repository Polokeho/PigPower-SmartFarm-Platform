import json
import logging
from datetime import datetime, timezone

logger = logging.getLogger("pigpower.audit")


async def handle_any_event(event_name: str, payload: dict) -> None:
    """
    ACRM's platform-wide audit standard, implemented as a single
    wildcard listener rather than per-module audit code -- ACRM
    FR-ACRM-001, 5.4 FR-BE-007.

    Pass 1 implementation logs structured JSON; a later pass should
    persist these to a dedicated audit_log table (immutable, per
    ACRM FR-ACRM-003) rather than only the application log.
    """
    logger.info(
        json.dumps(
            {
                "event": event_name,
                "payload": _json_safe(payload),
                "timestamp": datetime.now(timezone.utc).isoformat(),
            },
            default=str,
        )
    )


def _json_safe(payload: dict) -> dict:
    return {k: str(v) if not isinstance(v, (str, int, float, bool, type(None))) else v for k, v in payload.items()}


def register_audit_listener() -> None:
    from app.events.event_bus import event_bus

    event_bus.on_any(handle_any_event)
