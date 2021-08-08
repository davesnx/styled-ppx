%{

open! Location
open! New_css_types
open! Helpers

%}

%token EOF
%token <string> IDENT
%token <string> FUNCTION
%token <string> AT_KEYWORD
%token <string * [ `ID  | `UNRESTRICTED ]> HASH
%token <string> STRING
%token <string> URL
%token <string> DELIM
%token <float> NUMBER
%token <float> PERCENTAGE
%token <float * string> DIMENSION
%token WHITESPACE
%token CDO
%token CDC
%token COLON
%token SEMICOLON
%token COMMA
%token LEFT_SQUARE
%token RIGHT_SQUARE
%token LEFT_PARENS
%token RIGHT_PARENS
%token LEFT_CURLY
%token RIGHT_CURLY

%start <New_css_types.rule option> parse_rule
%start <New_css_types.declaration option> parse_declaration
%start <New_css_types.block option> parse_block
%start <New_css_types.rule Location.loc list Location.loc> parse_stylesheet

%%

let ws == ioption(WHITESPACE)
let with_loc(X) == | x = X; { loc $loc(x) x }

let prelude_token_without_whitespace ==
  | v = IDENT; { IDENT(v) }
  | v = FUNCTION; { FUNCTION(v) }
  | v = AT_KEYWORD; { AT_KEYWORD(v) }
  | v = HASH; { HASH(v) }
  | v = STRING; { STRING(v) }
  | v = URL; { URL(v) }
  | v = DELIM; { DELIM(v) }
  | v = NUMBER; { NUMBER(v) }
  | v = PERCENTAGE; { PERCENTAGE(v) }
  | v = DIMENSION; { DIMENSION(v) }
  | CDO; { CDO }
  | CDC; { CDC }
  | COLON; { COLON }
  | COMMA; { COMMA }
  | LEFT_SQUARE; { LEFT_SQUARE }
  | RIGHT_SQUARE; { RIGHT_SQUARE }
  | LEFT_PARENS; { LEFT_PARENS }
  | RIGHT_PARENS; { RIGHT_PARENS }

(* all tokens except SEMICOLON, LEFT_CURLY and RIGHT_CURLY *)
let prelude_token ==
  | prelude_token_without_whitespace
  | WHITESPACE; { WHITESPACE }

let declaration ==
  | ws; k = IDENT; ws; COLON; v = nonempty_list(with_loc(prelude_token)); {
      let (value, important) = declaration_value v in
      { name = loc $loc(k) k; value; important }
    }

let block_value == 
  | d = declaration; { Declaration(d) }
  | ws; r = qualified_rule; ws; { Rule(r) }

let block :=
  | vs = separated_list(SEMICOLON, with_loc(block_value)); RIGHT_CURLY; { vs }

(* https://drafts.csswg.org/css-syntax-3/#consume-a-qualified-rule *)
(* but it cannot start with an whitespace *)
let qualified_rule ==
  | p1 = with_loc(prelude_token_without_whitespace); ps = list(with_loc(prelude_token)); LEFT_CURLY; b = block; {
    let p = trim (p1 :: ps) in
    let prelude = loc (get_list_loc p) p in
    let block = loc $loc(b) b in
    { kind = Style; prelude; block }
  }

(* https://drafts.csswg.org/css-syntax-3/#consume-qualified-rule *)
let rule :=
  | ws; r = qualified_rule; ws; { r }

(* https://drafts.csswg.org/css-syntax-3/#consume-a-list-of-rules *)
(* TODO: top level *)
let list_of_rules ==
  | ws; rs = separated_list(ws, with_loc(qualified_rule)); EOF; { loc ($startpos, $endpos) rs }

let parse(x) ==
  | x = x; EOF; { Some(x) }
  | EOF; { None }

let parse_rule := | parse(rule)
let parse_declaration := | parse(declaration)
let parse_block := | parse(block)
let parse_stylesheet := list_of_rules

