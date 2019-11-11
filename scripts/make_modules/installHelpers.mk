SHELL:=/usr/bin/env bash

VENV_DIR='.venv'

######################
# Help
######################
define HELP_MSG
	make installForLocalDev			make a virtualenv in the base directory (see createVirtualEnvironment) and install dependencies.
	make createVirtualEnvironment	create a virtual environment in '${VENV_DIR}'.
endef
PROJECT_HELP_MSG := $(PROJECT_HELP_MSG)$(NEWLINE)$(NEWLINE)$(HELP_MSG)

######################
# Install Helpers
######################
.PHONY: install
install: requirements.txt
	@pip install -r requirements.txt

.PHONY: createVirtualEnvironment
createVirtualEnvironment:
	@test -d .venv || python3 -m venv --prompt $(PROJECT_NAME) ./$(VENV_DIR)
	@echo 'Environment created. Run "source ./$(VENV_DIR)/bin/activate" to activate the virtual environment.\n"deactivate" to exit it.'

.PHONY: installForLocalDev
installForLocalDev: createVirtualEnvironment requirements.txt
	@$(VENV_DIR)/bin/pip install --upgrade --requirement requirements.txt
	@echo 'Local install complete'
