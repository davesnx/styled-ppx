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
%token ASTERISK
%token COMMA
%token WS
%token <string> IDENT
%token <string> TAG
%token <string> STRING
%token <string> OPERATOR
%token <string> COMBINATOR
%token <string> DELIM
%token <string> FUNCTION
%token <string> NTH_FUNCTION
%token <string> URL
%token BAD_URL
%token <string> AT_MEDIA
%token <string> AT_KEYFRAMES
%token <string> AT_RULE
%token <string> AT_RULE_STATEMENT
%token <string> HASH
%token <string> NUMBER
%token <string> UNICODE_RANGE
%token <string * string> FLOAT_DIMENSION
%token <string * string> DIMENSION
%token <string list> VARIABLE

%start <Css_types.Stylesheet.t> stylesheet
%start <Css_types.Rule_list.t> declaration_list
%start <Css_types.Declaration.t> declaration
%start <Css_types.Rule_list.t> keyframes

%%

stylesheet: s = stylesheet_without_eof; EOF { s };
stylesheet_without_eof: rs = loc(list(rule)) { rs };

declaration_list:
  | EOF { ([], Lex_buffer.make_loc $startpos $endpos) }
  | ds = loc(declarations); EOF { ds }
;

/* keyframe may contain {} */
keyframe: rules = nonempty_list(keyframe_style_rule); { rules };

keyframes:
  | rules = loc(keyframe); EOF; { rules }
  | rules = brace_block(loc(keyframe)); EOF; { rules }
;

/* Adds location as a tuple */
loc(X): x = X { (x, Lex_buffer.make_loc $startpos(x) $endpos(x))}

/* Handle skipping whitespace */
skip_ws (X): x = delimited(WS?, X, WS?) { x };
skip_ws_right (X): x = X; WS?; { x };
skip_ws_left (X): WS?; x = X; { x };

/* TODO: Remove empty_brace_block */
/* {} */
empty_brace_block: LEFT_BRACE; RIGHT_BRACE; { [] }

/* { ... } */
brace_block(X):
  xs = delimited(LEFT_BRACE, X, RIGHT_BRACE); { xs };

/* [] */
bracket_block (X): xs = delimited(LEFT_BRACKET, X, RIGHT_BRACKET); { xs };

/* () */
paren_block (X): xs = delimited(LEFT_PAREN, X, RIGHT_PAREN); { xs };

/* https://www.w3.org/TR/mediaqueries-5 */
/* Parsing with this approach is almost as good the entire spec */

/* Missing grammars: */
/* (width >= 600px) */
/* (400px < width < 1000px) */
/* (not (color)) and (not (hover)) */
/* Combinator "," */
media_query_prelude_item:
  | i = IDENT { Component_value.Ident i }
  | v = VARIABLE { Component_value.Variable v }
  | xs = paren_block(prelude) { Component_value.Paren_block xs }
;

media_query_prelude: q = nonempty_list(loc(skip_ws(media_query_prelude_item))) { q };

