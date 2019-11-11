SHELL:=/usr/bin/env bash

PYTHON3_VERSION=$(shell python3 --version | grep -oE '3\.[7-9]')

ifeq "$(PYTHON3_VERSION)" ""
$(error 'At least Python 3.7 is required.')
endif
