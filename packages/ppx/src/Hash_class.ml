let hash = Murmur2.default
let nul_join parts = String.concat "\000" parts
let module_prefix_width = 4
let min_suffix_width = 3
let max_suffix_width = 6

let block_key ~module_name ~scope ~binding content =
  nul_join [ module_name; String.concat "." scope; binding; content ]

let marker_key ~module_name ~scope name =
  block_key ~module_name ~scope ~binding:name "\000marker"

let block_hash ~width ~module_name key =
  Murmur2.base36 ~width:module_prefix_width (Murmur2.murmur2 module_name)
  ^ Murmur2.base36 ~width (Murmur2.murmur2 key)

let variable_key ~module_name ~interpolation_seed ~type_key ~occurrence ~total
  path =
  nul_join
    [
      module_name;
      interpolation_seed;
      path;
      type_key;
      (if total > 1 then string_of_int occurrence else "");
    ]

let interpolation_name_prefix path =
  let path =
    let rec drop = function
      | [ last ] -> [ last ]
      | seg :: rest
        when String.length seg > 0 && seg.[0] >= 'A' && seg.[0] <= 'Z' ->
        drop rest
      | segs -> segs
    in
    String.concat "." (drop (String.split_on_char '.' path))
  in
  let buf = Buffer.create (String.length path) in
  let pending_dash = ref false in
  String.iter
    (fun c ->
      let ident =
        (c >= 'a' && c <= 'z')
        || (c >= 'A' && c <= 'Z')
        || (c >= '0' && c <= '9')
        || c = '_'
      in
      if ident then (
        if !pending_dash && Buffer.length buf > 0 then Buffer.add_char buf '-';
        pending_dash := false;
        Buffer.add_char buf c)
      else pending_dash := true)
    path;
  let s = Buffer.contents buf in
  let s = if String.length s > 40 then String.sub s 0 40 else s in
  if s = "" then "var" else s

let variable ~namespace ~type_key path =
  Printf.sprintf "%s-%s"
    (interpolation_name_prefix path)
    (hash (nul_join [ namespace; path; type_key ]))

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
