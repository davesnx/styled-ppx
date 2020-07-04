%{

open Ast

%}
%token <int> INT
%token <string> STRING
%token LOWER_THAN
%token GREATER_THAN
%token QUOTE
%token DOUBLE_AMPERSAND
%token DOUBLE_BAR
%token BAR
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token ASTERISK
%token PLUS
%token QUESTION_MARK
%token LEFT_BRACE
%token RIGHT_BRACE
%token COMMA
%token HASH
%token EXCLAMATION_POINT
%token LEFT_PARENS
%token RIGHT_PARENS
%token SLASH
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

let range ==
  | LEFT_BRACE; min = INT; RIGHT_BRACE;
    { (min, Some min) }
  | LEFT_BRACE; min = INT; COMMA; max = option(INT); RIGHT_BRACE;
    { (min, max) }

let multiplier :=
  | ASTERISK;
    { Zero_or_more }
  | PLUS;
    { One_or_more }
  | QUESTION_MARK;
    { Optional }
  | r = range;
    {
      let (min, max) = r in
      Repeat (min, max)
    }
  | HASH; r = range;
    {
      let (min, max) = r in
      Repeat_by_comma (min, max)
    }
  | HASH;
    { Repeat_by_comma (1, None) }
  | EXCLAMATION_POINT;
    { At_least_one }

let terminal ==
  | s = STRING; { Keyword s }
  | SLASH; { Keyword "/" }
  | COMMA; { Keyword "," }
  | LOWER_THAN; QUOTE; s = STRING; QUOTE; GREATER_THAN; { Property_type s }
  | LOWER_THAN; s = STRING; GREATER_THAN; { Data_type s }
  | LOWER_THAN; s = STRING; LEFT_PARENS; RIGHT_PARENS; GREATER_THAN; { Data_type (s ^ "()") }
  | s = STRING; LEFT_PARENS; RIGHT_PARENS; { Function s }

let terminal_multiplier ==
  | t = terminal; { Terminal(t, One) }
  | t = terminal; m = multiplier; { Terminal(t, m) }

let function_call ==
  | terminal_multiplier
  | s = STRING; LEFT_PARENS; v = value; RIGHT_PARENS; { Function_call (s, v) }

let group ==
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

let value := xor_expr
