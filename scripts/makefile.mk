#.EXPORT_ALL_VARIABLES
SHELL:=/usr/bin/env bash

PROJECT_NAME ?= ProjectNameHere
TIME_STAMP=$(shell date +"%y%m%d")
STACK_TIMESTAMP:=$(TIME_STAMP)

ifndef MAKE_MODULES_DIR
$(error MAKE_MODULES_DIR is not set)
endif

MAKE_MODULES_DIR := $(MAKE_MODULES_DIR)/make_modules

######################
# Help
######################
define NEWLINE


endef
define HELP_MSG
Usage:
	make help						show this message.
									To install run "make install". It''s recommended to run "make createVirtualEnvironment" and enter the virtual environment first.

	make list						list all targets.
endef
PROJECT_HELP_MSG := $(PROJECT_HELP_MSG)$(NEWLINE)$(HELP_MSG)

include $(MAKE_MODULES_DIR)/checkPythonVersion.mk
include $(MAKE_MODULES_DIR)/installHelpers.mk
include $(MAKE_MODULES_DIR)/unitTesting.mk
include $(MAKE_MODULES_DIR)/linting.mk
include $(MAKE_MODULES_DIR)/cleanup.mk

export PROJECT_HELP_MSG
.PHONY: help
help:
	@printf "%s" "$$PROJECT_HELP_MSG" | less


######################
# Help System
######################
.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'
