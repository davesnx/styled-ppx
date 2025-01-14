open Ast;
open Resolve;

let rec render_stylesheet = (ast: stylesheet) => {
  ast |> fst |> List.map(render_rule) |> String.concat("");
}
and render_rule = (ast: rule) => {
  switch (ast) {
  | Declaration(declaration) => render_declaration(declaration)
  | Style_rule(style_rule) => render_style_rule(style_rule)
  | At_rule(at_rule) => render_at_rule(at_rule)
  };
}
and render_style_rule = ({prelude, block, _}: style_rule) => {
  Printf.sprintf(
    "%s{%s}",
    prelude |> fst |> render_selector_list,
    render_rule_list(block),
  );
}
and render_at_rule = ({name, prelude, block, _}: at_rule) => {
  Printf.sprintf(
    "@%s %s{%s}",
    name |> fst,
    prelude |> fst |> render_component_value_list,
    render_brace_block(block),
  );
}
and render_brace_block = ast => {
  switch ((ast: brace_block)) {
  | Empty => ""
  | Rule_list(rule_list) => render_rule_list(rule_list)
  | Stylesheet(stylesheet) => render_stylesheet(stylesheet)
  };
}
and render_rule_list = (rule_list: rule_list) => {
  let resolved_rule_list = {
    let (declarations, selectors) =
      rule_list |> fst |> resolve_selectors |> split_by_kind;
    declarations @ selectors;
  };
  resolved_rule_list
  |> List.filter(
       fun
       | Style_rule({block: (block, _), _}) when List.length(block) == 0 =>
         false
       | _ => true,
      )
    |> List.map(render_rule)
    |> String.concat("");
}
and render_declaration = ({name, value, important, _}: declaration) => {
  Printf.sprintf(
    "%s:%s%s;",
    name |> fst,
    value |> fst |> render_component_value_list,
    important |> fst ? " !important" : "",
  );
}
and render_component_value_list = (ast: component_value_list) => {
  ast
  |> List.map(fst)
  |> List.map(render_component_value)
  |> String.concat("");
}

and render_variable = v => "$(" ++ String.concat(".", v) ++ ")"

and render_selector = (ast: selector) => {
  let rec render_simple_selector =
    fun
    | Universal => "*"
    | Ampersand => "&"
    | Type(v) => v
    | Subclass(v) => render_subclass_selector(v)
    | Variable(v) => render_variable(v)
    | Percentage(p) => Printf.sprintf("%s%%", p)
  and render_subclass_selector: subclass_selector => string =
    fun
    | Id(v) => Printf.sprintf("#%s", v)
    | Class(v) => Printf.sprintf(".%s", v)
    | Attribute(attr) => Printf.sprintf("[%s]", render_attribute(attr))
    | Pseudo_class(psc) => render_pseudo_selector(psc)
    | ClassVariable(v) => "." ++ render_variable(v)
  and render_attribute =
    fun
    | Attr_value(v) => v
    | To_equal({name, kind, value}) =>
      name ++ kind ++ render_attr_value(value)
  and render_attr_value =
    fun
    | Attr_ident(i) => i
    | Attr_string(str) => "\"" ++ str ++ "\""
  and render_nth =
    fun
    | Even => "even"
    | Odd => "odd"
    | A(a) => string_of_int(a)
    | AN(an) when an == 1 => "n"
    | AN(an) when an == (-1) => "-n"
    | AN(an) => string_of_int(an) ++ "n"
    | ANB(a, op, b) when a == 1 => "n" ++ op ++ string_of_int(b)
    | ANB(a, op, b) when a == (-1) => "-n" ++ op ++ string_of_int(b)
    | ANB(a, op, b) => string_of_int(a) ++ "n" ++ op ++ string_of_int(b)
  and render_nth_payload =
    fun
    | Nth(nth) => render_nth(nth)
    | NthSelector(v) =>
      v |> List.map(render_complex_selector) |> String.concat(", ")
  and render_pseudo_class =
    fun
    | PseudoIdent(i) => ":" ++ i
    | Function({name, payload: (selector_list, _)}) =>
      ":" ++ name ++ "(" ++ render_selector_list(selector_list) ++ ")"
    | NthFunction({name, payload: (selector, _)}) =>
      ":" ++ name ++ "(" ++ render_nth_payload(selector) ++ ")"
  and render_pseudo_selector =
    fun
    | Pseudoelement(v) => "::" ++ v
    | Pseudoclass(pc) => render_pseudo_class(pc)
  and render_compound_selector = (compound_selector: compound_selector) => {
    let simple_selector =
      Option.fold(
        ~none="",
        ~some=render_simple_selector,
        compound_selector.type_selector,
      );
    let subclass_selectors =
      List.map(render_subclass_selector, compound_selector.subclass_selectors)
      |> String.concat("");
    let pseudo_selectors =
      List.map(render_pseudo_selector, compound_selector.pseudo_selectors)
      |> String.concat("");
    simple_selector ++ subclass_selectors ++ pseudo_selectors;
  }
  and render_complex_selector = complex => {
    switch (complex) {
    | Combinator({left, right}) =>
      let left = render_selector(left);
      let right = render_right_combinator(right);
      left ++ right;
    | Selector(selector) => render_selector(selector)
    };
  }
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, selector)) => {
         Option.fold(~none=" ", ~some=o => " " ++ o ++ " ", combinator)
         ++ render_selector(selector)
       })
    |> String.concat("");
  }
  and render_relative_selector = ({combinator, complex_selector}) => {
    Option.fold(~none="", ~some=o => o ++ " ", combinator)
    ++ render_complex_selector(complex_selector);
  };

  switch (ast) {
  | SimpleSelector(simple) => simple |> render_simple_selector
  | ComplexSelector(complex) => complex |> render_complex_selector
  | CompoundSelector(compound) => compound |> render_compound_selector
  | RelativeSelector(relative) => relative |> render_relative_selector
  };
}
and render_selector_list = (ast: selector_list) => {
  ast |> List.map(fst) |> List.map(render_selector) |> String.concat(",");
}
and render_component_value = (ast: component_value) => {
  switch (ast) {
  | Whitespace => " "
  | Paren_block(block) => "(" ++ render_component_value_list(block) ++ ")"
  | Bracket_block(block) => "[" ++ render_component_value_list(block) ++ "]"
  | Percentage(string) => string ++ "%"
  | Ident(string) => string
  | String(string) => "\"" ++ string ++ "\""
  | Uri(string) => "url(\"" ++ string ++ "\")"
  | Operator(string) => string
  | Combinator(string) => string
  | Delim(string) => string
  | Function(name, body) =>
    let body = body |> fst |> render_component_value_list;
    Printf.sprintf("%s(%s)", fst(name), body);
  | Hash(string) => "#" ++ string
  | Number(n) => n
  | Unicode_range(string) => string
  | Float_dimension((a, b)) => Printf.sprintf("%s%s", a, b)
  | Dimension((a, b)) => Printf.sprintf("%s%s", a, b)
  | Variable(variable) => render_variable(variable)
  | Selector(v) => render_selector_list(v)
  };
};
