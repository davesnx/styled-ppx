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

%start <stylesheet> stylesheet
%start <rule_list> declaration_list
%start <declaration> declaration
%start <rule_list> keyframes

%%

stylesheet: s = stylesheet_without_eof; EOF { s }
stylesheet_without_eof: rs = loc(list(rule)) { rs }

declaration_list:
  | EOF { ([], Lex_buffer.make_loc $startpos $endpos) }
  | ds = loc(declarations) EOF { ds }

/* keyframe may contain {} */
keyframe: rules = nonempty_list(keyframe_style_rule) { rules }

keyframes:
  | rules = loc(keyframe) EOF { rules }
  | rules = brace_block(loc(keyframe)) EOF { rules }

/* Adds location as a tuple */
%public %inline loc(X): x = X {
  (x, Lex_buffer.make_loc $startpos(x) $endpos(x))
}

/* Handle skipping whitespace */
skip_ws (X): x = delimited(WS?, X, WS?) { x }
skip_ws_right (X): x = X; WS? { x }
skip_ws_left (X): WS? x = X; { x }

/* TODO: Remove empty_brace_block */
/* {} */
empty_brace_block: pair(LEFT_BRACE, RIGHT_BRACE) { [] }

/* TODO: Remove SEMI_COLON? from brace_block(X) */
/* { ... } */
brace_block(X): xs = delimited(LEFT_BRACE, X, RIGHT_BRACE) SEMI_COLON? { xs }

/* [] */
bracket_block (X): xs = delimited(LEFT_BRACKET, X, RIGHT_BRACKET) { xs }

/* () */
paren_block (X): xs = delimited(LEFT_PAREN, X, RIGHT_PAREN) { xs }

/* https://www.w3.org/TR/mediaqueries-5 */
/* Parsing with this approach is almost as good the entire spec */

prelude: xs = loption(nonempty_list(loc(value_in_prelude))) { xs }

/* Missing grammars: */
/* (width >= 600px) */
/* (400px < width < 1000px) */
/* (not (color)) and (not (hover)) */
/* Combinator "," */
media_query_prelude_item:
  | i = IDENT { Ident i }
  | v = VARIABLE { Variable v }
  | xs = paren_block(prelude) { Paren_block xs }

media_query_prelude: q = nonempty_list(loc(skip_ws(media_query_prelude_item))) { q }

