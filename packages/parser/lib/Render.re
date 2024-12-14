open Ast;
let render_field = ((key, value)) => Printf.sprintf("  %s: %s", key, value);

let render_record = record =>
  record
  |> List.map(render_field)
  |> String.concat(",\n")
  |> Printf.sprintf("{\n%s\n}");

let rec render_stylesheet = (ast: stylesheet) => {
  let inner = ast |> fst |> List.map(render_rule) |> String.concat(", ");
  "Stylesheet(" ++ inner ++ ")";
}
and render_rule = (ast: rule) => {
  switch (ast) {
  | Declaration(declaration) =>
    "Declaration(" ++ render_declaration(declaration) ++ ")"
  | Style_rule(style_rule) =>
    "Style_rule(" ++ render_style_rule(style_rule) ++ ")"
  | At_rule(at_rule) => "At_rule(" ++ render_at_rule(at_rule) ++ ")"
  };
}
and render_style_rule = ({prelude, block, _}: style_rule) => {
  render_record([
    ("prelude", prelude |> fst |> render_selector_list),
    ("block", render_rule_list(block)),
  ]);
}
and render_at_rule = (ast: at_rule) => {
  render_record([
    ("prelude", ast.prelude |> fst |> render_component_value),
    ("block", render_brace_block(ast.block)),
  ]);
}
and render_brace_block = ast => {
  switch ((ast: brace_block)) {
  | Empty => "Empty"
  | Rule_list(rule_list) => render_rule_list(rule_list)
  | Stylesheet(stylesheet) => render_stylesheet(stylesheet)
  };
}
and render_rule_list = (rule_list: rule_list) => {
  let inner =
    rule_list |> fst |> List.map(render_rule) |> String.concat(", ");
  "Declaration([" ++ inner ++ "])";
}
and render_declaration = ({name, value, important, _}: declaration) => {
  render_record([
    ("name", name |> fst),
    ("value", value |> fst |> render_component_value_list),
    ("important", important |> fst |> string_of_bool),
  ]);
}
and render_component_value_list = (ast: component_value_list) => {
  let inner =
    ast
    |> List.map(fst)
    |> List.map(render_component_value)
    |> String.concat(", ");
  "[" ++ inner ++ "]";
}

