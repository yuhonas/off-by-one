from bs4 import BeautifulSoup

"""
NOTE: Could be broken out into a dependencies.py
as suggested by FastAPI documentation
see https://fastapi.tiangolo.com/tutorial/bigger-applications/
"""
from starlette.config import Config
from celery import Celery
import numpy as np

"""
NOTE: Could be moved to it's own settings module
if it was used in multiple places
"""
config = Config(".env")


celery = Celery("tasks", broker=config("REDIS_URL"), result_backend=config("REDIS_URL"))


@celery.task
def aggregate_from_xml(xml_data):
    soup = BeautifulSoup(xml_data, features="xml")

    # enumerate through all summary-marks and count the available and obtained
    # NOTE: What if our results are not integers?
    results = [
        (int(summary_mark.attrs["obtained"]) / int(summary_mark.attrs["available"]))
        * 100
        for summary_mark in soup.find_all("summary-marks")
    ]

    # TODO: Rounding

    # calculate our percentiles
    return {
        "mean": np.median(results),
        "count": len(results),
        "p25": np.percentile(results, 25),
        "p50": np.percentile(results, 50),
        "p75": np.percentile(results, 75),
    }
