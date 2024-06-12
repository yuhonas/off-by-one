from app import main
from fastapi.testclient import TestClient

client = TestClient(main.app)


def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.headers["content-type"] == "application/json"
    assert response.json() == {"status": "ok"}