/* https://www.w3.org/TR/css-syntax-3/#at-rules */
at_rule:
  /* @media (min-width: 16rem) { ... } */
  | name = loc(AT_MEDIA) WS?
    prelude = loc(media_query_prelude) WS?
    ds = brace_block(loc(declarations)) WS? {
    { name = name;
      prelude;
      block = Rule_list ds;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @media (min-width: 16rem) {} */
  | name = loc(AT_MEDIA) WS?
    prelude = loc(media_query_prelude) WS?
    b = loc(empty_brace_block) WS? {
    { name = name;
      prelude;
      block = Rule_list b;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName { ... } */
  | name = loc(AT_KEYFRAMES) WS?
    i = IDENT WS?
    block = brace_block(keyframe) {
    let _item = (Ident i, Lex_buffer.make_loc $startpos(i) $endpos(i)) in
    let prelude = ([], Lex_buffer.make_loc $startpos $endpos) in
    let block = Rule_list (block, Lex_buffer.make_loc $startpos $endpos) in
    { name = name;
      prelude;
      block;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName {} */
  | name = loc(AT_KEYFRAMES) WS?
    i = IDENT WS?
    s = loc(empty_brace_block) {
    let _item = (Ident i, Lex_buffer.make_loc $startpos(i) $endpos(i)) in
    let prelude = ([], Lex_buffer.make_loc $startpos $endpos) in
    let empty_block = Rule_list s in
    ({ name = name;
      prelude = prelude;
      block = empty_block;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }): at_rule
  }
  /* @charset */
  | name = loc(AT_RULE_STATEMENT) WS?
    xs = loc(prelude) WS? SEMI_COLON? {
    { name = name;
      prelude = xs;
      block = Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @support { ... } */
  /* @page { ... } */
  /* @{{rule}} { ... } */
  | name = loc(AT_RULE) WS?
    xs = loc(prelude) WS?
    s = brace_block(stylesheet_without_eof) WS? {
    { name = name;
      prelude = xs;
      block = Stylesheet s;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }

percentage: n = NUMBER PERCENTAGE { n }

/* keyframe allows stylesheet by defintion, but we restrict the usage to: */
keyframe_style_rule:
  | WS? id = IDENT WS?
    declarations = brace_block(loc(declarations)) WS? {
    let prelude = [(SimpleSelector (Type id), Lex_buffer.make_loc $startpos(id) $endpos(id))] in
    Style_rule {
      prelude = (prelude, Lex_buffer.make_loc $startpos(id) $endpos(id));
      loc = Lex_buffer.make_loc $startpos $endpos;
      block = declarations;
    }
  }
  /* TODO: Support percentage in simple_selector and have selector parsing here */
  | WS? p = percentage; WS?
    declarations = brace_block(loc(declarations)) WS? {
    let item = Percentage p in
    let prelude = [(SimpleSelector item, Lex_buffer.make_loc $startpos(p) $endpos(p))] in
    Style_rule {
      prelude = (prelude, Lex_buffer.make_loc $startpos(p) $endpos(p));
      loc = Lex_buffer.make_loc $startpos $endpos;
      block = declarations;
    }
  }
  /* TODO: Handle separated_list(COMMA, percentage) */
;

selector_list:
  | selector = loc(selector) WS? { [selector] }
  | selector = loc(selector) WS? COMMA WS? seq = selector_list WS? { selector :: seq }

/* .class {} */
style_rule:
  | prelude = loc(selector_list) WS?
    block = loc(empty_brace_block) {
    { prelude;
      block;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  | prelude = loc(selector_list) WS?
    declarations = brace_block(loc(declarations)) {
    { prelude;
      block = declarations;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }

values: xs = nonempty_list(loc(value)) { xs }

declarations:
  | xs = nonempty_list(rule) SEMI_COLON? { xs }
  | xs = separated_nonempty_list(SEMI_COLON, rule) SEMI_COLON? { xs }

%inline rule:
  /* Rule can have declarations, since we have nesting, so both style_rules and
  declarations can live side by side. */
  | d = declaration_without_eof; { Declaration d }
  | r = skip_ws(at_rule) { At_rule r }
  | s = skip_ws(style_rule) { Style_rule s }

declaration: d = declaration_without_eof; EOF { d }

declaration_without_eof:
  /* property: value; */
  | property = loc(IDENT)
    COLON
    value = loc(values)
    important = loc(boption(IMPORTANT)) SEMI_COLON? {
    { name = property;
      value;
      important;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }

nth:
  /* even, odd, n */
  | i = IDENT { NthIdent i }
  /* <An+B> */
  /* 2 */
  | a = NUMBER { A a }
  /* 2n */
  | a = DIMENSION { AN (fst a) }
  /* Since our lexing isn't on point with DIMENSIONS/NUMBERS */
  /* We add a case where operator is missing */
  /* 2n-1 */
  | left = DIMENSION WS? right = NUMBER {
    ANB ((fst left, "", right))
  }
  /* 2n+1 */
  | left = DIMENSION WS? combinator = COMBINATOR right = NUMBER {
    ANB ((fst left, combinator, right))
  }
  /* TODO: Support "An+B of Selector" */
;

nth_payload:
  | complex = complex_selector_list; { NthSelector complex }
  | n = skip_ws(nth) { Nth n }

/* <pseudo-class-selector> = ':' <ident-token> | ':' <function-token> <any-value> ')' */
pseudo_class_selector:
  | COLON i = IDENT { (Pseudoclass(Ident i)) } /* :visited */
  | COLON f = FUNCTION xs = loc(selector) RIGHT_PAREN /* :not() */ {
    (Pseudoclass(Function({ name = f; payload = xs })))
  }
  | COLON f = NTH_FUNCTION xs = loc(nth_payload) RIGHT_PAREN /* :nth() */ {
    (Pseudoclass(NthFunction({ name = f; payload = xs })))
  }
  /* TODO: <function-token> and <any-value> */
;

/* "~=" | "|=" | "^=" | "$=" | "*=" | "=" */
attr_matcher: o = OPERATOR { o }

/* <attribute-selector> = '[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [  <string-token> | <ident-token> ] <attr-modifier>? ']' */
attribute_selector:
  /* https://www.w3.org/TR/selectors-4/#type-nmsp */
  /* We don't support namespaces in wq-name (`ns-prefix?`). We treat it like a IDENT */
  /* [ <wq-name> ] */
  | LEFT_BRACKET; WS?
    i = IDENT WS?
    RIGHT_BRACKET {
    Attribute(Attr_value i)
  }
  /* [ wq-name = "value"] */
  | LEFT_BRACKET; WS?
    i = IDENT WS?
    m = attr_matcher; WS?
    v = STRING; WS?
    RIGHT_BRACKET {
    Attribute(
      To_equal({
        name = i;
        kind = m;
        value = Attr_string v
      })
    )
  }
  /* [ wq-name = value] */
  | LEFT_BRACKET; WS?
    i = IDENT WS?
    m = attr_matcher; WS?
    v = IDENT WS?
    RIGHT_BRACKET {
    Attribute(
      To_equal({
        name = i;
        kind = m;
        value = Attr_ident v
      })
    )
  }
  /* TODO: add attr-modifier */
;

/* <id-selector> = <hash-token> */
id_selector: h = HASH { Id h }

/* <class-selector> = '.' <ident-token> */
class_selector:
  | DOT id = IDENT { Class id }
  /* TODO: Fix this: Here we need to add TAG in case some ident is an actual tag :( */
  | DOT tag = TAG { Class tag }

/* <subclass-selector> = <id-selector> | <class-selector> | <attribute-selector> | <pseudo-class-selector> */
subclass_selector:
  | id = id_selector { id } /* #id */
  | c = class_selector { c } /* .class */
  | a = attribute_selector { a } /* [attr] */
  | pcs = pseudo_class_selector { Pseudo_class pcs } /* :pseudo-class */
  | DOT v = VARIABLE { ClassVariable v } /* .$(Variable) as subclass_selector */

complex_selector_list:
  | xs = separated_nonempty_list(skip_ws_right(COMMA), complex_selector) { xs }

selector:
  /* By definition a selector can be one of those kinds, since inside
  complex_selector we arrive to simple and compound, we discard those branches here.
  The reason is because are in a LR(1) parser which makes those structures hard
  to accomplish by following the CSS spec.

  Check <non_complex_selector>
  */
  /* | xs = skip_ws_right(simple_selector) { SimpleSelector xs } */
  /* | xs = skip_ws_right(compound_selector) { CompoundSelector xs } */
  | xs = skip_ws_right(complex_selector) { ComplexSelector xs }

type_selector:
  | AMPERSAND; { Ampersand } /* & {} https://drafts.csswg.org/css-nesting/#nest-selector */
  | ASTERISK; { Universal } /* * {} */
  | v = VARIABLE { Variable v } /* $(Module.value) {} */
  /* TODO: type_selector should work with IDENTs, but there's a bunch of grammar
    conflicts with IDENT on value and others, we replaced with TAG, a
    list of valid HTML tags that does the job done, but this should be fixed. */
  | type_ = IDENT; { Type type_ } /* a {} */
  | type_ = TAG; { Type type_ } /* a {} */

/* <simple-selector> = <type-selector> | <subclass-selector> */
/* <simple-selector> = <self-selector> | <type-selector> | <subclass-selector> */
simple_selector:
  | t = type_selector { t }
  /* With <coumpound-selector> that subclass_selector becomes irrelevant */
  /* | sb = subclass_selector { Subclass sb } */ /* #a, .a, a:visited, a[] */

pseudo_element_selector:
  DOUBLE_COLON; pse = IDENT { Pseudoelement pse } /* ::after */

pseudo_list:
  /* ::after:hover */
  /* ::after:hover:visited */
  | element = pseudo_element_selector class_list = list(pseudo_class_selector) {
    element :: class_list
  }

/* <compound-selector> = [
    <type-selector>? <subclass-selector>*
    [ <pseudo-element-selector> <pseudo-class-selector>* ]*
  ]!

  compound_selector expects first to be a <type-selector>, since we support
  nesting and that can be a few more things look at <simple-selector> */
compound_selector:
  /* a#id */
  | t = type_selector sub = subclass_selector {
     {
      type_selector = Some t;
      subclass_selectors = [sub];
      pseudo_selectors = [];
    }
  }
  /* #hover */
  | sub = nonempty_list(subclass_selector) {
     {
      type_selector = None;
      subclass_selectors = sub;
      pseudo_selectors = [];
    }
  }
  /* a::after:hover */
  | t = type_selector ps = pseudo_list {
     {
      type_selector = Some t;
      subclass_selectors = [];
      pseudo_selectors = ps;
    }
  }
  /* ::after:hover */
  | ps = pseudo_list {
     {
      type_selector = None;
      subclass_selectors = [];
      pseudo_selectors = ps;
    }
  }

combinator_sequence:
  | WS s = non_complex_selector { (None, s) }
  | s = non_complex_selector WS? { (None, s) }
  | c = COMBINATOR WS? s = non_complex_selector WS? { (Some c, s) }

non_complex_selector:
  | s = simple_selector { SimpleSelector s }
  | s = compound_selector { CompoundSelector s }

/* <complex-selector> = <compound-selector> [ <combinator>? <compound-selector> ]* */
complex_selector:
  | left = skip_ws_right(non_complex_selector) { Selector left }
  | left = non_complex_selector WS? seq = nonempty_list(combinator_sequence) {
    Combinator {
      left = left;
      right = seq;
    }
  }

/* value_in_prelude we transform WS_* into Delim with white spaces inside
in value we transform to regular Delim
The rest of value_in_prelude and value should be sync */
value_in_prelude:
  | b = paren_block(prelude) { Paren_block b }
  | b = bracket_block(prelude) { Bracket_block b }
  | n = percentage { Percentage n }
  | i = IDENT { Ident i }
  | s = STRING { String s }
  | c = COMBINATOR { Combinator c}
  | o = OPERATOR { Operator o }
  | d = DELIM { Delim d }
  | DOT { Delim "." }
  | COLON { Delim ":" }
  | DOUBLE_COLON { Delim "::" }
  | h = HASH { Hash h }
  | COMMA { Delim "," }
  | n = NUMBER { Number n }
  | r = UNICODE_RANGE { Unicode_range r }
  | d = FLOAT_DIMENSION { Float_dimension d }
  | d = DIMENSION { Dimension d }
  | v = VARIABLE { Variable v } /* $(Lola.value) */
  | f = loc(FUNCTION) xs = loc(prelude) RIGHT_PAREN; { Function (f, xs) } /* calc() */
  | u = URL { Uri u } /* url() */
  | WS { Delim " " }

value:
  | b = paren_block(values) { Paren_block b }
  | b = bracket_block(values) { Bracket_block b }
  | n = percentage { Percentage n }
  | i = IDENT { Ident i }
  | s = STRING { String s }
  | c = COMBINATOR { Combinator c}
  | o = OPERATOR { Operator o }
  | d = DELIM { Delim d }
  | DOT { Delim "." }
  | ASTERISK { Delim "*" }
  | COLON { Delim ":" }
  | h = HASH { Hash h }
  | DOUBLE_COLON { Delim "::" }
  | COMMA { Delim "," }
  | n = NUMBER { Number n }
  | r = UNICODE_RANGE { Unicode_range r }
  | d = FLOAT_DIMENSION { Float_dimension d }
  | d = DIMENSION { Dimension d }
  | v = VARIABLE { Variable v } /* $(Lola.value) */
  | f = loc(FUNCTION) v = loc(values) RIGHT_PAREN; { Function (f, v) } /* calc() */
  | u = URL { Uri u } /* url() */
