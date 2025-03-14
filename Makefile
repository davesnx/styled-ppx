project_name = styled-ppx

OPAM_EXEC = opam exec --
DUNE = $(OPAM_EXEC) dune
opam_file = $(project_name).opam

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

.PHONY: deps
deps: $(opam_file) ## Alias to update the opam file and install the needed deps

.PHONY: format-check
format-check: ## Checks if format is correct
	$(DUNE) build @fmt

.PHONY: format
fmt format: ## Formats code
	$(DUNE) build @fmt --auto-promote

.PHONY: setup-githooks
setup-githooks: ## Setup githooks
	@git config core.hooksPath .githooks

.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . 5.2.0 --deps-only --with-test --no-install

.PHONY: pin
pin: ## Pin dependencies
	opam pin add server-reason-react.dev "https://github.com/ml-in-barcelona/server-reason-react.git#ce006ee5ad5562eee617a4c713b1efa317dc2aab" -y

.PHONY: install
install: pin ## Install project dependencies
	opam install . --deps-only --with-test --working-dir . -y
	npm install

.PHONY: init
init: setup-githooks create-switch install ## Create a local dev enviroment

.PHONY: subst
subst: ## Run dune substitute
	$(DUNE) subst

.PHONY: dev
dev: ## Run the project in dev mode
	$(DUNE) build --promote-install-files --root . --watch

.PHONY: release-static
release-static:
	$(DUNE) build --root . --ignore-promoted-rules --profile release-static --only-packages styled-ppx

# Testing commands

TEST_TARGETS := test-parser test-css-property-parser test-ppx-native test-ppx-snapshot-reason test-ppx-snapshot-rescript test-css-support test-css-spec-types test-runtime test-murmur2 test-css-spec-parser test-string-interpolation

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

.PHONY: test-e2e-rescript-v9
test-e2e-rescript-v9: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9-JSX3' install
	npm --prefix 'e2e/rescript-v9-JSX3' run build
	npm --prefix 'e2e/rescript-v9-JSX3' run test

.PHONY: test-e2e-rescript-v9-watch
test-e2e-rescript-v9-watch: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9-JSX3' run test-watch

.PHONY: test-e2e-rescript-v9-promote
test-e2e-rescript-v9-promote: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9-JSX3' run test-promote

.PHONY: test-e2e-rescript-v10
test-e2e-rescript-v10: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v10-JSX4' install
	npm --prefix 'e2e/rescript-v10-JSX4' run build
	npm --prefix 'e2e/rescript-v10-JSX4' run test

.PHONY: test-e2e-rescript-v10-watch
test-e2e-rescript-v10-watch: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v10-JSX4' run test-watch

.PHONY: test-e2e-rescript-v10-promote
test-e2e-rescript-v10-promote: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v10-JSX4' run test-promote

.PHONY: test
test: build
	@for target in $(TEST_TARGETS); do \
		if [ "$(CI)" = "true" ]; then \
			ALCOTEST_VERBOSE=true make $${target}; \
		else \
			ALCOTEST_VERBOSE=false make $${target}; \
		fi \
	done

.PHONY: test-e2e
test-e2e: build test-e2e-rescript-v9 test-e2e-rescript-v10 ## Run E2E tests

# Demo

.PHONY: demo-e2e-rescript-v10
demo-e2e-rescript-v10: build ## Run the ReScript v10 demo with JSX4
	npm --prefix 'e2e/rescript-v10-JSX4' install
	npm --prefix 'e2e/rescript-v10-JSX4' run start

.PHONY: demo-e2e-melange-debug
demo-e2e-melange-debug: ## Run the melange server demo
	$(DUNE) exec e2e-melange-debug

.PHONY: demo-e2e-melange-debug-watch
demo-e2e-melange-debug-watch: ## Run (and watch) the melange server demo
	$(DUNE) exec e2e-melange-debug --watch

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
	$(OPAM_EXEC) menhir --interpret --interpret-show-cst packages/parser/lib/Parser.mly

.PHONY: website-watch
website-watch: ## Run the website locally
	@cd packages/website && npm run dev
