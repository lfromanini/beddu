# Beddu build Makefile

OUT_DIR = build
OUTPUT = $(OUT_DIR)/beddu.sh
SRC_DIR = src
DEMO_DIR = demo

# Find all direct subdirectories of src and sort them alphabetically
SUBDIRS = $(sort $(dir $(wildcard $(SRC_DIR)/*/)))

# Define a function to get files from a specific directory
get_dir_files = $(wildcard $(1)*.sh)

# Build ALL_SRC_FILES by including files from each subdirectory in order
ALL_SRC_FILES = $(foreach dir,$(SUBDIRS),$(call get_dir_files,$(dir)))

.PHONY: all clean demo build

all: $(OUTPUT)

build:
	@$(MAKE) clean
	@$(MAKE) all

demo: build
	@./$(DEMO_DIR)/demo.sh

$(OUTPUT): $(ALL_SRC_FILES)
	@mkdir -p $(OUT_DIR)
	@echo '#! /usr/bin/env bash' > $(OUTPUT)
	@echo '# shellcheck disable=all' >> $(OUTPUT)
	@echo '#' >> $(OUTPUT)
	@echo '# beddu.sh - A lightweight bash framework for interactive scripts and pretty output' >> $(OUTPUT)
	@echo '# https://github.com/mjsarfatti/beddu' >> $(OUTPUT)
	@echo '#' >> $(OUTPUT)
	@echo '# Generated on: $(shell date)' >> $(OUTPUT)
	@# Process each file, stripping (line) comments and empty lines
	@for file in $(ALL_SRC_FILES); do \
		echo "" >> $(OUTPUT); \
		grep -v '^\s*#' "$$file" | sed '/^[[:space:]]*$$/d' | sed 's/#[a-zA-Z0-9 ]*$$//' >> $(OUTPUT); \
	done
	@chmod +x $(OUTPUT)
	@echo "\nBuild complete: \033[32m$(OUTPUT)\033[0m"

clean:
	@rm -rf $(OUT_DIR)
	@echo "\nClean up completed."