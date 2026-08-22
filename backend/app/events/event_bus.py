import inspect
import logging
from collections import defaultdict
from typing import Any, Awaitable, Callable, Union

logger = logging.getLogger("pigpower.events")

Handler = Callable[[dict], Union[None, Awaitable[None]]]
WildcardHandler = Callable[[str, dict], Union[None, Awaitable[None]]]


class EventBus:
    """
    In-process publish/subscribe -- the Python equivalent of NestJS's
    EventEmitter2, implementing 5.1 AD-SYS-004 ("in-process event
    mechanism, not a message broker, at pilot scale").

    Modules emit events (e.g. from a service, after committing a
    transaction) and other modules subscribe without either side
    needing to know about the other -- this is what lets ACRM's audit
    listener log every event platform-wide without each service
    reimplementing audit logging (ACRM FR-ACRM-001).
    """

    def __init__(self) -> None:
        self._handlers: dict[str, list[Handler]] = defaultdict(list)
        self._wildcard_handlers: list[WildcardHandler] = []

    def on(self, event: str, handler: Handler) -> None:
        self._handlers[event].append(handler)

    def on_any(self, handler: WildcardHandler) -> None:
        """Registers a wildcard listener that receives EVERY event -- used by AuditListener."""
        self._wildcard_handlers.append(handler)

    async def emit(self, event: str, payload: dict[str, Any]) -> None:
        for handler in self._handlers.get(event, []):
            await self._call(handler, payload)
        for handler in self._wildcard_handlers:
            await self._call(handler, event, payload)

    @staticmethod
    async def _call(handler: Callable, *args: Any) -> None:
        try:
            result = handler(*args)
            if inspect.isawaitable(result):
                await result
        except Exception:  # noqa: BLE001 -- a listener failure must never break the emitting request
            logger.exception("Event handler raised an exception")


# Module-level singleton -- imported wherever a service needs to emit
# or a startup routine needs to register a listener.
event_bus = EventBus()
