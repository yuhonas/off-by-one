from bs4 import BeautifulSoup

#
# malformed_xml = open("./tests/fixtures/test-result.xml").read()
# # Parse the malformed XML with BeautifulSoup
# soup = BeautifulSoup(malformed_xml, features="xml")
#
# # Repair the malformed XML by converting HTML entities
# repaired_xml = soup.prettify

"""
NOTE: Could be broken out into a dependencies.py
as suggested by FastAPI documentation
see https://fastapi.tiangolo.com/tutorial/bigger-applications/
"""
from starlette.config import Config
from celery import Celery

"""
NOTE: Could be moved to it's own settings module
if it was used in multiple places
"""
config = Config(".env")


celery = Celery("tasks", broker=config("REDIS_URL"), result_backend=config("REDIS_URL"))


@celery.task
def add(x, y):
    print("Adding", x, y, x + y)
    return x + y


@celery.task
def aggregate_from_xml(xml_data):
    soup = BeautifulSoup(xml_data, features="xml")
    return {"mean": 100, "count": 100, "p25": 100, "p50": 100, "p75": 100}
