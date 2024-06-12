# Base Docker Container for Fast API
# see https://fastapi.tiangolo.com/deployment/docker/

FROM python:3.12

WORKDIR /code

# Update the package list and install the redis client
RUN apt-get update && apt-get install -y redis

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app

# Perform a healthcheck to ensure the service is up and running
# this is pretty forgiving with a 3 second timeout/retry to ensure the service is up
# we may need to tweak these values depending on the service/how it plays out in prod
HEALTHCHECK --interval=5s --timeout=3s CMD curl --include --request GET http://localhost/health || exit 1

CMD ["fastapi", "run", "app/main.py", "--port", "80"]

