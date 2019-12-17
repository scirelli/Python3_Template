#.EXPORT_ALL_VARIABLES
SHELL:=/usr/bin/env bash

PROJECT_NAME ?= ProjectName
TIME_STAMP=$(shell date +"%y%m%d")
STACK_TIMESTAMP:=$(TIME_STAMP)
MAKE_MODULES_DIR = ./scripts


include $(MAKE_MODULES_DIR)/makefile.mk
