%{

open Css_types

%}

%token EOF
%token LEFT_BRACE
%token RIGHT_BRACE
%token LEFT_PAREN
%token RIGHT_PAREN
%token LEFT_BRACKET
%token RIGHT_BRACKET
%token COLON
%token DOUBLE_COLON
%token SEMI_COLON
%token PERCENTAGE
%token IMPORTANT
%token AMPERSAND
%token WS
%token <string> IDENT
%token <string> STRING
%token <string> URI
%token <string> OPERATOR
%token <string> DELIM
%token <string> NESTED_AT_RULE
%token <string> AT_RULE_WITHOUT_BODY
%token <string> AT_RULE
%token <string> HASH
%token <string> NUMBER
%token <string> UNICODE_RANGE
%token <string * string * Css_types.dimension> FLOAT_DIMENSION
%token <string * string> DIMENSION
%token <string list> VARIABLE

%start <Css_types.Stylesheet.t> stylesheet
%start <Css_types.Declaration_list.t> declaration_list
%start <Css_types.Declaration.t> declaration

%%

stylesheet: s = stylesheet_without_eof; EOF { s };
stylesheet_without_eof: rs = with_loc(list(rule)) { rs };

declaration_list:
  | EOF { ([], Lex_buffer.make_loc $startpos $endpos) }
  | ds = with_loc(declarations); EOF { ds }
;

rule:
  | r = at_rule { Rule.At_rule r }
  | r = style_rule { Rule.Style_rule r }
;

with_whitespace(X): xs = delimited(WS?, X, WS?); { xs }

brace_block(X):
  xs = delimited(LEFT_BRACE, with_whitespace(X), RIGHT_BRACE);
  SEMI_COLON? { xs };

empty_brace_block: LEFT_BRACE; WS?; RIGHT_BRACE; SEMI_COLON?; { [] }

with_loc(X): x = X { (x, Lex_buffer.make_loc $startpos(x) $endpos(x))}

at_rule:
  /* @charset */
  | name = with_loc(AT_RULE_WITHOUT_BODY); WS; xs = prelude; SEMI_COLON?; {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes { 100%: {} } */
  /* | name = with_whitespace(with_loc(NESTED_AT_RULE)); WS; xs = prelude; s = with_whitespace(brace_block(stylesheet_without_eof)); {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Stylesheet s;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  } */
  /* @media (min-width: 16rem) {} */
  | name = with_whitespace(with_loc(NESTED_AT_RULE)); xs = prelude; ds = with_whitespace(brace_block(with_loc(declarations))) {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Declaration_list ds;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @whatever */
  | name = with_loc(AT_RULE); WS; xs = prelude; ds = with_whitespace(brace_block(with_loc(declarations))) {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Declaration_list ds;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

/* .class {} */
style_rule:
  | xs = prelude; block = empty_brace_block; {
    { Style_rule.prelude = xs;
      block = block, Location.none;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  | xs = prelude; declarations = brace_block(with_loc(declarations)); {
    { Style_rule.prelude = xs;
      block = declarations;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

prelude: xs = with_loc(list(with_whitespace(with_loc(component_value)))) { xs };

declarations:
  | xs = nonempty_list(with_whitespace(declaration_or_at_rule)); SEMI_COLON?; { xs }
  | xs = separated_nonempty_list(SEMI_COLON, with_whitespace(declaration_or_at_rule)); SEMI_COLON?; { xs }

declaration_or_at_rule:
  | d = declaration_without_eof; { Declaration_list.Declaration d }
  | r = at_rule { Declaration_list.At_rule r }
  | s = style_rule { Declaration_list.Style_rule s } // This adds a lot of warnings
;

declaration: d = declaration_without_eof; EOF { d };

declaration_without_eof:
  n = IDENT; WS?; COLON; WS?; v = prelude; WS?; i = boption(IMPORTANT); WS?; SEMI_COLON? {
    { Declaration.name = (n, Lex_buffer.make_loc $startpos(n) $endpos(n));
      value = v;
      important = (i, Lex_buffer.make_loc $startpos(i) $endpos(i));
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

/* ::after */
pseudoelement: DOUBLE_COLON; i = with_loc(IDENT) { i };
/* :visited */
pseudoclass: COLON; i = with_loc(IDENT) { i };
/* :nth-child() */
pseudoclassfunction: COLON; f = with_loc(IDENT); xs = with_loc(paren_block) {
  Component_value.PseudoclassFunction (f, xs)
};

selector:
  /* & + component_value */
  | AMPERSAND; tl = nonempty_list(with_loc(component_value)); WS? {
    (Component_value.Ampersand, Lex_buffer.make_loc $startpos $endpos) :: tl
  }
  /* a:visited */
  /* li:nth-child(even) */
  | i = IDENT; p = pseudoclass; xs = paren_block? {
    [
      (Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i));
      (Component_value.Pseudoclass(p), Lex_buffer.make_loc $startpos(p) $endpos(p));
    ] @ match xs with
      | None -> []
      | Some xs -> [
        (Component_value.Paren_block(xs), Lex_buffer.make_loc $startpos(xs) $endpos(xs))
      ]
  }
  /* a::before */
  | i = IDENT; p = pseudoelement; {
    [
      (Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i));
      (Component_value.Pseudoelement(p), Lex_buffer.make_loc $startpos(p) $endpos(p))
    ]
  }
  /* lola[] */
  | i = IDENT; b = bracket_block; WS?; xs = paren_block? {
    [
      (Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i));
      (Component_value.Bracket_block b, Lex_buffer.make_loc $startpos(b) $endpos(b))
    ] @ match xs with
      | None -> []
      | Some xs -> [(Component_value.Paren_block(xs), Lex_buffer.make_loc $startpos(xs) $endpos(xs))]
  }
;

/* () */
paren_block:
  LEFT_PAREN; xs = separated_list(WS?, with_loc(component_value)); RIGHT_PAREN { xs }
;

/* [] */
bracket_block:
  LEFT_BRACKET; xs = separated_list(WS?, with_loc(component_value)); RIGHT_BRACKET { xs }
;

component_value:
  | b = paren_block { Component_value.Paren_block b }
  | b = bracket_block { Component_value.Bracket_block b }
  | n = NUMBER; PERCENTAGE { Component_value.Percentage n }
  | i = IDENT { Component_value.Ident i }
  | s = STRING { Component_value.String s }
  | u = URI { Component_value.Uri u }
  | o = OPERATOR { Component_value.Operator o }
  | d = DELIM { Component_value.Delim d }
  | COLON { Component_value.Delim ":" }
  | DOUBLE_COLON { Component_value.Delim "::" }
  | AMPERSAND { Component_value.Ampersand }
  | h = HASH { Component_value.Hash h }
  | n = NUMBER { Component_value.Number n }
  | r = UNICODE_RANGE { Component_value.Unicode_range r }
  | d = FLOAT_DIMENSION { Component_value.Float_dimension d }
  | d = DIMENSION { Component_value.Dimension d }
  /* $(Lola.value) */
  | v = VARIABLE { Component_value.Variable v }
  /* calc() */
  | f = with_loc(IDENT); xs = with_loc(paren_block) {
    Component_value.Function (f, xs)
  }
  | p = pseudoelement { Component_value.Pseudoelement p}
  | p = pseudoclass { Component_value.Pseudoclass p }
  | ps = pseudoclassfunction { ps }
  | s = selector { Component_value.Selector(s) }
;
