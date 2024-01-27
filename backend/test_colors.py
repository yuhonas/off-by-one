import random

from colors import ColorHSL, ColorRGB
from main import app


def test_color_rgb_random():
    color = ColorRGB.random()
    assert isinstance(color, ColorRGB)


def test_color_hsl_random():
    color = ColorHSL.random()
    assert isinstance(color, ColorHSL)
