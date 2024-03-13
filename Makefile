SRC_DIR = slides
BUILD_DIR = build
SRC_FILES = $(wildcard $(SRC_DIR)/*[0-9]_*.md)
HEADER_FILE = $(firstword $(SRC_FILES))
REST_FILES = $(filter-out $(HEADER_FILE), $(SRC_FILES))
OUTPUT_FILE = $(BUILD_DIR)/slide.md
THEME_NAME = honwaka-theme
THEME_REPO = https://github.com/abap34/honwaka-theme
MARPRC_FILE = .marprc.yml


all: clean preprocess pdf html pptx

preprocess: $(OUTPUT_FILE)
	@echo "Preprocessing..."
	
$(OUTPUT_FILE): $(SRC_FILES)
	@mkdir -p $(BUILD_DIR)
	@echo "Clone theme..."
	@git clone $(THEME_REPO)
	@mv $(THEME_NAME) $(BUILD_DIR)
	@echo "Creating slide file..."
	@echo "N_SECTION = $(words $(SRC_FILES))"

	@echo "HEADER_FILE = $(HEADER_FILE)"
	@cat $(HEADER_FILE) > $(OUTPUT_FILE)
	
	@for file in $(REST_FILES); do \
		echo "### section: $$file"; \
		awk 'BEGIN { found = 0; } { if (found == 2) print; if ($$0 == "---") found++; }' $$file >> $(OUTPUT_FILE); \
	done

pdf: preprocess
	@echo "Creating PDF..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --output $(BUILD_DIR)/slide.pdf

html: preprocess
	@echo "Creating HTML..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --output $(BUILD_DIR)/slide.html

pptx: preprocess
	@echo "Creating PPTX..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --output $(BUILD_DIR)/slide.pptx


preview: clean preprocess
	@echo "Creating preview..."
	@marp $(OUTPUT_FILE) --config-file $(MARPRC_FILE) --preview


clean:
	@echo "Cleaning up..."
	@rm -rf $(BUILD_DIR)
	@rm -rf honwaka-theme

.PHONY: all preprocess pdf html preview clean
