SHELL:=/usr/bin/env bash

define HELP_MSG
	make clean						will delete all temporary files for project.
endef
PROJECT_HELP_MSG := $(PROJECT_HELP_MSG)$(NEWLINE)$(NEWLINE)$(HELP_MSG)

##########################
# Clean up
##########################
.PHONY: cleanPyc
cleanPyc:
	@echo 'Cleaning pyc files...'
	@find ./ -name "*.pyc" -delete

.PHONY: cleanPyCache
cleanPyCache:
	@echo 'Cleaning __pycache__ files...'
	@find ./ -name "__pycache__" -type d -delete

.PHONY: cleanTmp
cleanTmp:
	@echo 'Cleaning tmp files...'

.PHONY: cleanCoverage
cleanCoverage:
	@echo 'Cleaning coverage files...'
	@rm -rf $(COVERAGE_DIR)
	@rm -f .coverage

.PHONY: cleanTestResults
cleanTestResults:
	rm -f $(TEST_RESULTS_JSON_FILE)
	rm -rf $(TEST_RESULTS_XML_FOLDER)

.PHONY: clean
clean: cleanPyc cleanTmp cleanPyCache cleanCoverage
	@echo 'Clean.'
