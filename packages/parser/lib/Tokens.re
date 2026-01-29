[@deriving show({ with_path: false })]
type token =
  | EOF
  | IDENT(string) // <ident-token> - in value context
  | TYPE_SELECTOR(string) // <type-selector-token> - in selector context (div, span, etc.)
  | FUNCTION(string) // <function-token>
  | NTH_FUNCTION(string) // <function-token> (nth-*)
  | AT_KEYWORD(string) // <at-keyword-token>
  | AT_KEYFRAMES(string) // <at-keyframes-token> (non-standard)
  | AT_RULE(string) // <at-rule-token> (non-standard)
  | AT_RULE_STATEMENT(string) // <at-rule-statement-token> (non-standard)
  | UNICODE_RANGE(string) // <unicode-range-token>
  | HASH(
      (
        string,
        [
          | `ID
          | `UNRESTRICTED
        ],
      ),
    ) // <hash-token>
  | STRING(string) // <string-token>
  | URL(string) // <url-token>
  | INTERPOLATION(list(string)) // <interpolation-token> (non-standard)
  | DELIM(string) // <delim-token>
  | DOT // <dot-token> (non-standard)
  | ASTERISK // <asterisk-token> (non-standard)
  | AMPERSAND // <ampersand-token> (non-standard)
  | NUMBER(float) // <number-token>
  | PERCENTAGE(float) // <percentage-token>
  | DIMENSION((float, string)) // <dimension-token>
  | DESCENDANT_COMBINATOR // whitespace as selector combinator (div span)
  | COLON // <colon-token>
  | DOUBLE_COLON // <double-colon-token>
  | IMPORTANT // <important-token>
  | SEMI_COLON // <semicolon-token>
  | COMMA // <comma-token>
  | LEFT_BRACKET // <[-token>
  | RIGHT_BRACKET // <]-token>
  | LEFT_PAREN // <(-token>
  | RIGHT_PAREN // <)-token>
  | LEFT_BRACE // <{-token>
  | RIGHT_BRACE // <}-token>
  | GTE
  | LTE;

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

let string_of_char = c => String.make(1, c);

type error =
  | Invalid_code_point
  | Eof
  | New_line
  | Bad_url
  | Bad_ident;

let show_error =
  fun
  | Invalid_code_point => "Invalid escape sequence"
  | Eof => "Unexpected end of input"
  | New_line => "Unexpected newline in string"
  | Bad_url => "Invalid URL"
  | Bad_ident => "Invalid identifier";

let humanize =
  fun
  | EOF => "the end"
  | IDENT(s) => s
  | TYPE_SELECTOR(s) => s
  | FUNCTION(fn) => fn ++ "("
  | NTH_FUNCTION(fn) => fn ++ "("
  | AT_KEYWORD(s) => "@" ++ s
  | AT_KEYFRAMES(s) => "@" ++ s
  | AT_RULE_STATEMENT(s) => "@" ++ s
  | AT_RULE(s) => "@" ++ s
  | UNICODE_RANGE(s) => s
  | HASH((s, _)) => "#" ++ s
  | STRING(s) => "'" ++ s ++ "'"
  | URL(url) => "url(" ++ url ++ ")"
  | INTERPOLATION(v) => "$(" ++ String.concat(".", v) ++ ")"
  | DELIM(s) => s
  | DOT => "."
  | ASTERISK => "*"
  | AMPERSAND => "&"
  | NUMBER(n) => Number_format.float_to_string(n)
  | PERCENTAGE(n) => Number_format.float_to_string(n) ++ "%"
  | DIMENSION((n, d)) => Number_format.float_to_string(n) ++ d
  | DESCENDANT_COMBINATOR => " "
  | COLON => ":"
  | DOUBLE_COLON => "::"
  | IMPORTANT => "!important"
  | SEMI_COLON => ";"
  | COMMA => ","
  | LEFT_BRACKET => "["
  | RIGHT_BRACKET => "]"
  | LEFT_PAREN => "("
  | RIGHT_PAREN => ")"
  | LEFT_BRACE => "{"
  | RIGHT_BRACE => "}"
  | GTE => ">="
  | LTE => "<=";

let to_debug =
  fun
  | EOF => "EOF"
  | LEFT_BRACE => "LEFT_BRACE"
  | RIGHT_BRACE => "RIGHT_BRACE"
  | LEFT_PAREN => "LEFT_PAREN"
  | RIGHT_PAREN => "RIGHT_PAREN"
  | LEFT_BRACKET => "LEFT_BRACKET"
  | RIGHT_BRACKET => "RIGHT_BRACKET"
  | COLON => "COLON"
  | DOUBLE_COLON => "DOUBLE_COLON"
  | SEMI_COLON => "SEMI_COLON"
  | COMMA => "COMMA"
  | IMPORTANT => "IMPORTANT"
  | IDENT(s) => "IDENT('" ++ s ++ "')"
  | TYPE_SELECTOR(s) => "TYPE_SELECTOR('" ++ s ++ "')"
  | STRING(s) => "STRING('" ++ s ++ "')"
  | FUNCTION(fn) => "FUNCTION(" ++ fn ++ ")"
  | NTH_FUNCTION(fn) => "NTH_FUNCTION(" ++ fn ++ ")"
  | URL(u) => "URL(" ++ u ++ ")"
  | AT_KEYWORD(s) => "AT_KEYWORD('" ++ s ++ "')"
  | AT_KEYFRAMES(s) => "AT_KEYFRAMES('" ++ s ++ "')"
  | AT_RULE_STATEMENT(s) => "AT_RULE_STATEMENT('" ++ s ++ "')"
  | AT_RULE(s) => "AT_RULE('" ++ s ++ "')"
  | HASH((s, kind)) => {
      let kind =
        switch (kind) {
        | `ID => "ID"
        | `UNRESTRICTED => "UNRESTRICTED"
        };
      "HASH('" ++ s ++ "', " ++ kind ++ ")";
    }
  | NUMBER(n) => "NUMBER(" ++ Number_format.float_to_string(n) ++ ")"
  | PERCENTAGE(n) => "PERCENTAGE(" ++ Number_format.float_to_string(n) ++ ")"
  | DIMENSION((n, d)) =>
    "DIMENSION(" ++ Number_format.float_to_string(n) ++ ", " ++ d ++ ")"
  | UNICODE_RANGE(s) => "UNICODE_RANGE('" ++ s ++ "')"
  | INTERPOLATION(v) => "INTERPOLATION('" ++ String.concat(".", v) ++ "')"
  | DELIM(s) => "DELIM('" ++ s ++ "')"
  | DOT => "DOT"
  | ASTERISK => "ASTERISK"
  | AMPERSAND => "AMPERSAND"
  | DESCENDANT_COMBINATOR => "DESCENDANT_COMBINATOR"
  | GTE => "GTE"
  | LTE => "LTE";

let show_mode =
  fun
  | Toplevel => "Toplevel"
  | Selector => "Selector"
  | Declaration_block => "Declaration_block"
  | Declaration_value => "Declaration_value"
  | At_rule_prelude => "At_rule_prelude";
