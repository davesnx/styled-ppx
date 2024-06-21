%{

open Ast

let make_loc = Parser_location.to_ppxlib_location

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
%token PERCENT
%token IMPORTANT
%token AMPERSAND
%token ASTERISK
%token COMMA
%token BAD_IDENT
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
%token <string> AT_RULE
%token <string> AT_RULE_STATEMENT
%token <string> HASH
%token <string> NUMBER
%token <string> UNICODE_RANGE
%token <string * string> FLOAT_DIMENSION
%token <string * string> DIMENSION
%token <string list> INTERPOLATION

%start <stylesheet> stylesheet
%start <rule_list> declaration_list
%start <declaration> declaration
%start <rule_list> keyframes

%%

stylesheet: s = stylesheet_without_eof; EOF { s }
stylesheet_without_eof: rs = loc(list(rule)) { rs }

declaration_list:
  | WS? EOF { ([], make_loc $startpos $endpos) }
  | ds = loc(declarations) EOF { ds }

/* keyframe may contain {} */
keyframe: rules = nonempty_list(keyframe_style_rule) { rules }

keyframes:
  | rules = loc(keyframe) EOF { rules }
  | rules = brace_block(loc(keyframe)) EOF { rules }

/* Adds location as a tuple */
loc(X): x = X {
  (x, make_loc $startpos(x) $endpos(x))
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

prelude: xs  = list(loc(skip_ws(value))) { xs }

/* https://www.w3.org/TR/css-syntax-3/#at-rules */
at_rule:
  | name = loc(AT_RULE_STATEMENT) WS?
    xs = loc(prelude) WS? SEMI_COLON? {
    { name;
      prelude = xs;
      block = Empty;
      loc = make_loc $startpos $endpos;
    }
  }
  | name = loc(AT_RULE) WS?
    xs = loc(prelude) WS?
    s = brace_block(stylesheet_without_eof) WS? {
    { name;
      prelude = xs;
      block = Stylesheet s;
      loc = make_loc $startpos $endpos;
    }
  }

percentage: n = NUMBER PERCENT { n }

/* keyframe allows stylesheet by defintion, but we restrict the usage to: */
keyframe_style_rule:
  /* from {} to {} */
  | WS? id = IDENT WS?
    declarations = brace_block(loc(declarations)) WS? {
    let prelude = [(SimpleSelector (Type id), make_loc $startpos(id) $endpos(id))] in
    Style_rule {
      prelude = (prelude, make_loc $startpos(id) $endpos(id));
      loc = make_loc $startpos $endpos;
      block = declarations;
    }
  }
  /* TODO: Support percentage in simple_selector and have selector parsing here */
  | WS? p = percentage; WS?
    declarations = brace_block(loc(declarations)) WS? {
    let item = Percentage p in
    let prelude = [(SimpleSelector item, make_loc $startpos(p) $endpos(p))] in
    Style_rule {
      prelude = (prelude, make_loc $startpos(p) $endpos(p));
      loc = make_loc $startpos $endpos;
      block = declarations;
    }
  }
  | percentages = separated_list(COMMA, skip_ws(percentage));
    declarations = brace_block(loc(declarations)) WS? {
    let prelude = percentages
      |> List.map (fun percent -> Percentage percent)
      |> List.map (fun p ->
        (SimpleSelector p, make_loc $startpos(percentages) $endpos(percentages))
      ) in
    Style_rule {
      prelude = (prelude, make_loc $startpos(percentages) $endpos(percentages));
      loc = make_loc $startpos $endpos;
      block = declarations;
    }
    (* TODO: Handle separated_list(COMMA, percentage) *)
  }

selector_list:
  | selector = loc(selector) WS? { [selector] }
  | selector = loc(selector) WS? COMMA WS? seq = selector_list WS? { selector :: seq }

relative_selector_list:
  | selector = loc(relative_selector) WS? { [selector] }
  | selector = loc(relative_selector) WS? COMMA WS? seq = relative_selector_list WS? { selector :: seq }

/* .class {} */
style_rule:
  | prelude = loc(selector_list) WS?
    block = loc(empty_brace_block) {
    { prelude;
      block;
      loc = make_loc $startpos $endpos;
    }
  }
  | prelude = loc(selector_list) WS?
    declarations = brace_block(loc(declarations)) {
    { prelude;
      block = declarations;
      loc = make_loc $startpos $endpos;
    }
  }

values: xs = nonempty_list(loc(skip_ws(value))) { xs }

declarations:
  | WS? xs = nonempty_list(rule) SEMI_COLON? { xs }
  | WS? xs = separated_nonempty_list(SEMI_COLON, rule) SEMI_COLON? { xs }

%inline rule:
  /* Rule can have declarations, since we have nesting, so both style_rules and
  declarations can live side by side. */
  | d = skip_ws(declaration_without_eof); { Declaration d }
  | r = skip_ws(at_rule) { At_rule r }
  | s = skip_ws(style_rule) { Style_rule s }

declaration: d = skip_ws_left(declaration_without_eof); WS? EOF { d }

declaration_without_eof:
  /* property: value; */
  | property = loc(IDENT)
    WS? COLON
    WS? value = loc(values)
    WS? important = loc(boption(IMPORTANT))
    WS? SEMI_COLON? {
    { name = property;
      value;
      important;
      loc = make_loc $startpos $endpos;
    }
  }

combinator:
  | c = COMBINATOR { c }

nth_payload:
  /* TODO implement [of <complex-selector-list>]? */
  /* | complex = complex_selector_list; { NthSelector complex } */
  /* <An+B> */
  /* 2 */
  | a = NUMBER { Nth (A (int_of_string a)) }
  /* 2n */
  | a = DIMENSION { Nth (AN (int_of_string (fst a))) }
  /* 2n-1 */
  | a = DIMENSION WS? combinator = COMBINATOR b = NUMBER {
    let b = int_of_string b in
    Nth (ANB (((int_of_string (fst a)), combinator, b)))
  }
  /* This is a hackish solution where combinator isn't catched because the lexer
  assignes the `-` to NUMBER. This could be solved by leftassoc or the lexer */
  | a = DIMENSION WS? b = NUMBER {
    let b = Int.abs (int_of_string (b)) in
    Nth (ANB (((int_of_string (fst a)), "-", b)))
  }
  | n = IDENT WS? {
    match n with
      | "even" -> Nth (Even)
      | "odd" -> Nth (Odd)
      | "n" -> Nth (AN 1)
      | _ -> (
        let first_char = String.get n 0 in
        let a = if first_char = '-' then -1 else 1 in
        Nth (AN a)
      )
  }
  /* n-1 */
  /* n */
  /* -n */
  | n = IDENT WS? combinator = COMBINATOR b = NUMBER {
    let first_char = String.get n 0 in
    let a = if first_char = '-' then -1 else 1 in
    Nth (ANB ((a, combinator, int_of_string b)))
  }
  /* TODO: Support "An+B of Selector" */

/* <pseudo-class-selector> = ':' <ident-token> | ':' <function-token> <any-value> ')' */
pseudo_class_selector:
  | COLON i = IDENT { (Pseudoclass(PseudoIdent i)) } /* :visited */
  | COLON f = FUNCTION xs = loc(relative_selector_list) RIGHT_PAREN /* :has() */ {
    (Pseudoclass(Function({ name = f; payload = xs })))
  }
  | COLON f = FUNCTION xs = loc(selector_list) RIGHT_PAREN /* :not() */ {
    (Pseudoclass(Function({ name = f; payload = xs })))
  }
  | COLON f = NTH_FUNCTION xs = loc(nth_payload) RIGHT_PAREN /* :nth() */ {
    (Pseudoclass(NthFunction({ name = f; payload = xs })))
  }
  /* TODO: <function-token> and <any-value> */
;

/* "~=" | "|=" | "^=" | "$=" | "*=" | "=" */
attr_matcher:
 | o = OPERATOR { o }

wq_name:
  | i = IDENT { i }
  | t = TAG { t }

/* <attribute-selector> = '[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [  <string-token> | <ident-token> ] <attr-modifier>? ']' */
attribute_selector:
  /* https://www.w3.org/TR/selectors-4/#type-nmsp */
  /* We don't support namespaces in wq-name (`ns-prefix?`). We treat it like a IDENT */
  /* [ <wq-name> ] */
  | LEFT_BRACKET; WS?
    i = wq_name WS?
    RIGHT_BRACKET {
    Attribute(Attr_value i)
  }
  /* [ wq-name = "value"] */
  | LEFT_BRACKET; WS?
    i = wq_name WS?
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
    i = wq_name WS?
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
  | DOT v = INTERPOLATION { ClassVariable v } /* .$(Variable) as subclass_selector */

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
  | v = INTERPOLATION { Variable v } /* $(Module.value) {} */
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
  /* a#id::hover:visited */
  | t = type_selector sub = nonempty_list(subclass_selector) ps = pseudo_list {
     {
      type_selector = Some t;
      subclass_selectors = sub;
      pseudo_selectors = ps;
    }
  }
  /* #id::hover:visited */
  | sub = nonempty_list(subclass_selector) ps = pseudo_list {
     {
      type_selector = None;
      subclass_selectors = sub;
      pseudo_selectors = ps;
    }
  }
  /* a#id */
  | t = type_selector sub = nonempty_list(subclass_selector) {
     {
      type_selector = Some t;
      subclass_selectors = sub;
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
  | c = combinator WS? s = non_complex_selector WS? { (Some c, s) }

%inline non_complex_selector:
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
/* <relative-selector> = <combinator>? <complex-selector> */
relative_selector:
  | xs = skip_ws_right(complex_selector) { RelativeSelector { combinator = None; complex_selector = xs} }
  | c = combinator WS? xs = complex_selector WS? { RelativeSelector { combinator = Some c; complex_selector = xs } }

value:
  | b = paren_block(values) { Paren_block b }
  | b = bracket_block(values) { Bracket_block b }
  | n = NUMBER; PERCENT { Percentage n }
  | i = IDENT { Ident i }
  | i = TAG { Ident i }
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
  | v = INTERPOLATION { Variable v } /* $(Lola.value) */
  | f = loc(FUNCTION) v = loc(values) RIGHT_PAREN; { Function (f, v) } /* calc() */
  | u = URL { Uri u } /* url() */
