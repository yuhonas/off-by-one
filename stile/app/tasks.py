# from bs4 import BeautifulSoup
#
# malformed_xml = open("./tests/fixtures/test-result.xml").read()
# # Parse the malformed XML with BeautifulSoup
# soup = BeautifulSoup(malformed_xml, features="xml")
#
# # Repair the malformed XML by converting HTML entities
# repaired_xml = soup.prettify
# print(repaired_xml)

from celery import Celery

import os

REDIS_URL = os.environ.get('REDIS_URL')

app = Celery('tasks', broker=REDIS_URL,
             result_backend=REDIS_URL)


@app.task
def add(x, y):
    print('Adding', x, y, x+y)
    return x + y


add.delay(4, 4)
# print(app.conf.broker_url)
# print(app.conf.result_backend)
