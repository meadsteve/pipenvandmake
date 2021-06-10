PROJECT_PYTHON_VERSION := $(shell cat .python-version)

export PIPENV_IGNORE_VIRTUALENVS := 1 # Always use the one pipenv created
export PIPENV_VENV_IN_PROJECT := 1 # This makes overwriting the env create in a consistent location

.venv: .python-version
	pipenv --python $(PROJECT_PYTHON_VERSION)

Pipfile.lock: Pipfile
	pipenv update

venv.lock: Pipfile.lock .venv
	pipenv sync
	md5sum Pipfile.lock .python-version > venv.lock

.PHONY: moo
moo: venv.lock
	pipenv run python moo.py
