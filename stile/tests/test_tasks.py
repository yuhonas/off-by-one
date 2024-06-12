import pytest
from app import main
from app import tasks


def test_aggregate_from_xml():
    xml = open("./tests/fixtures/test-result.xml").read()
    result = tasks.aggregate_from_xml(xml)

    assert result["mean"] == 65.0
    assert result["p25"] == 65.0
    assert result["p50"] == 65.0
    assert result["p75"] == 65.0
    assert result["count"] == 1


def test_multiple_aggregate_from_xml():
    xml = open("./tests/fixtures/test-result-multiple.xml").read()
    result = tasks.aggregate_from_xml(xml)

    assert result["count"] == 2
