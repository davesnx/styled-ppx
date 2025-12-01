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
(* Lowercases only the first character to preserve internal casing like RotateX *)
let module_name_to_type_name name =
  if String.length name = 0 then name
  else
    String.make 1 (Char.lowercase_ascii name.[0])
    ^ String.sub name 1 (String.length name - 1)

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

(* Convert module name to type name (lowercase first char) *)
let module_to_type_name module_name =
  if String.length module_name = 0 then module_name
  else
    String.make 1 (Char.lowercase_ascii module_name.[0])
    ^ String.sub module_name 1 (String.length module_name - 1)

(* Extract entries of a specific kind from Parser.ml content *)
(* Returns list of (css_name, type_name) pairs *)
let extract_entries_of_kind kind_name content =
  let entries = ref [] in
  let re =
    Str.regexp
      (kind_name ^ {| "\([^"]+\)",[^(]*(module \([A-Za-z0-9_]+\) : RULE)|})
  in
  let pos = ref 0 in
  (try
     while true do
       let _ = Str.search_forward re content !pos in
       let css_name = Str.matched_group 1 content in
       let module_name = Str.matched_group 2 content in
       let type_name = module_to_type_name module_name in
       entries := (css_name, type_name) :: !entries;
       pos := Str.match_end ()
     done
   with Not_found -> ());
  List.rev !entries

(* Deduplicate entries by type_name, keeping first occurrence *)
let deduplicate_by_type_name entries =
  let seen = Hashtbl.create 1000 in
  List.filter
    (fun (_css_name, type_name) ->
      if Hashtbl.mem seen type_name then false
      else begin
        Hashtbl.add seen type_name ();
        true
      end)
    entries

(* Extract registry entries from Parser.ml content for witness generation *)
(* Returns list of (css_name, type_name) pairs *)
let extract_registry_entries content =
  List.concat
    [
      extract_entries_of_kind "Property" content;
      extract_entries_of_kind "Value" content;
      extract_entries_of_kind "Function" content;
      extract_entries_of_kind "Media_query" content;
    ]
  |> deduplicate_by_type_name

(* Generate witness GADT and helper functions as raw OCaml code *)
let generate_witness_code (registry_entries : (string * string) list) : string =
  if registry_entries = [] then begin
    Printf.eprintf
      "Warning: no registry entries found, skipping witness code generation\n";
    "\n(* No registry entries found - witness code not generated *)\n"
  end
  else begin
    let buf = Buffer.create 10000 in

    (* Type equality proof *)
    Buffer.add_string buf "\n(** Type equality proof - used for safe casting *)\n";
    Buffer.add_string buf "type (_, _) eq = Refl : ('a, 'a) eq\n\n";

    (* GADT witness type *)
    Buffer.add_string buf
      "(** GADT witness type - connects CSS names to OCaml types *)\n";
    Buffer.add_string buf "type _ witness =\n";
    List.iter
      (fun (_css_name, type_name) ->
        let witness_name = "W_" ^ type_name in
        Buffer.add_string buf
          (Printf.sprintf "  | %s : %s witness\n"
             (String.capitalize_ascii witness_name)
             type_name))
      registry_entries;

    (* Helper to generate registry key - properties are prefixed to avoid collisions *)
    let registry_key css_name type_name =
      if String.length type_name > 9 && String.sub type_name 0 9 = "property_" then
        "property_" ^ css_name
      else
        css_name
    in

    (* witness_to_name function *)
    Buffer.add_string buf
      "\n(** Convert witness to registry key for lookup.\n\
      \    Properties are prefixed with 'property_' to avoid collisions with values. *)\n";
    Buffer.add_string buf
      "let witness_to_name : type a. a witness -> string = function\n";
    List.iter
      (fun (css_name, type_name) ->
        let witness_name = "W_" ^ type_name in
        let key = registry_key css_name type_name in
        Buffer.add_string buf
          (Printf.sprintf "  | %s -> %S\n"
             (String.capitalize_ascii witness_name)
             key))
      registry_entries;

    (* witness_eq function - O(1) using physical equality *)
    Buffer.add_string buf
      "\n(** Compare witnesses for type equality.\n\
      \    Uses physical equality for O(1) performance instead of O(n) pattern matching.\n\
      \    This is safe because GADT constructors have unique runtime representations. *)\n";
    Buffer.add_string buf
      "let witness_eq : type a b. a witness -> b witness -> (a, b) eq option =\n\
      \  fun a b ->\n\
      \    if Obj.repr a == Obj.repr b then\n\
      \      Some (Obj.magic Refl : (a, b) eq)\n\
      \    else\n\
      \      None\n";

    (* Packed witness type for heterogeneous storage *)
    Buffer.add_string buf
      "\n(** Packed witness for heterogeneous storage - hides the type parameter *)\n";
    Buffer.add_string buf "type packed_witness = Pack : 'a witness -> packed_witness\n";

    (* name_to_packed_witness function *)
    Buffer.add_string buf
      "\n(** Convert registry key to packed witness.\n\
      \    Properties use 'property_' prefix to match witness_to_name. *)\n";
    Buffer.add_string buf
      "let name_to_packed_witness : string -> packed_witness option = function\n";
    List.iter
      (fun (css_name, type_name) ->
        let w = String.capitalize_ascii ("W_" ^ type_name) in
        let key = registry_key css_name type_name in
        Buffer.add_string buf
          (Printf.sprintf "  | %S -> Some (Pack %s)\n" key w))
      registry_entries;
    Buffer.add_string buf "  | _ -> None\n";

    (* Compile-time verification function *)
    Buffer.add_string buf
      "\n(** Compile-time verification that all witnesses have correct types.\n\
      \    This function is never called at runtime, but if any witness doesn't\n\
      \    match its declared type, this will fail to compile. *)\n";
    Buffer.add_string buf "let _verify_witnesses () =\n";
    List.iter
      (fun (_css_name, type_name) ->
        let w = String.capitalize_ascii ("W_" ^ type_name) in
        Buffer.add_string buf
          (Printf.sprintf "  let _ = (%s : %s witness) in\n" w type_name))
      registry_entries;
    Buffer.add_string buf "  ()\n";

    Buffer.contents buf
  end

