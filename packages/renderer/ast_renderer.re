/* esy x ast-renderer */
open Css_types;

let render_field = ((key, value)) => Printf.sprintf("  %s: %s", key, value);

let render_record = record =>
  record
  |> List.map(render_field)
  |> String.concat(",\n")
  |> Printf.sprintf("{\n%s\n}");

let dimension_of_string =
  fun
  | Length => "Length"
  | Angle => "Angle"
  | Time => "Time"
  | Frequency => "Frequency";

let rec render_stylesheet = (ast: Stylesheet.t) => {
  let inner = ast |> fst |> List.map(render_rule) |> String.concat(", ");
  "Stylesheet(" ++ inner ++ ")";
}
and render_rule = (ast: Rule.t) => {
  switch (ast) {
  | Declaration(decl) =>
    "Declaration(" ++ render_declaration(decl) ++ ")";
  | Style_rule(style_rule) =>
    "Style_rule(" ++ render_style_rule(style_rule) ++ ")"
  | At_rule(at_rule) => "At_rule(" ++ render_at_rule(at_rule) ++ ")"
  };
}
and render_style_rule = (ast: Style_rule.t) => {
  render_record([
    ("prelude", ast.prelude |> fst |> render_selector),
    ("block", render_declaration_list(ast.block)),
  ]);
}
and render_at_rule = (ast: At_rule.t) => {
  render_record([
    ("prelude", ast.prelude |> render_declaration_value),
    ("block", render_brace_block(ast.block)),
  ]);
}
and render_brace_block = ast => {
  switch ((ast: Brace_block.t)) {
  | Empty => "Empty"
  | Rule_list(declaration_list) =>
    render_declaration_list(declaration_list)
  | Stylesheet(stylesheet) => render_stylesheet(stylesheet)
  };
}
and render_declaration_kind = (ast: Rule.t) => {
  switch (ast) {
  | Declaration(declaration) => render_declaration(declaration)
  | Style_rule(style_rule) => render_style_rule(style_rule)
  | At_rule(at_rule) => render_at_rule(at_rule)
  };
}
and render_declaration_list = (ast: Rule_list.t) => {
  let inner =
    ast |> fst |> List.map(render_declaration_kind) |> String.concat(", ");
  "Declaration([" ++ inner ++ "])";
}
and render_declaration = (ast: Declaration.t) => {
  render_record([
    ("name", ast.name |> fst),
    ("value", ast.value |> render_declaration_value),
    ("important", ast.important |> fst |> string_of_bool),
  ]);
}
and render_declaration_value =
    (ast: with_loc(list(with_loc(Component_value.t)))) => {
  let inner =
    ast |> fst |> List.map(render_component_value) |> String.concat(", ");
  "[" ++ inner ++ "]";
}

