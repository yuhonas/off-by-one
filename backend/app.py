# from typing import Union

from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()


@app.get("/")
def read_root():
    return {"Hello": "World"}

handler = Mangum(app)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app)
