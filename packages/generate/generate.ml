(** styled-ppx aggregator: walk every post-PPX [.ml] file in a dune library,
    collect [[\@\@\@css ...]] CSS rules and any cross-module references embedded
    as NUL-delimited sentinels, resolve those sentinels against a global index
    of [%css] bindings, and emit the final stylesheet.

    The aggregator runs once per `dune build` invocation, after the PPX has
    produced the post-PPX [.ml] files for every module in the library.

    Two-pass design:

    Pass 1 — Collect every [[\@\@\@css.bindings ...]] attribute payload into a
    global index mapping [longident -> class_string]. The PPX itself populates
    these payloads with the fully-qualified longident ([["M.Css.marker"]]) and
    the space-separated class names it minted, so the aggregator only has to
    read them — it does not re-derive module names from filenames or
    pattern-match [CSS.make] calls.

    Pass 2 — For each rule string in [[\@\@\@css ...]], scan for NUL-delimited
    sentinels [\x00LONGIDENT\x00]. Look the longident up in the index and
    substitute its class chain (multi-class bindings produce a dot-chain like
    [cssA.cssB], a valid CSS compound selector). Resolution failures emit a hard
    error pointing at the original [.re]/[.ml] source via the location
    descriptors in [[\@\@\@css.refs ...]] attributes.

    See [documents/cross-module-selector-interpolation.md]. *)

(** Root module segment of a dotted longident. [["M.Css.marker"]] -> [["M"]];
    [["foo"]] -> [["foo"]]. *)
let longident_head longident =
  match String.split_on_char '.' longident with
  | head :: _ -> head
  | [] -> longident

(** Global index of [%css] bindings, populated from [[\@\@\@css.bindings ...]]
    attribute payloads. Keyed by the dotted longident exactly as users write it
    in their [%css] selector refs (e.g. [["M.Css.marker"]]) so resolution is a
    direct [Hashtbl.find_opt]. *)
module Index = struct
  type t = (string, string) Hashtbl.t

  let create () : t = Hashtbl.create 64

  let add_from_payload (idx : t) payload =
    match Css_extraction.decode_bindings_payload payload with
    | Error msg -> Error msg
    | Ok entries ->
      List.iter
        (fun (entry : Css_extraction.binding) ->
          Hashtbl.replace idx entry.longident entry.class_string)
        entries;
      Ok ()
end

(** Every
    [[\@\@\@css.refs [(longident, file, start_line, start_col, end_col); ...]]]
    attribute decoded into a list of records. The aggregator uses these
    locations when reporting unresolvable refs. *)
module Refs = struct
  type ref_loc = Css_extraction.ref_loc

  let of_list_expr = Css_extraction.decode_refs_payload
end

(** Per-file harvest: rules with potential sentinels, plus all cross-module ref
    descriptors seen in this file. The bindings attribute is consumed directly
    into the global [Index] during the same walk. *)
type harvest = {
  filename : string;
  rules : string list;
  refs : Refs.ref_loc list;
  protocol_errors : string list;
}

let harvest_structure ~filename ~idx structure : harvest =
  let rules = ref [] in
  let refs = ref [] in
  let protocol_errors = ref [] in
  let add_protocol_error attribute msg =
    protocol_errors :=
      Printf.sprintf "%s: malformed [@@@%s]: %s" filename attribute msg
      :: !protocol_errors
  in
  List.iter
    (fun item ->
      match item with
      | [%stri [@@@css [%e? value]]] ->
        (match Css_extraction.decode_css_payload value with
        | Ok v -> rules := v :: !rules
        | Error msg -> add_protocol_error Css_extraction.css_attribute_name msg)
      | [%stri [@@@css.refs [%e? value]]] ->
        (match Refs.of_list_expr value with
        | Ok entries -> refs := entries @ !refs
        | Error msg -> add_protocol_error Css_extraction.refs_attribute_name msg)
      | [%stri [@@@css.bindings [%e? value]]] ->
        (match Index.add_from_payload idx value with
        | Ok () -> ()
        | Error msg ->
          add_protocol_error Css_extraction.bindings_attribute_name msg)
      | _ -> ())
    structure;
  {
    filename;
    rules = List.rev !rules;
    refs = List.rev !refs;
    protocol_errors = List.rev !protocol_errors;
  }

