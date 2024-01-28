# Kanopi - Color Swatch  [![Build & Deploy static site](https://github.com/yuhonas/kanopi/actions/workflows/frontend-site.yml/badge.svg)](https://github.com/yuhonas/kanopi/actions/workflows/frontend-site.yml) [![Build & Deploy Backend API](https://github.com/yuhonas/kanopi/actions/workflows/backend-api.yml/badge.svg)](https://github.com/yuhonas/kanopi/actions/workflows/backend-api.yml)

A basic color swatch "renderer" built using [Vue.js](https://vuejs.org/) & [Nuxt](https://nuxt.com/), essentially the VueJS equivilient of [Next.JS](https://nextjs.org/)

![example color swatch](./example.jpg)

See [BACKGROUND.md](./BACKGROUND.md) on the test brief and my running thoughts about it, i've gone above and beyond because of the nature of the role (Head of Engineering)

## Project Organization

The project is divided into two components, this project and the backend [API](./api) which is the data provider for this component

## Design Rationale

First of all, i've been using Vue.js recently for personal projects so it was quicker for me to build something in that then React though I did do some brief research into some of the available frameworks/components in the React ecosystem like
* [react-color-swatch](https://www.npmjs.com/package/@uiw/react-color-swatch)
* [react color](https://casesandberg.github.io/react-color/)

I also looked into Adobe's [leonardo](https://github.com/adobe/leonardo) but then time boxed it & made a call to optimize for discussion rather then the perfect implementation & tooling

## Getting Started

### Dependencies
* Node 20.x
* NPM 10.x

### Installation

You can checkout the repo using

```
git clone git@github.com:yuhonas/kanopi.git
```

Install dependencies using

```
npm install
```

See [package.json](./package.json) for other useful tasks

### Development

You can run a development server using

```
npm run dev
```

It defaults to serving a local JSON file as the backend data source see [nuxt.config.ts](./nuxt.config.ts#L16) you can override this by modifying the config or overiding it an `ENV` variable to the backend data source eg.

```
NUXT_PUBLIC_API_URL=http://www.example.com npm run dev
```

If you want something live to test against, the most recent deployed backend API URL is always available as build output in the [Backend API CD Jobs](https://github.com/yuhonas/kanopi/actions/workflows/backend-api.yml), it will be in the "Build Summary" in the job's detail


## Design Goals

* Simplicity
* Readability
* Optimize for discussion, i've left notes where i've thought a snap judgement/unintentional hiring bias could be made
* A bit of over-engineering for fun to explore what can/should/shouldn't be done

## Limitations

* There is no test cases, i've only added basic linting in to keep thing's consistent, obviously this could be expanded in all kinds of ways

## Deployment

This static site is currently deployed to github pages see [yuhonas.github.io/kanopi](https://yuhonas.github.io/kanopi/) via a [Github Action CD Job](./.github/workflows/frontend-site.yml)

## Extending

This has been designed with adding non conventional color spaces in mind eg. `BRGB` so there is an abstraction layer to deal with a color space "type" and some way to render it into a _web safe version_ eg. let's implement BRGB

> BRGB stores the red, green, and blue components as values between 0 and 10000 (inclusive).

Assuming from the [API Schema](https://j8adom76wl.execute-api.ap-southeast-2.amazonaws.com/openapi.json) we're getting a record of something like

```json
[
  {
    "type": "brgb",
    "red": "3000",
    "green": "500",
    "blue": "9000"
  }
]
```

We'll need to add the appropriate converter logic on the [frontend color parser](./components/colorswatch.js) so we have a mapping of that "type" to a web safe renderable version eg.

```javascript
const brgbConverter = ({ red, green, blue }) => {
  const parsedColor = someFictionalBRGBParser.parse(red, green, blue)

  return {
    name: parsedColor.someName(); // a name to be displayed in the rendered swatch
    hex: parsedColor.hex(), // a web safe version of this color
  };
};
```

Then you'll need to add a way to instantiate that converter based on the type via the factory design pattern in [colors_swatch.js](./components/colorswatch.js)

```javascript
const createColorConverterFactory = ({ type, ...colors }) => {
  switch (type) {
    case "brgb":
      return brgbConverter(colors);
  // .....
```


## My closing thoughts 🤔
I'm not a big of this overall implementation, _many assumptions_ have been made that wouldn't be in the world real, the implementation is on the way but I feel there'd be far more simpler, elegant solution, heres what I dont like, why and what i'd improve

* The backend offer's nothing that couldn't be done on the frontend (in it's present state)
* Making the assumption we need to cater for "non standard" color spaces and they need to be rendered in a web safe manner introduces a lot of complexity on the frontend essentially doubling the abstraction layer/transformation logic, eg. extending it requires making changes in "two places" and there is no single source of truth
* No

### Better Solutions

* Do this all on the frontend there are a wealth of frontend color libraries/components, we could then
consider making it part of a wider "component" library via something like [Story Book](https://storybook.js.org/) within the ORG
* If we still want to keep the backend color models and transformational logic on the frontend add some integration test's to ensure they both "work together" so that test's would break if somebody doesn't extend it on both the backend/frontend
* Simplify the client side logic by the introduction of a web safe color in the backend `JSON` for each generated color in each color space eg. `rgbColor: #EFEFEF`, then the client would be drastically thinner & simply render out the swatch and web safe color representation
* Generate the frontend client based on our [openapi schema](https://j8adom76wl.execute-api.ap-southeast-2.amazonaws.com/openapi.json) with something like  [openapi-typescript](https://www.npmjs.com/package/openapi-typescript) then we would have a single source of truth/type safety etc


#### Alternative solutions

I did limited research but i'm sure there'd be a whole host of other tooling/no code/low code/generators to produce something like this, again I timeboxed it for expediancy
