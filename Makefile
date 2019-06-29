PHONY: serve

serve:
	pipenv run mkdocs serve -a localhost:3300 --dirtyreload

init:
	pipenv install

build:
	pipenv run mkdocs build
