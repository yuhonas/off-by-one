// simple javascript based color parser/converter
// see https://github.com/One-com/one-color
import OneColor from "onecolor";

const rgbConverter = ({ red, green, blue }) => {
  return {
    name: `rgb: ${red},${green},${blue}`,
    hex: OneColor(`rgb(${red},${green},${blue})`).hex(),
  };
};

const hslConverter = ({ hue, saturation, lightness }) => {
  return {
    name: `hsl: ${hue},${saturation},${lightness}`,
    hex: OneColor(`hsl(${hue},${saturation},${lightness})`).hex(),
  };
};

const factoryTypes = {
  rgb: rgbConverter,
  hsl: hslConverter,
};

// implement factory pattern
// TODO: Implement error case for an invalid color type
const createColorConverterFactory = (color) => {
  return factoryTypes[color.type](color);
};

export { createColorConverterFactory };