(* Parse arguments *)
let parse_args args =
  let rec parse input_file output_file verbose = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse input_file (Some file) verbose rest
    | "-v" :: rest | "-verbose" :: rest | "--verbose" :: rest ->
      parse input_file output_file true rest
    | arg :: rest ->
      (match input_file with
      | Some existing ->
        Printf.eprintf
          "Warning: multiple input files provided. Using '%s', ignoring '%s'\n"
          arg existing
      | None -> ());
      parse (Some arg) output_file verbose rest
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

  (* Generate the 'all' type - combines ALL types (standalone + spec_module) *)
  let all_type_names = standalone_type_names @ type_names in
  let all_type = generate_all_type ~loc all_type_names in

  (* Combine: standalone types first, then spec_module types, then 'all' type *)
  let all_type_decls = standalone_types @ type_decls @ [ all_type ] in

  (* Create the structure with recursive type declarations *)
  let type_structure = Ast_helper.Str.type_ ~loc Recursive all_type_decls in

  (* Generate the output *)
  let output_structure = [ type_structure ] in

  (* Extract registry entries for witness generation *)
  let registry_entries = extract_registry_entries content in
  if verbose then
    Printf.eprintf "Found %d registry entries for witness generation\n"
      (List.length registry_entries);

  (* Generate witness code *)
  let witness_code = generate_witness_code registry_entries in

  (* Format and write output *)
  let write_output out_channel =
    Printf.fprintf out_channel
      "(** Types.ml - Auto-generated CSS type definitions and GADT witnesses\n\
      \n\
      \    DO NOT EDIT MANUALLY - Generated by generate_types from Parser.ml\n\
      \n\
      \    This module contains:\n\
      \    - Type definitions for all CSS values (generated from spec_module definitions)\n\
      \    - GADT witness type connecting CSS names to OCaml types\n\
      \    - witness_to_name: Convert witness to registry key for lookups\n\
      \    - witness_eq: O(1) witness equality check using physical comparison\n\
      \    - name_to_packed_witness: Convert registry key to packed witness\n\
      \n\
      \    The witness system enables type-safe lookups in the CSS rule registry.\n\
      \    Each CSS property/value type has a corresponding witness constructor\n\
      \    (e.g., Types.W_property_color for property_color type).\n\
      \n\
      \    Usage in Parser.ml:\n\
      \      let lookup : type a. a Types.witness -> a Rule.rule\n\
      \      lookup Types.W_property_color  (* Returns property_color Rule.rule *)\n\
      \ *)\n\n";
    Pprintast.structure Format.str_formatter output_structure;
    let formatted = Format.flush_str_formatter () in
    output_string out_channel formatted;
    output_string out_channel "\n";
    (* Append witness GADT and helpers *)
    output_string out_channel witness_code;
    output_string out_channel "\n"
  in

  match output_file with
  | Some file ->
    let out_channel = open_out file in
    Fun.protect
      ~finally:(fun () -> close_out out_channel)
      (fun () ->
        write_output out_channel;
        if verbose then Printf.eprintf "Output written successfully\n")
  | None -> write_output Stdlib.stdout
