%{

open Css_types

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
%token <string> EQUAL_SIGN
%token <string> MEDIA_QUERY_OPERATOR
%token <string> MEDIA_FEATURE_COMPARISON
%token <string> AT_MEDIA
%token <string> SCREEN_MEDIA_TYPE
%token <string> PRINT_MEDIA_TYPE
%token <string> ALL_MEDIA_TYPE
%token <string> AT_KEYFRAMES
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

/* https://www.w3.org/TR/mediaqueries-5 */

/* ">" */
greater_than: gt = MEDIA_FEATURE_COMPARISON { gt }
/* "<" */
less_than: lt = MEDIA_FEATURE_COMPARISON { lt }
/* "=" */
equal_sign: eq = EQUAL_SIGN { eq }
/* "and" */
and_operator: a = MEDIA_QUERY_OPERATOR { a }
/* "or" */
or_operator: o = MEDIA_QUERY_OPERATOR { o }
/* "only" */
only_operator: o = MEDIA_QUERY_OPERATOR { o }
/* "not" */
not_operator: n = MEDIA_QUERY_OPERATOR { n }
/* "screen" */
screen_media_type: smt = SCREEN_MEDIA_TYPE { smt }
/* "print" */
print_media_type: pmt = PRINT_MEDIA_TYPE { pmt }
/* "all" */
all_media_type: amt = ALL_MEDIA_TYPE { amt }

/* https://www.w3.org/TR/mediaqueries-5/#mq-syntax */
interpolation:
  v = INTERPOLATION { Variable v}

mf_value:
  | v = interpolation { v }
  | v = value { v }

/* <mf-plain> = <mf-name> : <mf-value> */
mf_plain: mf = IDENT WS? COLON WS? mf_value { mf }

/* <mf-lt> = '<' '='? */
mf_lt: mflt = less_than equal_sign? { mflt }

/* <mf-gt> = '>' '='? */
mf_gt: mglt = greater_than equal_sign? { mglt }

/* <mf-comparison> = <mf-lt> | <mf-gt> | <mf-eq> */
mf_comparison:
  | mflt = mf_lt { mflt }
  | mfgt = mf_gt { mfgt }
  | mfeq = equal_sign { mfeq }

/* <mf-range> =
      <mf-name> <mf-comparison> <mf-value>
      | <mf-value> <mf-comparison> <mf-name>
      | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value>
      | <mf-value> <mf-gt> <mf-name> <mf-gt> <mf-value> */
mf_range:
  | xs = IDENT WS mf_comparison WS mf_value { xs }
  | mf_value WS xs = mf_comparison WS IDENT { xs }
  | mf_value WS xs = mf_lt WS IDENT WS mf_lt WS mf_value { xs }
  | mf_value WS xs = mf_gt WS IDENT WS mf_gt WS mf_value { xs }

screen_or_print_media_type:
  | mt = screen_media_type { mt }
  | mt = print_media_type { mt }

mf_boolean:
  /* TODO: IDENT is not safely parsed */
  | i = IDENT WS? { i }
  | all_mt = all_media_type WS? { all_mt }
  | mt = screen_or_print_media_type WS? { mt }
  | mt = screen_or_print_media_type WS and_media_condition_without_or? WS? { mt }
  | mt = screen_or_print_media_type WS? COMMA WS? screen_or_print_media_type WS? { mt }

/* <media-feature> = ( [ <mf-plain> | <mf-boolean> | <mf-range> ] ) */
media_feature:
  /* TODO: property & value in mf_plain are not safely parsed */
  | mfp = mf_plain { mfp }
  | mfb = mf_boolean { mfb }
  | mfr = mf_range { mfr }

/* TODO: <general-enclosed> = [ <function-token> <any-value> ) ] | ( <ident> <any-value> ) */

/* <media-in-parens> = ( <media-condition> ) | <media-feature> | TODO: <general-enclosed> */
media_in_parens:
  | LEFT_PAREN mc = media_condition RIGHT_PAREN { mc }
  | LEFT_PAREN WS? mf = media_feature WS? RIGHT_PAREN { Ident mf }
  | i = interpolation { i }

media_not: WS? mn = not_operator media_in_parens WS? { Ident mn }

/* <media-and> = and <media-in-parens> */
media_and: xs = and_operator media_in_parens { xs }

/* <media-and>* */
media_and_star:
  | /* Empty case, represents zero occurrences of <media-and> */
    { [] }
  | and_rule = media_and
      rest = media_and_star
    { and_rule :: rest }

/* <media-or> = or <media-in-parens> */
media_or: xs = or_operator media_in_parens { xs }

/* <media-or>* */
media_or_star:
  | /* Empty case, represents zero occurrences of <media-or> */
    { [] }
  | or_rule = media_or
      rest = media_or_star
    { or_rule :: rest }

/* [ <media-and>* | <media-or>* ] */
media_and_or_star:
  | xs = media_and_star { xs }
  | xs = media_or_star { xs }

/* <media-condition> = <media-not> | <media-in-parens> [ <media-and>* | <media-or>* ] */
media_condition:
  | mn = media_not { mn }
  | xs = media_in_parens WS? media_and_or_star { xs }

/* <media-condition-without-or> = <media-not> | <media-in-parens> <media-and>* */
media_condition_without_or:
  | mn = media_not { mn }
  | xs = media_in_parens WS? media_and_star { xs }

/* not | only */
not_or_only:
  | n = not_operator { n }
  | o = only_operator { o }

/* and <media-condition-without-or>  */
and_media_condition_without_or: xs = and_operator media_condition_without_or { Ident xs }

/* media_query = <media-condition> | [ not | only ]? <media-type> [ and <media-condition-without-or> ]? */
media_query:
  | mc = media_condition WS? COMMA? WS? { mc }
  | not_or_only? xs = screen_or_print_media_type WS? COMMA?
    WS? and_media_condition_without_or ?COMMA? WS?  { Ident xs }
  | not_or_only? xs = all_media_type WS? and_media_condition_without_or? WS?  { Ident xs }

media_query_prelude:
  | v = INTERPOLATION { Variable v }
  | mq = nonempty_list(loc(media_query)) { Paren_block mq }

prelude: xs = value { xs }

/* https://www.w3.org/TR/css-syntax-3/#at-rules */
at_rule:
  /* @media (min-width: 16rem) { ... } */
  | name = loc(AT_MEDIA) WS?
    prelude = loc(media_query_prelude) WS?
    ds = brace_block(loc(declarations)) WS? {
    { name;
      prelude;
      block = Rule_list ds;
      loc = make_loc $startpos $endpos;
    }
  }
  /* @media (min-width: 16rem) {} */
  | name = loc(AT_MEDIA) WS?
    prelude = loc(media_query_prelude) WS?
    b = loc(empty_brace_block) WS? {
    { name;
      prelude;
      block = Rule_list b;
      loc = make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName { ... } */
  | name = loc(AT_KEYFRAMES) WS?
    i = IDENT WS?
    block = brace_block(keyframe) {
    let prelude = (Ident i, make_loc $startpos(i) $endpos(i)) in
    let block = Rule_list (block, make_loc $startpos $endpos) in
    { name;
      prelude;
      block;
      loc = make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName {} */
  | name = loc(AT_KEYFRAMES) WS?
    i = IDENT WS?
    s = loc(empty_brace_block) {
    let prelude = ((Ident i), make_loc $startpos(i) $endpos(i)) in
    let empty_block = Rule_list s in
    ({ name;
      prelude;
      block = empty_block;
      loc = make_loc $startpos $endpos;
    }): at_rule
  }
  /* @charset */
  | name = loc(AT_RULE_STATEMENT) WS?
    xs = loc(prelude) WS? SEMI_COLON? {
    { name;
      prelude = xs;
      block = Empty;
      loc = make_loc $startpos $endpos;
    }
  }
  /* @support { ... } */
  /* @page { ... } */
  /* @{{rule}} { ... } */
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
  | d = skip_ws_right(declaration_without_eof); { Declaration d }
  | r = skip_ws(at_rule) { At_rule r }
  | s = skip_ws(style_rule) { Style_rule s }

declaration: d = declaration_without_eof; EOF { d }

declaration_without_eof:
  /* property: value; */
  | WS? property = loc(IDENT)
    WS? COLON
    WS? value = loc(values)
    WS? important = loc(boption(IMPORTANT))
    WS? SEMI_COLON?
    WS? {
    { name = property;
      value;
      important;
      loc = make_loc $startpos $endpos;
    }
  }

combinator:
  | c = COMBINATOR { c }
  | c = greater_than { c }

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
  | COLON f = FUNCTION xs = loc(selector) RIGHT_PAREN /* :not() */ {
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
 | eq = EQUAL_SIGN { eq }

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

value:
  | b = paren_block(values) { Paren_block b }
  | b = bracket_block(values) { Bracket_block b }
  | n = percentage { Percentage n }
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
  | mq_operator = MEDIA_QUERY_OPERATOR { Operator mq_operator }
  | all = ALL_MEDIA_TYPE { Operator all }
  | screen = SCREEN_MEDIA_TYPE { Ident screen}
