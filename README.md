# Kanopi - Color Swatch

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
* SOA/Service Template do we have them? is this the kind of org we want to be? why?
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
  // Three more colors in random combinations of RGB and HSL_
]
```

> The front-end should consume this API, rendering each of the five colors in a swatch to the user.
> The user should be able to regenerate the swatches by clicking a button.

### My questions
* What API standard does this conform too eg. [JSON API](https://jsonapi.org/) or [REST](https://en.wikipedia.org/wiki/REST) are we not adopting a standard here? why wouldn't we?
* Why five different colours? is this a hard limit?
* Why mixing colour spaces? why not normalize the output?
* Is there something here that can _only_ be done on the backend hence necessitating the need for a backend, doubling the implementation & TCO, I would strive for an entirely front end solution if possible
* Why random? and how "random" does it need to be?, subsequent calls could by chance generate a previous combination, is this a problem?
* Is it order sensitive?
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

### My closing questions
* I dont know [Color Theory](https://en.wikipedia.org/wiki/Color_theory)
* Does color theory/rgb/hsl represent real world problems in the org? or just something to explore that _may_ be out of peoples comfort zone
- If it's a color swatch "component" should it be part of a wider component library within the org eg [storybook](https://storybook.js.org/)
* There's an overwhelming fixation with "extending", what's driven this, what's happened in the org, any horror stories to share?
* API design standards, don't re-invent the rule, eg. json api/open api/restful/graphql or at least standization within the org (but needs to be for good reason) then we could implement against a schema/documentation
* How is this test evaluated, rubrick?, how do you navigate hiring/engineer biases?
* I'm answering this as a head of engineering, a lead/staff engineer would be weighted on technical acumen, i'm not doing that, being brutally practical/strategic
* What's the total cost per hire for this to bubble down into recruitment
* What would be the use in making this a client/server application at this point, everything could be done on the frontend unless you need authentication/persistance/etc why complicate it
* Infrastructure I would favour an entirely frontend app for multiple reasons, we don't need django at this stage, it offers nothing
* Going to make assumptions to speed up evaluation process for you and I but you'll know exactly why I made them and I feel that's more critical then some end goal
* Wire frames & User Stories would help greatly
* Without context of the what/why of the problem there is no move to solve for outcomes

## Design goals
* Django for an API at this stage seems over-engineered, model/template/form/admin/emails
* Something simple, popular, standards based
* High signal to noise to optimize for reviewability

* [django rest framework](https://www.django-rest-framework.org/)
* [django ninja](https://django-ninja.dev/)
* input [color element](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/color)
* https://github.com/bgrins/TinyColor
* https://github.com/One-com/one-color


## Assumptions
TBD

## Performance
* There is no IO/persistence layer
* Big O Time Complexity is O(1), Constant time, irespective of input it will remain constant time as the enumeration is fixed
* There is 255^3 colors in RGB (16,777,216), We have 5 colors in the swatch so potentially we have (255^3)^5 possible combinations
* If we have performance SLA's we could implement something like [pytest-benchmark](https://pypi.org/project/pytest-benchmark/) into the CI pipeline

## Suggestions
TBD

## Links
- [ ] Implement [Env Variables](https://vitejs.dev/guide/env-and-mode)
- [ ] Where's it going to be embedded? styling etc
- [ ] [Error Handling](https://stackoverflow.com/questions/48656993/best-practice-in-error-handling-in-vuejs-with-vuex-and-axios)
## Links
- [Tree swing story](https://www.zentao.pm/blog/tree-swing-project-management-tire-analogy-426.html)
- [Microservice Template](https://microservices.io/patterns/service-template.html)
- Best practice [folder structure](https://masterlwa.medium.com/structuring-your-mern-stack-project-best-practices-and-organization-5776861e2c92)
- https://github.com/drwpow/openapi-typescript
- https://www.youtube.com/watch?v=hAzg2iBe6cg

- [Most Popular Color Formats](https://developer.chrome.com/docs/css-ui/high-definition-css-color-guide)
- [Django Rest Framework](https://www.django-rest-framework.org/)
- https://www.github.com/adobe/leonardo
- https://vue-styleguidist.github.io/docs/Documenting.html#code-comments

* https://github.com/adobe/leonardo?tab=readme-ov-file
* https://github.com/d3/d3-color?tab=readme-ov-file
* https://www.npmjs.com/package/@uiw/react-color-swatch
