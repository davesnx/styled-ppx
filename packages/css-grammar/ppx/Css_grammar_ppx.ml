open Ppxlib

let extract_spec_string (expr : expression) : string option =
  match expr.pexp_desc with
  | Pexp_constant (Pconst_string (s, _, _)) -> Some s
  | _ -> None

let rec longident_to_string (lid : Longident.t) : string =
  match lid with
  | Lident s -> s
  | Ldot (prefix, s) -> longident_to_string prefix ^ "." ^ s
  | Lapply (_, _) -> failwith "Lapply not supported in module path"

let extract_module_path (expr : expression) : string option =
  match expr.pexp_desc with
  | Pexp_constraint ({ pexp_desc = Pexp_pack mod_expr; _ }, _) ->
    (match mod_expr.pmod_desc with
    | Pmod_ident { txt = lid; _ } -> Some (longident_to_string lid)
    | _ -> None)
  | Pexp_pack mod_expr ->
    (match mod_expr.pmod_desc with
    | Pmod_ident { txt = lid; _ } -> Some (longident_to_string lid)
    | _ -> None)
  | _ -> None

let module_path_expander ~loc ~path:_ (payload : payload) =
  let module Builder = Ast_builder.Make (struct
    let loc = loc
  end) in
  let open Builder in
  match payload with
  | PStr [ { pstr_desc = Pstr_eval (expr, _); _ } ] -> (
      match expr.pexp_desc with
      | Pexp_construct ({ txt = lid; _ }, None) ->
          let path_str = longident_to_string lid in
          let mod_expr = pmod_ident (Located.mk lid) in
          pexp_letmodule (Located.mk (Some "_Module_path_check"))
            mod_expr
            (estring path_str)
      | _ ->
          Location.raise_errorf ~loc
            "module_path expects a module constructor like Css_types.Length")
  | _ ->
      Location.raise_errorf ~loc
        "module_path expects a module constructor like Css_types.Length"

let module_path_extension =
  Extension.declare "module_path" Extension.Context.Expression
    Ast_pattern.(__)
    (fun ~loc ~path payload -> module_path_expander ~loc ~path payload)

let spec_expander ~loc ~path:_ (payload_expr : expression) =
  let module Builder = Ast_builder.Make (struct
    let loc = loc
  end) in
  let module Emit = Generate.Make (Builder) in
  let spec_string, runtime_path_opt =
    match payload_expr.pexp_desc with
    | Pexp_constant (Pconst_string (s, _, _)) -> s, None
    | Pexp_tuple [ spec_expr; witness_expr ] ->
      (match extract_spec_string spec_expr with
      | Some s ->
        let runtime_path = extract_module_path witness_expr in
        s, runtime_path
      | None ->
        Location.raise_errorf ~loc "first element must be a spec string literal")
    | _ ->
      Location.raise_errorf ~loc
        "spec expects a string or (string, module) tuple"
  in
  match Css_spec_parser.value_of_string spec_string with
  | Some parsed_spec ->
    Emit.generate_spec_record ~spec:parsed_spec
      ~runtime_module_path:runtime_path_opt
  | None -> Location.raise_errorf ~loc "couldn't parse CSS spec: %s" spec_string

let spec_extension =
  Extension.declare "spec" Extension.Context.Expression
    Ast_pattern.(pstr (pstr_eval __ nil ^:: nil))
    (fun ~loc ~path payload_expr -> spec_expander ~loc ~path payload_expr)

let rule_expander ~loc ~path:_ (spec_string : string) _ =
  let module Builder = Ast_builder.Make (struct
    let loc = loc
  end) in
  let module Emit = Generate.Make (Builder) in
  match Css_spec_parser.value_of_string spec_string with
  | Some parsed_spec -> Emit.generate_rule parsed_spec
  | None -> Location.raise_errorf ~loc "couldn't parse CSS spec: %s" spec_string

let rule_extension =
  Extension.declare "rule" Extension.Context.Expression
    Ast_pattern.(
      pstr (pstr_eval (pexp_constant (pconst_string __ __' none)) nil ^:: nil))
    (fun ~loc ~path spec_string _ -> rule_expander ~loc ~path spec_string ())

let spec_t_expander ~loc ~path:_ (spec_string : string) _ =
  let module Builder = Ast_builder.Make (struct
    let loc = loc
  end) in
  let module Emit = Generate.Make (Builder) in
  match Css_spec_parser.value_of_string spec_string with
  | Some parsed_spec -> Emit.generate_type parsed_spec
  | None -> Location.raise_errorf ~loc "couldn't parse CSS spec: %s" spec_string

let spec_t_extension =
  Extension.declare "spec_t" Extension.Context.Core_type
    Ast_pattern.(
      pstr (pstr_eval (pexp_constant (pconst_string __ __' none)) nil ^:: nil))
    (fun ~loc ~path spec_string _ -> spec_t_expander ~loc ~path spec_string ())

let spec_module_expander ~loc ~path:_ (payload_expr : expression) =
  let module Builder = Ast_builder.Make (struct
    let loc = loc
  end) in
  let module Emit = Generate.Make (Builder) in
  let spec_string, runtime_path_opt =
    match payload_expr.pexp_desc with
    | Pexp_constant (Pconst_string (s, _, _)) -> s, None
    | Pexp_tuple [ spec_expr; witness_expr ] ->
      (match extract_spec_string spec_expr with
      | Some s ->
        let runtime_path = extract_module_path witness_expr in
        s, runtime_path
      | None ->
        Location.raise_errorf ~loc "first element must be a spec string literal")
    | _ ->
      Location.raise_errorf ~loc
        "spec_module expects a string or (string, module) tuple"
  in
  match Css_spec_parser.value_of_string spec_string with
  | Some parsed_spec ->
    Emit.generate_module_structure ~spec:parsed_spec
      ~runtime_module_path:runtime_path_opt
  | None -> Location.raise_errorf ~loc "couldn't parse CSS spec: %s" spec_string

let spec_module_extension =
  Extension.declare "spec_module" Extension.Context.Module_expr
    Ast_pattern.(pstr (pstr_eval __ nil ^:: nil))
    (fun ~loc ~path payload_expr -> spec_module_expander ~loc ~path payload_expr)

let () =
  Driver.register_transformation
    ~extensions:
      [
        spec_extension;
        rule_extension;
        module_path_extension;
        spec_t_extension;
        spec_module_extension;
      ]
    "css-grammar-ppx"
