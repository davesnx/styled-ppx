type lexer_mode =
  | Toplevel
  | Selector
  | Declaration_block
  | Declaration_value
  | At_rule_prelude;

type lexer_state = {
  mutable mode: lexer_mode,
  mutable paren_depth: int,
  mutable brace_depth: int,
  mutable bracket_depth: int,
  mutable last_was_ident: bool,
  mutable last_was_combinator: bool,
  mutable last_was_delimiter: bool,
};

let initial_state = () => {
  mode: Toplevel,
  paren_depth: 0,
  brace_depth: 0,
  bracket_depth: 0,
  last_was_ident: false,
  last_was_combinator: false,
  last_was_delimiter: false,
};

let show_mode =
  fun
  | Toplevel => "Toplevel"
  | Selector => "Selector"
  | Declaration_block => "Declaration_block"
  | Declaration_value => "Declaration_value"
  | At_rule_prelude => "At_rule_prelude";