and render_selector = (ast: Selector.t) => {
  open Selector;

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
    | Pseudo_class(psc) => "Pseudo_class(" ++ render_pseudo_selector(psc) ++ ")"
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
  and render_pseudo_selector =
    fun
    | Pseudoelement(v) => "Pseudoelement(" ++ v ++ ")"
    | Pseudoclass(Ident(i)) => "Pseudoclass(Ident(" ++ i ++ "))"
    | Pseudoclass(Function({name, payload: (selector, _)})) =>
      "Pseudoclass(Function("
      ++ name
      ++ ", "
      ++ render_selector(selector)
      ++ "))"
  and render_variable = v => String.concat(".", v);

  let rec render_compound_selector = (compound_selector: compound_selector) => {
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
    let compound = String.concat(", ", [simple_selector, subclass_selectors, pseudo_selectors] |> List.filter(is_not_empty));
    "Compound(" ++ compound ++ ")"
  }
  and render_complex_selector: complex_selector => string =
    fun
    | Selector(compound) => render_compound_selector(compound)
    | Combinator({left, right}) =>
      "Left(" ++ render_compound_selector(left) ++ "), Right(" ++ render_right_combinator(right) ++ ")"
  and render_right_combinator = right => {
    right
    |> List.map(((combinator, compound_selector)) => {
         String.concat(", ", [Option.fold(
           ~none="Whitespace",
           ~some=o => "Combinator(" ++ o ++ ")",
           combinator,
         ), render_compound_selector(compound_selector)])
       })
    |> String.concat(", ");
  };

  switch (ast) {
  | SimpleSelector(v) =>
    "SimpleSelector(["
    ++ (v |> List.map(render_simple_selector) |> String.concat(", "))
    ++ "])"
  | ComplexSelector(v) =>
    "ComplexSelector(["
    ++ (v |> List.map(render_complex_selector) |> String.concat(", "))
    ++ "])"
  | CompoundSelector(v) =>
    "CompoundSelector(["
    ++ (v |> List.map(render_compound_selector) |> String.concat(", "))
    ++ "])"
  };
}
and render_component_value = (ast: with_loc(Component_value.t)) => {
  let value = ast |> fst;
  switch (value) {
  | Paren_block(block) =>
    let block =
      block |> List.map(render_component_value) |> String.concat(", ");
    "Paren_block(" ++ block ++ ")";
  | Bracket_block(block) =>
    let block =
      block |> List.map(render_component_value) |> String.concat(", ");
    "Bracket_block(" ++ block ++ ")";
  | Percentage(string) => "Percentage(" ++ string ++ ")"
  | Ident(string) => "Ident(" ++ string ++ ")"
  | String(string) => "String(" ++ string ++ ")"
  | Uri(string) => "Uri(" ++ string ++ ")"
  | Operator(string) => "Operator(" ++ string ++ ")"
  | Combinator(string) => "Combinator(" ++ string ++ ")"
  | Delim(string) => "Delim(" ++ string ++ ")"
  | Function(name, body) =>
    let body =
      body |> fst |> List.map(render_component_value) |> String.concat(", ");
    "Function(" ++ fst(name) ++ ", [" ++ body ++ "])";
  | Hash(string) => "Hash(" ++ string ++ ")"
  | Number(string) => "Number(" ++ string ++ ")"
  | Unicode_range(string) => "Unicode_range(" ++ string ++ ")"
  | Float_dimension((a, b, dimension)) =>
    "Float_dimension("
    ++ a
    ++ ", "
    ++ b
    ++ ", "
    ++ dimension_of_string(dimension)
    ++ ")"
  | Dimension((a, b)) => "Dimension(" ++ a ++ ", " ++ b ++ ")"
  | Variable(variable) =>
    "Variable(" ++ (variable |> String.concat(".")) ++ ")"
  | Pseudoelement((v, _)) => "Pseudoelement(" ++ v ++ ")"
  | Pseudoclass((v, _)) => "Pseudoclass(" ++ v ++ ")"
  | PseudoclassFunction((v, _), (_, _)) =>
    "PseudoclassFunction(" ++ v ++ ")"
  | Selector(v) =>
    let value = v |> fst |> render_selector;
    "Selector(" ++ value ++ ")";
  };
};

let render_help = () => {
  print_endline("");
  print_endline("");
  print_endline(
    {|  ast-renderer pretty-prints the CSS AST of parser/css_lexer.re|},
  );
  print_endline("");
  print_endline({|    EXAMPLE: esy x ast-renderer ".a { color: red }"|});
  print_endline("");
  print_endline("");
};

let container_lnum = 0;
let pos = Lexing.dummy_pos;
let args = Sys.argv |> Array.to_list;
let input = List.nth_opt(args, 1);
let help =
  List.exists(
    arg =>
      arg == "--help"
      || arg == "-help"
      || arg == "help"
      || arg == "--h"
      || arg == "-h",
    args,
  );

switch (input, help) {
| (Some(_), true)
| (None, _) => render_help()
| (Some(css), _) =>
  /* TODO: parse any css:
     - check if it's valid stylesheet and render it
     - check if it's a valid declaration list and render it.
     - in any other case, print both errors.
     */
  let ast = Css_lexer.parse_declaration_list(~container_lnum, ~pos, css);
  print_endline(render_declaration_list(ast));
  /* let ast = Css_lexer.parse_stylesheet(~container_lnum, ~pos, css);
  print_endline(render_stylesheet(ast)); */
};
