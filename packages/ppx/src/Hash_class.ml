let hash = Murmur2.default
let nul_join parts = String.concat "\000" parts

let block_hash ~module_name ~scope ~binding content =
  hash (nul_join [ module_name; String.concat "." scope; binding; content ])

let block_class ~module_name ~scope ~binding content =
  "css-" ^ block_hash ~module_name ~scope ~binding content

let block_variables ~block_hash =
  let names = Hashtbl.create 8 in
  fun ~type_key ~occurrence ~total path ->
    let key =
      nul_join
        [ path; type_key; (if total > 1 then string_of_int occurrence else "") ]
    in
    match Hashtbl.find_opt names key with
    | Some name -> name
    | None ->
      let name = Printf.sprintf "%s-%d" block_hash (Hashtbl.length names) in
      Hashtbl.add names key name;
      name

let marker_class ~module_name ~scope name =
  block_class ~module_name ~scope ~binding:name "\000marker"

let variable ~namespace ~type_key path =
  hash (nul_join [ namespace; path; type_key ])

let variable_for_occurrence ~namespace ~type_key ~occurrence ~total path =
  let name = variable ~namespace ~type_key path in
  if total > 1 then Printf.sprintf "%s_%d" name occurrence else name

let scoped_namespace ~kind ~module_name ~scope ~rendered_rules =
  let scope_key = String.concat "." scope in
  let rules_key = String.concat "\n" rendered_rules in
  nul_join [ kind; module_name; scope_key; hash rules_key ]

let keyframe_name rendered_body =
  Printf.sprintf "keyframe-%s" (hash rendered_body)

let global_key rendered_rule = Printf.sprintf "global-%s" (hash rendered_rule)
