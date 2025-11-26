open Ppxlib

(* Extract standalone type definitions from the structure *)
(* These are the concrete types defined at the top of Parser.ml (length, angle, etc.) *)
let extract_standalone_types (structure : structure) :
  Parsetree.type_declaration list =
  let rec extract_from_items acc = function
    | [] -> List.rev acc
    | item :: rest ->
      (match item.pstr_desc with
      (* Extract type definitions *)
      | Pstr_type (_, type_decls) ->
        (* Only include types that are NOT 'kind' (internal helper) *)
        let filtered =
          List.filter (fun td -> td.ptype_name.txt <> "kind") type_decls
        in
        extract_from_items (filtered @ acc) rest
      (* Stop when we hit a module (spec_module definitions start) *)
      | Pstr_module _ -> List.rev acc
      | _ -> extract_from_items acc rest)
  in
  extract_from_items [] structure

(* Extract type_name and spec_string from a module expression that uses [%spec_module ...] *)
(* Returns (type_name, spec_string) *)
let extract_spec_info (mod_expr : module_expr) : (string * string) option =
  match mod_expr.pmod_desc with
  | Pmod_extension ({ txt = "spec_module"; _ }, payload) ->
    (match payload with
    | PStr [ { pstr_desc = Pstr_eval (expr, _); _ } ] ->
      (match expr.pexp_desc with
      (* Form 1: [%spec_module "spec_string"] - derive type name from module name (handled below) *)
      | Pexp_constant (Pconst_string (s, _, _)) -> Some ("", s)
      (* Form 2+: Tuple forms *)
      | Pexp_tuple elements ->
        (match elements with
        (* Form 2: [%spec_module "type_name", "spec_string"] *)
        | [
         { pexp_desc = Pexp_constant (Pconst_string (type_name, _, _)); _ };
         { pexp_desc = Pexp_constant (Pconst_string (spec, _, _)); _ };
        ] ->
          Some (type_name, spec)
        (* Form 3: [%spec_module "type_name", "spec_string", ...] (with witness) *)
        | { pexp_desc = Pexp_constant (Pconst_string (type_name, _, _)); _ }
          :: { pexp_desc = Pexp_constant (Pconst_string (spec, _, _)); _ }
          :: _ ->
          Some (type_name, spec)
        (* Form 4: [%spec_module "spec_string", (module ...)] - old format with witness *)
        | [ { pexp_desc = Pexp_constant (Pconst_string (spec, _, _)); _ }; _ ]
          ->
          Some ("", spec)
        | _ -> None)
      | _ -> None)
    | _ -> None)
  | _ -> None

(* Convert module name to type name (e.g., Property_display -> property_display) *)
let module_name_to_type_name name = String.lowercase_ascii name

(* Extract all spec_module definitions from a structure *)
(* Returns list of (type_name, spec_string) *)
let extract_spec_modules (structure : structure) : (string * string) list =
  List.filter_map
    (fun item ->
      match item.pstr_desc with
      | Pstr_module { pmb_name = { txt = Some module_name; _ }; pmb_expr; _ } ->
        (match extract_spec_info pmb_expr with
        | Some (type_name, spec) ->
          (* If type_name is empty, derive from module name *)
          let final_type_name =
            if type_name = "" then module_name_to_type_name module_name
            else type_name
          in
          Some (final_type_name, spec)
        | None -> None)
      | _ -> None)
    structure

(* Generate type declaration from spec *)
(* Input: (type_name, spec_string) *)
let generate_type_decl ~loc (type_name, spec_string) :
  (Parsetree.type_declaration * string) option =
  match Css_spec_parser.value_of_string spec_string with
  | Some parsed_spec ->
    let module Ast_builder = Ast_builder.Make (struct
      let loc = loc
    end) in
    let module Emit = Generate.Make (Ast_builder) in
    let core_type = Emit.create_type_parser parsed_spec in
    let type_decl =
      Ast_helper.Type.mk ~loc ~kind:Ptype_abstract ~manifest:core_type
        { txt = type_name; loc }
    in
    Some (type_decl, type_name)
  | None ->
    Printf.eprintf "Warning: couldn't parse spec for %s: %s\n" type_name
      spec_string;
    None

