# MARKR - Marking as a service (CEO Included)
![marker boss](./public/markr-boss.jpeg)
___Where did all that Series B Money Go?___

## Background

I enjoyed this test, it was well written with many wtf's that do in fact happen IRL and an abundance of conversation starters, I had a laugh so i've responded in kind, See also [BACKGROUND.md](./BACKGROUND.md)

## Requirements

I broke the requirements out into a `TODO` list see [REQUIREMENTS.md](./REQUIREMENTS.md)

## Getting started

### Dependencies

- [Docker](https://docs.docker.com/get-docker/)
- [git](https://git-scm.com/)

### Installation

Once you have installed Docker and git

You can checkout the entire mono repo (yep all my code tests are here) using

```
git clone git@github.com:yuhonas/off-by-one.git
```

Or selectively checkout the `stile` subdirectory using

```
git clone --filter=blob:none --sparse https://github.com/yuhonas/off-by-one.git
cd off-by-one
git sparse-checkout set stile
```

### Development

You can run a development server using

```
./bin/rails server
```

### Testing

You can run the full [RSpec](https://rspec.info/) test suite with

```
bundle exec rspec
```

See also [./spec](./spec)

## Usage

To build the docker container and expose port [3000](./compose.yml#7) to access this service on the host you can run the following

```
docker compose up --build
```

See also [compose.yml](./compose.yml)

## Design Goals

3 hours is not a long time, so I had a few goals in mind

- What does the minimum slice to deliver value to solve this problem look like, **spoiler alert:** what i've got here is more then that but it's a great conversation
- The use of the word "Prototype" and that it may become something we use on production is a hilariously common commerical occurence, so build this as a "first slice" to deliver value for the org
- Optimising for learning, this test is laden with unknown knowns and unknown unknowns which could very well and does happen in real life, so let's build around that to ensure as we learn more we can course correct
- Optimize for conversation, engineering always involves compromises, let's chat about them
- Less is more, I may be able to solve this without code (or less of it) so let's expend a little time to include
  1. Is there any "out of the box solutions" to solve this, if so, great, let's do that whilst also avoiding [Not Invented Here](https://en.wikipedia.org/wiki/Not_invented_here)
  2. If I need to build it what's the write tool for the job, I favoured python/node api frameworks due to popular usage so I looked at express (node)/fastapi (python) amongst others with an eye for maxing out existing technology leverage
  3. Once that framework is found let's keep it simple even at the cost of performance to optimize for serviceability, who knows who will be building on it, start simple
- Replayability, with all the unknowns, we're most likely going to get it wrong, that's ok, as long as we can course correct

Did I spend more then 3 hours... yes, but happy to chat about those constraints/what that would mean professionally and why I spent more 😆

I settled on Rails with bare bones api generation using `rails new stile --api` as it had
* A language i've been coding in recently
* Health Check Out of the Box
* Dockerfile out of the box
* All the Middleware Goodness
* I could re-use code from previous projects

But it didn't have any auto generated [openapi documentation](https://www.openapis.org/) but with only two routes I wasn't concerned

## Assumptions

* That we're a mature "SOA" company and thing's such as SSL, routing, auth, APM and logging are dealt with in their respective layers, not here
* That we have some lovely SOA template to bootstrap off and this was based on it
* That I don't need to worry about deployment and container orchestration and we're using something like kubernetes or amazon fargate etc.
* That even though we'll do our best to respond with all the appropriate response codes, the clients may not obey them
* That catering for "Not paying the AWS bill" and needing persistent storage is simply having a DB persisted on disk, not in memory, although being in arrears for long enough will mean eventual data loss unless we have off-site backup with someone else we're not in arrears with 🤷‍♂️
* That any judgements made about design/coding choices i've made will be discussed

### Notes

I've left plenty of comments throughout the code around things I feel are key to my decision making process

You can either discover them file by file or run

```
./bin/rails notes
```

To get a list of all of them


## Observations

The XML Example has a [syntax error](./BACKGROUND.md#sample)

```
11:	46	Element type "answer" must be followed by either attribute specifications, ">" or "/>".
```

So if this was deliberate, I took the bait and it did highlight that may need the most lenient parser we can find

## Limitations

At present there are the following limitations

* We have a rogue CEO that despite Series B funding we're cutting corners on security and hosting (it can happen)
* We have no XML schema so type/correctness can only be assumed, we're bound to run into all sorts of XML parsing fun and broken assumptions but as long as we know about these and don't back ourselves into a corner we'll learn and improve
* No control of clients so retries/associated response code might not be obeyed


## Security

First of all no SSL from the boss? 😆 props to who-ever wrote that, I honestly think these days it maybe harder to _NOT_ implement SSL then to, I think the better question maybe to ask where does the SSL terminate given we're using SOA's I would assume some set of load balancers/routing layer but in any case if we didn't that's just a risk/impact discussion with technical/non technical stakeholders

As for everything else it almost deserves it's own section, given there is a significant attack surface and the chance for a BEE (Business Ending Event) if we don't take this seriously, student records and [PII](https://en.wikipedia.org/wiki/Personal_data) but as with all thing's we can take a risk based approach, happy to discuss

## Performance

No performance SLA's were given for the project however, performance will be O(n) in regards to the XML document size, making an assumption about how it will be used, it'll be write heavy so IO bound given reporting will be something used infrequently

If the pendulum swings in the reporting direction it'll be CPU bound due to the computational requirements to generate the response

We could go to town with this with performance benchmarks etc but there needs to be a stated goal, I dont think this would be hard to scale but there's a lot of thing's we could do to make this work at big scale (see below)

### Suggestions

Doing this _at scale_ the first thing to do (given we need it and this should be stepped) would be clear seperation of concerns eg.

* Ingestion - ___Consuming that Data via some method in this case `HTTP`___
* Data Transformation - ___Clensing/Normalising/Transforming that data into something usable for us___
* Reporting - ___Generating some kind of human readable report on it___

There are many design patterns for this and it can get architectually quite complex but in general it involves many of the following amongst others

- A bunch of services to operate asynchronously on data during lifecycle events
- Some kind of event streaming platform for ingesting that data at scale eg. Kafka
- Some kind of SNS/pubsub type platform for decoupled signally of key events, ie. the wiring between services
- An [ETL](https://en.wikipedia.org/wiki/Extract,_transform,_load) Pipeline of some description, like what I used on my [resume in spotify's luigi](https://github.com/yuhonas/clintp.xyz/blob/main/resume/resume-transform.py) on my [personal website](https://clintp.xyz/)

Some kind of CI/CD Pipeline for this would be great too, with publication to a [Docker Registry](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images) which would speed up development/deployment as I did with my [dotfiles](https://github.com/yuhonas/dotfiles/pkgs/container/dotfiles%2Fdotfiles-minimal)

#### Data testing/monitoring

We could _at scale_ also consider data testing/monitoring

To ensure we have

* "Valid" Data
* Obervability - Absolutely crucial given the nature of the data we're handling
* Security

## Alternatives Solutions

There maybe hosted solutions or something to bootstrap us towards solving some of these problems, I would prioritize these in the early stages (condtionally) to avoid baking our own solutions/architecture if we didn't need too


## FIN (The End)

That's it folks, I hope you enjoyed my attempt at the stile code test 🙌
