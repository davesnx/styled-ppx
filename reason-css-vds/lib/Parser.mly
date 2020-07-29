%{

open Ast

%}
%token <string> LITERAL
%token <string> DATA
%token <string> FUNCTION
%token <string> PROPERTY
%token DOUBLE_AMPERSAND
%token DOUBLE_BAR
%token BAR
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token ASTERISK
%token PLUS
%token QUESTION_MARK
%token <[ `Comma  | `Space ] * int * int option> RANGE
%token EXCLAMATION_POINT
%token LEFT_PARENS
%token RIGHT_PARENS
%token EOF

%start <Ast.value option> value_of_lex
%start <Ast.multiplier option> multiplier_of_lex
%%

let value_of_lex :=
  | EOF; { None }
  | v = value; EOF; { Some v }
let multiplier_of_lex :=
  | EOF; { None }
  | m = multiplier; EOF; { Some m }

let multiplier :=
  | ASTERISK;
    { Zero_or_more }
  | PLUS;
    { One_or_more }
  | QUESTION_MARK;
    { Optional }
  | r = RANGE;
    {
      match r with
      | (`Space, min, max) -> Repeat (min, max)
      | (`Comma, min, max) -> Repeat_by_comma (min, max)
    }
  | EXCLAMATION_POINT;
    { At_least_one }

let terminal ==
  | l = LITERAL; { Keyword l }
  | d = DATA; { Data_type d }
  | f = FUNCTION; { Function f }
  | p = PROPERTY; { Property_type p }

let terminal_multiplier(terminal) ==
  | t = terminal; { Terminal(t, One) }
  | t = terminal; m = multiplier; { Terminal(t, m) }

let function_call :=
  | terminal_multiplier(terminal)
  | l = LITERAL; LEFT_PARENS; v = value; RIGHT_PARENS; { Function_call(l, v) }

let group :=
  | function_call
  | LEFT_BRACKET; v = value; RIGHT_BRACKET; { v }
  | LEFT_BRACKET; v = value; RIGHT_BRACKET; m = multiplier; { Group(v, m) }

let combinator(sep, sub, kind) == 
  | vs = separated_nonempty_list(sep, sub); ~ = kind;
    { match vs with | v::[] -> v | vs -> Combinator(kind, vs) }

let static_expr ==
  | combinator(| {}, group, | { Static })
let and_expr == 
  | combinator(DOUBLE_AMPERSAND, static_expr, | { And })
let or_expr ==
  | combinator(DOUBLE_BAR, and_expr, | { Or })
let xor_expr ==
  | combinator(BAR, or_expr, | { Xor })

let value :=
  | xor_expr
  (* TODO: this is clearly a workaround *)
  | terminal_multiplier(| RIGHT_PARENS; { Keyword ")" } | LEFT_PARENS; { Keyword "(" })
