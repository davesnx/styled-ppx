%{

open Css_types

let clean_ws (value) = value

%}

%token EOF
%token WS
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_PAREN
%token RIGHT_PAREN
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token COLON
%token SEMI_COLON
%token PERCENTAGE
%token IMPORTANT
%token AMPERSAND
%token DOT
%token LESS_THAN
%token BIGGER_THAN
%token COMMA
%token PLUS
%token MINUS
%token MULTIPLY
%token DIVIDE
%token EQUAL
%token PIPELINE
%token TILDE
%token <string> IDENT
%token <string> STRING
%token <string> URI
%token <string> OPERATOR
%token <string> DELIM
%token <string> NESTED_AT_RULE
%token <string> AT_RULE_WITHOUT_BODY
%token <string> AT_RULE
%token <string> FUNCTION
%token <string> PSEUDOCLASS
%token <string> PSEUDOELEMENT
%token <string> HASH
%token <string> NUMBER
%token <string> UNICODE_RANGE
%token <string * string * Css_types.dimension> FLOAT_DIMENSION
%token <string * string> DIMENSION
%token <string list> VARIABLE
%token UNSAFE

%start <Css_types.Stylesheet.t> stylesheet
%start <Css_types.Declaration_list.t> declaration_list
%start <Css_types.Declaration.t> declaration

%%

stylesheet:
  s = stylesheet_without_eof; EOF { s }
  ;

stylesheet_without_eof:
  rs = list(rule) { (rs, Lex_buffer.make_loc $startpos $endpos) }
  ;

declaration_list:
  | EOF { ([], Lex_buffer.make_loc $startpos $endpos) }
  | ds = declarations_with_loc; EOF { ds }
  ;

rule:
  | r = at_rule { Rule.At_rule r }
  | r = style_rule { Rule.Style_rule r }
  ;

at_rule:
  | name = AT_RULE_WITHOUT_BODY; xs = separated_nonempty_list(WS, prelude_with_loc); SEMI_COLON {
      { At_rule.name = (name, Lex_buffer.make_loc $startpos(name) $endpos(name));
        prelude = (xs, Lex_buffer.make_loc $startpos $endpos);
        block = Brace_block.Empty;
        loc = Lex_buffer.make_loc $startpos $endpos;
      }
    }
  | name = NESTED_AT_RULE; xs = separated_nonempty_list(WS, prelude_with_loc); LEFT_BRACE; s = stylesheet_without_eof; RIGHT_BRACE {
      { At_rule.name = (name, Lex_buffer.make_loc $startpos(name) $endpos(name));
        prelude = (xs, Lex_buffer.make_loc $startpos $endpos);
        block = Brace_block.Stylesheet s;
        loc = Lex_buffer.make_loc $startpos $endpos;
      }
    }
  | name = AT_RULE; xs = separated_nonempty_list(WS, prelude_with_loc); LEFT_BRACE; ds = declarations_with_loc; RIGHT_BRACE {
      { At_rule.name = (name, Lex_buffer.make_loc $startpos(name) $endpos(name));
        prelude = (xs, Lex_buffer.make_loc $startpos $endpos);
        block = Brace_block.Declaration_list ds;
        loc = Lex_buffer.make_loc $startpos $endpos;
      }
    }
  | name = NESTED_AT_RULE; xs = separated_nonempty_list(WS, prelude_with_loc); LEFT_BRACE; ds = declarations_with_loc; RIGHT_BRACE {
      { At_rule.name = (name, Lex_buffer.make_loc $startpos(name) $endpos(name));
        prelude = (xs, Lex_buffer.make_loc $startpos $endpos);
        block = Brace_block.Declaration_list ds;
        loc = Lex_buffer.make_loc $startpos $endpos;
      }
    }
  ;

style_rule:
  | xs = separated_nonempty_list(WS, prelude_with_loc); LEFT_BRACE; RIGHT_BRACE {
      { Style_rule.prelude = (xs, Lex_buffer.make_loc $startpos $endpos);
        block = [], Location.none;
        loc = Lex_buffer.make_loc $startpos $endpos;
      }
    }
  | xs = separated_nonempty_list(WS, prelude_with_loc); LEFT_BRACE; ds = declarations_with_loc; RIGHT_BRACE {
      { Style_rule.prelude = (xs, Lex_buffer.make_loc $startpos $endpos);
        block = ds;
        loc = Lex_buffer.make_loc $startpos $endpos;
      }
    }
  ;

declarations_with_loc:
  | ds = declarations { (ds, Lex_buffer.make_loc ~loc_ghost:true $startpos $endpos) }
  ;

declarations:
  | ds = declarations_without_ending_semi_colon { List.rev ds }
  | ds = declarations_without_ending_semi_colon; SEMI_COLON { List.rev ds }
  ;

