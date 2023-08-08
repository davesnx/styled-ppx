project_name = styled-ppx

OPAM_EXEC = opam exec --
DUNE = $(OPAM_EXEC) dune
opam_file = $(project_name).opam

.PHONY: help
help: ## Print this help message
	@echo "";
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: build
build: ## Build the project, including non installable libraries and executables
	@$(DUNE) build --promote-install-files --root . @@default

.PHONY: build-prod
build-prod: ## Build for production (--profile=prod)
	@$(DUNE) build --profile=prod @@default

.PHONY: clean
clean: ## Clean artifacts
	@$(DUNE) clean

.PHONY: deps
deps: $(opam_file) ## Alias to update the opam file and install the needed deps

.PHONY: format-check
format-check: ## Checks if format is correct
	@$(DUNE) build @fmt

.PHONY: format
fmt format: ## Formats code
	$(DUNE) build @fmt --auto-promote

.PHONY: init
setup-githooks: ## Setup githooks
	@git config core.hooksPath .githooks

.PHONY: pin
pin: ## Pin dependencies
	@opam pin add melange.dev "https://github.com/melange-re/melange.git#d4868a5300c8c6e9f1b387aedb85ded4a705bc0a" -y
	@opam pin add reason.dev "https://github.com/reasonml/reason.git#b283f335f90e3aaa398bff8e82761038ee42a99d" -y
	@opam pin add ppxlib.dev "https://github.com/ocaml-ppx/ppxlib.git#8b8987c5690ad839348d96bf52471b03b88f06ed" -y
	@opam pin add server-reason-react.dev "https://github.com/ml-in-barcelona/server-reason-react.git#bf99d8dbc1e8c686c5b4c9530e5036ecd350ea42" -y

.PHONY: create-switch
create-switch: ## Create opam switch
	@opam switch create . 4.14.1 --deps-only --with-test

.PHONY: install
install: ## Install project dependencies
	@opam install . --deps-only --with-test
	@yarn install

.PHONY: init
init: setup-githooks create-switch pin install ## Create a local dev enviroment

.PHONY: subst
subst: ## Run dune substitute
	@$(DUNE) subst

.PHONY: dev
dev: ## Run the project in dev mode
	$(DUNE) build --promote-install-files --root . --watch

.PHONY: release-static
release-static:
	$(DUNE) build --root . --ignore-promoted-rules --profile release-static --only-packages styled-ppx

# Testing commands

.PHONY: test_typecheck
test_typecheck: ## Run Typecheck tests
	$(DUNE) build @native_typecheck_test

.PHONY: test_css_support
test_css_support: ## Run CSS Support tests
	$(DUNE) build @css_support_test

.PHONY: test_css_support_promote
test_css_support_promote: ## Promote CSS Support snapshots
	$(DUNE) build @css_support_test --auto-promote

.PHONY: test_ppx_snapshot
test_ppx_snapshot: ## Run ppx snapshot tests
	$(DUNE) build @ppx_snapshot_test

.PHONY: test_ppx_snapshot_promote
test_ppx_snapshot_promote: ## Promote ppx snapshot snapshots
	$(DUNE) build @ppx_snapshot_test --auto-promote

.PHONY: test_parser
test_parser: ## Run CSS Parser tests
	$(DUNE) build @parser_test

.PHONY: test_css_lexer
test_css_lexer: ## Run CSS Lexer tests
	$(DUNE) build @css_lexer_test

.PHONY: test_reason_css_parser
test_reason_css_parser: ## Run Reason CSS Parser tests
	$(DUNE) build @reason_css_parser_test

.PHONY: test_css_spec_parser
test_css_spec_parser: ## Run CSS Spec Parser tests
	$(DUNE) build @css_spec_parser_test

.PHONY: test_css_spec_types
test_css_spec_types: ## Run CSS Spec Types tests
	$(DUNE) build @css_spec_types_test

.PHONY: test_e2e
test_e2e: ## Run End-to-end tests for JSX3
	@yarn --cwd 'e2e/rescript-v9-JSX3' test

.PHONY: test_string_interpolation
test_string_interpolation: ## Run string_interpolation tests
	$(DUNE) build @string_interpolation_test

.PHONY: test_all
test_all: build test_typecheck test_css_support test_ppx_snapshot test_parser test_css_lexer test_reason_css_parser test_css_spec_parser test_css_spec_types test_string_interpolation test_e2e

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
