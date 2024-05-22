# Shiftcare JSON Explorer &nbsp;[![test & lint](https://github.com/yuhonas/shiftcare/actions/workflows/ci.yml/badge.svg)](https://github.com/yuhonas/shiftcare/actions/workflows/ci.yml)

## Background

You are tasked with building a minimalist command-line application using Ruby. Given a JSON dataset with [clients](./spec/fixtures/clients.json), the application will need to offer two commands:

* Search through all clients and return those with names partially matching a given search query
* Find out if there are any clients with the same email in the dataset, and show those duplicates if any are found.

## Installation

You can checkout the repo using

```
git clone git@github.com:yuhonas/shiftcare.git
```

After cloning you will need to execute `./bin/setup` to install any dependencies

or alternatively install the gem directly from the repo (it's not published to ruby gems) by adding the following to your `Gemfile`

```
gem "shiftcare", github: "yuhonas/shiftcare"
```

## Usage

There is a CLI and Interactive Console

### CLI
There is a basic CLI that facilitates some simple data exploration, the following options are available

```
shiftcare-cli v0.1.0 [filename|STDIN] [options]
OPTIONS:
    -s, --search KEYWORD             Search for KEYWORD within the dataset
    -d, --duplicates                 List all duplicates within the dataset
    -h, --help                       Show this message
    -v, --version                    Show the current version
```
Data can be provided either as filename or through STDIN, there is a sample fixture of data under `spec/fixtures/clients.json`

#### Example

```
$ ./bin/shiftcare-cli ./spec/fixtures/clients.json --search john
{"id":1,"full_name":"John Doe","email":"john.doe@gmail.com"}
```
or alternatively if you wish to use STDIN

```
$ cat ./spec/fixtures/clients.json | ./bin/shiftcare-cli --search john
```

All data is returned in `JSON` format for further manipulation if you wish

### Console
There is console for interactive data exploration, it also takes either a file or STDIN

#### Example
```
$ ./bin/console ./spec/fixtures/clients.json

Welcome to the shiftcare JSON explorer
15 records loaded.
A helper instance '@explorer' is available for you to interactively explore this data
>>
```

Data can be explored using the [@explorer](./lib/shiftcare/data_explorer.rb) instance eg.

```
>> @explorer.search 'james'
=> {"id"=>8, "full_name"=>"James Wilson", "email"=>"james.wilson@yandex.com"}
```

## Design Goals
The following goals were kept in mind during development

* Simplicity
* Composability
* Seperation of concerns
* Principle of least suprise
* Dependency Injection (for loose coupling & testability)

However it is _over-designed_ purely for discussion (which could come back and bite me when we build on it), I would think very diffently about a real world practical application

## Assumptions

* This is largely an academic exercise to spur conversation rather then a practical exercise
* We'll be using only JSON with the provided Schema

## Limitations

At present there are the following limitations

* Search is matched insensitively, no partial matching _within_ words, and only the first match is returned, a `FULL TEXT` search engine would solve
all these issues
* The Implementation is tied to the schema of [clients.json](./spec/fixtures/clients.json)
* Only accepts JSON (other interchange formats could be supported potentially)
* There is limited error handling eg. bad json/incorrect schema etc

## Performance

No performance SLA's were given for the project however

* Current performance for the search algorithm is `O(n)`, performance will degrade linearly in proportion to the number of items
* Memory will also degrade lineraly as all items in the `JSON` are loaded in at boot time this could be remedied via data streaming

### Suggestions

For scale, there's many many questions about the design goals, traffic patterns, what alternatives there are and if this is even fit for purpose, my off the cuff suggestion would be a database, for `FULL TEXT` search, `INDEX`es which would scale horizontally (particulary) that it's `READ` heavy but let's discuss

## Alternatives Solutions

The following are simple one liners to the initial problems posited (that'd i'd probably start with in the real world depending)

### Searching JSON by name
```
$ cat clients.json | jq --raw-output '.[] | .full_name' | ag "john"

John Doe
Alex Johnson
```

### Getting all duplicates
```
$ cat clients.json | jq --raw-output '.[] | .email'  | sort | uniq --all-repeated

jane.smith@yahoo.com
jane.smith@yahoo.com
```
