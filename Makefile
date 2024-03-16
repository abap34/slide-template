SRC_DIR := slides
BUILD_DIR := build
SRC_FILES := $(wildcard $(SRC_DIR)/*.md)
HEADER_FILE := $(firstword $(SRC_FILES))
REST_FILES := $(filter-out $(HEADER_FILE), $(SRC_FILES))
OUTPUT_FILE := $(BUILD_DIR)/slide.md
THEME_NAME := honwaka-theme
THEME_REPO := https://github.com/abap34/honwaka-theme
MARPRC_FILE := .marprc.yml

.PHONY: all setup pdf html pptx preview clean

all: clean setup pdf html pptx

setup: $(OUTPUT_FILE)
	@echo "Setup theme and slide file..."

$(OUTPUT_FILE): $(SRC_FILES)
	@mkdir -p $(BUILD_DIR)
	@echo "Clone theme..."
	@git clone $(THEME_REPO) $(BUILD_DIR)/$(THEME_NAME)
	@echo "Creating slide file..."
	@echo "N_SECTION = $(words $(SRC_FILES))"
	@cp -r $(SRC_DIR)/* $(BUILD_DIR)/
	@echo "HEADER_FILE = $(HEADER_FILE)"
	@cat $(HEADER_FILE) > $(OUTPUT_FILE)
	@for file in $(REST_FILES); do \
		echo "### section: $$file"; \
		awk 'BEGIN { found = 0; } { if (found >= 2) print; if ($$0 == "---") found++; }' $$file >> $(OUTPUT_FILE); \
	done

pdf: setup
	@echo "Creating PDF..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --output $(BUILD_DIR)/slide.pdf

html: setup
	@echo "Creating HTML..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --output $(BUILD_DIR)/slide.html

pptx: setup
	@echo "Creating PPTX..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --output $(BUILD_DIR)/slide.pptx

preview: clean setup
	@echo "Creating preview..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --preview

clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)
