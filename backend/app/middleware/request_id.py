import uuid

from starlette.middleware.base import BaseHTTPMiddleware, RequestResponseEndpoint
from starlette.requests import Request
from starlette.responses import Response


class RequestIdMiddleware(BaseHTTPMiddleware):
    """
    Attaches a unique request ID to every incoming request if the
    client didn't already supply one (5.5 §2.2, IAPI FR-IAPI-032), so a
    single failed mobile-app action can be traced end-to-end through
    backend logs when a field user reports an issue (per IAPI §19).
    """

    async def dispatch(self, request: Request, call_next: RequestResponseEndpoint) -> Response:
        request_id = request.headers.get("x-request-id") or str(uuid.uuid4())
        request.state.request_id = request_id
        response = await call_next(request)
        response.headers["x-request-id"] = request_id
        return response
