import random
from typing import List, Union

from .colors import ColorHSL, ColorRGB
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from mangum import Mangum

# List of color classes to generate the random colors from
# we could do some dunder method magic to get this list
# eg. enumerate `Color.__subclasses__()` but i'd prefer to favour explicitness (the pythonic way)
COLOR_CLASSES = [
    ColorRGB,
    ColorHSL,
]  # Color Classes to choose from during the random color generation
COLORS_RESULT_SIZE = 5  # Number of colors to return, could also be a query param

app = FastAPI(title="Color Swatch Generator API")

# NOTE: This is way too permissive, in the real world we would want to restrict this
app.add_middleware(CORSMiddleware, allow_origins=["*"], expose_headers=["*"])


@app.get(
    "/",
    response_model=List[Union[ColorRGB | ColorHSL]],
    responses={
        200: {  # NOTE: provide an example of each color class in the docs
            "content": {
                "application/json": {
                    "example": [color.random() for color in COLOR_CLASSES]
                }
            }
        }
    },
)
def retrieve_a_list_of_random_colors():
    """
    Retrieve a list of of 5 randomly generated colors across random color spaces
    """

    # NOTE: obviously could be done in a oneliner with a map/lambda
    # but I feel it sacrifices readability for brevity
    colors = []
    for _ in range(COLORS_RESULT_SIZE):
        color_class = random.choice(COLOR_CLASSES)
        colors.append(color_class.random())

    return colors


# NOTE: this is required for AWS Lambda
# See ./serverless.yml && https://mangum.io/
handler = Mangum(app)
