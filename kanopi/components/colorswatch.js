/*
 * Simple library of functions from converting colors from a "type" to a web safe color
 * @see {@link https://d3js.org/d3-color}
 */

import { color as D3Color } from 'd3-color'

const rgbConverter = ({ red, green, blue }) => {
  const parsedColor = D3Color(`rgb(${red},${green},${blue})`)

  return {
    name: parsedColor.formatRgb(),
    hex: parsedColor.hex()
  }
}

const hslConverter = ({ hue, saturation, lightness }) => {
  // NOTE: This assumes saturation and lightness are integers when in fact they should be %
  // You could normalize them with something like parseInt(<value>) + '%' defensively but i'd
  // rather address the issue up stream
  const parsedColor = D3Color(`hsl(${hue},${saturation}%,${lightness}%)`)

  return {
    name: parsedColor.formatHsl(),
    hex: parsedColor.hex()
  }
}

// Simple factory pattern for instantiating color converters based on "type"
// NOTE: as these are really only thin wrappers around D3Color objects and we may want to utilize
// some of the other methods offered from D3color we could potentially return a `Proxy`
const createColorConverterFactory = ({ type, ...colors }) => {
  switch (type) {
    case 'rgb':
      return rgbConverter(colors)
    case 'hsl':
      return hslConverter(colors)
    default:
      // NOTE:
      // if we had type safety/agreed schema between the frontend and backend we wouldn't
      // need to deal with this, but for now we'll just throw an error
      // i'd prefer to "make impossible states impossible"
      // something i picked up from elm
      // https://sporto.github.io/elm-patterns/basic/impossible-states.html
      throw new Error(`Unsupported color type: ${type}`)
  }
}

export { createColorConverterFactory }
