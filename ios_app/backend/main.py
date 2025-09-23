from fastapi import FastAPI, APIRouter, Depends, status
from pydantic import BaseModel
from typing import Dict, Optional
from datetime import datetime

# Create FastAPI instance
app = FastAPI(
    title="NBA Draft Visualizer API",
    description="API for NBA Draft Visualization and Analysis",
    version="1.0.0"
)

# Create API Router for health checks
health_router = APIRouter(
    prefix="/health",
    tags=["Health"]
)

# Pydantic model for health check response
class HealthResponse(BaseModel):
    status: str
    timestamp: datetime
    version: str
    environment: Optional[str] = None

# Dependency for getting app version
async def get_app_version() -> str:
    return "1.0.0"

# Health check endpoint
@health_router.get(
    "",
    response_model=HealthResponse,
    status_code=status.HTTP_200_OK,
    description="Check API health status"
)
async def health_check(version: str = Depends(get_app_version)) -> HealthResponse:
    return HealthResponse(
        status="healthy",
        timestamp=datetime.utcnow(),
        version=version,
        environment="development"
    )

# Include routers in main app
app.include_router(health_router)

# For local development
if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
