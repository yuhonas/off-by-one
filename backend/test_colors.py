import random

from colors import ColorHSL, ColorRGB
from main import app

# NOTE: Very basic test's could obviously increase the coverage considerably but
# just wanted to get some boilerplate down


def test_color_rgb_random():
    color = ColorRGB.random()
    assert isinstance(color, ColorRGB)


def test_color_hsl_random():
    color = ColorHSL.random()
    assert isinstance(color, ColorHSL)
