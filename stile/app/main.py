from fastapi import FastAPI, Request
from .tasks import aggregate_from_xml

app = FastAPI()


# @app.get("/")
# async def root():
#     add.delay(4, 4)
#     return {"message": "Task Queued"}


# Use a 202 status code to indicate that the request has been accepted for processing
@app.post("/import", status_code=202)
async def submit(request: Request) -> dict:
    xml_data = await request.body()

    aggregate_from_xml(xml_data)
    return {"status": "ok"}


@app.get("/health")
async def health_check() -> dict:
    """
    Endpoint to check the health status of the application.

    Returns:
      dict: A dictionary containing the status of the application.
    """
    return {"status": "ok"}