/* https://www.w3.org/TR/css-syntax-3/#at-rules */
at_rule:
  /* @media (min-width: 16rem) { ... } */
  | name = loc(AT_MEDIA); WS?;
    prelude = loc(media_query_prelude); WS?;
    ds = brace_block(loc(declarations)); WS? {
    { At_rule.name = name;
      prelude;
      block = Brace_block.Rule_list ds;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @media (min-width: 16rem) {} */
  | name = loc(AT_MEDIA); WS?;
    prelude = loc(media_query_prelude); WS?;
    b = loc(empty_brace_block); WS?; {
    { At_rule.name = name;
      prelude;
      block = Brace_block.Rule_list b;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName { ... } */
  | name = loc(AT_KEYFRAMES); WS?;
    i = IDENT; WS?;
    block = brace_block(keyframe) {
    let item = (Component_value.Ident i, Lex_buffer.make_loc $startpos(i) $endpos(i)) in
    let prelude = ([item], Lex_buffer.make_loc $startpos(i) $endpos(i)) in
    let block = Brace_block.Rule_list (block, Lex_buffer.make_loc $startpos $endpos) in
    { At_rule.name = name;
      prelude;
      block;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName {} */
  | name = loc(AT_KEYFRAMES); WS?;
    i = IDENT; WS?;
    s = loc(empty_brace_block) {
    let item = (Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i)) in
    let prelude = ([item], Lex_buffer.make_loc $startpos(i) $endpos(i)) in
    let empty_block = Brace_block.Rule_list s in
    { At_rule.name = name;
      prelude;
      block = empty_block;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @charset */
  | name = loc(AT_RULE_STATEMENT); WS?;
    xs = loc(prelude); WS?; {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @support { ... } */
  /* @page { ... } */
  /* @{{rule}} { ... } */
  | name = loc(AT_RULE); WS?;
    xs = loc(prelude); WS?;
    s = brace_block(stylesheet_without_eof); WS?; {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Stylesheet s;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

percentage: n = NUMBER; PERCENTAGE; { n }

/* keyframe allows stylesheet by defintion, but we restrict the usage to: */
keyframe_style_rule:
  | WS?; id = IDENT; WS?;
    declarations = brace_block(loc(declarations)); WS?; {
    let item = Selector.Type id in
    let prelude = Selector.SimpleSelector [item] in
    Rule.Style_rule {
      Style_rule.prelude = (prelude, Lex_buffer.make_loc $startpos(id) $endpos(id));
      loc = Lex_buffer.make_loc $startpos $endpos;
      block = declarations;
    }
  }
  | WS?; p = percentage; WS?;
    declarations = brace_block(loc(declarations)); WS?; {
    let item = Selector.Percentage p in
    let prelude = Selector.SimpleSelector [item] in
    Rule.Style_rule {
      Style_rule.prelude = (prelude, Lex_buffer.make_loc $startpos(p) $endpos(p));
      loc = Lex_buffer.make_loc $startpos $endpos;
      block = declarations;
    }
  }
  /* TODO: Handle separated_list(COMMA, percentage) */
;

/* .class {} */
style_rule:
  | WS?; selector = loc(selector); WS?;
    block = loc(empty_brace_block); WS?; {
    { Style_rule.prelude = selector;
      block;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  | WS?; selector = loc(selector); WS?;
    declarations = brace_block(loc(declarations)); WS?; {
    { Style_rule.prelude = selector;
      block = declarations;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

prelude: xs = loption(nonempty_list(loc(component_value_in_prelude))) { xs };

component_values: xs = loption(nonempty_list(loc(component_value))) { xs };

declarations:
  | xs = nonempty_list(rule); { xs }

rule:
  | d = declaration_without_eof; { Rule.Declaration d }
  | r = at_rule { Rule.At_rule r }
  | s = style_rule { Rule.Style_rule s }
;

/* property: value; */
declaration_without_eof:
  | property = loc(IDENT);
    COLON;
    value = loc(component_values);
    important = loc(boption(IMPORTANT)); SEMI_COLON?; {
    { Declaration.name = property;
      value;
      important;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

declaration: d = declaration_without_eof; EOF { d };

/* ::after */
pseudo_element_selector:
  DOUBLE_COLON; pse = IDENT { Selector.Pseudoelement pse };

nth:
  /* even, odd, n */
  | i = IDENT { Selector.NthIdent i }
  /* <An+B> */
  /* 2 */
  | a = NUMBER; { Selector.A a }
  /* 2n */
  | a = DIMENSION { Selector.AN (fst a) }
  /* Since our lexing isn't on point with DIMENSIONS/NUMBERS */
  /* We add a case where operator is missing */
  /* 2n-1 */
  | left = DIMENSION; WS?; right = NUMBER; {
    Selector.ANB ((fst left, "", right))
  }
  /* 2n+1 */
  | left = DIMENSION; WS?; combinator = COMBINATOR; right = NUMBER; {
    Selector.ANB ((fst left, combinator, right))
  }
  /* TODO: Support "An+B of Selector" */
;

nth_payload:
  | complex = complex_selector_list; { Selector.NthSelector complex }
  | n = skip_ws(nth); { Selector.Nth n }
;

/* <pseudo-class-selector> = ':' <ident-token> | ':' <function-token> <any-value> ')' */
pseudo_class_selector:
  /* :visited */
  | COLON; i = IDENT { Selector.(Pseudoclass(Ident i)) }
  /* :not() */
  | COLON; f = FUNCTION; xs = loc(selector); RIGHT_PAREN {
    Selector.(Pseudoclass(Function({ name = f; payload = xs })))
  }
  /* :nth-child() */
  | COLON; f = NTH_FUNCTION; xs = loc(nth_payload); RIGHT_PAREN {
    Selector.(Pseudoclass(NthFunction({ name = f; payload = xs })))
  }
  /* TODO: <function-token> and <any-value> */
;

/* "~=" | "|=" | "^=" | "$=" | "*=" | "=" */
attr_matcher: o = OPERATOR { o };

/* <attribute-selector> = '[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [  <string-token> | <ident-token> ] <attr-modifier>? ']' */
attribute_selector:
  /* https://www.w3.org/TR/selectors-4/#type-nmsp */
  /* We don't support namespaces in wq-name (`ns-prefix?`). We treat it like a IDENT */
  /* [ <wq-name> ] */
  | LEFT_BRACKET; WS?;
    i = IDENT; WS?;
    RIGHT_BRACKET {
    Selector.Attribute(Attr_value i)
  }
  /* [ wq-name = "value"] */
  | LEFT_BRACKET; WS?;
    i = IDENT; WS?;
    m = attr_matcher; WS?;
    v = STRING; WS?;
    RIGHT_BRACKET {
    Selector.Attribute(
      To_equal({
        name = i;
        kind = m;
        value = Selector.Attr_string v
      })
    )
  }
  /* [ wq-name = value] */
  | LEFT_BRACKET; WS?;
    i = IDENT; WS?;
    m = attr_matcher; WS?;
    v = IDENT; WS?;
    RIGHT_BRACKET {
    Selector.Attribute(
      To_equal({
        name = i;
        kind = m;
        value = Selector.Attr_ident v
      })
    )
  }
  /* TODO: add attr-modifier */
;

/* <id-selector> = <hash-token> */
id_selector: h = HASH { Selector.Id h }

/* <class-selector> = '.' <ident-token> */
class_selector:
  | DOT; c = IDENT { Selector.Class c }
  /* This should be an IDENT. Tiny bug where we split idents and tags by it's content,
    here we want to treat them equaly */
  | DOT; t = TAG { Selector.Class t };

/* <subclass-selector> = <id-selector> | <class-selector> | <attribute-selector> | <pseudo-class-selector> */
subclass_selector:
  | id = id_selector { id }
  | c = class_selector { c }
  | a = attribute_selector { a }
  | pcs = pseudo_class_selector { Selector.Pseudo_class pcs }
  /* .$(Variable) as subclass_selector */
  | DOT; v = VARIABLE { Selector.ClassVariable v };
;

complex_selector_list:
  | xs = separated_nonempty_list(skip_ws_right(COMMA), skip_ws_right(complex_selector)) { xs }
;

selector:
  /* <simple-selector-list> = <simple-selector># */
  | xs = separated_nonempty_list(skip_ws_right(COMMA), simple_selector) {
    Selector.SimpleSelector xs
  }
  /* <compound-selector-list> = <compound-selector># */
  | xs = separated_nonempty_list(skip_ws_right(COMMA), skip_ws_right(compound_selector)) {
    Selector.CompoundSelector xs
  }
  /* <complex-selector-list> = <complex-selector># */
  | xs = complex_selector_list { Selector.ComplexSelector xs }
;

/* <simple-selector> = <type-selector> | <subclass-selector> */
/* We change the spec adding the & selector */
/* <simple-selector> = <self-selector> | <type-selector> | <subclass-selector> */
simple_selector:
  /* & {} */
  /* https://drafts.csswg.org/css-nesting/#nest-selector */
  | AMPERSAND; { Selector.Ampersand }
  /* * {} */
  | ASTERISK; { Selector.Universal }
  /* $(Module.value) {} */
  | v = VARIABLE { Selector.Variable v }
  /* a {} */
  | type_ = TAG; { Selector.Type type_ }
  /* #a, .a, a:visited, a[] */
  | sb = subclass_selector { Selector.Subclass sb }
;

/* <compound-selector> = [
    <type-selector>? <subclass-selector>*
    [ <pseudo-element-selector> <pseudo-class-selector>* ]*
  ]!

  &#id.class
  &.id::after
  &.id::after:hover
  &.id::after:hover:hover

  We differ from the spec on type-selector which is a IDENT,
  for a simple_selector (adding & and variables) */
pseudo:
  | pe = pseudo_element_selector; { pe }
  | pc = pseudo_class_selector; { pc }
;

compound_selector:
  | type_selector = simple_selector; subclass_selectors = loption(list(subclass_selector)); pseudo_selectors = loption(list(pseudo)); {
    Selector.{
      type_selector = Some type_selector;
      subclass_selectors;
      pseudo_selectors;
    }
  }
;

combinator:
  /* Since we render COMBINATOR always with spaces, we ignore them here */
  | WS?; c = COMBINATOR; WS?; s = compound_selector; WS?; { (Some c, s) }
  | WS; s = compound_selector; WS?; { (None, s) }
;

/* <complex-selector> = <compound-selector> [ <combinator>? <compound-selector> ]* */
complex_selector:
  | left = compound_selector; right = nonempty_list(combinator); {
    Selector.Combinator {
      left;
      right;
    }
  }
;

/* component_value_in_prelude we transform WS_* into Delim with white spaces inside
in component_value we transform to regular Delim
The rest of component_value_in_prelude and component_value should be sync */
component_value_in_prelude:
  | b = paren_block(prelude) { Component_value.Paren_block b }
  | b = bracket_block(prelude) { Component_value.Bracket_block b }
  | n = percentage { Component_value.Percentage n }
  | i = IDENT { Component_value.Ident i }
  | s = STRING { Component_value.String s }
  | c = COMBINATOR { Component_value.Combinator c}
  | o = OPERATOR { Component_value.Operator o }
  | d = DELIM { Component_value.Delim d }
  | DOT { Component_value.Delim "." }
  | COLON { Component_value.Delim ":" }
  | DOUBLE_COLON { Component_value.Delim "::" }
  | h = HASH { Component_value.Hash h }
  | COMMA { Component_value.Delim "," }
  | n = NUMBER { Component_value.Number n }
  | r = UNICODE_RANGE { Component_value.Unicode_range r }
  | d = FLOAT_DIMENSION { Component_value.Float_dimension d }
  | d = DIMENSION { Component_value.Dimension d }
  /* $(Lola.value) */
  | v = VARIABLE { Component_value.Variable v }
  /* calc() */
  | f = loc(FUNCTION); xs = loc(prelude); RIGHT_PAREN; {
    Component_value.Function (f, xs)
  }
  /* url() */
  | u = URL { Component_value.Uri u }
  | WS { Component_value.Delim " " }
;

component_value:
  | b = paren_block(component_values) { Component_value.Paren_block b }
  | b = bracket_block(component_values) { Component_value.Bracket_block b }
  | n = percentage { Component_value.Percentage n }
  | i = IDENT { Component_value.Ident i }
  /* This should be an IDENT. Tiny bug where we split idents and tags by it's content,
    here we want to treat them equaly */
  | i = TAG { Component_value.Ident i }
  | s = STRING { Component_value.String s }
  | c = COMBINATOR { Component_value.Combinator c}
  | o = OPERATOR { Component_value.Operator o }
  | d = DELIM { Component_value.Delim d }
  | DOT { Component_value.Delim "." }
  | ASTERISK { Component_value.Delim "*" }
  | COLON { Component_value.Delim ":" }
  | h = HASH { Component_value.Hash h }
  | DOUBLE_COLON { Component_value.Delim "::" }
  | COMMA { Component_value.Delim "," }
  | n = NUMBER { Component_value.Number n }
  | r = UNICODE_RANGE { Component_value.Unicode_range r }
  | d = FLOAT_DIMENSION { Component_value.Float_dimension d }
  | d = DIMENSION { Component_value.Dimension d }
  /* $(Lola.value) */
  | v = VARIABLE { Component_value.Variable v }
  /* calc() */
  | f = loc(FUNCTION) xs = loc(component_values); RIGHT_PAREN; {
    Component_value.Function (f, xs)
  }
  /* url() */
  | u = URL { Component_value.Uri u }
;
