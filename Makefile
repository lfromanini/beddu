# Beddu build Makefile

OUT_DIR = dist
OUTPUT = $(OUT_DIR)/beddu.sh
SRC_DIR = src
DEMO_DIR = demo
YEAR = $(shell date +%Y)
IP = $(shell curl -s ipinfo.io/ip)

# Find all direct subdirectories of src and sort them alphabetically
SUBDIRS = $(sort $(dir $(wildcard $(SRC_DIR)/*/)))

# Define a function to get files from a specific directory
get_dir_files = $(wildcard $(1)*.sh)

# Build ALL_SRC_FILES by including files from each subdirectory in order
ALL_SRC_FILES = $(foreach dir,$(SUBDIRS),$(call get_dir_files,$(dir)))

.PHONY: all clean demo build _release bump-patch bump-minor bump-major

all: $(OUTPUT)

build:
	@$(MAKE) clean
	@$(MAKE) all

demo: build
	@./$(DEMO_DIR)/demo.sh

_release:
	@if [ -z "$(filter-out $@,$(MAKECMDGOALS))" ]; then \
		echo "Error: Please specify a version number (e.g. make release v0.0.5)"; \
		exit 1; \
	fi
	$(eval VERSION := $(filter-out $@,$(MAKECMDGOALS)))
	@if ! git diff-index --quiet HEAD --; then \
		echo "Error: Git working directory is not clean. Please commit or stash your changes first."; \
		exit 1; \
	fi; \
	$(MAKE) build; \
	sed -i '' "s/# Version: .*/# Version: $(VERSION)/" $(OUTPUT); \
	git add $(OUTPUT); \
	git commit -m "Release $(VERSION)"; \
	git tag -a "$(VERSION)" -m "Release $(VERSION)"
	@echo "\nRelease complete: \033[32m$(VERSION)\033[0m"

# Get the last version tag and increment the appropriate part
release-patch:
	@LAST_VERSION=$$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0"); \
	NEW_VERSION=$$(echo $$LAST_VERSION | awk -F. '{print $$1"."$$2"."$$3+1}'); \
	echo "Bumping patch version from $$LAST_VERSION to $$NEW_VERSION"; \
	$(MAKE) _release $$NEW_VERSION

release-minor:
	@LAST_VERSION=$$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0"); \
	NEW_VERSION=$$(echo $$LAST_VERSION | awk -F. '{print $$1"."$$2+1".0"}'); \
	echo "Bumping minor version from $$LAST_VERSION to $$NEW_VERSION"; \
	$(MAKE) _release $$NEW_VERSION

release-major:
	@LAST_VERSION=$$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0"); \
	NEW_VERSION=$$(echo $$LAST_VERSION | awk -F. '{print "v"$$2+1".0.0"}'); \
	echo "Bumping major version from $$LAST_VERSION to $$NEW_VERSION"; \
	$(MAKE) _release $$NEW_VERSION

%:
	@:

$(OUTPUT): $(ALL_SRC_FILES)
	@mkdir -p $(OUT_DIR)
	@echo '#!/usr/bin/env bash' > $(OUTPUT)
	@echo '# shellcheck disable=all' >> $(OUTPUT)
	@echo '#' >> $(OUTPUT)
	@echo '# beddu.sh - A lightweight bash framework for interactive scripts and pretty output' >> $(OUTPUT)
	@echo '# Version: $(shell git describe --tags --dirty)' >> $(OUTPUT)
	@echo '#' >> $(OUTPUT)
	@echo '# Copyright © $(YEAR) Manuele Sarfatti' >> $(OUTPUT)
	@echo '# Licensed under the MIT license' >> $(OUTPUT)
	@echo '# See https://github.com/mjsarfatti/beddu' >> $(OUTPUT)
	@# Process each file, stripping comments, empty lines, and source lines
	@for file in $(ALL_SRC_FILES); do \
		echo "" >> $(OUTPUT); \
		grep -v '^\s*#\|^source \|^SCRIPT_DIR=\|^readonly BEDDU_.*_LOADED\|^\[\[ \$$BEDDU_.*_LOADED \]\]' "$$file" | sed '/^[[:space:]]*$$/d' | sed 's/#[a-zA-Z0-9 ]*$$//' >> $(OUTPUT); \
	done
	@chmod +x $(OUTPUT)
	@echo "\nBuild complete: \033[32m$(OUTPUT)\033[0m"

clean:
	@rm -rf $(OUT_DIR)
	@echo "\nClean up completed."