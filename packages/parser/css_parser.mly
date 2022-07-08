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
%token DOT
%token DOUBLE_COLON
%token SEMI_COLON
%token PERCENTAGE
%token IMPORTANT
%token AMPERSAND
%token WS
%token COMMA
%token <string> IDENT
%token <string> STRING
%token <string> URI
%token <string> OPERATOR
%token <string> COMBINATOR
%token <string> DELIM
%token <string> AT_MEDIA
%token <string> AT_KEYFRAMES
%token <string> AT_RULE
%token <string> AT_RULE_WITHOUT_BODY
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

/* {} */
brace_block(X):
  xs = delimited(LEFT_BRACE, with_whitespace(X), RIGHT_BRACE);
  SEMI_COLON? { xs };

empty_brace_block: LEFT_BRACE; WS?; RIGHT_BRACE; SEMI_COLON?; { [] }

with_loc(X): x = X { (x, Lex_buffer.make_loc $startpos(x) $endpos(x))}

at_rule:
  /* @charset */
  | name = with_whitespace(with_loc(AT_RULE_WITHOUT_BODY)); xs = prelude; SEMI_COLON?; {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @media (min-width: 16rem) {} */
  | name = with_whitespace(with_loc(AT_MEDIA)); xs = prelude; with_whitespace(empty_brace_block) {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @media (min-width: 16rem) { ... } */
  | name = with_whitespace(with_loc(AT_MEDIA)); xs = prelude; ds = with_whitespace(brace_block(with_loc(declarations))) {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Declaration_list ds;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName {} */
  | name = with_whitespace(with_loc(AT_KEYFRAMES)); i = with_whitespace(IDENT); empty_brace_block {
    { At_rule.name = name;
      prelude = ([(Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i))], Lex_buffer.make_loc $startpos(i) $endpos(i));
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName { ... } */
  | name = with_whitespace(with_loc(AT_KEYFRAMES)); i = with_whitespace(IDENT); s = with_whitespace(brace_block(stylesheet_without_eof)) {
    { At_rule.name = name;
      prelude = ([(Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i))], Lex_buffer.make_loc $startpos(i) $endpos(i));
      block = Brace_block.Stylesheet s;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @{{rule}} {} */
  | name = with_whitespace(with_loc(AT_RULE)); xs = prelude; empty_brace_block {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @{{rule}} { ... } */
  | name = with_whitespace(with_loc(AT_RULE)); xs = prelude; s = with_whitespace(brace_block(stylesheet_without_eof)) {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Stylesheet s;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

/* .class {} */
style_rule:
  | xs = with_whitespace(prelude); block = with_whitespace(empty_brace_block); {
    { Style_rule.prelude = xs;
      block = block, Location.none;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  | xs = with_whitespace(prelude); declarations = with_whitespace(brace_block(with_loc(declarations))); {
    { Style_rule.prelude = xs;
      block = declarations;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

prelude: xs = with_loc(nonempty_list(with_whitespace(with_loc(component_value)))) { xs };

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
  WS?; n = IDENT; WS?; COLON; WS?; v = prelude; WS?; i = boption(IMPORTANT); WS?; SEMI_COLON? {
    { Declaration.name = (n, Lex_buffer.make_loc $startpos(n) $endpos(n));
      value = v;
      important = (i, Lex_buffer.make_loc $startpos(i) $endpos(i));
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

// https://www.w3.org/TR/selectors-4/#grammar
selector:
  /* & + component_value */
  | AMPERSAND; tl = nonempty_list(with_loc(component_value)); WS? {
    (Component_value.Ampersand, Lex_buffer.make_loc $startpos $endpos) :: tl
  }
  /* lola[] */
  | i = IDENT; b = bracket_block; WS?; {
    [
      (Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i));
      (Component_value.Bracket_block b, Lex_buffer.make_loc $startpos(b) $endpos(b))
    ]
  }
;


simple_selector:
  | HASH; i = IDENT { Selector.Id(i) } // id-selector
  | DOT; i = IDENT { Selector.Class(i) } // class-selector
;


/* ::after */
pseudoelement_selector: DOUBLE_COLON; i = IDENT { Selector.Pseudoelement(i) };
/* :visited */
pseudoclass_selector: COLON; i = IDENT { Selector.(Pseudoclass(Ident(i))) };
/* :nth-child() */
pseudoclassfunction_selector: COLON; f = IDENT; xs = paren_block {
  Selector.(Pseudoclass(Function({ name = f; payload = xs })))
};

pseudoclass_selectors:
  | pseudoclass_selector
  | pseudoclassfunction_selector { <> }

pseudo_selectors:
  | pseudoelement_selector; { <> }
  | pseudoclass_selectors; { <> }
  ;


// <wq-name> = <ns-prefix>? <ident-token> ... do we support namespaces?
wq_name:
  | IDENT { <> }
  ;

attr_matcher:
  | OPERATOR { <> }
  ;

attribute_selector:
  | LEFT_BRACE; i = wq_name; RIGHT_BRACE { Selector.Attr_value(i) } // [ident]
  | LEFT_BRACE; i = wq_name; m = attr_matcher; v = STRING ; RIGHT_BRACE; //[ident="value"]
  | LEFT_BRACE; i = wq_name; m = attr_matcher; v = IDENT  ; RIGHT_BRACE {
    Selector.To_equal({
      name = i;
      kind = m;
      value = v
    }) 
  } //[ident=value]
  ;

subclass_selector:
   | simple_selector { <> }
   | attribute_selector { <> }
   | pseudoclass_selector { <> }
  ;

// simple_selector_list: 
//   | xs = separated_nonempty_list(COMMA, simple_selector)  { xs } ;
// complex_selector_list: 
//   | xs =  separated_nonempty_list(COMMA, complex_selector) { xs } ;
// compound_selector_list: 
//   | xs = separated_nonempty_list(COMMA, compound_selector) { xs } ;

// TODO: better name
pseudoelement_followed_by_pseudoclasslist:
  | pseudoelement_selector; { <> }
  | pseudoelement_selector; list(pseudoclass_selectors); { <> }
;

compound_selector:
  type_selector = type_selector?; subclass_selectors = list(subclass_selector); list(pseudoelement_followed_by_pseudoclasslist); {
    Selector.Selector {
      type_selector;
      subclass_selectors;
      pseudo_selectors;
    } 
   }

complex_selector:
  | compound_selector; { <> }
  | left = complex_selector; combinator = COMBINATOR?; right = compound_selector; { 
    Selector.Combinator {
      left;
      combinator;
      right;
    }
   }

type_selector:
  | name = wq_name { <> }


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
  | c = COMBINATOR { Component_value.Combinator c}
  | o = OPERATOR { Component_value.Operator o }
  | d = DELIM { Component_value.Delim d }
  | DOT  { Component_value.Delim "." }
  | COLON { Component_value.Delim ":" }
  | DOUBLE_COLON { Component_value.Delim "::" }
  | COMMA { Component_value.Delim "," }
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
  // | p = pseudoelement_selector { Component_value.Pseudoelement p}
  // | p = pseudoclass_selector { Component_value.Pseudoclass p }
  // | ps = pseudoclassfunction_selector { ps }
  // | s = selector { Component_value.Selector(s) }
;
