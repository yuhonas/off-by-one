# MARKR - Marking as a service
![marker boss](./public/markr-boss.jpeg)
___Where did all that Series B Money Go?___

## Background

See [BACKGROUND.md](./BACKGROUND.md)

* Optimize for correctness
* Optimize to get something out quickly & learn, perfect is the enemy of good
* Be clear about trade off's and how this could fail
* Seperation of concerns
* Not a prototype but a first cut
* Focus on getting the data first (ingest) everything else we can do offline
* Known unknowns

### Top scenario's we need to deal with
* Malformed XML
* "Incorrect" Data
* No control of clients so retries/associated response code might not be obeyed

## Requirements

See [REQUIREMENTS.md]

## Getting started

### Dependencies
TBD

### Installation

You can checkout the entire mono repo using

```
git clone git@github.com:yuhonas/off-by-one.git
```

Or simply checkout this service subdirectory using

```
git clone --filter=blob:none --sparse https://github.com/yuhonas/off-by-one.git
cd off-by-one
git sparse-checkout set stile
```

Install dependencies using

```
make deps
```

## Usage

TBD


## Design Goals
The following goals were kept in mind during development
* Optimized for discussion
* Simplicity / Minimize Single Point of Failure
* Flexability
* Seperation of concerns
* Principle of least suprise

* Focus is on ingesting the data and dealing with uncertainty, dont overbake it!
* Think about scaling and _how_ it could be scaled but don't over-engineer it
* Think about how it could fail



### Seperation of concerns
* Ingestion
* Data Transformation
* Reporting



However it is _over-designed_ purely for discussion (which could come back and bite me when we build on it), I would think very diffently about a real world practical application

## Assumptions

* That we're a mature "SOA" company and thing's such as routing, auth, APM and logging are dealt with in their respective layers, not here
* That we have some lovely SOA template to bootstrap off and this was based on it

## Observations

The XML has a [syntax error](./tests/fixtures/test-result.xml)

```
11:	46	Element type "answer" must be followed by either attribute specifications, ">" or "/>".
```

We'll try and find the most lenient parser we can find

## Limitations

At present there are the following limitations


## Security

## Performance

No performance SLA's were given for the project however

Documents could be compressed to save size on disk at the cost of CPU

TBD

### Suggestions

TBD
* microservice template
* clear seperation of responsiblities
* Better Seperation of concerns eg. ingestion/data transformation/reporting
* ETL Pipeline



## Alternatives Solutions


TBD


## Links

### Data testing/monitoring

* Validation
* Obervability
* Security
* Testing

* https://www.linkedin.com/advice/1/what-some-common-data-integrity-issues-how-can-jsclf
* https://datatest.readthedocs.io/en/stable/
* https://www.montecarlodata.com/
* Uploading files to S3 - https://medium.com/@mybytecode/simplified-aws-fastapi-s3-file-upload-3db69431f806 (Skip the round trip to the server)



## Links

- Hosted solution
- Roll our own (lots of wiring/setup/infrastructure as code) unless we already have it i'd stay clear of it for V1
  - 3 hours is not enough time to roll a massivley scalable solution out but I think it's the wrong thing to start with anyhow, start small, focus on the ingestion
- Proeducer (ie. the schools) POST to an exposed endpoint
- https://stackoverflow.com/questions/5606106/what-is-the-maximum-value-size-you-can-store-in-redis
- https://www.composerize.com/

## Questions
- do they have a test harness

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Health Check Out of the Box
Dockerfile out of the box
All the Middleware Goodness
Already had some of the other setup from another app i've been working on
