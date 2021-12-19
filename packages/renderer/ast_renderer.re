open Css_types;

let container_lnum = 0;
let pos = Lexing.dummy_pos;
let ast = Css_lexer.parse_declaration_list(~container_lnum, ~pos, "display: flex");

let render_record = zippedRecord => {
  let inner = zippedRecord |> List.map(((key, value)) =>
    Printf.sprintf("  %s: %s", key, value)
  ) |> String.concat(",\n")

  Printf.sprintf("{\n%s\n}", inner);
}

let rec render_declaration_kind = (ast: Declaration_list.kind): string => {
  switch (ast) {
    | Declaration(declaration) => render_declaration(declaration)
    | Unsafe(unsafe) => render_declaration(unsafe)
    | At_rule(_at_rule) => failwith("TODO")
    | Style_rule(_style_rule) => failwith("TODO")
  }
} and render_declaration_list = (ast: Declaration_list.t): string => {
  let inner = ast |> fst |> List.map(render_declaration_kind) |> String.concat(", ");
  "Declaration(" ++ inner ++ ")";
}
and render_declaration = (ast: Declaration.t): string => {
  render_record([("name", ast.name |> fst), ("value", ast.value |> fst |> render_declaration_value), ("important", ast.important |> fst |> string_of_bool)])
} and render_declaration_value = (ast): string => {
  let inner = ast |> List.map(render_value) |> String.concat(", ");
  "[" ++ inner ++ "]"
}
and render_value = (ast): string => {
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

print_endline(render_declaration_list(ast))

/* let parse_declaration = (~container_lnum=?, ~pos=?, css) =>
  parse_string(~container_lnum?, ~pos?, Parser.declaration, css);

let parse_stylesheet = (~container_lnum=?, ~pos=?, css) =>
  parse_string(~container_lnum?, ~pos?, Parser.stylesheet, css);
 */
