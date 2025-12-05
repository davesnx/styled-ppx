project_name = styled-ppx

OPAM_EXEC = opam exec --
DUNE = $(OPAM_EXEC) dune

.PHONY: help
help: ## Print this help message
	@echo "";
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z0-9_.-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}';
	@echo $(TEST_TARGETS) | tr -s " " "\012" | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m Run %s test \33[1;97m(add \"-watch\" or \"-promote\")\033[0m\n", $$1, $$1}';
	@echo "";

.PHONY: build
build: ## Build the project, including non installable libraries and executables
	$(DUNE) build --promote-install-files --root .

.PHONY: build-prod
build-prod: ## Build for production (--profile=prod)
	$(DUNE) build --profile=prod

.PHONY: clean
clean: ## Clean artifacts
	$(DUNE) clean

.PHONY: format-check
format-check: ## Checks if format is correct
	$(DUNE) build @fmt

.PHONY: fmt format
fmt format: ## Formats code
	$(DUNE) build @fmt --auto-promote

.PHONY: setup-githooks
setup-githooks: ## Setup githooks
	@git config core.hooksPath .githooks

.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . 5.2.0 --deps-only --with-test --no-install

.PHONY: install
install: ## Install project dependencies
	opam update
	opam install . --deps-only --with-test --with-dev-setup --working-dir . -y
	npm install

.PHONY: pin
pin: ## Pin project dependencies
	echo "No pinned dependencies"

.PHONY: init
init: setup-githooks create-switch pin install ## Create a local dev environment

.PHONY: subst
subst: ## Run dune substitute
	$(DUNE) subst

.PHONY: dev
dev: ## Run the project in dev mode
	$(DUNE) build --promote-install-files --root . --watch

.PHONY: release-static
release-static: ## Build static release
	$(DUNE) build --root . --ignore-promoted-rules --profile release-static --only-packages styled-ppx

# Testing commands

TEST_TARGETS := test-css-parser test-css-grammar test-css-grammar-snapshot test-ppx-native test-ppx-snapshot-reason test-css-support test-runtime test-murmur2 test-css-spec-parser test-string-interpolation
# Disabled test-ppx-snapshot-rescript

# Create targets with the format "test-{{target_name}}-{{ "watch" | "promote" }}"
define create-test
.PHONY: $(1)
$(1): ## Run $(1) tests
	$$(DUNE) build @$(1)
endef

define create-test-watch
.PHONY: $(1)-watch
$(1)-watch: ## Run $(1) tests
	$$(DUNE) build @$(1) --watch
endef

define create-test-promote
.PHONY: $(1)-promote
$(1)-promote: ## Run $(1) tests
	$$(DUNE) build @$(1) --auto-promote
endef

$(foreach target,$(TEST_TARGETS), $(eval $(call create-test,$(target))))
$(foreach target,$(TEST_TARGETS), $(eval $(call create-test-watch,$(target))))
$(foreach target,$(TEST_TARGETS), $(eval $(call create-test-promote,$(target))))

.PHONY: test-demo-rescript-v9
test-demo-rescript-v9: ## Run End-to-end tests for JSX3
	npm --prefix 'demo/rescript-v9-JSX3' install
	npm --prefix 'demo/rescript-v9-JSX3' run build
	npm --prefix 'demo/rescript-v9-JSX3' run test

.PHONY: test-demo-rescript-v9-watch
test-demo-rescript-v9-watch: ## Run End-to-end tests for JSX3
	npm --prefix 'demo/rescript-v9-JSX3' run test-watch

.PHONY: test-demo-rescript-v9-promote
test-demo-rescript-v9-promote: ## Run End-to-end tests for JSX3
	npm --prefix 'demo/rescript-v9-JSX3' run test-promote

.PHONY: test-demo-rescript-v10
test-demo-rescript-v10: ## Run End-to-end tests for JSX4
	npm --prefix 'demo/rescript-v10-JSX4' install
	npm --prefix 'demo/rescript-v10-JSX4' run build
	npm --prefix 'demo/rescript-v10-JSX4' run test

.PHONY: test-demo-rescript-v10-watch
test-demo-rescript-v10-watch: ## Run End-to-end tests for JSX4
	npm --prefix 'demo/rescript-v10-JSX4' run test-watch

.PHONY: test-demo-rescript-v10-promote
test-demo-rescript-v10-promote: ## Run End-to-end tests for JSX4
	npm --prefix 'demo/rescript-v10-JSX4' run test-promote

.PHONY: test
test: build
	@for target in $(TEST_TARGETS); do \
		if [ "$(CI)" = "true" ]; then \
			ALCOTEST_VERBOSE=true make $${target}; \
		else \
			ALCOTEST_VERBOSE=false make $${target}; \
		fi \
	done

.PHONY: test
test-promote: build
	@for target in $(TEST_TARGETS); do \
		ALCOTEST_VERBOSE=false make $${target}-promote; \
	done

.PHONY: test-demo
test-demo: build test-demo-rescript-v9 test-demo-rescript-v10 ## Run demo tests

# Demo

.PHONY: demo-rescript-v10
demo-rescript-v10: build ## Run the ReScript v10 demo with JSX4
	npm --prefix 'demo/rescript-v10-JSX4' install
	npm --prefix 'demo/rescript-v10-JSX4' run start

.PHONY: demo-server
demo-server: ## Run the server demo
	$(DUNE) exec demo-server

.PHONY: demo-server-watch
demo-server-watch: ## Run (and watch) the server demo
	$(DUNE) exec demo-server --watch

.PHONY: demo-melange-build
demo-melange-build: ## Build the melange demo
	$(DUNE) build demo/melange

.PHONY: demo-melange-build-watch
demo-melange-build-watch: ## Build the melange demo
	$(DUNE) build demo/melange --watch

.PHONY: demo-melange-serve
demo-melange-serve: ## Serve the melange demo
	npm --prefix 'demo/melange' run serve

# Debug commands

.PHONY: ast
ast: ## Print the command to debug the ast
	@echo "Run the following command to debug the AST"
	@echo "  $(DUNE) exec ast-renderer"

.PHONY: lexer
lexer: ## Print the command to debug the lexer
	@echo "Run the following command to debug the AST"
	@echo "  $(DUNE) exec lexer-renderer"

.PHONY: interpreter
interpreter: ## Run menhir as interpret
	$(OPAM_EXEC) menhir --interpret --interpret-show-cst packages/css-parser/lib/Parser.mly

# Website

.PHONY: website-watch
website-watch: ## Run the website locally
	@cd packages/website && npm run dev
