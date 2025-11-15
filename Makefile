GOOS ?= $(shell go env GOOS)
GOARCH ?= $(shell go env GOARCH)

BUILD_DIR := build

PROJECTS := $(shell find . -maxdepth 1 -type d ! -name build ! -name . -exec test -f "{}/main.go" \; -print | sed 's|^\./||')

BUILD_FLAGS := -ldflags "-s -w"

BINARIES := $(addprefix $(BUILD_DIR)/,$(addsuffix _$(GOOS)_$(GOARCH),$(PROJECTS)))

.PHONY: all clean

all: $(BINARIES)

$(BUILD_DIR)/%_$(GOOS)_$(GOARCH): %
	@mkdir -p $(BUILD_DIR)
	@echo "Сборка $< для $(GOOS)/$(GOARCH)..."
	@cd $< && GOOS=$(GOOS) GOARCH=$(GOARCH) go build $(BUILD_FLAGS) -o $(CURDIR)/$@

clean:
	rm -rf $(BUILD_DIR)
