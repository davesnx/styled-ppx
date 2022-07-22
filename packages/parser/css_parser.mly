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
%token COMMA
%token WS
%token <string> IDENT
%token <string> TAG
%token <string> STRING
%token <string> OPERATOR
%token <string> COMBINATOR
%token <string> DELIM
%token <string> AT_MEDIA
%token <string> AT_KEYFRAMES
%token <string> AT_RULE
%token <string> AT_RULE_STATEMENT
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
stylesheet_without_eof: rs = loc(list(rule)) { rs };

declaration_list:
  | EOF { ([], Lex_buffer.make_loc $startpos $endpos) }
  | ds = loc(declarations); EOF { ds }
;

rule:
  | r = at_rule { Rule.At_rule r }
  | r = style_rule { Rule.Style_rule r }
;

loc(X): x = X { (x, Lex_buffer.make_loc $startpos(x) $endpos(x))}

/* TODO: Remove empty_brace_block */
/* {} */
empty_brace_block: LEFT_BRACE; RIGHT_BRACE; { [] }
brace_block(X):
  xs = delimited(LEFT_BRACE, X, RIGHT_BRACE);
  SEMI_COLON? { xs };

/* [] */
bracket_block (X): xs = delimited(LEFT_BRACKET, X, RIGHT_BRACKET); { xs };

/* () */
paren_block (X): xs = delimited(LEFT_PAREN, X, RIGHT_PAREN); { xs };

