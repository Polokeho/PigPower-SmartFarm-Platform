from pydantic import field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """
    Environment-based configuration — 5.4 FR-BE-017. Loaded from a .env
    file (never committed to source control), matching the same
    credential/config isolation principle as the NestJS version and
    IAPI FR-IAPI-020.
    """

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8", extra="ignore")

    # --- Database (5.2 AD-DB-001 / AD-DB-004) ---
    database_url: str = "postgresql+asyncpg://pigpower:pigpower@localhost:5432/pigpower"

    # --- Auth (IAPI FR-IAPI-010) ---
    jwt_access_secret: str = "change-me-in-production"
    jwt_access_expires_minutes: int = 30
    jwt_refresh_secret: str = "change-me-in-production-too"
    jwt_refresh_expires_days: int = 30
    jwt_algorithm: str = "HS256"

    # --- App ---
    port: int = 8000
    env: str = "development"

    # --- Security: FR-SEC-002 CORS restriction ---
    # Comma-separated in .env, e.g.: CORS_ALLOWED_ORIGINS=https://admin.pigpower.example
    # Defaults to localhost-only origins, appropriate for local development
    # and for native mobile clients (which aren't subject to CORS at all —
    # this setting matters once a browser-based client exists).
    #
    # NOTE: declared here as `str`, not `list[str]`. pydantic-settings
    # (2.5.2, pinned in requirements.txt) JSON-decodes any *complex*
    # field type (list, dict, ...) read from the environment/.env BEFORE
    # any field_validator runs — a plain comma list like
    # "http://a,http://b" isn't valid JSON, so a `list[str]` annotation
    # raises `SettingsError` at startup before our validator ever gets a
    # chance to split it (this is the exact error hit when this field
    # was first added). `NoDecode`, which sidesteps that cleanly, isn't
    # available until a later pydantic-settings release — so instead we
    # keep the field typed `str` and let an "after" validator turn the
    # already-parsed string into the `list[str]` every call site expects.
    cors_allowed_origins: str = "http://localhost,http://localhost:8000,http://127.0.0.1:8000"

    @field_validator("cors_allowed_origins", mode="after")
    @classmethod
    def _split_cors_origins(cls, value: str) -> list[str]:
        # Allows plain "http://a.com,http://b.com" in .env, rather than
        # requiring JSON array syntax — easier to hand-edit correctly.
        # Runs after pydantic's own `str` validation of the raw env
        # value, then hands back a list — `settings.cors_allowed_origins`
        # is a `list[str]` at every call site (e.g. main.py's
        # `CORSMiddleware(allow_origins=settings.cors_allowed_origins)`),
        # even though the field is annotated `str` above.
        return [origin.strip() for origin in value.split(",") if origin.strip()]

    # --- Storage (5.3 AD-FS-002: local driver at pilot scale) ---
    storage_driver: str = "local"
    storage_local_path: str = "./storage-data"
    storage_signed_url_secret: str = "change-me-in-production"
    storage_signed_url_ttl_seconds: int = 900


settings = Settings()