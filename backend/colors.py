import random
from abc import ABCMeta, abstractmethod

from pydantic import BaseModel, Field


class Color(BaseModel, metaclass=ABCMeta):
    """Abstract base class for representing colors."""

    @abstractmethod
    def random(cls):
        """Return a random color."""
        pass


class ColorRGB(Color):
    """
    Represents a color in RGB color space.

    Attributes:
        type (str): The type of color, which is "rgb".
        red (int): The value of the red component, ranging from 0 to 255.
        green (int): The value of the green component, ranging from 0 to 255.
        blue (int): The value of the blue component, ranging from 0 to 255.
    """

    type: str = "rgb"  # NOTE: this should be immutable
    red: int = Field(..., ge=0, le=255)
    green: int = Field(..., ge=0, le=255)
    blue: int = Field(..., ge=0, le=255)

    # create a class method to generate a random color within
    # the constraints of the fields
    @classmethod
    def random(cls):
        """
        Generate a random color within the constraints of the fields.

        Returns:
            ColorRGB: A randomly generated color.
        """
        return cls(
            red=random.randint(0, 255),
            green=random.randint(0, 255),
            blue=random.randint(0, 255),
        )


class ColorHSL(Color):
    """
    Represents a color in the HSL color space.

    Attributes:
        type (str): The type of color, which is "hsl".
        hue (int): The hue value of the color, ranging from 0 to 360.
        saturation (int): The saturation value of the color, ranging from 0 to 100.
        lightness (int): The lightness value of the color, ranging from 0 to 100.
    """

    type: str = "hsl"  # NOTE: this should be immutable
    hue: int = Field(..., ge=0, le=360)
    saturation: int = Field(..., ge=0, le=100)
    lightness: int = Field(..., ge=0, le=100)

    @classmethod
    def random(cls):
        """
        Generates a random ColorHSL object.

        Returns:
            ColorHSL: A randomly generated ColorHSL object.
        """
        return cls(
            hue=random.randint(0, 360),
            saturation=random.randint(0, 100),
            lightness=random.randint(0, 100),
        )