/* https://www.w3.org/TR/css-syntax-3/#at-rules */
at_rule:
  /* @media (min-width: 16rem) {} */
  | name = loc(AT_MEDIA); xs = loc(prelude); empty_brace_block {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @media (min-width: 16rem) { ... } */
  | name = loc(AT_MEDIA); xs = loc(prelude); ds = brace_block(loc(declarations)) {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Declaration_list ds;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName {} */
  | name = loc(AT_KEYFRAMES); i = IDENT; empty_brace_block {
    { At_rule.name = name;
      prelude = ([(Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i))], Lex_buffer.make_loc $startpos(i) $endpos(i));
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @keyframes animationName { ... } */
  | name = loc(AT_KEYFRAMES); i = IDENT; s = brace_block(stylesheet_without_eof) {
    { At_rule.name = name;
      prelude = ([(Component_value.Ident(i), Lex_buffer.make_loc $startpos(i) $endpos(i))], Lex_buffer.make_loc $startpos(i) $endpos(i));
      block = Brace_block.Stylesheet s;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @charset */
  | name = loc(AT_RULE_STATEMENT); xs = loc(prelude); SEMI_COLON?; {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @{{rule}} {} */
  | name = loc(AT_RULE); xs = loc(prelude); empty_brace_block {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Empty;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  /* @{{rule}} { ... } */
  | name = loc(AT_RULE); xs = loc(prelude); s = brace_block(stylesheet_without_eof) {
    { At_rule.name = name;
      prelude = xs;
      block = Brace_block.Stylesheet s;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

/* .class {} */
style_rule:
  | selector = loc(selector); WS?; block = empty_brace_block; {
    { Style_rule.prelude = selector;
      block = block, Location.none;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
  | selector = loc(selector); WS?; declarations = brace_block(loc(declarations)); {
    { Style_rule.prelude = selector;
      block = declarations;
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

prelude: xs = nonempty_list(loc(component_value_in_prelude)) { xs };

component_values: xs = nonempty_list(loc(component_value)) { xs };

declarations:
  | xs = nonempty_list(declaration_or_at_rule); SEMI_COLON?; { xs }
  | xs = separated_nonempty_list(SEMI_COLON, declaration_or_at_rule); SEMI_COLON?; { xs }

declaration_or_at_rule:
  | d = declaration_without_eof; { Declaration_list.Declaration d }
  | r = at_rule { Declaration_list.At_rule r }
  | s = style_rule { Declaration_list.Style_rule s }
;

declaration: d = declaration_without_eof; EOF { d };

/* property: value; */
declaration_without_eof:
  | n = IDENT; WS?; COLON; v = loc(component_values); i = boption(IMPORTANT); SEMI_COLON? {
    { Declaration.name = (n, Lex_buffer.make_loc $startpos(n) $endpos(n));
      value = v;
      important = (i, Lex_buffer.make_loc $startpos(i) $endpos(i));
      loc = Lex_buffer.make_loc $startpos $endpos;
    }
  }
;

/* ::after */
pseudo_element_selector:
  DOUBLE_COLON; pse = IDENT { Selector.Pseudoelement pse };

/* <pseudo-class-selector> = ':' <ident-token> | ':' <function-token> <any-value> ')' */
pseudo_class_selector:
  /* :visited */
  | COLON; i = IDENT { Selector.(Pseudoclass(Ident i)) }
  /* :nth-child() */
  | COLON; f = IDENT; LEFT_PAREN; xs = loc(selector); RIGHT_PAREN {
    Selector.(Pseudoclass(Function({ name = f; payload = xs })))
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
  | LEFT_BRACKET; i = IDENT; RIGHT_BRACKET {
    Selector.Attribute(Attr_value i)
  }
  /* [ wq-name = "value"] */
  | LEFT_BRACKET; i = IDENT; m = attr_matcher; v = STRING; RIGHT_BRACKET {
    Selector.Attribute(
      To_equal({
        name = i;
        kind = m;
        value = Selector.Attr_string v
      })
    )
  }
  /* [ wq-name = value] */
  | LEFT_BRACKET; i = IDENT; m = attr_matcher; v = IDENT; RIGHT_BRACKET {
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
id_selector:
  | h = HASH { Selector.Id h }

/* <class-selector> = '.' <ident-token> */
class_selector: DOT; c = IDENT { Selector.Class c };

/* <subclass-selector> = <id-selector> | <class-selector> | <attribute-selector> | <pseudo-class-selector> */
subclass_selector:
  | id = id_selector { id }
  | c = class_selector { c }
  | a = attribute_selector { a }
  | pcs = pseudo_class_selector { Selector.Pseudo_class pcs }
;

selector:
  /* <simple-selector-list> = <simple-selector># */
  | xs = separated_nonempty_list(COMMA, simple_selector) {
    Selector.SimpleSelector xs
  }
  /* <compound-selector-list> = <compound-selector># */
  | xs = separated_nonempty_list(COMMA, compound_selector) {
    Selector.CompoundSelector xs
  }
  /* <complex-selector-list> = <complex-selector># */
  | xs = separated_nonempty_list(COMMA, complex_selector) {
    Selector.ComplexSelector xs
  }
;

/* <simple-selector> = <type-selector> | <subclass-selector> */
/* We change the spec adding the & selector */
/* <simple-selector> = <self-selector> | <type-selector> | <subclass-selector> */
simple_selector:
  /* & {} */
  | AMPERSAND; { Selector.Ampersand }
  /* $(Module.value) {} */
  | v = VARIABLE { Selector.Variable v }
  /* a {} */
  | type_ = TAG; { Selector.Type type_ }
  /* #a, .a, a:visited, a[] */
  | sb = subclass_selector { Selector.Subclass sb }
;

/* TODO: better name */
/* [ <pseudo-element-selector> <pseudo-class-selector>* ] */
pseudoelement_followed_by_pseudoclasslist:
  | e = pseudo_element_selector; xs = list(pseudo_class_selector); { (e, xs) }
;

/* <compound-selector> = [ <type-selector>? <subclass-selector>* [ <pseudo-element-selector> <pseudo-class-selector>* ]* ]!
  We differ from the spec on type-selector which is a IDENT,
  for a simple_selector (adding & and variables) */
compound_selector:
  | type_selector = simple_selector; subclass_selectors = loption(list(subclass_selector)); pseudo_selectors = loption(list(pseudoelement_followed_by_pseudoclasslist)); {
    Selector.{
      type_selector = Some type_selector;
      subclass_selectors;
      pseudo_selectors;
    }
  }
;

/* <complex-selector> = <compound-selector> [ <combinator>? <compound-selector> ]* */
complex_selector:
  | left = compound_selector;
    right = loption(list(pair(COMBINATOR?, compound_selector))); {
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
  | n = NUMBER; PERCENTAGE { Component_value.Percentage n }
  | i = IDENT { Component_value.Ident i }
  | s = STRING { Component_value.String s }
  | c = COMBINATOR { Component_value.Combinator c}
  | o = OPERATOR { Component_value.Operator o }
  | d = DELIM { Component_value.Delim d }
  | DOT { Component_value.Delim "." }
  | COLON { Component_value.Delim ":" }
  | DOUBLE_COLON { Component_value.Delim "::" }
  | WS { Component_value.Delim "*" }
  | h = HASH { Component_value.Hash h }
  | COMMA { Component_value.Delim "," }
  | n = NUMBER { Component_value.Number n }
  | r = UNICODE_RANGE { Component_value.Unicode_range r }
  | d = FLOAT_DIMENSION { Component_value.Float_dimension d }
  | d = DIMENSION { Component_value.Dimension d }
  /* $(Lola.value) */
  | v = VARIABLE { Component_value.Variable v }
  /* calc() */
  | f = loc(IDENT); LEFT_PAREN; xs = loc(prelude); RIGHT_PAREN; {
    Component_value.Function (f, xs)
  }
;

component_value:
  | b = paren_block(component_values) { Component_value.Paren_block b }
  | b = bracket_block(component_values) { Component_value.Bracket_block b }
  | n = NUMBER; PERCENTAGE { Component_value.Percentage n }
  | i = IDENT { Component_value.Ident i }
  | s = STRING { Component_value.String s }
  | c = COMBINATOR { Component_value.Combinator c}
  | o = OPERATOR { Component_value.Operator o }
  | d = DELIM { Component_value.Delim d }
  | WS?; DOT { Component_value.Delim "." }
  | WS?; COLON { Component_value.Delim ":" }
  | WS?; h = HASH { Component_value.Hash h }
  | WS?; DOUBLE_COLON { Component_value.Delim "::" }
  | COMMA { Component_value.Delim "," }
  | n = NUMBER { Component_value.Number n }
  | r = UNICODE_RANGE { Component_value.Unicode_range r }
  | d = FLOAT_DIMENSION { Component_value.Float_dimension d }
  | d = DIMENSION { Component_value.Dimension d }
  /* $(Lola.value) */
  | v = VARIABLE { Component_value.Variable v }
  /* calc() */
  | f = loc(IDENT); LEFT_PAREN; xs = loc(component_values); RIGHT_PAREN; {
    Component_value.Function (f, xs)
  }
;