(* Generate the 'all' variant type that combines all types *)
let generate_all_type ~loc (type_names : string list) :
  Parsetree.type_declaration =
  let module Ast_builder = Ast_builder.Make (struct
    let loc = loc
  end) in
  let open Ast_builder in
  let variant_rows =
    List.map
      (fun type_name ->
        let variant_name =
          String.capitalize_ascii type_name
          |> String.split_on_char '_'
          |> List.map String.capitalize_ascii
          |> String.concat "_"
        in
        let type_ref = ptyp_constr { txt = Lident type_name; loc } [] in
        rtag { txt = variant_name; loc } false [ type_ref ])
      type_names
  in
  let all_type = ptyp_variant variant_rows Closed None in
  Ast_helper.Type.mk ~loc ~kind:Ptype_abstract ~manifest:all_type
    { txt = "all"; loc }

(* Parse arguments *)
let parse_args args =
  let rec parse input_file output_file verbose = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse input_file (Some file) verbose rest
    | "-v" :: rest | "-verbose" :: rest | "--verbose" :: rest ->
      parse input_file output_file true rest
    | arg :: rest -> parse (Some arg) output_file verbose rest
    | [] -> input_file, output_file, verbose
  in
  parse None None false (Array.to_list args |> List.tl)

(* Main *)
let () =
  let input_file, output_file, verbose = parse_args Sys.argv in

  let input_file =
    match input_file with
    | Some f -> f
    | None ->
      Printf.eprintf "Usage: generate_types <input.ml> [-o output.ml]\n";
      exit 1
  in

  if verbose then Printf.eprintf "Processing %s...\n" input_file;

  (* Parse the input file *)
  let ic = open_in input_file in
  let len = in_channel_length ic in
  let content = really_input_string ic len in
  close_in ic;

  let lexbuf = Lexing.from_string content in
  lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = input_file };
  let structure = Parse.implementation lexbuf in

  (* Extract standalone types (length, angle, etc.) *)
  let standalone_types = extract_standalone_types structure in
  if verbose then
    Printf.eprintf "Found %d standalone type definitions\n"
      (List.length standalone_types);

  (* Extract spec_modules *)
  let spec_modules = extract_spec_modules structure in
  if verbose then
    Printf.eprintf "Found %d spec_module definitions\n"
      (List.length spec_modules);

  (* Get names of standalone types *)
  let standalone_type_names =
    List.map (fun td -> td.ptype_name.txt) standalone_types
  in

  (* Filter spec_modules to exclude those that have manually-defined standalone types.
     The standalone types are preferred because they have proper recursive references
     instead of Obj.t for cross-module type erasure. *)
  let filtered_spec_modules =
    List.filter
      (fun (type_name, _) -> not (List.mem type_name standalone_type_names))
      spec_modules
  in
  if verbose then
    Printf.eprintf "Keeping %d spec_modules after filtering duplicates\n"
      (List.length filtered_spec_modules);

  (* Generate type declarations from filtered spec_modules *)
  let loc = Location.none in
  let type_decls_with_names =
    List.filter_map (generate_type_decl ~loc) filtered_spec_modules
  in
  let type_decls = List.map fst type_decls_with_names in
  let type_names = List.map snd type_decls_with_names in

  if verbose then
    Printf.eprintf "Generated %d type declarations\n" (List.length type_decls);

  (* Generate the 'all' type *)
  let all_type = generate_all_type ~loc type_names in

  (* Combine: standalone types first, then spec_module types, then 'all' type *)
  let all_type_decls = standalone_types @ type_decls @ [ all_type ] in

  (* Create the structure with recursive type declarations *)
  let type_structure = Ast_helper.Str.type_ ~loc Recursive all_type_decls in

  (* Generate the output *)
  let output_structure = [ type_structure ] in

  (* Format and write output *)
  let out_channel =
    match output_file with Some file -> open_out file | None -> Stdlib.stdout
  in

  Printf.fprintf out_channel
    "(* Auto-generated by generate_types - do not edit *)\n\n";
  Pprintast.structure Format.str_formatter output_structure;
  let formatted = Format.flush_str_formatter () in
  output_string out_channel formatted;
  output_string out_channel "\n";

  match output_file with
  | Some _ ->
    close_out out_channel;
    if verbose then Printf.eprintf "Output written successfully\n"
  | None -> ()
