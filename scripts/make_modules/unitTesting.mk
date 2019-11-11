SHELL:=/usr/bin/env bash

define HELP_MSG
	make test						will run all unit tests and integration tests.

	make unitTestDebug				will run the unit tests in debug mode.

	make openReport					will generate the unit test code coverage report and open it in Chrome.
endef
PROJECT_HELP_MSG := $(PROJECT_HELP_MSG)$(NEWLINE)$(NEWLINE)$(HELP_MSG)

########################
# Unit Testing
########################
TESTS_DIR=tests/unit
MIN_TEST_COVERAGE ?= 0
UNIT_TEST_REPORT_COMMON_FLAGS =
COVERAGE_DIR='coverage_data'
TEST_RESULTS_JSON_FILE?=/tmp/testResults.json
TEST_RESULTS_XML_FOLDER?=/tmp/unit_test_xml_results
PYTHONPATH=$(shell echo "`pwd`:$$PYTHONPATH")

.PHONY: test
test: unitTest integrationTests
	@echo 'Testing complete'

.coverage: cleanCoverage
	@PYTHONBREAKPOINT=0 \
	PYTHONPATH=$(PYTHONPATH) \
	coverage run --branch -m unittest discover --verbose --pattern '*_test.py' --start-directory $(TESTS_DIR) --top-level-directory '.'

.PHONY: unitTest
unitTest: .coverage
	@echo

.PHONY: unitTestReport
unitTestReport: .coverage
	@coverage xml -o $(COVERAGE_DIR)/unit_test_coverage.xml
	@coverage html --skip-covered --directory=$(COVERAGE_DIR)/unit_test_coverage_html
	coverage report --skip-covered --show-missing

.PHONY: unitTestFailUnder
unitTestFailUnder: .coverage
	coverage report --fail-under=$(MIN_TEST_COVERAGE) --skip-covered --show-missing 1>/dev/null

.PHONY: unitTestDebug
unitTestDebug:
	PYTHONPATH=$(PYTHONPATH) \
    python -m unittest discover --verbose --pattern '*_test.py' --start-directory $(TESTS_DIR) --top-level-directory '.'

.PHONY: unitTestJSON
unitTestJSON: cleanCoverage cleanTestResults
	@PYTHONBREAKPOINT=0 \
	PYTHONPATH=$(PYTHONPATH) \
	coverage run --branch -m tests.utils.unittest.json discover --verbose --pattern '*_test.py' --start-directory $(TESTS_DIR) --top-level-directory '.' 2> $(TEST_RESULTS_JSON_FILE)

.PHONY: openReport
openReport: unitTestReport
	open -a "Google Chrome" file://`pwd`/$(COVERAGE_DIR)/unit_test_coverage_html/index.html



########################
# Integration Testing
########################

.PHONY: integrationTests
integrationTests:
	@echo 'No integration tests here.'
