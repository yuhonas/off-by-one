# background
- what is the context
- whats problem are we solving
- is this even the right solution?
- have we looked into alternatives
- why are we building it - https://en.wikipedia.org/wiki/Not_invented_here


# design
- composable
- simple try and use stdlib when possible
- over designed (for discussion points)
- standards based - https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap12.html

- SOLID Principles.
- Don't Repeat Yourself (DRY)
- Encapsulation Principle.
- Principle of Least Astonishment (PoLA)
- You Aren't Gonna Need It (YAGNI)
- Keep It Simple, Stupid (KISS)
- Sharing Design Principles Effectively.


- need full text search or it's naive and non performant

## design patterns used
- why?

# assumptions


# rationale

# implementation

# performance

- aspiring for O(1) time to access values.
- use time to benchmark
- use fibres for improved search
- binary search
- if we have performance metrics we need to meet we could make it into the test suite
- memory performance
- boot time/cold vs warm cache
- all loaded into memory at once

# makefile
- import into another database
- other things??
- benchmark

# testing
- code coverage

# ci

# questions
- fuzzy text searching (Jaro-Winkler Algorithm) (boolean vs fuzzy logic)
- what if we want to use another format other then json eg. YAML, jsonb, json with commments
- https://github.com/ankane/searchkick

# import into database

# alternatives

- import data into

# installation


# alternatives
```
cat clients.json | jq --raw-output '.[] | .full_name' | ag "john"

John Doe
Alex Johnson
```

```
cat clients.json | jq --raw-output '.[] | .email'  | sort | uniq --all-repeated

jane.smith@yahoo.com
jane.smith@yahoo.com

```

## limitations
- only accepts JSON (could be adpated to other interchange formats)


# links
- https://fx.wtf/
- https://github.com/ruby/did_you_mean
- https://github.com/PaulJuliusMartinez/jless
- https://jmespath.org/
- https://github.com/flori/amatch
- https://www.betterspecs.org/#
- https://lite.datasette.io/?json=
