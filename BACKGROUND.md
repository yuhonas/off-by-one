## Background

My answering objective with the following challenge is to wear many hats as the role (Head of Engineering) would dictate, so strap yourself in for some verbosity 😀 or simply jump to my [TLDR](#tldr)

> The intent of this challenge is to explore general system design,
> along with approaches to code extensibility. While a simple challenge,
> we wish to stress that extensibility is important, please think about
> how easy it would be for others to take your work and add new
> elements to it.

### My Obversations
Building for "__extensibility__"
* First of all we don't know _how_ it's going to be extended and it's a trap to try to anticipate and design for this initially, I feel it's classic [YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it), some quotes that always resonate with me
  * Always implement things when you actually need them, never when you just foresee that you will need them.
  * John Carmack wrote "It is hard for less experienced developers to appreciate how rarely architecting for future requirements / applications turns out net-positive
* I'm a proponent of [Worse is better](https://en.wikipedia.org/wiki/Worse_is_better)
* We're assuming "extensibility" means extended by a developer other then it's author, so I feel the core tenents should given the second/third person to optimize for simplicity & understandability
* With understandability comes readability, changeability, extensibility and maintainability


## Background - Cont
> * Build a back-end to generate color swatches via an API in various color spaces.
> * Build a front-end to consume the back-end API and render the color swatches.
> * Maintain a focus on extensibility in your code.

### My Questions
* What is the actual problem? If we we're empowered with the problem we could potentially solve this in a much more elegant way
* Why do we need to build it? does an existing solution not exist?
* Are there any third party solutions?
* Why is architecture being dictated? does it actually need a backend? do we have external/internal standards for the creation of said services?
* Is this a classic case of [Not Invented Here](https://en.wikipedia.org/wiki/Not_invented_here), feature fascination or [Cargo Culting](https://en.wikipedia.org/wiki/Cargo_cult_programming)

Or as the problem lacks context with people eager to solutionize are we heading down the road of an [XY Problem](https://en.wikipedia.org/wiki/XY_problem)

In any case if we are going to build it

* Who's going to be consuming it/how
* SLA's/SLO/SLI for Availability/Performance
  * Caching/Throttling/Perms etc
* What's going to be the TCO (Total cost of ownership) through the total SDLC of this endevour, will it be net positive?

## Background - Cont

> You've been working on a number of projects within a company across a few teams, and you've found that the teams have a shared requirement for easily viewing "color swatches" using different color spaces.
>
> We'd like to produce a service that could be easily used, and also easily extended,
> by all the teams in the company. The service should be able to render a "swatch" of five colors, each color being potentially represented in a different color space (RGB, HSL, etc).

### My Questions
* For what purpose, why do they need these "color swatches" in different "color spaces"?
* Do we have internal qualification/standards upon when/if something becomes a service and what the implementation will conform too
* Do we have an org that producing a service is a low "cost" endevour, is this the first "sharable" service within the company
* What is "easily" used? I'll make the assumption that it could be "documented" all the way to being discoverable in a Microservice Service Registry
* Is this problem representative of one in Kanopi? I needed to look up [color spaces](https://en.wikipedia.org/wiki/Color_space) I had nfi 😆

> The back-end should provide an API capable of returning to the front-end a set of five different colors for each call.
> Each color should be in a random color space; e.g. if the back-end supports RGB and HSL, then in one call the back-end may return something like (note that your payload structure may be different):

```json

[
  {
    "type": "rgb",
    "red": 255,
    "green": 255,
    "blue": 255
  },
  {
    "type": "hsl",
    "hue": "360",
    "saturation": "100",
    "lightness": "100"
  },
]
```

> The front-end should consume this API, rendering each of the five colors in a swatch to the user.
> The user should be able to regenerate the swatches by clicking a button.

### My questions
* What does 'rendering' a swatch look like, wireframes/figma mockups etc?
* What API standard does this conform too eg. [JSON API](https://jsonapi.org/) or [REST](https://en.wikipedia.org/wiki/REST) are we not adopting a standard here? why wouldn't we?
* Why five different colours? is this a hard limit?
* Why mixing colour spaces? why not normalize the output?
* Is there something here that can _only_ be done on the backend hence necessitating the need for a backend, doubling the implementation & TCO, I would strive for an entirely front end solution if possible
* Why random? and how "random" does it need to be?, subsequent calls could by chance generate a previous combination, is this a problem?
* Would clients be consuming by color space?, If consuming from a "color space" perspective it'd be far more performant to group it by color space for consumers eg.
```json
{
  "rgb": [
    {
      "red": 255,
      "green": 255,
      "blue": 255
    },
  ],
  "hsl":[
    {
      "hue": "360",
      "saturation": "100",
      "lightness": "100"
    }
  ]
```

## Background - Cont

### Stage 1
> We know for sure that we will be using RGB and HSL color spaces. Please implement your service supporting RGB and HSL color spaces.

My solution here would be to use something as out of the box as possible, color spaces are standardized and code implementions of those standards would be abundant so don't re-invent the wheel

### Stage 2

> After we delivered the solution to stage 1 to the teams, we found that one of the teams uses a strange representation of the RGB color space, BRGB. BRGB stores the red, green, and blue components as values between 0 and 10000 (inclusive).
> The team has asked about how they can easily extend your implementation to include the BRGB color space.
>
> Please write a how-to for any team to be able to add new color spaces themselves.
> Have you designed the system in such a way to make it easy and straight forward to extend?

#### My Questions
* If we we're implementing something in a color space that doesn't exist we're venturing into a world of hurt, are we a design company? isn't this a solved problem?
  * I Love the quote - `The nice thing about standards is that you have so many to choose from - Andrew Tanenbaum`
* Let's take the assumption that it needs to support the common color spaces (RGB/HSL/CIE/CMY/YIQ)
* We need an abstract class to represent the space and colours, this is the obvious answer for "extensibility" but I wouldn't do this for the first implementation, we simply don't know where it's going to end up and a premature abstraction adds a needless additional layer of complexity
* Has anyone seen [Color spaces and their uses](https://en.wikipedia.org/wiki/List_of_color_spaces_and_their_uses) I would definitely centre on this to make more informed practical decisions about the real world application of said service

## Background - Cont
> * Ideally you can develop the solution with Django and React, but feel free to use any other technologies you're more comfortable with.
> * Please don't spend more than 3-4 hours on it. If you can't get to do everything, please write down how you would approach adding any missing functionality.
