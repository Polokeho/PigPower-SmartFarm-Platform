import logging

from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse

from app.api.v1.router import api_v1_router
from app.events.audit_listener import register_audit_listener
from app.middleware.request_id import RequestIdMiddleware
from app.utils.error_codes import ErrorCode
from app.utils.exceptions import AppException
from app.utils.responses import error_envelope

logging.basicConfig(level=logging.INFO)

app = FastAPI(title="PigPower SmartFarm Platform API", version="0.1.0")

app.add_middleware(RequestIdMiddleware)
app.add_middleware(CORSMiddleware, allow_origins=["*"], allow_methods=["*"], allow_headers=["*"])

app.include_router(api_v1_router)


@app.on_event("startup")
async def on_startup() -> None:
    # 5.1 AD-SYS-004 -- in-process event mechanism; listeners are
    # registered once here at startup, matching the "modules subscribe
    # without the emitter knowing" principle used throughout Chapter 4.
    register_audit_listener()


# --- Global exception handlers, implementing IAPI's standard error
# envelope (5.5 §2.4) regardless of which layer raised the error --
# the FastAPI equivalent of 5.4 FR-BE-009's global exception filter.


@app.exception_handler(AppException)
async def app_exception_handler(request: Request, exc: AppException) -> JSONResponse:
    request_id = getattr(request.state, "request_id", "unknown")
    return JSONResponse(
        status_code=exc.status_code,
        content=error_envelope(exc.code.value, exc.message, request_id, exc.field),
    )


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError) -> JSONResponse:
    request_id = getattr(request.state, "request_id", "unknown")
    message = "; ".join(f"{'.'.join(str(p) for p in e['loc'])}: {e['msg']}" for e in exc.errors())
    return JSONResponse(
        status_code=422,
        content=error_envelope(ErrorCode.VALIDATION_FAILED.value, message or "Validation failed.", request_id),
    )


@app.exception_handler(Exception)
async def unhandled_exception_handler(request: Request, exc: Exception) -> JSONResponse:
    request_id = getattr(request.state, "request_id", "unknown")
    logging.getLogger("pigpower.errors").exception("Unhandled exception")
    return JSONResponse(
        status_code=500,
        content=error_envelope(ErrorCode.INTERNAL_ERROR.value, "An unexpected error occurred.", request_id),
    )


@app.get("/health")
async def health() -> dict:
    return {"status": "ok"}
