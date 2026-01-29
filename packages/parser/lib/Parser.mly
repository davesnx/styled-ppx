%{

open Ast

let make_loc = Parser_location.to_ppxlib_location

let int_of_float_exn value =
  if Float.is_integer value then int_of_float value
  else raise (Failure "Expected integer")

let expect_delim expected actual =
  if actual = expected then actual
  else raise (Failure ("Expected delimiter " ^ expected))

let combinator_from_delim =
  function
  | ("+" | "~" | ">") as value -> value
  | value -> raise (Failure ("Invalid combinator " ^ value))

let operator_prefix_from_delim =
  function
  | ("~" | "|" | "^" | "$" | "*") as value -> value
  | value -> raise (Failure ("Invalid operator prefix " ^ value))

let nth_operator_from_delim =
  function
  | ("+" | "-") as value -> value
  | value -> raise (Failure ("Invalid nth operator " ^ value))

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
%token IMPORTANT
%token AMPERSAND
%token ASTERISK
%token COMMA
%token DESCENDANT_COMBINATOR
%token WS
%token GTE
%token LTE
%token <string> IDENT
%token <string> TYPE_SELECTOR
%token <string> STRING
%token <string> DELIM
%token <string> FUNCTION
%token <string> NTH_FUNCTION
%token <string> URL
%token <string> AT_KEYWORD
%token <string> AT_KEYFRAMES
%token <string> AT_RULE
%token <string> AT_RULE_STATEMENT
%token <string> UNICODE_RANGE
%token <string list> INTERPOLATION
%token <string * [ `ID | `UNRESTRICTED ]> HASH
%token <float> NUMBER
%token <float> PERCENTAGE
%token <float * string> DIMENSION

%start <stylesheet> stylesheet
%start <rule_list> declaration_list
%start <declaration> declaration
%start <rule_list> keyframes

%%

stylesheet: s = stylesheet_without_eof; EOF { s }
stylesheet_without_eof: rs = loc(list(rule)) { rs }

declaration_list:
  | EOF { ([], make_loc $startpos $endpos) }
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

/* TODO: Remove empty_brace_block */
/* {} */
empty_brace_block: LEFT_BRACE RIGHT_BRACE { [] }

/* { ... } */
brace_block(X): xs = delimited(LEFT_BRACE, X, RIGHT_BRACE) SEMI_COLON? { xs }

/* [] */
bracket_block (X): xs = delimited(LEFT_BRACKET, X, RIGHT_BRACKET) { xs }

/* () */
paren_block (X): xs = delimited(LEFT_PAREN, X, RIGHT_PAREN) { xs }

/* https://www.w3.org/TR/css-syntax-3/#at-rules */
at_rule:
  /* @keyframes animationName { ... } */
  | name = loc(AT_KEYFRAMES)
    i = IDENT
    block = brace_block(keyframe) {
    let prelude = ([(Ident i, make_loc $startpos(i) $endpos(i))], make_loc $startpos(i) $endpos(i)) in
    let block = Rule_list (block, make_loc $startpos $endpos) in
    { name;
      prelude;
      block;
      loc = make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName {} */
  | name = loc(AT_KEYFRAMES)
    i = IDENT
    s = loc(empty_brace_block) {
    let prelude = ([(Ident i, make_loc $startpos(i) $endpos(i))], make_loc $startpos(i) $endpos(i)) in
    let empty_block = Rule_list s in
    ({ name;
      prelude;
      block = empty_block;
      loc = make_loc $startpos $endpos;
    }): at_rule
  }
  /* @charset */
  | name = loc(AT_RULE_STATEMENT)
    xs = loc(values) SEMI_COLON {
    { name;
      prelude = xs;
      block = Empty;
      loc = make_loc $startpos $endpos;
    }
  }
  /* @support { ... } */
  /* @page { ... } */
  /* @{{rule}} { ... } */
  | name = loc(AT_RULE)
    xs = loc(values)
    s = brace_block(stylesheet_without_eof) {
    { name;
      prelude = xs;
      block = Stylesheet s;
      loc = make_loc $startpos $endpos;
    }
  }

percentage: n = PERCENTAGE { n }

/* keyframe allows stylesheet by defintion, but we restrict the usage to: */
keyframe_style_rule:
  /* from {} to {} */
  | id = selector_ident
    declarations = brace_block(loc(declarations)) {
    let prelude = [(SimpleSelector (Type id), make_loc $startpos(id) $endpos(id))] in
    Style_rule {
      prelude = (prelude, make_loc $startpos(id) $endpos(id));
      loc = make_loc $startpos $endpos;
      block = declarations;
    }
  }
  /* TODO: Support percentage in simple_selector and have selector parsing here */
  | percentages = separated_nonempty_list(COMMA, percentage)
    declarations = brace_block(loc(declarations)) {
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
  }

selector_list:
  | selector = loc(selector) { [selector] }
  | selector = loc(selector) COMMA seq = selector_list { selector :: seq }

relative_selector_list:
  | selector = loc(relative_selector) { [selector] }
  | selector = loc(relative_selector) COMMA seq = relative_selector_list { selector :: seq }

/* .class {} */
style_rule:
  | prelude = loc(selector_list)
    block = loc(empty_brace_block) {
    { prelude;
      block;
      loc = make_loc $startpos $endpos;
    }
  }
  | prelude = loc(selector_list)
    declarations = brace_block(loc(declarations)) {
    { prelude;
      block = declarations;
      loc = make_loc $startpos $endpos;
    }
  }

values: xs = list(loc(value)) { xs }

declarations:
  | xs = nonempty_list(rule) SEMI_COLON? { xs }

%inline rule:
  /* Rule can have declarations, since we have nesting, so both style_rules and
  declarations can live side by side. */
  | d = declaration_without_eof { Declaration d }
  | r = at_rule { At_rule r }
  | s = style_rule { Style_rule s }

declaration: d = declaration_without_eof EOF { d }

declaration_without_eof:
  /* property: value; */
  | property = loc(IDENT)
    COLON
    value = loc(values)
    important = loc(boption(IMPORTANT))
    SEMI_COLON? {
    { name = property;
      value;
      important;
      loc = make_loc $startpos $endpos;
    }
  }

combinator:
  | d = DELIM { combinator_from_delim d }

nth_operator:
  | d = DELIM { nth_operator_from_delim d }

nth_payload:
  /* TODO implement [of <complex-selector-list>]? */
  /* | complex = complex_selector_list; { NthSelector complex } */
  /* <An+B> */
  /* 2 */
  | a = NUMBER { Nth (A (int_of_float_exn a)) }
  /* 2n or 2n-1 (ndashdigit-dimension) */
  | a = DIMENSION {
    let (num, unit) = a in
    (* Check if unit matches n-<digits> pattern *)
    if String.length unit > 2 && String.get unit 0 = 'n' && String.get unit 1 = '-' then
      let b_str = String.sub unit 2 (String.length unit - 2) in
      try
        let b = int_of_string b_str in
        Nth (ANB ((int_of_float_exn num, "-", b)))
      with _ -> Nth (AN (int_of_float_exn num))
    else
      Nth (AN (int_of_float_exn num))
  }
  /* 2n+1 with explicit + */
  | a = DIMENSION combinator = nth_operator b = NUMBER {
    let b = int_of_float_exn b in
    Nth (ANB (((int_of_float_exn (fst a)), combinator, b)))
  }
  /* This is a hackish solution where the combinator isn't captured because the lexer
  assigns the sign (+/-) to NUMBER. We detect the sign from the number's value. */
  | a = DIMENSION b = NUMBER {
    let b_int = int_of_float_exn b in
    let (op, b_abs) = if b_int < 0 then ("-", Int.abs b_int) else ("+", b_int) in
    Nth (ANB (((int_of_float_exn (fst a)), op, b_abs)))
  }
  | n = selector_ident {
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
  | n = selector_ident combinator = nth_operator b = NUMBER {
    let first_char = String.get n 0 in
    let a = if first_char = '-' then -1 else 1 in
    Nth (ANB ((a, combinator, int_of_float_exn b)))
  }
  /* Handle case where combinator is absorbed into NUMBER (e.g., -n+6 -> IDENT NUMBER) */
  | n = selector_ident b = NUMBER {
    let first_char = String.get n 0 in
    let a = if first_char = '-' then -1 else 1 in
    let b_int = int_of_float_exn b in
    let (op, b_abs) = if b_int < 0 then ("-", Int.abs b_int) else ("+", b_int) in
    Nth (ANB ((a, op, b_abs)))
  }
  /* TODO: Support "An+B of Selector" */

%inline selector_ident:
  | i = IDENT { i }
  | i = TYPE_SELECTOR { i }

/* <pseudo-class-selector> = ':' <ident-token> | ':' <function-token> <any-value> ')' */
pseudo_class_selector:
  | COLON i = selector_ident { (Pseudoclass(PseudoIdent i)) } /* :visited */
  | COLON f = FUNCTION xs = loc(relative_selector_list) RIGHT_PAREN {
    (Pseudoclass(Function({ name = f; payload = xs })))
  }
  | COLON f = NTH_FUNCTION xs = loc(nth_payload) RIGHT_PAREN /* :nth() */ {
    (Pseudoclass(NthFunction({ name = f; payload = xs })))
  }
  /* TODO: <function-token> and <any-value> */
;

/* "~=" | "|=" | "^=" | "$=" | "*=" | "=" */
operator_prefix:
  | d = DELIM { operator_prefix_from_delim d }
  | ASTERISK { operator_prefix_from_delim "*" }

operator:
  | prefix = operator_prefix d = DELIM { let _ = expect_delim "=" d in prefix ^ "=" }
  | d = DELIM { expect_delim "=" d }

attr_matcher:
 | o = operator { o }

wq_name:
  | i = selector_ident { i }

/* <attribute-selector> = '[' <wq-name> ']' | '[' <wq-name> <attr-matcher> [  <string-token> | <ident-token> ] <attr-modifier>? ']' */
attribute_selector:
  /* https://www.w3.org/TR/selectors-4/#type-nmsp */
  /* We don't support namespaces in wq-name (`ns-prefix?`). We treat it like a IDENT */
  /* [ <wq-name> ] */
  | LEFT_BRACKET
    i = wq_name
    RIGHT_BRACKET {
    Attribute(Attr_value i)
  }
  /* [ wq-name = "value"] */
  | LEFT_BRACKET
    i = wq_name
    m = attr_matcher
    v = STRING
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
  | LEFT_BRACKET
    i = wq_name
    m = attr_matcher
    v = wq_name
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
id_selector: h = HASH { let (value, _) = h in Id value }

/* <class-selector> = '.' <ident-token> */
class_selector:
  | DOT id = selector_ident { Class id }

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
  /* | xs = simple_selector { SimpleSelector xs } */
  /* | xs = compound_selector { CompoundSelector xs } */
  | xs = complex_selector { ComplexSelector xs }

type_selector:
  | AMPERSAND; { Ampersand } /* & {} https://drafts.csswg.org/css-nesting/#nest-selector */
  | ASTERISK; { Universal } /* * {} */
  | v = INTERPOLATION { Variable v } /* $(Module.value) {} */
  | type_ = TYPE_SELECTOR { Type type_ } /* a {} */

/* <simple-selector> = <type-selector> | <subclass-selector> */
/* <simple-selector> = <self-selector> | <type-selector> | <subclass-selector> */
simple_selector:
  | t = type_selector { t }
  /* With <coumpound-selector> that subclass_selector becomes irrelevant */
  /* | sb = subclass_selector { Subclass sb } */ /* #a, .a, a:visited, a[] */

pseudo_element_selector:
  DOUBLE_COLON; pse = selector_ident { Pseudoelement pse } /* ::after */

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
  | DESCENDANT_COMBINATOR s = non_complex_selector { (None, s) }
  | c = combinator s = non_complex_selector { (Some c, s) }

%inline non_complex_selector:
  | s = simple_selector { SimpleSelector s }
  | s = compound_selector { CompoundSelector s }

/* <complex-selector> = <compound-selector> [ <combinator>? <compound-selector> ]* */
complex_selector:
  | left = non_complex_selector seq = list(combinator_sequence) {
    match seq with
    | [] -> Selector left
    | _ ->
      Combinator {
        left = left;
        right = seq;
      }
  }
/* <relative-selector> = <combinator>? <complex-selector> */
relative_selector:
  | xs = complex_selector { RelativeSelector { combinator = None; complex_selector = xs} }
  | c = combinator xs = complex_selector { RelativeSelector { combinator = Some c; complex_selector = xs } }

value:
  | WS { Whitespace }
  | b = paren_block(values) { Paren_block b }
  | b = bracket_block(values) { Bracket_block b }
  | n = percentage { Percentage n }
  | i = IDENT { Ident i }
  | i = TYPE_SELECTOR { Ident i }
  | s = STRING { String s }
  | COLON { Delim ":" }
  | DOUBLE_COLON { Delim "::" }
  | COMMA { Delim "," }
  | DOT { Delim "." }
  | ASTERISK { Delim "*" }
  | AMPERSAND { Delim "&" }
  | d = DELIM { Delim d }
  | GTE { Delim ">=" }
  | LTE { Delim "<=" }
  | h = HASH { let (value, _) = h in Hash value }
  | n = NUMBER { Number n }
  | r = UNICODE_RANGE { Unicode_range r }
  | d = DIMENSION { Dimension d }
  | v = INTERPOLATION { Variable v } /* $(Lola.value) */
  | f = loc(FUNCTION) v = loc(values) RIGHT_PAREN; { Function (f, v) } /* calc() */
  | f = loc(NTH_FUNCTION) v = loc(values) RIGHT_PAREN; { Function (f, v) } /* nth-() */
  | u = URL { Uri u } /* url() */
