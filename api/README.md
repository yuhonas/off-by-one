# Kanopi Color Swatch API [![Backend API](https://github.com/yuhonas/kanopi/actions/workflows/backend-api.yml/badge.svg)](https://github.com/yuhonas/kanopi/actions/workflows/backend-api.yml)


A simple API to return a random set of colors accross a randomized set of color spaces with extensability beyond [standard color spaces](https://en.wikipedia.org/wiki/List_of_color_spaces_and_their_uses) in mind

## Getting Started

### Dependencies
* Python 3.11

### Installation

You can checkout the repo & `api` sub directory using api

```
git clone git@github.com:yuhonas/kanopi.git && cd api
```

Install dependencies using

```
make deps
```

See the [Makefile](./Makefile) for other useful tasks

## Documentation

As this API is based on open standards using [FastAPI](https://fastapi.tiangolo.com/) the following is avilable out of the box

* Automagically generated interactive [Swagger UI](https://j8adom76wl.execute-api.ap-southeast-2.amazonaws.com/docs) for you to explore the endpoints
* An [Open API Schema](https://j8adom76wl.execute-api.ap-southeast-2.amazonaws.com/openapi.json) compatible with [JSON Schema](https://json-schema.org/), which you could potentially build implementations/clients/types against

## Design Goals

* Simplicity
* Readability
* Optimize for discussion, i've left notes where i've thought a snap judgement/unintentional hiring bias could be made
* A bit of over-engineering for fun to explore what can/should/shouldn't be done

## Assumptions

* The API must conform to the schema in [sample.json](../public/sample.json)
* That we will be using non standard color spaces as dictated in _Stage 2_ of the brief
* There is no performance or availability SLA's we need to meet

## Limitations

* There is limited test cases, i've simply added them as sanity check's and _could be expanded_, if you'd like to talk code coverage happy to do it
* Outputs "randomness" dictated by python's `random` implementation which is psuedo-random, this may/may not be a problem across "large" result sets

## Deployment

This API is currently deployed via [serverless](https://github.com/serverless/serverless) see [serverless.yml](serverless.yml) with AWS as a provider

See [Deploying with Serverless](https://www.serverless.com/framework/docs/providers/aws/guide/deploying) and the [Github Action CD Job](../.github/workflows/backend-api.yml)


## Performance

* I haven't benchmarked it but there's no persistence layer so IO shouldn't be a problem
* The output is not dictated by any inputs so Big O complexity for both time/space would simply be `O(1)` consistent time
* I would need to do a bigger deep dive into the stack to understand where/if we may be bottlenecked somewhere but as mentioned this is only relevant if we have performance SLA's

## Extending

This has been designed with adding non conventional color spaces in mind eg. `BRGB` so there is an abstraction layer to deal with a color space that has some kind of input attributes and knows how to randomize it's self see [colors.py](./app/colors.py) these are defined using python types in [pydantic](https://docs.pydantic.dev/latest/) so you get a lot out of the box see [pydantic features](https://fastapi.tiangolo.com/features/#pydantic-features) including type safety/validation/documentation etc

### Example for a fictional BRGB Color Space

> BRGB stores the red, green, and blue components as values between 0 and 10000 (inclusive).

```python
class ColorBRGB(Color):
    type: str = "brgb"
    red: int = Field(..., ge=0, le=10000)
    green: int = Field(..., ge=0, le=10000)
    blue: int = Field(..., ge=0, le=10000)

    @classmethod
    def random(cls):
        return cls(
            # NOTE: You could DRY this up, as all values are randomized 0-1000
            red=random.randint(0, 10000),
            green=random.randint(0, 10000),
            blue=random.randint(0, 10000),
        )
```

Then you'd simply need to add that class too [main.py](./app/main.py#L12) as well as appropriate imports of course

## My closing thoughts 🤔

* Given it's simplicity, is a backend for this problem even needed, why couldn't we do this entirely on the frontend, saving a huge amount in time/complexity/maintenance
* I feel using Django _at this stage_ isn't the right fit given so much of what you get [out of the box](https://docs.djangoproject.com/en/5.0/ref/) we wouldn't be using and further to this we'd need to add packages to get the features we have here (openapi etc), a middle ground could be something like [django rest framework](https://github.com/encode/django-rest-framework/tree/master) or [django ninja](https://django-ninja.dev/) but there could be a case for it if we're a django shop and it's easier to spin an app like this up
* Two thing's I feel make this much more complex then it needs to be one is the implementation of a non standard colour space and the other is the fixed schema, re-implementing color spaces in classes _feels_ dirty and those implementations/standards should be readily accessible via third party libraries, if we had more schema flexability I believe we could simplify the frontend dramatically via color normalization for client rendering
