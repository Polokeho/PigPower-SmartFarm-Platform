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

    # --- Storage (5.3 AD-FS-002: local driver at pilot scale) ---
    storage_driver: str = "local"
    storage_local_path: str = "./storage-data"
    storage_signed_url_secret: str = "change-me-in-production"
    storage_signed_url_ttl_seconds: int = 900


settings = Settings()
