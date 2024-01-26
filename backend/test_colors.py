import random
from main import app
from colors import ColorRGB, ColorHSL


def test_color_rgb_random():
    color = ColorRGB.random()
    assert isinstance(color, ColorRGB)


def test_color_hsl_random():
    color = ColorHSL.random()
    assert isinstance(color, ColorHSL)
