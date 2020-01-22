open Css_types

let rec dump_component_value ppf (cv, _) =
  let dump_block start_char end_char cs =
    let pp = Fmt.(list ~sep:(const string " ") dump_component_value) in
    let pp =
      pp |> Fmt.(prefix (const string start_char))
      |> Fmt.(suffix (const string end_char))
    in
    pp ppf cs
  in
  match cv with
  | Component_value.Paren_block cs -> dump_block "(" ")" cs
  | Bracket_block cs -> dump_block "[" "]" cs
  | Percentage p ->
    let pp = Fmt.string |> Fmt.(suffix (const string "%")) in
    pp ppf p
  | Ident s
  | Uri s
  | Operator s
  | Delim s
  | Number s
  | Unicode_range s ->
    let pp = Fmt.string in
    pp ppf s
  | Hash s ->
    let pp = Fmt.(string |> prefix (const string "#")) in
    pp ppf s
  | String s ->
    let pp = Fmt.(string |> prefix (const string "\"") |> suffix (const string "\"")) in
    pp ppf s
  | Function ((name, _), (params, _)) ->
    let pp_name = Fmt.string |> Fmt.(suffix (const string "(")) in
    let pp_params =
      Fmt.(list ~sep:(const string ", ") dump_component_value)
      |> Fmt.(suffix (const string ")"))
    in
    let pp = Fmt.pair ~sep:Fmt.nop pp_name pp_params in
    pp ppf (name, params)
  | Float_dimension (number, dimension, _)
  | Dimension (number, dimension) ->
    let pp = Fmt.fmt "%s%s" in
    pp ppf number dimension

and dump_at_rule ppf (ar: At_rule.t) =
  let pp_name = Fmt.string |> Fmt.(prefix (const string "@")) in
  let pp_prelude = Fmt.(list ~sep:(const string " ") dump_component_value) in
  let pp_block ppf () =
    match ar.At_rule.block with
    | Brace_block.Empty -> Fmt.nop ppf ()
    | Declaration_list dl ->
      Fmt.(dump_declaration_list
           |> prefix cut
           |> prefix (const string "{")
           |> suffix cut
           |> suffix (const string "}")) ppf dl
    | Stylesheet s ->
      Fmt.(vbox ~indent:2
             (dump_stylesheet
              |> prefix cut)
           |> prefix cut
           |> prefix (const string "{")
           |> suffix cut
           |> suffix (const string "}")) ppf s
  in
  let (name, _) = ar.At_rule.name in
  let (prelude, _) = ar.At_rule.prelude in
  Fmt.fmt "%a %a %a" ppf pp_name name
    pp_prelude prelude pp_block ()

and dump_declaration ppf (d: Declaration.t) =
  let pp_name = Fmt.string in
  let pp_values = Fmt.(list ~sep:(const string " ") dump_component_value) in
  let pp_important =
    match d.Declaration.important with
    | (false, _) -> Fmt.nop
    | (true, _) -> Fmt.(const string " !important")
  in
  let (name, _) = d.Declaration.name in
  let (value, _) = d.Declaration.value in
  Fmt.fmt "%a: %a%a" ppf pp_name name
    pp_values value pp_important ()

and dump_declaration_list ppf (dl, _) : unit =
  let pp_elem ppf d =
    match d with
    | Declaration_list.Declaration d -> dump_declaration ppf d
    | Declaration_list.At_rule ar -> dump_at_rule ppf ar
  in
  let pp =
    Fmt.(vbox ~indent:2
           (list ~sep:(const string ";" |> suffix cut) pp_elem |> prefix cut))
  in
  pp ppf dl

and dump_style_rule ppf (sr: Style_rule.t) =
  let pp_prelude = Fmt.(list ~sep:(const string " ") dump_component_value) in
  let (prelude, _) = sr.Style_rule.prelude in
  Fmt.fmt "%a {@,%a@,}@," ppf pp_prelude
    prelude dump_declaration_list
    sr.Style_rule.block

and dump_rule ppf (r: Rule.t) =
  match r with
  | Rule.Style_rule sr -> dump_style_rule ppf sr
  | Rule.At_rule ar -> dump_at_rule ppf ar

and dump_stylesheet ppf (s, _) =
  let pp = Fmt.(vbox (list dump_rule)) in
  pp ppf s
