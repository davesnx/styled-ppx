(* Checks that registry-backed references in [%spec] and [%spec_module]
   payloads resolve.

   Usage: registry_closure_check <file.ml|file.re>... *)

(* Reuse the key derivation used by generated parser lookups. *)
module G = Generate.Make ((val Ppxlib.Ast_builder.make Ppxlib.Location.none))

(* Force [Registry] initialization before reading [registry_tbl]. *)
let () = assert (Css_grammar.registry <> [])
let errors = ref 0
let specs_checked = ref 0
let keys_checked = ref 0
let property_prefix = G.property_registry_prefix

let report fmt =
  Printf.ksprintf
    (fun message ->
      incr errors;
      prerr_endline message)
    fmt

let rec required_keys (spec : Css_spec_parser.value) : string list =
  match spec with
  | Terminal (kind, _) -> Option.to_list (G.registry_key_of_terminal kind)
  | Group (inner, _) -> required_keys inner
  | Combinator (_, values) -> List.concat_map required_keys values
  | Function_call (_, inner) -> required_keys inner

let spec_string_of_payload (payload : Ppxlib.payload) : string option =
  match payload with
  | PStr [ { pstr_desc = Pstr_eval (expr, _); _ } ] ->
    (match expr.pexp_desc with
    | Pexp_constant (Pconst_string (spec, _, _)) -> Some spec
    | Pexp_tuple
        ({ pexp_desc = Pexp_constant (Pconst_string (spec, _, _)); _ } :: _) ->
      Some spec
    | _ -> None)
  | _ -> None

let collect_specs (structure : Ppxlib.structure) ~path : (int * string) list =
  let specs = ref [] in
  let iterator =
    object
      inherit Ppxlib.Ast_traverse.iter as super

      method! extension ((name, payload) as extension) =
        (match name.txt with
        | "spec" | "spec_module" ->
          let line = name.loc.loc_start.pos_lnum in
          (match spec_string_of_payload payload with
          | Some spec -> specs := (line, spec) :: !specs
          | None ->
            (* Reject unsupported payload shapes instead of skipping them. *)
            report
              "%s:%d: unrecognized [%%%s] payload; extend \
               registry_closure_check"
              path line name.txt)
        | _ -> ());
        super#extension extension
    end
  in
  iterator#structure structure;
  List.rev !specs

let check_spec ~path (line, spec_string) =
  incr specs_checked;
  match Css_spec_parser.value_of_string spec_string with
  | None | (exception _) ->
    report "%s:%d: could not parse spec %S" path line spec_string
  | Some spec ->
    let display_reference key =
      if String.starts_with ~prefix:property_prefix key then (
        let n = String.length property_prefix in
        "<'" ^ String.sub key n (String.length key - n) ^ "'>")
      else "<" ^ key ^ ">"
    in
    required_keys spec
    |> List.iter (fun key ->
      incr keys_checked;
      if not (Hashtbl.mem Css_grammar.registry_tbl key) then
        report "%s:%d: %s does not resolve in the rule registry (spec %S)" path
          line (display_reference key) spec_string)

let contains_substring haystack needle =
  let n = String.length needle in
  let h = String.length haystack in
  let rec go i =
    i + n <= h && (String.sub haystack i n = needle || go (i + 1))
  in
  go 0

let check_ocaml_file path =
  let structure =
    In_channel.with_open_text path (fun ic ->
      let lexbuf = Lexing.from_channel ic in
      Lexing.set_filename lexbuf path;
      Ppxlib.Parse.implementation lexbuf)
  in
  List.iter (check_spec ~path) (collect_specs structure ~path)

(* Reject Reason sources containing [%spec]; this checker only parses OCaml. *)
let check_reason_file path =
  let contents = In_channel.with_open_text path In_channel.input_all in
  if contains_substring contents "[%spec" then
    report
      "%s: [%%spec] found in a Reason source; registry_closure_check only \
       parses OCaml sources. Move the spec to a .ml file or teach the check \
       Reason syntax."
      path

let check_file path =
  if Filename.check_suffix path ".ml" then check_ocaml_file path
  else if Filename.check_suffix path ".re" then check_reason_file path

let () =
  match Array.to_list Sys.argv with
  | _ :: (_ :: _ as files) ->
    List.iter check_file files;
    if !specs_checked = 0 then
      report
        "no [%%spec]/[%%spec_module] payloads found; the check would be \
         vacuous. Are the grammar sources being passed?";
    if !errors > 0 then (
      Printf.eprintf "registry closure check failed with %d error(s).\n" !errors;
      exit 1)
    else
      Printf.printf
        "registry closure: %d registry references from %d specs all resolve\n"
        !keys_checked !specs_checked
  | _ ->
    prerr_endline "usage: registry_closure_check <file.ml|file.re>...";
    exit 2