(** Read a post-PPX [.ml] file or its serialized [.pp.ml] AST into a ppxlib
    structure. File-read and parse errors are surfaced unconditionally (not
    gated on [~verbose]) so a mistyped path produces a clear aggregator-level
    diagnostic instead of silent empty output. *)
let read_structure filename : Ppxlib.structure option =
  try
    if String.ends_with filename ~suffix:".pp.ml" then (
      match Ppxlib.Ast_io.read_binary filename with
      | Error msg ->
        Printf.eprintf "styled-ppx aggregator: cannot read %s: %s\n" filename
          msg;
        None
      | Ok t ->
        (match Ppxlib.Ast_io.get_ast t with Impl s -> Some s | Intf _ -> None))
    else if String.ends_with filename ~suffix:".ml" then (
      let ic = open_in filename in
      let len = in_channel_length ic in
      let content = really_input_string ic len in
      close_in ic;
      let lexbuf = Lexing.from_string content in
      lexbuf.lex_curr_p <- { lexbuf.lex_curr_p with pos_fname = filename };
      Some (Ppxlib.Parse.implementation lexbuf))
    else failwith ("Expected .ml or .pp.ml file, got: " ^ filename)
  with
  | Sys_error msg ->
    Printf.eprintf "styled-ppx aggregator: cannot read %s: %s\n" filename msg;
    None
  | exn ->
    Printf.eprintf "styled-ppx aggregator: cannot parse %s: %s\n" filename
      (Printexc.to_string exn);
    None

(** Format an aggregator error in the OCaml [File "..."] convention so editors
    pick it up the same way they pick up compiler errors. *)
let format_location (r : Refs.ref_loc) : string =
  Printf.sprintf "File %S, line %d, characters %d-%d:" r.file r.start_line
    r.start_col r.end_col

(** Derive the module name from a file path the way dune/OCaml does: take the
    basename, strip the [.ml] / [.re] / [.pp.ml] extension, and capitalize the
    first letter. This matches how a user writes [M.foo] when the source file is
    [m.re]. *)
let module_of_filename filename =
  let base = Filename.basename filename in
  let stem =
    if String.ends_with base ~suffix:".pp.ml" then
      String.sub base 0 (String.length base - String.length ".pp.ml")
    else Filename.remove_extension base
  in
  if stem = "" then stem else String.capitalize_ascii stem

(** Detect cross-library references: a longident whose root module is NOT one of
    the input files passed to the aggregator. The aggregator only sees files
    from the current library invocation, so any longident whose root segment
    doesn't correspond to one of those files must point outside the library.
    Note: we check the input file set rather than [idx] (the [%css] binding
    index), because a file may be in-library yet contain no [%css] bindings at
    all (and therefore contribute nothing to [idx]). Conflating those two cases
    would produce a misleading "not part of the current library" error for a
    reference whose target module IS in the library, just not as a [%css]. *)
