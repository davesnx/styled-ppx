open Types

let registry_tbl : (string, kind * packed_rule) Hashtbl.t = Hashtbl.create 1000

let lookup (name : string) : _ Rule.rule =
 fun tokens ->
  match Hashtbl.find_opt registry_tbl name with
  | Some (_, Pack_rule { rule; _ }) -> (Obj.magic rule : _ Rule.rule) tokens
  | None -> failwith ("Rule not found in registry: " ^ name)

let detect_whole_value_interpolation ~runtime_module_path input =
  let interp_rule =
    Rule.Match.map Css_value_types.interpolation (fun data -> data)
  in
  match Rule.run interp_rule input with
  | Ok parts ->
    let type_path = Option.value ~default:"" runtime_module_path in
    [ String.concat "." parts, type_path ]
  | Error _ -> []

let extract_from_registry_ast (type_name : string) (type_context : string)
  (ast_obj : Obj.t) : (string * string) list =
  match Hashtbl.find_opt registry_tbl type_name with
  | Some (_, Pack_rule { infer_interpolation_types_from_ast; _ }) ->
    infer_interpolation_types_from_ast type_context ast_obj
  | None -> []

let runtime_module_path_of_registry_key (key : string) : string option =
  match Hashtbl.find_opt registry_tbl key with
  | Some (_, Pack_rule { runtime_module_path; _ }) -> runtime_module_path
  | None -> None

let resolve_runtime_module_path (key : string) ~(fallback : string) : string =
  Option.value ~default:fallback (runtime_module_path_of_registry_key key)

let pack_rule (type a) (rule : a Rule.rule)
  ?(runtime_module_path : string option) () : packed_rule =
  let validate input =
    match Rule.run rule input with Ok _ -> Ok () | Error info -> Error info
  in
  let infer_interpolation_types =
    detect_whole_value_interpolation ~runtime_module_path
  in
  let infer_interpolation_types_from_ast (_type_context : string) (_obj : Obj.t)
    : (string * string) list =
    []
  in
  Pack_rule
    {
      rule;
      validate;
      runtime_module_path;
      infer_interpolation_types;
      infer_interpolation_types_from_ast;
    }

let pack_module (module M : RULE) : packed_rule =
  let validate input =
    match M.type_check input with Ok _ -> Ok () | Error info -> Error info
  in
  let infer_interpolation_types input =
    (* First: check for whole-value interpolation (e.g., "$(myWidth)").
       Use the property/module's runtime_module_path for the type.
       This ensures full-value interpolation returns the property type
       (e.g., Css_types.Width) rather than a sub-type (e.g., Css_types.Percentage). *)
    let whole =
      detect_whole_value_interpolation
        ~runtime_module_path:M.runtime_module_path input
    in
    if whole <> [] then whole
    else (
      (* Not a whole-value interpolation - parse and extract.
         Delegation to sub-types via registry handles partial interpolation. *)
      match M.type_check input with
      | Ok ast ->
        let result = M.infer_interpolation_types ast in
        if result <> [] then result else []
      | Error _ -> [])
  in
  let infer_interpolation_types_from_ast (type_context : string) (obj : Obj.t) :
    (string * string) list =
    M.infer_interpolation_types_with_context type_context (Obj.obj obj : M.t)
  in
  Pack_rule
    {
      rule = M.rule;
      validate;
      runtime_module_path = M.runtime_module_path;
      infer_interpolation_types;
      infer_interpolation_types_from_ast;
    }
