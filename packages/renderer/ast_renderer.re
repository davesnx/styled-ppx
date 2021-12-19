open Css_types;
let container_lnum = 0;
let pos = Lexing.dummy_pos;
let ast = Css_lexer.parse_stylesheet(~container_lnum, ~pos, "html, body {display: flex}");

let render_record = zippedRecord => {
  let inner = zippedRecord |> List.map(((key, value)) =>
    Printf.sprintf("  %s: %s", key, value)
  ) |> String.concat(",\n")

  Printf.sprintf("{\n%s\n}", inner);
}

let rec render_stylesheet = (ast: Stylesheet.t) => {
  let inner = ast |> fst |> List.map(render_rule) |> String.concat(", ");
  "Stylesheet([" ++ inner ++ "])";
} and render_rule = (ast: Rule.t) => {
  switch (ast) {
    | Style_rule(style_rule) => render_style_rule(style_rule)
    | At_rule(at_rule) => render_at_rule(at_rule)
  }
} and render_style_rule = (ast:  Style_rule.t) => {
  render_record([("prelude", ast.prelude |> render_declaration_value), ("block", render_declaration_list(ast.block))])
}
 and render_at_rule = (ast: At_rule.t) => {
   render_record([("prelude", ast.prelude |> render_declaration_value), ("block", render_brace_block(ast.block))])
 }
 and render_brace_block = (ast) => {
   switch (ast: Brace_block.t) {
     | Empty => "Empty"
    | Declaration_list(declaration_list) => render_declaration_list(declaration_list)
    | Stylesheet(stylesheet) => render_stylesheet(stylesheet)
   }
 }
and render_declaration_kind = (ast: Declaration_list.kind) => {
  switch (ast) {
    | Declaration(declaration) => render_declaration(declaration)
    | Unsafe(unsafe) => render_declaration(unsafe)
    | Style_rule(style_rule) => render_style_rule(style_rule)
    | At_rule(at_rule) => render_at_rule(at_rule)
  }
} and render_declaration_list = (ast: Declaration_list.t) => {
  let inner = ast |> fst |> List.map(render_declaration_kind) |> String.concat(", ");
  "Declaration([" ++ inner ++ "])";
}
and render_declaration = (ast: Declaration.t) => {
  render_record([("name", ast.name |> fst), ("value", ast.value |> render_declaration_value), ("important", ast.important |> fst |> string_of_bool)])
} and render_declaration_value = (ast: with_loc(list(with_loc(Component_value.t)))) => {
  let inner = ast |> fst |> List.map( render_component_value) |> String.concat(", ");
  "[" ++ inner ++ "]"
}
and render_component_value = (ast: with_loc(Component_value.t)) => {
  let value = ast |> fst;
  switch (value) {
    | Paren_block(_) => "Paren_block(_)"
    | Bracket_block(_) => "Bracket_block(_)"
    | Percentage(string) => "Percentage(" ++ string ++ ")"
    | Ident(string) => "Ident(" ++ string ++ ")"
    | String(string) => "String(" ++ string ++ ")"
    | Selector(string) => "Selector(" ++ string ++ ")"
    | Uri(string) => "Uri(" ++ string ++ ")"
    | Operator(string) => "Operator(" ++ string ++ ")"
    | Delim(string) => "Delim(" ++ string ++ ")"
    | Function(_) => "Function(_)"
    | Hash(string) => "Hash(" ++ string ++ ")"
    | Number(string) => "Number(" ++ string ++ ")"
    | Unicode_range(string) => "Unicode_range(" ++ string ++ ")"
    | Float_dimension(_) => failwith("TODO")
    | Dimension(_) => "Dimension(_)"
    | Variable(_) => "Variable(_)"
  }
}

print_endline(render_stylesheet(ast))

/* let parse_declaration = (~container_lnum=?, ~pos=?, css) =>
  parse_string(~container_lnum?, ~pos?, Parser.declaration, css);

let parse_stylesheet = (~container_lnum=?, ~pos=?, css) =>
  parse_string(~container_lnum?, ~pos?, Parser.stylesheet, css);
 */
