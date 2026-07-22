(** styled-ppx generator: walk every post-PPX [.ml] file in a dune library,
    collect [[\@\@\@css ...]] CSS rules and any cross-module references embedded
    as NUL-delimited sentinels, resolve those sentinels against a global index
    of [%css] bindings, and emit the final stylesheet.

    The generator runs once per `dune build` invocation, after the PPX has
    produced the post-PPX [.ml] files for every module in the library.

    Two-pass design:

    Pass 1. Collect every [[\@\@\@css.bindings ...]] attribute payload into a
    global index mapping [longident -> class_string]. The PPX itself populates
    these payloads with the fully-qualified longident ([["M.Css.marker"]]) and
    the space-separated class names it minted, so the generator only has to read
    them. It does not re-derive module names from filenames or pattern-match
    [CSS.make] calls.

    Pass 2. For each rule string in [[\@\@\@css ...]], scan for NUL-delimited
    sentinels [\x00LONGIDENT\x00]. Look the longident up in the index and
    substitute its class chain (multi-class bindings produce a dot-chain like
    [cssA.cssB], a valid CSS compound selector). Resolution failures emit a hard
    error pointing at the original [.re]/[.ml] source via the location
    descriptors in [[\@\@\@css.refs ...]] attributes.

    See [documents/cross-module-selector-interpolation.md]. *)

(** All generator diagnostics go through this module. Every message is written
    to stderr prefixed with ["styled-ppx:"] and gated on the current log level:

    - [Error] ([--log error]): resolution/protocol/IO errors only.
    - [Warning] (default): same as [Error] plus warnings (e.g. input files
      disagreeing on their [[@@@css.config]] environment).
    - [Info] ([--log info]): additionally prints the output file.
    - [Debug] ([--debug] or [--log debug]): additionally prints the whole
      generated stylesheet. *)
module Logger = struct
  type level =
    | Error
    | Warning
    | Info
    | Debug

  let severity = function Error -> 0 | Warning -> 1 | Info -> 2 | Debug -> 3
  let current_level = ref Warning
  let set_level level = current_level := level

  let level_of_string = function
    | "error" -> Some Error
    | "warning" | "warn" -> Some Warning
    | "info" -> Some Info
    | "debug" -> Some Debug
    | _ -> None

  let log level fmt =
    Printf.ksprintf
      (fun message ->
        if severity level <= severity !current_level then
          Printf.eprintf "styled-ppx: %s\n%!" message)
      fmt

  let error fmt = log Error fmt
  let warning fmt = log Warning fmt
  let info fmt = log Info fmt
  let debug fmt = log Debug fmt
end

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
    attribute decoded into a list of records. The generator uses these locations
    when reporting unresolvable refs. *)
module Refs = struct
  type ref_loc = Css_extraction.ref_loc

  let of_list_expr = Css_extraction.decode_refs_payload
end

(** Per-file harvest: rules with potential sentinels, all cross-module ref
    descriptors seen in this file, and the file's declared environment from
    [[@@@css.config]] ([None] when absent, i.e. development). The bindings
    attribute is consumed directly into the global [Index] during the same walk.
*)
type harvest = {
  filename : string;
  rules : string list;
  refs : Refs.ref_loc list;
  env : string option;
  protocol_errors : string list;
}

let harvest_structure ~filename ~idx structure : harvest =
  let rules = ref [] in
  let refs = ref [] in
  let env = ref None in
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
      | [%stri [@@@css.config [%e? value]]] ->
        (match Css_extraction.decode_config_payload value with
        | Ok entries ->
          (match List.assoc_opt Css_extraction.config_env_key entries with
          | Some _ as declared -> env := declared
          | None -> ())
        | Error msg ->
          add_protocol_error Css_extraction.config_attribute_name msg)
      | _ -> ())
    structure;
  {
    filename;
    rules = List.rev !rules;
    refs = List.rev !refs;
    env = !env;
    protocol_errors = List.rev !protocol_errors;
  }

(** Read a post-PPX [.ml] file or its serialized [.pp.ml] AST into a ppxlib
    structure. File-read and parse errors are surfaced at [Error] level (always
    printed) so a mistyped path produces a clear generator-level diagnostic
    instead of silent empty output. *)
