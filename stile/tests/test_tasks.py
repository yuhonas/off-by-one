import pytest
from app import main
from fastapi.testclient import TestClient
from celery.result import AsyncResult


from app.tasks import celery
from app import tasks

client = TestClient(main.app)


# Test fixture to mock out the connection to Redis
@pytest.fixture(scope="module")
def celery_app(request):
    celery.conf.update(CELERY_ALWAYS_EAGER=True)
    return celery


def test_post(celery_app):
    malformed_xml = open("./tests/fixtures/test-result.xml")

    response = client.post(
        "/results",
        content=malformed_xml.read(),
        headers={"Content-Type": "application/xml"},
    )

    assert response.status_code == 202
    assert response.headers["content-type"] == "application/json"
    assert response.json() == {"status": "ok"}


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.headers["content-type"] == "application/json"
    assert response.json() == {"status": "ok"}
