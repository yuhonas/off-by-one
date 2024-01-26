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

// implement factory pattern
// TODO: Implement error case for an invalid color type
const createColorConverterFactory = (color) => {
  return factoryTypes[color.type](color)
}

export { createColorConverterFactory }