declarations_without_ending_semi_colon:
  | d = declaration_or_at_rule { [d] }
  | ds = declarations_without_ending_semi_colon; d = declaration_or_at_rule { d :: ds }
  | ds = declarations_without_ending_semi_colon; SEMI_COLON; d = declaration_or_at_rule { d :: ds }
  ;

declaration_or_at_rule:
  | d = declaration_without_eof { Declaration_list.Declaration d }
  | u = unsafe { Declaration_list.Unsafe u }
  | r = at_rule { Declaration_list.At_rule r }
  | s = style_rule { Declaration_list.Style_rule s }
  ;

declaration:
  d = declaration_without_eof; SEMI_COLON?; EOF { d }
  ;

declaration_without_eof:
  n = IDENT; COLON; v = list(component_value_with_loc); i = boption(IMPORTANT) {
    { Declaration.name = (n, Lex_buffer.make_loc $startpos(n) $endpos(n));
      value = (v, Lex_buffer.make_loc $startpos(v) $endpos(v));
      important = (i, Lex_buffer.make_loc $startpos(i) $endpos(i));
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  ;

unsafe:
  UNSAFE; n = IDENT; COLON; v = list(component_value_with_loc); i = boption(IMPORTANT) {
    { Declaration.name = (n, Lex_buffer.make_loc $startpos(n) $endpos(n));
      value = (v, Lex_buffer.make_loc $startpos(v) $endpos(v));
      important = (i, Lex_buffer.make_loc $startpos(i) $endpos(i));
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  ;

paren_block:
  LEFT_PAREN; xs = list(component_value_with_loc); RIGHT_PAREN { xs }
  ;

bracket_block:
  LEFT_BRACKET; xs = list(component_value_with_loc); RIGHT_BRACKET {

    xs
  }
  ;

component_value_with_loc:
  | c = clean_ws component_value { (clean_ws c, Lex_buffer.make_loc $startpos $endpos) }

/* & > a */
/* [Ampersand, Delim(">"), Ident("a")] */

prelude:
  /* | v = VARIABLE { Component_value.Variable v }
  | o = OPERATOR { Component_value.Operator o } */
  | AMPERSAND { Prelude.Ampersand }
  | d = DELIM { Prelude.Delim d }
  /* span:hover */
  | i = IDENT; p = PSEUDOCLASS; {
    Prelude.Pseudoclass(
      (i, Lex_buffer.make_loc $startpos(i) $endpos(i)),
      (p, Lex_buffer.make_loc $startpos(p) $endpos(p))
    )
  }
  /* li:nth-child(2) */
  /* | i = IDENT; p = PSEUDOCLASS; xs = paren_block {
    Prelude.PseudoclassFunction(
      (i, Lex_buffer.make_loc $startpos $endpos),
      (p, Lex_buffer.make_loc $startpos $endpos),
      xs
    )
  } */
  /* p::first-line */
  | i = IDENT; p = PSEUDOELEMENT {
    Prelude.Pseudoelement(
      (i, Lex_buffer.make_loc $startpos(i) $endpos(i)),
      (p, Lex_buffer.make_loc $startpos(p) $endpos(p))
    )
  }
  /* a[target], a[target="_blank"] */
  /* | i = IDENT; b = bracket_block {
    [
      (Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i));
      (Component_value.Bracket_block(b, Lex_buffer.make_loc $startpos(b) $endpos(b)), Lex_buffer.make_loc $startpos(b) $endpos(b));
    ]
  } */
  ;

prelude_with_loc:
  xs = prelude { (xs, Lex_buffer.make_loc $startpos $endpos) }
  ;

component_value:
  | b = paren_block { Component_value.Paren_block b }
  | b = bracket_block { Component_value.Bracket_block b }
  | n = NUMBER; PERCENTAGE { Component_value.Percentage n }
  | i = IDENT { Component_value.Ident i }
  | s = STRING { Component_value.String s }
  | u = URI { Component_value.Uri u }
  | d = DELIM { Component_value.Delim d }
  | COLON { Component_value.Delim ":" }
  | f = FUNCTION; xs = paren_block {
      Component_value.Function (
        (f, Lex_buffer.make_loc $startpos(f) $endpos(f)),
        (xs, Lex_buffer.make_loc $startpos(xs) $endpos(xs))
      )
    }
  | h = HASH { Component_value.Hash h }
  | n = NUMBER { Component_value.Number n }
  | r = UNICODE_RANGE { Component_value.Unicode_range r }
  | d = FLOAT_DIMENSION { Component_value.Float_dimension d }
  | d = DIMENSION { Component_value.Dimension d }
  | v = VARIABLE { Component_value.Variable v }
  | p = separated_nonempty_list(WS, prelude_with_loc); bracket_block {
    Component_value.Selector ((p, Lex_buffer.make_loc $startpos $endpos), [])
  }
  ;
