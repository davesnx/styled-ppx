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
	@echo $(TEST_TARGETS) | tr -s " " "\012" | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m Run %s test \33[1;97m(or \"%s_watch\" to watch them)\033[0m\n", $$1, $$1, $$1}';
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
	opam switch create . 5.1.1 --deps-only --with-test --no-install

.PHONY: install
install: ## Install project dependencies
	opam install . --deps-only --with-test -y
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

TEST_TARGETS := test_parser test_reason_css_parser test_native_typecheck test_ppx_snapshot_reason test_ppx_snapshot_rescript test_css_support test_css_spec_types test_emotion test_murmur2 test_css_spec_parser test_string_interpolation

# Create targets with the format "test_{{target_name}}_{{ "watch" | "promote" }}"
define create_test
.PHONY: $(1)
$(1): ## Run $(1) tests
	$$(DUNE) build @$(1)
endef

define create_test_watch
.PHONY: $(1)_watch
$(1)_watch: ## Run $(1) tests
	$$(DUNE) build @$(1) --watch
endef

define create_test_promote
.PHONY: $(1)_promote
$(1)_promote: ## Run $(1) tests
	$$(DUNE) build @$(1) --auto-promote
endef

# Apply the create_watch_target rule for each test target
$(foreach target,$(TEST_TARGETS), $(eval $(call create_test,$(target))))
$(foreach target,$(TEST_TARGETS), $(eval $(call create_test_watch,$(target))))
$(foreach target,$(TEST_TARGETS), $(eval $(call create_test_promote,$(target))))

.PHONY: test_e2e_rescript_v9
test_e2e_rescript_v9: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9' install
	npm --prefix 'e2e/rescript-v9' run build
	npm --prefix 'e2e/rescript-v9' run test

.PHONY: test_e2e_rescript_v9_watch
test_e2e_rescript_v9_watch: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9' run test_watch

.PHONY: test_e2e_rescript_v9_promote
test_e2e_rescript_v9_promote: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9' run test_promote

.PHONY: test_e2e_rescript_v10
test_e2e_rescript_v10: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v10' install
	npm --prefix 'e2e/rescript-v10' run build
	npm --prefix 'e2e/rescript-v10' run test

.PHONY: test_e2e_rescript_v10_watch
test_e2e_rescript_v10_watch: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v10' run test_watch

.PHONY: test_e2e_rescript_v10_promote
test_e2e_rescript_v10_promote: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v10' run test_promote

.PHONY: test_e2e_rescript_v11
test_e2e_rescript_v11: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v11' install
	npm --prefix 'e2e/rescript-v11' run build
	npm --prefix 'e2e/rescript-v11' run test

.PHONY: test_e2e_rescript_v11_watch
test_e2e_rescript_v11_watch: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v11' run test_watch

.PHONY: test_e2e_rescript_v11_promote
test_e2e_rescript_v11_promote: ## Run End-to-end tests for JSX4
	npm --prefix 'e2e/rescript-v11' run test_promote

.PHONY: test
test: build
	@for target in $(TEST_TARGETS); do \
		if [ "$(CI)" = "true" ]; then \
			ALCOTEST_VERBOSE=true make $${target}; \
		else \
			ALCOTEST_VERBOSE=false make $${target}; \
		fi \
	done

# Demo

.PHONY: demo_e2e_rescript_v10
demo_e2e_rescript_v10: build ## Run the ReScript v10 demo with JSX4
	npm --prefix 'e2e/rescript-v10' install
	npm --prefix 'e2e/rescript-v10' run start

.PHONY: demo_e2e_melange_debug
demo_e2e_melange_debug: ## Run the melange server demo
	$(DUNE) exec e2e_melange_debug

.PHONY: demo_e2e_melange_debug_watch
demo_e2e_melange_debug_watch: ## Run (and watch) the melange server demo
	$(DUNE) exec e2e_melange_debug --watch

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
	$(OPAM_EXEC) menhir --interpret --interpret-show-cst packages/parser/lib/css_parser.mly
