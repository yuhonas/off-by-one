from fastapi import FastAPI
from .tasks import add
app = FastAPI()


@app.get("/")
async def root():
    add.delay(4, 4)
    return {"message": "Task Queued"}


@app.get("/health")
async def health_check() -> dict:
    """
    Endpoint to check the health status of the application.

    Returns:
      dict: A dictionary containing the status of the application.
    """
    return {"status": "ok"}
