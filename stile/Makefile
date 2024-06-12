.PHONY: deps devlint fix test

deps:
	pip install pipenv --upgrade
	pipenv install --dev

dev:
	pipenv run python -m app

lint:
	pipenv run black --check .

fix:
	pipenv run black .

test: fix
	pipenv run python -m pytest