and render_selector = (ast: selector) => {
  let rec render_simple_selector =
    fun
    | Universal => "Universal"
    | Ampersand => "Ampersand"
    | Type(v) => "Type(" ++ v ++ ")"
    | Subclass(v) => "Subclass(" ++ render_subclass_selector(v) ++ ")"
    | Variable(v) => "Variable(" ++ render_variable(v) ++ ")"
    | Percentage(p) => "Percentage(" ++ p ++ ")"
  and render_subclass_selector: subclass_selector => string =
    fun
    | Id(v) => "Id(" ++ v ++ ")"
    | Class(v) => "Class(" ++ v ++ ")"
    | Attribute(attr) => "Attribute(" ++ render_attribute(attr) ++ ")"
    | Pseudo_class(psc) =>
      "Pseudo_class(" ++ render_pseudo_selector(psc) ++ ")"
    | ClassVariable(v) => "ClassVariable(" ++ render_variable(v) ++ ")"
  and render_attribute =
    fun
    | Attr_value(v) => "Attr_value(" ++ v ++ ")"
    | To_equal({name, kind, value}) =>
      "To_equal("
      ++ name
      ++ ", "
      ++ kind
      ++ ", "
      ++ render_attr_(value)
      ++ ")"
  and render_attr_ =
    fun
    | Attr_ident(i) => i
    | Attr_string(str) => "\"" ++ str ++ "\""
  and render_nth =
    fun
    | A(a) => "A(" ++ string_of_int(a) ++ ")"
    | AN(a) => "AN(" ++ string_of_int(a) ++ ")"
    | ANB(left, op, right) =>
      "ANB("
      ++ string_of_int(left)
      ++ ", "
      ++ op
      ++ ", "
      ++ string_of_int(right)
      ++ ")"
    | Even => "Even"
    | Odd => "Odd"
  and render_nth_payload =
    fun
    | Nth(nth) => render_nth(nth)
    | NthSelector(v) =>
      "NthSelector(ComplexSelector(["
      ++ (v |> List.map(render_complex_selector) |> String.concat(", "))
      ++ "]))"
  and render_pseudo_class =
    fun
    | PseudoIdent(i) => "Pseudoclass(Ident(" ++ i ++ "))"
    | Function({name, payload: (selector_list, _)}) =>
      "Function("
      ++ name
      ++ ", "
      ++ render_selector_list(selector_list)
      ++ ")"
    | NthFunction({name, payload: (selector, _)}) =>
      "Function(" ++ name ++ ", " ++ render_nth_payload(selector) ++ ")"
  and render_pseudo_selector =
    fun
    | Pseudoelement(v) => "Pseudoelement(" ++ v ++ ")"
    | Pseudoclass(pc) => "Pseudoclass(" ++ render_pseudo_class(pc) ++ ")"
  and render_variable = v => String.concat(".", v)
  and render_compound_selector = (compound_selector: compound_selector) => {
    let simple_selector =
      compound_selector.type_selector
      |> Option.fold(~none="", ~some=render_simple_selector);
    let subclass_selectors =
      List.map(render_subclass_selector, compound_selector.subclass_selectors)
      |> String.concat("");
    let pseudo_selectors =
      List.map(render_pseudo_selector, compound_selector.pseudo_selectors)
      |> String.concat("");

    let is_not_empty = s => String.length(s |> String.trim) != 0;
    let compound =
      String.concat(
        ", ",
        [simple_selector, subclass_selectors, pseudo_selectors]
        |> List.filter(is_not_empty),
      );
    "Compound(" ++ compound ++ ")";
  }
  and render_complex_selector: complex_selector => string =
    fun
    | Selector(compound) => render_selector(compound)
    | Combinator({left, right}) =>
      "Left("
      ++ render_selector(left)
      ++ "), Right("
      ++ render_right_combinator(right)
      ++ ")"
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, selector)) => {
         String.concat(
           ", ",
           [
             Option.fold(
               ~none="Whitespace",
               ~some=o => "Combinator(" ++ o ++ ")",
               combinator,
             ),
             render_selector(selector),
           ],
         )
       })
    |> String.concat(", ");
  }
  and render_relative_selector = ({ combinator, complex_selector }) => {
    render_right_combinator([(combinator, ComplexSelector(complex_selector))])
  };

  switch (ast) {
  | SimpleSelector(v) =>
    "SimpleSelector([" ++ render_simple_selector(v) ++ "])"
  | ComplexSelector(v) =>
    "ComplexSelector([" ++ render_complex_selector(v) ++ "])"
  | CompoundSelector(v) =>
    "CompoundSelector([" ++ render_compound_selector(v) ++ "])"
  | RelativeSelector(v) =>
    "RelativeSelector([" ++ render_relative_selector(v) ++ "])"
  };
}
and render_selector_list = (ast: selector_list) => {
  ast |> List.map(fst) |> List.map(render_selector) |> String.concat(", ");
}
and render_component_value = (ast: component_value) => {
  switch (ast) {
  | Paren_block(block) =>
    "Paren_block(" ++ render_component_value_list(block) ++ ")";
  | Bracket_block(block) =>
    "Bracket_block(" ++ render_component_value_list(block) ++ ")";
  | Percentage(string) => string ++ "%"
  | Ident(string) => string
  | String(string) => "\"" ++ string ++ "\""
  | Uri(string) => "Uri(" ++ string ++ ")"
  | Operator(string) => "Operator(" ++ string ++ ")"
  | Combinator(string) => "Combinator(" ++ string ++ ")"
  | Delim(string) => "Delim(" ++ string ++ ")"
  | Function(name, body) =>
    let body =
      body |> fst |> render_component_value_list;
    "Function(" ++ fst(name) ++ ", [" ++ body ++ "])";
  | Hash(string) => "Hash(" ++ string ++ ")"
  | Number(n) => "Number(" ++ n ++ ")"
  | Unicode_range(string) => "Unicode_range(" ++ string ++ ")"
  | Float_dimension((a, b)) => "Float_dimension(" ++ a ++ ", " ++ b ++ ")"
  | Dimension((a, b)) => "Dimension(" ++ a ++ ", " ++ b ++ ")"
  | Variable(variable) =>
    "Variable(" ++ (variable |> String.concat(".")) ++ ")"
  | Selector(v) =>
    "Selector(" ++ render_selector_list(v) ++ ")";
  };
};
