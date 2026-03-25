type lexer_mode =
  | Toplevel
  | Selector
  | Declaration_block
  | Declaration_value
  | At_rule_prelude;

type unclassified_token =
  | Unclassified_whitespace
  | Unclassified_ident(string)
  | Unclassified_token(Tokens.token);

type unclassified_token_with_location = {
  txt: result(unclassified_token, Tokens.error),
  start_pos: Lexing.position,
  end_pos: Lexing.position,
};

type lexer_state = {
  mutable mode_stack: list(lexer_mode),
  unclassified_buffer: Queue.t(unclassified_token_with_location),
  mutable paren_depth: int,
  mutable brace_depth: int,
  mutable bracket_depth: int,
  mutable last_was_ident: bool,
  mutable last_was_combinator: bool,
  mutable last_was_delimiter: bool,
};

let initial_state = () => {
  mode_stack: [Toplevel],
  unclassified_buffer: Queue.create(),
  paren_depth: 0,
  brace_depth: 0,
  bracket_depth: 0,
  last_was_ident: false,
  last_was_combinator: false,
  last_was_delimiter: false,
};

let current_mode = state =>
  switch (state.mode_stack) {
  | [mode, ..._] => mode
  | [] => Toplevel
  };

let push_mode = (state, mode) => {
  state.mode_stack = [mode, ...state.mode_stack];
};

let replace_mode = (state, mode) => {
  switch (state.mode_stack) {
  | [_current, ...rest] => state.mode_stack = [mode, ...rest]
  | [] => state.mode_stack = [mode]
  };
};

let pop_mode = state => {
  switch (state.mode_stack) {
  | [_current, next, ...rest] =>
    state.mode_stack = [next, ...rest];
    true;
  | [_]
  | [] => false
  };
};

let show_mode =
  fun
  | Toplevel => "Toplevel"
  | Selector => "Selector"
  | Declaration_block => "Declaration_block"
  | Declaration_value => "Declaration_value"
  | At_rule_prelude => "At_rule_prelude";
