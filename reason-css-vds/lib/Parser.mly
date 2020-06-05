%{

open Ast

let multiplier value =
  match value with
  | None  -> One
  | Some (value) -> value

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

let terminal :=
  | s = STRING; m = option(multiplier);
    { Keyword (s, multiplier m) }
  | LOWER_THAN; QUOTE; s = STRING; QUOTE; GREATER_THAN; m = option(multiplier);
    { Property_type (s, multiplier m) }
  | LOWER_THAN; s = STRING; GREATER_THAN; m = option(multiplier);
    { Data_type (s, multiplier m) }
  | LEFT_BRACKET; v = value; RIGHT_BRACKET;
    { v }
  | LEFT_BRACKET; v = value; RIGHT_BRACKET; m = multiplier;
    { Group(v, m) }

let combinator(sep, sub, fn) == 
  | vs = separated_nonempty_list(sep, sub); ~ = fn;
    { match vs with | v::[] -> v | vs -> fn vs }

let static_expr ==
  | combinator(| {}, terminal, | { fun vs -> Static vs })
let and_expr == 
  | combinator(DOUBLE_AMPERSAND, static_expr, | { fun vs -> And vs })
let or_expr ==
  | combinator(DOUBLE_BAR, and_expr, | { fun vs -> Or vs })
let xor_expr ==
  | combinator(BAR, or_expr, | { fun vs -> Xor vs })

let value := xor_expr
