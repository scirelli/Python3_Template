SHELL:=/usr/bin/env bash

define HELP_MSG
	make lint						will run all linters.
endef
PROJECT_HELP_MSG := $(PROJECT_HELP_MSG)$(NEWLINE)$(NEWLINE)$(HELP_MSG)

##########################
# Linting
##########################
.phony: pylint
pylint:
	@echo '###### Pylint #######'
	@find . -type d -name '.venv' -prune -o -type d -name '.git' -prune -o -name '*.py' -print -exec pylint --jobs=0 "{}" +
	@echo '#####################'

.phony: flake8
flake8:
	@echo '###### Flake8 #######'
	@find . -type d -name '.venv' -prune -o -type d -name '.git' -prune -o -name '*.py' -print -exec flake8 --jobs=0 "{}" +
	@echo '#####################'

.PHONY: lint
lint: pylint flake8
	@echo 'Linting with Flake8 and Pylint complete'
