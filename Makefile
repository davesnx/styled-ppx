project_name = styled-ppx

OPAM_EXEC = opam exec --
DUNE = $(OPAM_EXEC) dune
opam_file = $(project_name).opam

.PHONY: help
help: ## Print this help message
	@echo "";
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2}';
	@echo $(TEST_TARGETS) | tr -s " " "\012" | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36mtest_%-20s\033[0m Run %s test \33[1;97m(or \"test_%s_watch\" to watch them)\033[0m\n", $$1, $$1, $$1}';
	@echo "";

.PHONY: build
build: ## Build the project, including non installable libraries and executables
	$(DUNE) build --promote-install-files --root . @@default

.PHONY: build-prod
build-prod: ## Build for production (--profile=prod)
	$(DUNE) build --profile=prod @@default

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

.PHONY: pin
pin: ## Pin dependencies
	@opam pin add melange.dev "https://github.com/melange-re/melange.git#d4868a5300c8c6e9f1b387aedb85ded4a705bc0a" -y
	@opam pin add reason.dev "https://github.com/reasonml/reason.git#b283f335f90e3aaa398bff8e82761038ee42a99d" -y
	@opam pin add ppxlib.dev "https://github.com/ocaml-ppx/ppxlib.git#8b8987c5690ad839348d96bf52471b03b88f06ed" -y
	@opam pin add server-reason-react.dev "https://github.com/ml-in-barcelona/server-reason-react.git#f46fa4bd9a5490bd3a6d64e1e77dab66028a6a2f" -y

.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . 4.14.1 --deps-only --with-test --no-install

.PHONY: install
install: ## Install project dependencies
	opam install . --deps-only --with-test
	npm install

.PHONY: init
init: setup-githooks create-switch pin install ## Create a local dev enviroment

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

TEST_TARGETS := ppx_snapshot parser css_lexer reason_css_parser css_spec_parser css_support css_spec_types string_interpolation emotion native_typecheck

# Create targets with the format "test_{{target_name}}_{{ "watch" | "promote" }}"
define create_test
.PHONY: test_$(1)
test_$(1): ## Run $(1) tests
	$$(DUNE) build @$(1)_test
endef

define create_test_watch
.PHONY: test_$(1)_watch
test_$(1)_watch: ## Run $(1) tests
	$$(DUNE) build @$(1)_test --watch
endef

define create_test_promote
.PHONY: test_$(1)_promote
test_$(1)_promote: ## Run $(1) tests
	$$(DUNE) build @$(1)_promote
endef

# Apply the create_watch_target rule for each test target
$(foreach target,$(TEST_TARGETS), $(eval $(call create_test,$(target))))
$(foreach target,$(TEST_TARGETS), $(eval $(call create_test_watch,$(target))))
$(foreach target,$(TEST_TARGETS), $(eval $(call create_test_promote,$(target))))

.PHONY: test_e2e
test_e2e: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9-JSX3' install --force
	npm --prefix 'e2e/rescript-v9-JSX3' run build
	npm --prefix 'e2e/rescript-v9-JSX3' run test

.PHONY: test_e2e_watch
test_e2e_watch: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9-JSX3' run test_watch

.PHONY: test_e2e_promote
test_e2e_promote: ## Run End-to-end tests for JSX3
	npm --prefix 'e2e/rescript-v9-JSX3' run test_promote

.PHONY: test
test: build test_native_typecheck test_css_support test_ppx_snapshot test_parser test_css_lexer test_reason_css_parser test_css_spec_parser test_css_spec_types test_string_interpolation test_emotion test_e2e

# Debug commands

.PHONY: ast
ast:
	$(DUNE) exec ast-renderer -- $@

.PHONY: lexer
lexer:
	$(DUNE) exec lexer-renderer -- $@

.PHONY: interpreter
interpreter:
	$(OPAM_EXEC) menhir --interpret --interpret-show-cst packages/parser/lib/css_parser.mly