let read_structure filename : Ppxlib.structure option =
  try
    if String.ends_with filename ~suffix:".pp.ml" then (
      match Ppxlib.Ast_io.read_binary filename with
      | Error msg ->
        Logger.error "cannot read %s: %s" filename msg;
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
    Logger.error "cannot read %s: %s" filename msg;
    None
  | exn ->
    Logger.error "cannot parse %s: %s" filename (Printexc.to_string exn);
    None

(** Format a generator error in the OCaml [File "..."] convention (prefixed with
    ["styled-ppx:"] by {!Logger} when printed) so the original source location
    is easy to locate. *)
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
    the input files passed to the generator. The generator only sees files from
    the current library invocation, so any longident whose root segment doesn't
    correspond to one of those files must point outside the library. Note: we
    check the input file set rather than [idx] (the [%css] binding index),
    because a file may be in-library yet contain no [%css] bindings at all (and
    therefore contribute nothing to [idx]). Conflating those two cases would
    produce a misleading "not part of the current library" error for a reference
    whose target module IS in the library, just not as a [%css]. *)
let is_cross_library ~in_library_modules longident =
  match String.split_on_char '.' longident with
  | [] | [ _ ] -> false (* No dot: single-segment, can't be cross-anything. *)
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

(** Statement at-rule ordering (issue #581).

    [%styled.global] passes statement at-rules ([@charset], [@import],
    [@namespace], statement-form [@layer]) through to the aggregator, but
    browsers only honor them at the top of a stylesheet: [@import] must precede
    [@namespace], and both must precede every other kind of rule. Since the
    aggregator concatenates rules in file order, an [@import] contributed by a
    "late" module would otherwise land mid-stylesheet, where browsers silently
    ignore it.

    Classification is string-based rather than parser-based, deliberately: the
    rule strings the aggregator receives are renderer output
    ([packages/parser/lib/Render.re]): canonical, minified, deterministic. An
    at-rule renders as [@name] or [@name <prelude>] followed by [;] (statement
    form) or [{...}] (block form), so at-keyword prefix matching on that shape
    is exact, while re-parsing would drag the whole CSS parser into the
    aggregator only to recover facts the renderer already fixed in the string.
    The one name that needs statement-vs-block disambiguation is [@layer]:
    statement form ([@layer a,b;]) must hoist, block form ([@layer a{...}]) must
    stay put. Layer names are CSS identifiers and can never contain [{], so
    "contains no brace" is a precise statement-form test. *)
module Statement_at_rules = struct
  type t =
    | Charset
    | Layer_statement
    | Import
    | Namespace
    | Other

  let is_ident_char c =
    (c >= 'a' && c <= 'z')
    || (c >= 'A' && c <= 'Z')
    || (c >= '0' && c <= '9')
    || c = '-'
    || c = '_'

  (* At-keyword of a rendered rule: the identifier characters following a
     leading '@'. Returns [""] for anything that is not an at-rule. *)
  let at_name rule =
    let len = String.length rule in
    if len < 2 || rule.[0] <> '@' then ""
    else begin
      let stop = ref 1 in
      while !stop < len && is_ident_char rule.[!stop] do
        incr stop
      done;
      String.lowercase_ascii (String.sub rule 1 (!stop - 1))
    end

  let classify rule =
    match at_name rule with
    | "charset" -> Charset
    | "import" -> Import
    | "namespace" -> Namespace
    | "layer" when not (String.contains rule '{') -> Layer_statement
    | _ -> Other
end

(** Decide the output mode from the harvested [[@@@css.config]] attributes.

    The PPX declares [("env", "production")] in every file it processes with
    production settings and omits the attribute in development, so the
    aggregator needs no mode flag of its own. Output is minified (inter-rule
    newlines dropped) only when every contributing input file (every file with
    harvested rules or an explicit config) was compiled for production. Mixed
    inputs mean some library stanzas ran the PPX with production settings and
    some did not: warn and emit readable output. *)
let production_mode harvests =
  let contributing =
    List.filter (fun h -> h.rules <> [] || h.env <> None) harvests
  in
  let production, development =
    List.partition
      (fun h -> h.env = Some Css_extraction.config_env_production)
      contributing
  in
  match production, development with
  | [], _ -> false
  | _ :: _, [] -> true
  | prod :: _, dev :: _ ->
    Logger.warning
      "input files disagree on their [@@@%s] environment: %s was compiled for \
       production but %s was not; emitting non-minified output. Pass the same \
       environment to every (pps styled-ppx ...) stanza."
      Css_extraction.config_attribute_name prod.filename dev.filename;
    false

(** Collect, index, resolve, dedup, output. *)
let run ~output_file input_files =
  Logger.info "output file: %s"
    (match output_file with Some file -> file | None -> "stdout");
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
          (* [@charset] is dropped rather than hoisted: the generated asset
             is UTF-8, [@charset] is only meaningful as the very first bytes
             of a CSS file, and anywhere else browsers ignore it. A hoisted
             copy would be noise and a mid-sheet copy is invalid anyway. *)
          match Statement_at_rules.classify resolved with
          | Charset ->
            Logger.warning
              "dropping %S from module %s: the generated stylesheet is UTF-8, \
               and @charset is only honored as the very first bytes of a CSS \
               file. Remove the @charset rule from [%%styled.global]."
              resolved
              (module_of_filename harvest.filename)
          | _ -> resolved_rules := resolved :: !resolved_rules)
        harvest.rules)
    harvests;

  (match !errors with
  | [] -> ()
  | _ ->
    List.iter (fun msg -> Logger.error "%s" msg) (List.rev !errors);
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

  (* Hoist statement at-rules to the top of the stylesheet, where browsers
     honor them (issue #581; see [Statement_at_rules]). Stable partition of
     the deduped stream into four buckets, each keeping file order:

       1. statement-form [@layer]: legal before [@import] per
          css-cascade-5, and placing layer-order declarations first is the
          established best practice since they must not accidentally follow
          a rule that already used one of the layers;
       2. [@import]: must precede [@namespace];
       3. [@namespace]: must precede all remaining rules;
       4. everything else (including block-form [@layer]): unchanged.

     Spec nuance: [@layer] statements interleaved with [@import] are also
     legal, but a simple stable partition is correct and predictable, so
     interleavings are deliberately not preserved. *)
  let ordered_rules =
    let classified =
      List.map
        (fun rule -> Statement_at_rules.classify rule, rule)
        ordered_rules
    in
    let bucket wanted =
      List.filter_map
        (fun (cls, rule) -> if cls = wanted then Some rule else None)
        classified
    in
    bucket Statement_at_rules.Layer_statement
    @ bucket Statement_at_rules.Import
    @ bucket Statement_at_rules.Namespace
    @ bucket Statement_at_rules.Other
  in

  let minify = production_mode harvests in
  Logger.info "environment: %s"
    (if minify then "production (from [@@@css.config])" else "development");
  let stylesheet =
    let separator = if minify then "" else "\n" in
    let buffer = Buffer.create 1024 in
    Buffer.add_string buffer
      "/* This file is generated by styled-ppx, do not edit manually */\n";
    List.iter
      (fun rule ->
        Buffer.add_string buffer rule;
        Buffer.add_string buffer separator)
      ordered_rules;
    Buffer.contents buffer
  in
  Logger.debug "stylesheet:\n%s" stylesheet;
  let out_channel =
    match output_file with Some file -> open_out file | None -> Stdlib.stdout
  in
  output_string out_channel stylesheet;
  match output_file with Some _ -> close_out out_channel | None -> ()

(** The aggregator deliberately has no mode flag: output minification follows
    the [[@@@css.config]] attributes the PPX embeds in its input files, so the
    environment is declared exactly once, on the (pps styled-ppx ...) stanza. *)
let parse_args args =
  let rec parse acc ~output_file ~log_level = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse acc ~output_file:(Some file) ~log_level rest
    | "--log" :: level :: rest ->
      (match Logger.level_of_string level with
      | Some log_level -> parse acc ~output_file ~log_level rest
      | None ->
        Logger.error
          "invalid --log level %S (expected \"error\", \"warning\", \"info\" \
           or \"debug\")"
          level;
        exit 2)
    | "--debug" :: rest -> parse acc ~output_file ~log_level:Logger.Debug rest
    | [ (("-o" | "-output" | "--output" | "--log") as flag) ] ->
      Logger.error "missing value for flag %S" flag;
      exit 2
    | arg :: _ when String.length arg > 0 && arg.[0] = '-' ->
      Logger.error "unknown flag %S" arg;
      exit 2
    | arg :: rest -> parse (arg :: acc) ~output_file ~log_level rest
    | [] -> List.rev acc, output_file, log_level
  in
  let tail = match Array.to_list args with [] -> [] | _ :: t -> t in
  parse [] ~output_file:None ~log_level:Logger.Warning tail

let () =
  let input_files, output_file, log_level = parse_args Sys.argv in
  Logger.set_level log_level;
  run ~output_file input_files
