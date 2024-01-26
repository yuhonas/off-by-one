// simple javascript based color parser/converter
// see https://github.com/One-com/one-color
import OneColor from 'onecolor'

const rgbConverter = ({ red, green, blue }) => {
  const parsedColor = OneColor(`rgb(${red},${green},${blue})`)

  return {
    name: parsedColor.toJSON(),
    hex: parsedColor.hex()
  }
}

const hslConverter = ({ hue, saturation, lightness }) => {
  // NOTE: This assumes saturation and lightness are integers when in fact they should be %
  // You could normalize them with something like parseInt(<value>) + '%' defensively but i'd
  // rather address the problem up stream
  const parsedColor = OneColor(`hsl(${hue},${saturation}%,${lightness}%)`)

  return {
    name: parsedColor.toJSON(),
    hex: parsedColor.hex()
  }
}

const factoryTypes = {
  rgb: rgbConverter,
  hsl: hslConverter
}

// implement factory pattern for color conversion based on color space type
// FIXME: Implement type checking and throw error if type is not supported
const createColorConverterFactory = (color) => {
  return factoryTypes[color.type](color)
}

export { createColorConverterFactory }
