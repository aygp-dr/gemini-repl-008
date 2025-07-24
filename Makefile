# Gemini REPL 008 - Ruby Implementation
# Main project Makefile

# Detect OS for compatibility
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),FreeBSD)
    MAKE := gmake
    SED := gsed
else
    MAKE := make
    SED := sed
endif

# Ruby settings
RUBY := ruby
BUNDLE := bundle
GEM := gem

# Default target
.PHONY: all
all: setup test

# Setup development environment
.PHONY: setup
setup:
	@echo "==> Setting up Gemini REPL 008 (Ruby)"
	@echo "==> Installing bundler..."
	$(GEM) install bundler
	@echo "==> Installing dependencies..."
	$(BUNDLE) install
	@echo "==> Creating directories..."
	@mkdir -p logs workspace sessions docs/diagrams
	@echo "==> Setting up git hooks..."
	@if [ -d .git ]; then \
		$(BUNDLE) exec overcommit --install 2>/dev/null || true; \
	fi
	@echo "==> Setup complete!"

# Extract code from org files (literate programming)
.PHONY: tangle
tangle:
	@echo "==> Tangling code from RUBY-GEMINI-REPL.org..."
	@emacs --batch \
		--eval "(require 'org)" \
		--eval "(setq org-confirm-babel-evaluate nil)" \
		--eval "(org-babel-tangle-file \"RUBY-GEMINI-REPL.org\")" \
		2>/dev/null || echo "Note: Emacs required for tangling. Install or extract manually."

# Run tests
.PHONY: test
test:
	@echo "==> Running tests..."
	$(BUNDLE) exec rspec

# Run linter
.PHONY: lint
lint:
	@echo "==> Running RuboCop..."
	$(BUNDLE) exec rubocop

# Auto-fix linting issues
.PHONY: fix
fix:
	@echo "==> Auto-fixing linting issues..."
	$(BUNDLE) exec rubocop -a

# Run the REPL
.PHONY: run
run:
	@echo "==> Starting Gemini REPL..."
	$(BUNDLE) exec $(RUBY) bin/gemini-repl

# Run with debug mode
.PHONY: debug
debug:
	@echo "==> Starting Gemini REPL in debug mode..."
	DEBUG=true $(BUNDLE) exec $(RUBY) bin/gemini-repl --debug

# Generate documentation
.PHONY: docs
docs:
	@echo "==> Generating documentation..."
	$(BUNDLE) exec yard doc
	@echo "==> Documentation generated in doc/"

# Open documentation in browser
.PHONY: docs-serve
docs-serve: docs
	@echo "==> Serving documentation on http://localhost:8808"
	$(BUNDLE) exec yard server -r

# Start development console
.PHONY: console
console:
	@echo "==> Starting development console..."
	$(BUNDLE) exec rake console

# Clean build artifacts
.PHONY: clean
clean:
	@echo "==> Cleaning build artifacts..."
	rm -rf pkg/ coverage/ doc/ .yardoc/
	rm -f Gemfile.lock
	rm -rf logs/*.log
	rm -rf workspace/*
	@echo "==> Clean complete!"

# Build gem
.PHONY: build
build:
	@echo "==> Building gem..."
	$(BUNDLE) exec rake build

# Install gem locally
.PHONY: install
install: build
	@echo "==> Installing gem locally..."
	$(BUNDLE) exec rake install

# Show version
.PHONY: version
version:
	@$(RUBY) -r ./lib/gemini_repl/version -e "puts GeminiRepl::VERSION"

# Create a new experiment
.PHONY: new-experiment
new-experiment:
	@read -p "Experiment name: " name; \
	./scripts/new-experiment.sh "$$name"

# Security audit
.PHONY: security
security:
	@echo "==> Running security audit..."
	$(BUNDLE) exec bundle-audit check --update

# Performance profiling
.PHONY: profile
profile:
	@echo "==> Running performance profiler..."
	$(BUNDLE) exec $(RUBY) -r ruby-prof bin/gemini-repl --version

# CI tasks
.PHONY: ci
ci: setup lint test security

# Help
.PHONY: help
help:
	@echo "Gemini REPL 008 (Ruby) - Available targets:"
	@echo ""
	@echo "  Setup & Configuration:"
	@echo "    make setup       - Set up development environment"
	@echo "    make tangle      - Extract code from org files"
	@echo ""
	@echo "  Development:"
	@echo "    make run         - Start the REPL"
	@echo "    make debug       - Start in debug mode"
	@echo "    make console     - Start development console"
	@echo "    make test        - Run tests"
	@echo "    make lint        - Run linter"
	@echo "    make fix         - Auto-fix linting issues"
	@echo ""
	@echo "  Documentation:"
	@echo "    make docs        - Generate YARD documentation"
	@echo "    make docs-serve  - Serve documentation locally"
	@echo ""
	@echo "  Build & Release:"
	@echo "    make build       - Build gem package"
	@echo "    make install     - Install gem locally"
	@echo "    make version     - Show current version"
	@echo ""
	@echo "  Maintenance:"
	@echo "    make clean       - Clean build artifacts"
	@echo "    make security    - Run security audit"
	@echo "    make profile     - Run performance profiler"
	@echo ""
	@echo "  Other:"
	@echo "    make ci          - Run CI tasks"
	@echo "    make help        - Show this help message"

# Default help
.DEFAULT_GOAL := help