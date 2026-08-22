from fastapi import APIRouter

from app.api.v1 import auth, documents, farmers, production, sync, users, veterinary

api_v1_router = APIRouter()
api_v1_router.include_router(auth.router)
api_v1_router.include_router(users.router)
api_v1_router.include_router(farmers.router)
api_v1_router.include_router(production.router)
api_v1_router.include_router(veterinary.router)
api_v1_router.include_router(documents.router)
api_v1_router.include_router(sync.router)
