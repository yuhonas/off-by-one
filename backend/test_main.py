import main
from fastapi.testclient import TestClient

client = TestClient(main.app)


def test_read_root():
    response = client.get("/")
    assert response.status_code == 200
    assert response.headers["content-type"] == "application/json"
    assert len(response.json()) == main.COLORS_RESULT_SIZE
