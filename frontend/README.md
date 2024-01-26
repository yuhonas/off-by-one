# Kanopi Color Swatch [![Frontend](https://github.com/yuhonas/kanopi/actions/workflows/frontend.yml/badge.svg)](https://github.com/yuhonas/kanopi/actions/workflows/frontend.yml) [![Backend API](https://github.com/yuhonas/kanopi/actions/workflows/backend-api.yml/badge.svg)](https://github.com/yuhonas/kanopi/actions/workflows/backend-api.yml) 
Look at the [Nuxt 3 documentation](https://nuxt.com/docs/getting-started/introduction) to learn more.

## Setup

Make sure to install the dependencies:

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install

# bun
bun install
```

## Development Server

Start the development server on `http://localhost:3000`:

```bash
# npm
npm run dev

# pnpm
pnpm run dev

# yarn
yarn dev

# bun
bun run dev
```

## Production

Build the application for production:

```bash
# npm
npm run build

# pnpm
pnpm run build

# yarn
yarn build

# bun
bun run build
```

Locally preview production build:

```bash
# npm
npm run preview

# pnpm
pnpm run preview

# yarn
yarn preview

# bun
bun run preview
```

Check out the [deployment documentation](https://nuxt.com/docs/getting-started/deployment) for more information.


* https://vuejs.org/style-guide/rules-strongly-recommended.html


## limitations
* not dealing with invalid colors, assuming they generated and valid
* the HTML 5 Color input varies accross browsers, I'm aware of this but used it for fun
* the HTML 5 color input only accepts HEX see https://developer.mozilla.org/en-US/docs/Web/HTML/Element/input/color#providing_a_default_color
* i'm aware CSS supports other color spaces eg. HSL natively
* saturation/lightness should be in percentated this now bubbles downstream into the client, they should correct
* are the colors even valid?
* use stdlib colorsys in python
* no mobile responsive view


## documentation
* http://localhost:8000/docs
* https://codepen.io/alemesa/pen/YNrBqr
