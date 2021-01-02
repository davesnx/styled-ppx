open Location;
open New_css_types;

let loc = ((start, last), txt) => {
  let loc = {loc_start: start, loc_end: last, loc_ghost: false};
  {txt, loc};
};
let get_list_loc = list => {
  let loc_start =
    switch (list) {
    | [{loc: {loc_start, _}, _}, ..._] => loc_start
    | _ => raise(Invalid_argument("empty value"))
    };
  let loc_end =
    switch (list |> List.rev) {
    | [{loc: {loc_end, _}, _}, ..._] => loc_end
    | _ => raise(Invalid_argument("empty value"))
    };
  (loc_start, loc_end);
};
let rec trim_left =
  fun
  | [{txt: WHITESPACE, _}, ...tokens] => trim_left(tokens)
  | tokens => tokens;
let trim_right = tokens => tokens |> List.rev |> trim_left |> List.rev;
let trim = tokens => tokens |> trim_left |> trim_right;

let remove_whitespace = List.filter((!=)(WHITESPACE));

let declaration_value = value => {
  let is_important = str => String.lowercase_ascii(str) == "important";
  let value = trim(value);
  // TODO: check according to https://drafts.csswg.org/css-syntax-3/#typedef-declaration-value
  let (value, important) =
    switch (value |> List.rev) {
    | [
        {txt: IDENT(str), loc: {loc_start, _}},
        {txt: DELIM("!"), loc: {loc_end, _}},
        ...value,
      ]
        when is_important(str) => (
        value,
        loc((loc_start, loc_end), true),
      )
    | value => (value, {txt: false, loc: Location.none})
    };

  let value = {
    loc(get_list_loc(value), value);
  };
  (value, important);
};
let rec next_is_rule = next => {
  switch (next()) {
  | LEFT_CURLY => true
  | RIGHT_CURLY
  | SEMICOLON
  | EOF => false
  | _ => next_is_rule(next)
  };
};

let from_lexer = ({txt: token, loc}) => {
  let token =
    switch (token) {
    | Reason_css_lexer.EOF => EOF
    | IDENT(id) => IDENT(id)
    | BAD_IDENT => failwith("grr")
    | FUNCTION(name) => FUNCTION(name)
    | AT_KEYWORD(name) => AT_KEYWORD(name)
    | HASH(s, kind) => HASH((s, kind))
    | STRING(s) => STRING(s)
    | BAD_STRING(_s) => failwith("grr")
    | URL(u) => URL(u)
    | BAD_URL => failwith("grr")
    // TODO: this is a2 workaround for something
    | DELIM("{") => LEFT_CURLY
    // TODO: this is a2 workaround for something
    | DELIM("}") => RIGHT_CURLY
    | DELIM(c) => DELIM(c)
    | NUMBER(n) => NUMBER(n)
    | PERCENTAGE(n) => PERCENTAGE(n)
    | DIMENSION(n, s) => DIMENSION((n, s))
    | WHITESPACE => WHITESPACE
    | CDO => CDO
    | CDC => CDC
    | COLON => COLON
    | SEMICOLON => SEMICOLON
    | COMMA => COMMA
    | LEFT_SQUARE => LEFT_SQUARE
    | RIGHT_SQUARE => RIGHT_SQUARE
    | LEFT_PARENS => LEFT_PARENS
    | RIGHT_PARENS => RIGHT_PARENS
    | LEFT_CURLY => LEFT_CURLY
    | RIGHT_CURLY => RIGHT_CURLY
    };
  {txt: token, loc};
};
let to_lexer = ({txt: token, loc}) => {
  open Reason_css_lexer;
  let token =
    switch (token) {
    | New_css_types.EOF => EOF
    | IDENT(id) => IDENT(id)
    | FUNCTION(name) => FUNCTION(name)
    | AT_KEYWORD(name) => AT_KEYWORD(name)
    | HASH((s, kind)) => HASH(s, kind)
    | STRING(s) => STRING(s)
    | URL(u) => URL(u)
    // TODO: this is a2 workaround for something
    | LEFT_CURLY => DELIM("{")
    | RIGHT_CURLY => DELIM("}")
    | DELIM(c) => DELIM(c)
    | NUMBER(n) => NUMBER(n)
    | PERCENTAGE(n) => PERCENTAGE(n)
    | DIMENSION((n, s)) => DIMENSION(n, s)
    | WHITESPACE => WHITESPACE
    | CDO => CDO
    | CDC => CDC
    | COLON => COLON
    | SEMICOLON => SEMICOLON
    | COMMA => COMMA
    | LEFT_SQUARE => LEFT_SQUARE
    | RIGHT_SQUARE => RIGHT_SQUARE
    | LEFT_PARENS => LEFT_PARENS
    | RIGHT_PARENS => RIGHT_PARENS
    };
  {txt: token, loc};
};
