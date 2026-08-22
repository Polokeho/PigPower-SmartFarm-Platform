from typing import AsyncGenerator

from sqlalchemy.ext.asyncio import AsyncSession, async_sessionmaker, create_async_engine
from sqlalchemy.orm import DeclarativeBase

from app.config import settings

# Lazy connection: create_async_engine does not connect until the first
# query is issued, so importing this module never requires a live
# database — matching the same "safe to import without a running DB"
# property the NestJS PrismaService had via Nest's module lifecycle.
engine = create_async_engine(settings.database_url, echo=(settings.env == "development"), pool_pre_ping=True)

AsyncSessionLocal = async_sessionmaker(engine, expire_on_commit=False, class_=AsyncSession)


class Base(DeclarativeBase):
    """Declarative base every model in app/models inherits from."""
    pass


async def get_db() -> AsyncGenerator[AsyncSession, None]:
    """
    FastAPI dependency yielding a request-scoped session — the
    equivalent of injecting PrismaService into a NestJS
    controller/service. Used as `db: AsyncSession = Depends(get_db)`.
    """
    async with AsyncSessionLocal() as session:
        yield session
