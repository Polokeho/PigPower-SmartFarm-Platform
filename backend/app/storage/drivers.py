from pathlib import Path
from typing import Protocol


class StorageDriver(Protocol):
    """
    The Storage Service interface -- 5.3 AD-FS-001. All file access
    goes through this interface; other modules never touch a concrete
    driver (local disk, MinIO, S3-compatible) directly.
    """

    async def put(self, key: str, data: bytes) -> str: ...
    async def get(self, key: str) -> bytes: ...
    async def delete(self, key: str) -> None: ...


class LocalStorageDriver:
    """Local filesystem storage driver -- 5.3 AD-FS-002 (pilot-phase choice)."""

    def __init__(self, base_path: str):
        self.base_path = Path(base_path)

    async def put(self, key: str, data: bytes) -> str:
        full_path = self.base_path / key
        full_path.parent.mkdir(parents=True, exist_ok=True)
        full_path.write_bytes(data)
        return key

    async def get(self, key: str) -> bytes:
        return (self.base_path / key).read_bytes()

    async def delete(self, key: str) -> None:
        path = self.base_path / key
        if path.exists():
            path.unlink()