let is_cross_library ~in_library_modules longident =
  match String.split_on_char '.' longident with
  | [] | [ _ ] -> false (* No dot — single-segment, can't be cross-anything. *)
  | _ ->
    let head = longident_head longident in
    not (List.mem head in_library_modules)

let cross_library_message ~longident ~head ~ref_loc =
  Printf.sprintf
    "%s\n\
     Error: cross-library [%%css] selector references are not supported.\n\
     The reference `%s` resolves to module `%s` which is not part of the\n\
     current library. Move the [%%css] binding into the current library, or\n\
     inline the class chain literally."
    (format_location ref_loc) longident head

let unresolved_message ~longident ~ref_loc ~in_library_modules =
  let head = longident_head longident in
  if is_cross_library ~in_library_modules longident then
    cross_library_message ~longident ~head ~ref_loc
  else
    Printf.sprintf
      "%s\n\
       Error: cross-module [%%css] selector reference `%s` does not resolve.\n\
       The target binding is missing from module `%s`, or the binding is not\n\
       a [%%css] expression. Define `%s` with [%%css \"...\"], or remove the\n\
       reference."
      (format_location ref_loc) longident head longident

(** Collect, index, resolve, dedup, output. *)
let run ~verbose ~minify ~output_file input_files =
  if verbose then Printf.eprintf "Input files: %d\n" (List.length input_files);
  let idx = Index.create () in
  let in_library_modules = List.map module_of_filename input_files in
  let harvests =
    List.filter_map
      (fun filename ->
        if String.ends_with filename ~suffix:".css" then
          failwith "Extracting from .css files is not supported yet";
        match read_structure filename with
        | None -> None
        | Some structure -> Some (harvest_structure ~filename ~idx structure))
      input_files
  in

  (* Resolve all rules across all harvests, collecting errors with locations. *)
  let errors =
    ref (List.concat_map (fun harvest -> harvest.protocol_errors) harvests)
  in
  let resolved_rules = ref [] in
  List.iter
    (fun harvest ->
      List.iter
        (fun rule ->
          let on_error longident =
            let ref_loc =
              match
                List.find_opt
                  (fun (r : Refs.ref_loc) -> r.longident = longident)
                  harvest.refs
              with
              | Some r -> r
              | None ->
                Css_extraction.ref_loc ~longident ~file:harvest.filename
                  ~start_line:1 ~start_col:0 ~end_col:0
            in
            let msg =
              unresolved_message ~longident ~ref_loc ~in_library_modules
            in
            errors := msg :: !errors
          in
          let on_malformed msg =
            errors :=
              Printf.sprintf "%s: malformed [@@@%s]: %s" harvest.filename
                Css_extraction.css_attribute_name msg
              :: !errors
          in
          let resolved =
            Css_extraction.resolve_sentinels ~lookup:(Hashtbl.find_opt idx)
              ~on_unresolved:on_error ~on_malformed rule
          in
          resolved_rules := resolved :: !resolved_rules)
        harvest.rules)
    harvests;

  (match !errors with
  | [] -> ()
  | _ ->
    List.iter prerr_endline (List.rev !errors);
    exit 1);

  (* Dedup the resolved CSS rules while preserving source order.

     Source order matters because every atomized rule shares the same
     specificity (one class, no qualifiers). The cascade tiebreaker is
     "later in stylesheet wins", so a longhand override written after a
     shorthand (`margin: 10px; margin-top: 20px`) must appear *after* the
     shorthand in the emitted stylesheet to survive. Earlier versions
     deduped through `Set.Make(String)`, which sorted by murmur2-prefixed
     rule text and silently destroyed declaration order.

     [resolved_rules] is in reverse traversal order (rules pushed via
     `r :: !resolved_rules`); reverse once to walk forward, then keep
     the first forward occurrence of each rule string. Keeping the
     first forward occurrence (rather than the last) places shared
     rules at the position dune first encounters them, which makes the
     output stable regardless of which file's later occurrence is
     deduped. *)
  let ordered_rules =
    let seen = Hashtbl.create 64 in
    List.rev !resolved_rules
    |> List.filter (fun rule ->
      if Hashtbl.mem seen rule then false
      else begin
        Hashtbl.add seen rule ();
        true
      end)
  in

  let out_channel =
    match output_file with Some file -> open_out file | None -> Stdlib.stdout
  in
  let separator = if minify then "" else "\n" in
  output_string out_channel
    "/* This file is generated by styled-ppx, do not edit manually */\n";
  List.iter
    (fun rule ->
      output_string out_channel rule;
      output_string out_channel separator)
    ordered_rules;
  match output_file with Some _ -> close_out out_channel | None -> ()

let parse_args args =
  let rec parse acc ~output_file ~verbose ~minify = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse acc ~output_file:(Some file) ~verbose ~minify rest
    | "-v" :: rest | "-verbose" :: rest | "--verbose" :: rest ->
      parse acc ~output_file ~verbose:true ~minify rest
    | "--minify" :: rest -> parse acc ~output_file ~verbose ~minify:true rest
    | arg :: rest -> parse (arg :: acc) ~output_file ~verbose ~minify rest
    | [] -> List.rev acc, output_file, verbose, minify
  in
  let tail = match Array.to_list args with [] -> [] | _ :: t -> t in
  parse [] ~output_file:None ~verbose:false ~minify:false tail

let () =
  let input_files, output_file, verbose, minify = parse_args Sys.argv in
  run ~verbose ~minify ~output_file input_files
