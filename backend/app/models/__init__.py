"""
Importing every model here ensures SQLAlchemy's Base.metadata is fully
populated in one place -- Alembic's autogenerate (and any code doing
`Base.metadata.create_all`) depends on all models having been imported
before it inspects the metadata.
"""

from app.models.sacm import Role, Permission, RolePermission, LookupTable, LookupValue, Sequence  # noqa: F401
from app.models.user import User, UserRole, Device, RefreshToken  # noqa: F401
from app.models.farmer import Farmer, Farm, Pig  # noqa: F401
from app.models.production import ProductionBatch  # noqa: F401
from app.models.veterinary import VeterinaryRecord  # noqa: F401
from app.models.document import Document  # noqa: F401
from app.models.sync import IdempotencyRecord, EntityMapping  # noqa: F401
