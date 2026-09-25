(** styled-ppx generator: walk every post-PPX [.ml] file in a dune library,
    collect [[\@\@\@css ...]] CSS rules and any cross-module references embedded
    as NUL-delimited sentinels, resolve those sentinels against a global index
    of [%css] bindings, and emit the final stylesheet.

    The generator runs once per `dune build` invocation, after the PPX has
    produced the post-PPX [.ml] files for every module in the library.

    Two-pass design:

    Pass 1 — Collect every [[\@\@\@css.bindings ...]] attribute payload into a
    global index mapping [longident -> identity]. The PPX itself populates these
    payloads with the fully-qualified longident ([["M.Css.marker"]]), the
    binding's build-independent identity class (a `cid-...` handle, see
    [Hash_class.identity_class] in the PPX), and its atomized class string (kept
    only as a content fingerprint for collision detection — see [Index]), so the
    generator only has to read them — it does not re-derive module names from
    filenames or pattern-match [CSS.make] calls.

    Pass 2 — For each rule string in [[\@\@\@css ...]], scan for NUL-delimited
    sentinels [\x00LONGIDENT\x00]. Look the longident up in the index and
    substitute its identity class verbatim (one class, regardless of how many
    atoms the binding minted). Resolution failures emit a hard error pointing at
    the original [.re]/[.ml] source via the location descriptors in
    [[\@\@\@css.refs ...]] attributes.

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
    attribute payloads. [by_longident] is keyed by the dotted longident exactly
    as users write it in their [%css] selector refs (e.g. [["M.Css.marker"]]),
    mapping to the binding's identity class, so resolution is a direct
    [Hashtbl.find_opt]. [by_identity] is the reverse index used only to detect
    an identity collision: two different bindings whose identity classes
    coincide (e.g. same module basename and binding name in two libraries,
    without a distinguishing [--namespace]) but whose atomized content differs.
    Two entries with the SAME identity and the SAME [class_string] are not a
    collision — that's the same module compiled twice (native + melange
    [copy_files], vendoring), which is expected and benign. *)
module Index = struct
  type t = {
    by_longident : (string, string) Hashtbl.t;
    by_identity : (string, string * string * string) Hashtbl.t;
  }

  let create () : t =
    { by_longident = Hashtbl.create 64; by_identity = Hashtbl.create 64 }

  let lookup (idx : t) longident = Hashtbl.find_opt idx.by_longident longident

  let collision_message ~filename (entry : Css_extraction.binding)
    ~other:(other_longident, other_class_string, other_filename) =
    Printf.sprintf
      "identity collision: %S (in %s) and %S (in %s) both hash to identity %s, \
       but carry different CSS (%S vs %S). Pass `--namespace <name>` to one \
       library's (pps styled-ppx ...) stanza, identically on its native and \
       melange stanzas."
      other_longident other_filename entry.longident filename entry.identity
      other_class_string entry.class_string

  let add_from_payload ~filename (idx : t) payload =
    match Css_extraction.decode_bindings_payload payload with
    | Error msg -> Error msg
    | Ok entries ->
      let errors =
        List.filter_map
          (fun (entry : Css_extraction.binding) ->
            let error =
              match Hashtbl.find_opt idx.by_identity entry.identity with
              | Some ((_, other_class_string, _) as other)
                when other_class_string <> entry.class_string ->
                Some (collision_message ~filename entry ~other)
              | _ -> None
            in
            Hashtbl.replace idx.by_identity entry.identity
              (entry.longident, entry.class_string, filename);
            Hashtbl.replace idx.by_longident entry.longident entry.identity;
            error)
          entries
      in
      (match errors with
      | [] -> Ok ()
      | msgs -> Error (String.concat "; " msgs))
end

(** Every
    [[\@\@\@css.refs [(longident, file, start_line, start_col, end_col); ...]]]
    attribute decoded into a list of records. The generator uses these locations
    when reporting unresolvable refs. *)
module Refs = struct
  type ref_loc = Css_extraction.ref_loc

  let of_list_expr = Css_extraction.decode_refs_payload
end

(** [--order]: [Dependency] (the default) emits a module's rules after the rules
    of every module it references; [Source] keeps the input file order. *)
type order_mode =
  | Dependency
  | Source

(** What the generator extracts from one input file: rules with potential
    sentinels, all cross-module ref descriptors seen in this file, the file's
    declared environment from [[@@@css.config]] ([None] when absent, i.e.
    development), the module names the file references ({!Order.references}),
    and its declared [@@@css.config] [library] key ([None] when absent: such a
    file groups with its sibling files by directory, see {!group_key}). The
    bindings attribute is consumed directly into the global [Index] during the
    same walk. *)
type input = {
  filename : string;
  rules : string list;
  refs : Refs.ref_loc list;
  env : string option;
  library : string option;
  protocol_errors : string list;
  references : string list;
}

let extract_structure ~filename ~idx structure : input =
  let rules = ref [] in
  let refs = ref [] in
  let env = ref None in
  let library = ref None in
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
        (match Index.add_from_payload ~filename idx value with
        | Ok () -> ()
        | Error msg ->
          add_protocol_error Css_extraction.bindings_attribute_name msg)
      | [%stri [@@@css.config [%e? value]]] ->
        (match Css_extraction.decode_config_payload value with
        | Ok entries ->
          (match List.assoc_opt Css_extraction.config_env_key entries with
          | Some _ as declared -> env := declared
          | None -> ());
          (match List.assoc_opt Css_extraction.config_library_key entries with
          | Some _ as declared -> library := declared
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
    library = !library;
    protocol_errors = List.rev !protocol_errors;
    references = Order.references structure;
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
  | [] | [ _ ] -> false (* No dot — single-segment, can't be cross-anything. *)
  | _ ->
    let head = longident_head longident in
    not (List.mem head in_library_modules)

let cross_library_message ~longident ~head ~ref_loc =
  Printf.sprintf
    "%s\n\
     Error: cross-library [%%css] selector references are not supported.\n\
     The reference `%s` resolves to module `%s` which is not part of the\n\
     current library. Move the [%%css] binding into the current library."
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

(** Decide the output mode from the extracted [[@@@css.config]] attributes.

    The PPX declares [("env", "production")] in every file it processes with
    production settings and omits the attribute in development, so the
    aggregator needs no mode flag of its own. Output is minified (inter-rule
    newlines dropped) only when every contributing input file — every file with
    extracted rules or an explicit config — was compiled for production. Mixed
    inputs mean some library stanzas ran the PPX with production settings and
    some did not: warn and emit readable output. *)
let production_mode inputs =
  let contributing =
    List.filter (fun h -> h.rules <> [] || h.env <> None) inputs
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

(** A file's ordering group: its declared [@@@css.config] [library] key, or
    (when absent) the directory of its input path. Two files agree on their
    group either by naming the same library or by sharing a directory. *)
let group_key (h : input) : string =
  match h.library with Some lib -> lib | None -> Filename.dirname h.filename

(** Order [scope] so each file comes after the files in [scope] it references
    ({!Order.sort}), and return the [edges] lookup so the caller can log them. A
    referenced module name resolves to the file in [scope] with that module
    name; when several match, the one sharing the longest directory prefix with
    the referrer wins, and a tie means no edge. *)
let order_modules_within_scope (scope : input list) :
  input list * (input -> input list) =
  let by_module_name = Hashtbl.create (List.length scope) in
  List.iter
    (fun h -> Hashtbl.add by_module_name (module_of_filename h.filename) h)
    scope;
  let dirs filename =
    String.split_on_char '/' (Filename.dirname filename)
    |> List.filter (fun s -> s <> "" && s <> ".")
  in
  let rec shared_prefix a b =
    match a, b with
    | x :: xs, y :: ys when x = y -> 1 + shared_prefix xs ys
    | _ -> 0
  in
  let resolve referrer name =
    let candidates = Hashtbl.find_all by_module_name name in
    let closeness c =
      shared_prefix (dirs referrer.filename) (dirs c.filename)
    in
    let best =
      List.fold_left (fun acc c -> max acc (closeness c)) 0 candidates
    in
    match List.filter (fun c -> closeness c = best) candidates with
    | [ only ] -> Some only
    | [] -> None
    | ties ->
      Logger.debug "ambiguous module %s referenced from %s (%s); no edge" name
        referrer.filename
        (String.concat ", " (List.map (fun c -> c.filename) ties));
      None
  in
  let edges h = List.filter_map (resolve h) h.references in
  Order.sort ~nodes:scope ~edges ~key:(fun h -> h.filename), edges

(** One ordering group: every input that shares a {!group_key}. Returned in
    Hashtbl order, which {!Order.sort} downstream ties-break by key anyway, so
    the group order here never reaches the output. *)
type library_group = {
  key : string;
  inputs : input list;
}

let group_by_library (inputs : input list) : library_group list =
  let members : (string, input list ref) Hashtbl.t = Hashtbl.create 16 in
  List.iter
    (fun h ->
      let k = group_key h in
      match Hashtbl.find_opt members k with
      | Some acc -> acc := h :: !acc
      | None -> Hashtbl.add members k (ref [ h ]))
    inputs;
  Hashtbl.fold
    (fun key hs acc -> { key; inputs = List.rev !hs } :: acc)
    members []

(** Collapse module references into library edges: a reference [X] from a file
    in [self] is a same-library reference — left to
    {!order_modules_within_scope} — whenever [self] itself has a module named
    [X]. Otherwise, [X] names the library dependency directly: a module named
    [X] in exactly one other group (the unwrapped case), or else [X] equal to
    the capitalized library name of exactly one other group (the wrapped case,
    referenced through its alias module). Anything else is not a library
    reference at all (a stdlib/external module, for instance) and contributes no
    edge. *)
let library_edge_target ~(groups_with_module : string -> library_group list)
  ~(groups_with_alias : string -> library_group list) ~(self : library_group)
  (referenced_name : string) : library_group option =
  let single = function [ only ] -> Some only | _ -> None in
  let holders = groups_with_module referenced_name in
  if List.exists (fun g -> g.key = self.key) holders then None
  else (
    match single holders with
    | Some target -> Some target
    | None ->
      groups_with_alias referenced_name
      |> List.filter (fun g -> g.key <> self.key)
      |> single)

(** Two-level order: libraries first (by the dependency graph collapsed from
    module references), then, within each library, {!order_modules_within_scope}
    unchanged from PR 1. Both levels reuse {!Order.sort}, so the alphabetical
    tiebreak and the never-fail cycle policy apply at both levels for free.
    Returns the ordered inputs and the library keys in emitted order, the one
    value both the log line and [--layers] consume. *)
let order_by_dependency (inputs : input list) : input list * string list =
  let groups = group_by_library inputs in
  (* Indexed once: scanning every group for every raw reference measured 2 s
     extra on a 5,824-file input with 246 groups. *)
  let groups_with_module : (string, library_group) Hashtbl.t =
    Hashtbl.create (List.length inputs)
  in
  let groups_with_alias : (string, library_group) Hashtbl.t =
    Hashtbl.create (List.length groups)
  in
  List.iter
    (fun g ->
      g.inputs
      |> List.map (fun h -> module_of_filename h.filename)
      |> List.sort_uniq String.compare
      |> List.iter (fun name -> Hashtbl.add groups_with_module name g);
      Hashtbl.add groups_with_alias (String.capitalize_ascii g.key) g)
    groups;
  let library_edges_by_key : (string, library_group list) Hashtbl.t =
    Hashtbl.create (List.length groups)
  in
  List.iter
    (fun g ->
      let targets =
        g.inputs
        |> List.concat_map (fun h -> h.references)
        |> List.sort_uniq String.compare
        |> List.filter_map
             (library_edge_target
                ~groups_with_module:(Hashtbl.find_all groups_with_module)
                ~groups_with_alias:(Hashtbl.find_all groups_with_alias)
                ~self:g)
        |> List.sort_uniq (fun a b -> String.compare a.key b.key)
      in
      Hashtbl.replace library_edges_by_key g.key targets)
    groups;
  let library_edges g = Hashtbl.find library_edges_by_key g.key in
  let sorted_groups =
    Order.sort ~nodes:groups ~edges:library_edges ~key:(fun g -> g.key)
  in
  Logger.info "library order: %s"
    (String.concat ", " (List.map (fun g -> g.key) sorted_groups));
  let ordered_groups =
    List.map
      (fun g ->
        let ordered, edges = order_modules_within_scope g.inputs in
        Logger.info "order: %s: %s" g.key
          (String.concat ", "
             (List.map (fun h -> module_of_filename h.filename) ordered));
        g, ordered, edges)
      sorted_groups
  in
  List.iter
    (fun g ->
      List.iter
        (fun dep -> Logger.debug "library edge: %s -> %s" g.key dep.key)
        (library_edges g))
    sorted_groups;
  List.iter
    (fun (_, ordered, edges) ->
      List.iter
        (fun h ->
          List.iter
            (fun dep ->
              Logger.debug "edge: %s -> %s"
                (module_of_filename h.filename)
                (module_of_filename dep.filename))
            (edges h))
        ordered)
    ordered_groups;
  ( List.concat_map (fun (_, ordered, _) -> ordered) ordered_groups,
    List.map (fun (g, _, _) -> g.key) ordered_groups )

(** [--layers] cascade-layer name for a library key: its last path segment (a
    no-op for a plain library name; the effective rule for a directory-fallback
    key such as ["./lib/native"]), with every character outside [A-Za-z0-9_-]
    replaced by ['_']. *)
let sanitize_layer_name key =
  Filename.basename key
  |> String.map (function
    | ('A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' | '-') as c -> c
    | _ -> '_')

(** When two different library keys sanitize to the same layer name, their
    blocks share that name and CSS itself concatenates same-named [@layer]
    blocks into one layer; warn once per colliding name so the merge isn't a
    silent surprise. *)
let warn_layer_name_collisions layer_names =
  let by_name : (string, string) Hashtbl.t = Hashtbl.create 8 in
  List.iter (fun (key, name) -> Hashtbl.add by_name name key) layer_names;
  List.map snd layer_names
  |> List.sort_uniq String.compare
  |> List.iter (fun name ->
    (* [Hashtbl.find_all] returns the most-recently-added key first; reverse
       to report libraries in the order they were declared. *)
    match List.rev (Hashtbl.find_all by_name name) with
    | [] | [ _ ] -> ()
    | many ->
      Logger.warning
        "layer name %S is shared by libraries %s; their rules merge into one \
         layer"
        name (String.concat ", " many))

(** [@property] and [@keyframes] rules are global registrations, not scoped
    declarations: leaving one inside a [@layer] block would make its
    registration, or a keyframe name lookup, depend on layer order. [--layers]
    emits them ahead of every layer instead. *)
let is_global_registration rule =
  let trimmed = String.trim rule in
  String.starts_with ~prefix:"@property" trimmed
  || String.starts_with ~prefix:"@keyframes" trimmed

(** A rendered rule is a hoisted [\@import]/[\@namespace] statement when, after
    trimming, it starts with that keyword and ends with [';']. CSS only honors
    these two kinds when they precede every other rule (and Cascade 5
    additionally requires every [\@import] to precede every [\@namespace]), so
    the aggregator hoists them to the front of the output — [\@import] block
    first, then [\@namespace] — regardless of which module emitted a rule or
    where {!order_by_dependency} placed that module; relative order within each
    kind is left alone. Statement-form [\@layer a, b;] is deliberately NOT
    hoisted here: CSS permits it anywhere in a stylesheet, and layer order is
    first-occurrence order, so moving a [\@layer] statement would silently
    reorder a library's cascade layers instead of just relocating text. Textual
    prefix/suffix matching (not a search for ['{']) is required because an
    [\@import] URL can itself contain ['{'] (e.g. [\@import url("a{b.css");]),
    which a ['{']-search would misclassify as a block rule. *)
let is_import_statement rule =
  let trimmed = String.trim rule in
  String.starts_with ~prefix:"@import" trimmed
  && String.ends_with ~suffix:";" trimmed

let is_namespace_statement rule =
  let trimmed = String.trim rule in
  String.starts_with ~prefix:"@namespace" trimmed
  && String.ends_with ~suffix:";" trimmed

(** [\@charset] is only ever honored as the literal first bytes of a stylesheet,
    but the generated file always opens with a comment identifying it and is
    written as UTF-8 regardless of what a module declares, so a collected
    [\@charset] can never be honored and is dropped (with a warning) instead of
    silently misplaced. *)
let is_charset rule = String.starts_with ~prefix:"@charset" (String.trim rule)

(** The leading `css-`/`csi-`/`csv-` atom class name in a rendered rule, if any
    (atom-slot-keys phase 2 - see [Hash_class.slot_class] / [Class_format]).
    Every atom this generator emits opens with its own class as a leading
    compound-selector token, so the first occurrence in the rule text is always
    the atom's own class. Returns [None] for anything else ([cid-]/[keyframe-]
    classes, [@import]/[@namespace] statements, etc.) - those aren't this
    check's concern. *)
let atom_class_name rule_text =
  (* Real output is lowercase base36 + '-', but this must not stop early on
     other test-fixture shapes (existing generate.ml cram tests fabricate
     raw [@@@css ...] payloads with hand-written names like ".css-A-y") -
     under-matching here would truncate two different class names down to
     the same "css-" prefix and report a false collision. *)
  let is_class_char c =
    (c >= 'a' && c <= 'z')
    || (c >= 'A' && c <= 'Z')
    || (c >= '0' && c <= '9')
    || c = '-'
    || c = '_'
  in
  let n = String.length rule_text in
  let has_prefix i prefix =
    let m = String.length prefix in
    i + m <= n && String.sub rule_text i m = prefix
  in
  let rec scan i =
    if i >= n then None
    else if
      rule_text.[i] = '.'
      && (has_prefix (i + 1) "css-"
         || has_prefix (i + 1) "csi-"
         || has_prefix (i + 1) "csv-")
    then (
      let start = i + 1 in
      let j = ref (start + 4) in
      while !j < n && is_class_char rule_text.[!j] do
        incr j
      done;
      Some (String.sub rule_text start (!j - start)))
    else scan (i + 1)
  in
  scan 0

(** Collision check for the new atom-class format: its value hash is only unique
    within one (context, family[, mask]) bucket, not globally (see
    [Class_format]'s doc comment), so a coincidental collision would otherwise
    let two genuinely different atoms silently share one class - whichever rule
    text is deduped away would then apply to every element using that class,
    everywhere, for the OTHER atom's declaration too. Same shape as [Index]'s
    `cid-` identity-collision check: same key, different content, is a hard
    build error naming both sides, never a silently wrong stylesheet.

    A `csv-` (interpolation-bundle) class is explicitly exempt, in both
    directions - never recorded, never compared, never flagged. [Css_file.re]'s
    bundling already, legitimately, gives several different declarations from
    one binding the SAME class when they all carry a [$(...)] interpolation;
    that is not a hash collision, it is the bundling mechanism working as
    designed (see `.workplace/plans/atom-slot-keys_PLAN.md`'s "Collision check"
    notes - an earlier, unconditional version of this check broke
    `minify-interpolation.t` and the `reason-cx-*` snapshot tests for exactly
    this reason). Call after [ordered_rules]'s exact-text dedup, so only
    genuinely different rule bodies remain to compare. *)
let check_atom_class_collisions rules =
  let seen : (string, string) Hashtbl.t = Hashtbl.create 256 in
  List.filter_map
    (fun (rule, _layer) ->
      match atom_class_name rule with
      | None -> None
      | Some class_name
        when String.length class_name >= 4 && String.sub class_name 0 4 = "csv-"
        ->
        None
      | Some class_name ->
        (match Hashtbl.find_opt seen class_name with
        | Some other when other <> rule ->
          Some
            (Printf.sprintf
               "atom class collision: %S and %S both use class %S but render \
                different CSS - a value-hash collision (astronomically \
                unlikely by chance; rerun with a different --namespace on one \
                side, or file an issue)."
               other rule class_name)
        | _ ->
          Hashtbl.replace seen class_name rule;
          None))
    rules

(** Collect, index, resolve, dedup, output. *)
let run ~output_file ~order ~layers input_files =
  Logger.info "output file: %s"
    (match output_file with Some file -> file | None -> "stdout");
  let idx = Index.create () in
  let in_library_modules = List.map module_of_filename input_files in
  let inputs =
    List.filter_map
      (fun filename ->
        if String.ends_with filename ~suffix:".css" then
          failwith "Extracting from .css files is not supported yet";
        match read_structure filename with
        | None -> None
        | Some structure -> Some (extract_structure ~filename ~idx structure))
      input_files
  in
  let inputs, library_order =
    match order with
    | Dependency -> order_by_dependency inputs
    | Source -> inputs, []
  in

  (* Resolve all rules across all inputs, collecting errors with locations. *)
  let errors =
    ref (List.concat_map (fun input -> input.protocol_errors) inputs)
  in
  let resolved_rules = ref [] in
  List.iter
    (fun input ->
      let input_layer = group_key input in
      List.iter
        (fun rule ->
          let on_error longident =
            let ref_loc =
              match
                List.find_opt
                  (fun (r : Refs.ref_loc) -> r.longident = longident)
                  input.refs
              with
              | Some r -> r
              | None ->
                Css_extraction.ref_loc ~longident ~file:input.filename
                  ~start_line:1 ~start_col:0 ~end_col:0
            in
            let msg =
              unresolved_message ~longident ~ref_loc ~in_library_modules
            in
            errors := msg :: !errors
          in
          let on_malformed msg =
            errors :=
              Printf.sprintf "%s: malformed [@@@%s]: %s" input.filename
                Css_extraction.css_attribute_name msg
              :: !errors
          in
          let resolved =
            Css_extraction.resolve_sentinels ~lookup:(Index.lookup idx)
              ~on_unresolved:on_error ~on_malformed rule
          in
          if is_charset resolved then
            Logger.warning
              "%s: dropping @charset: the output already starts with a leading \
               comment, so @charset could never be the first bytes of the \
               stylesheet; output is UTF-8 regardless."
              input.filename
          else resolved_rules := (resolved, input_layer) :: !resolved_rules)
        input.rules)
    inputs;

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
    |> List.filter (fun (rule, _layer) ->
      if Hashtbl.mem seen rule then false
      else begin
        Hashtbl.add seen rule ();
        true
      end)
  in

  (match check_atom_class_collisions ordered_rules with
  | [] -> ()
  | msgs ->
    List.iter (fun msg -> Logger.error "%s" msg) msgs;
    exit 1);

  (* [@import] before [@namespace] (Cascade 5), each preserving its own
     relative order; everything else, [@layer] statements included, stays in
     [other_rules] untouched. *)
  let import_rules, rest =
    List.partition
      (fun (rule, _layer) -> is_import_statement rule)
      ordered_rules
  in
  let namespace_rules, other_rules =
    List.partition (fun (rule, _layer) -> is_namespace_statement rule) rest
  in
  let statement_rules = import_rules @ namespace_rules in

  (* [--layers]: [@property]/[@keyframes] registrations go ahead of every
     layer; everything else is bucketed by group key in one pass, in traversal
     order, so the "last wins" order the cascade needs survives inside a layer.
     A group gets a layer only when a rule actually landed in its bucket: a
     module without [%css] (grouped by its directory, since the PPX attaches
     no [@@@css.config] to it), a library whose rules all deduplicated away,
     or one that only registers [@property]/[@keyframes] adds neither an
     empty block nor a name-collision warning. Rule-less groups still took
     part in {!order_by_dependency}, so a styles-free module keeps bridging
     edges between styled libraries. *)
  let layered =
    if not layers then None
    else begin
      let registrations, library_rules =
        List.partition
          (fun (rule, _layer) -> is_global_registration rule)
          other_rules
      in
      let rules_by_layer : (string, (string * string) list ref) Hashtbl.t =
        Hashtbl.create 16
      in
      List.iter
        (fun ((_, key) as rule) ->
          match Hashtbl.find_opt rules_by_layer key with
          | Some acc -> acc := rule :: !acc
          | None -> Hashtbl.add rules_by_layer key (ref [ rule ]))
        library_rules;
      let layer_names =
        library_order
        |> List.filter (Hashtbl.mem rules_by_layer)
        |> List.map (fun key -> key, sanitize_layer_name key)
      in
      warn_layer_name_collisions layer_names;
      Logger.info "layers: %s" (String.concat ", " (List.map snd layer_names));
      Some (registrations, rules_by_layer, layer_names)
    end
  in

  let minify = production_mode inputs in
  Logger.info "environment: %s"
    (if minify then "production (from [@@@css.config])" else "development");
  let stylesheet =
    let separator = if minify then "" else "\n" in
    let buffer = Buffer.create 1024 in
    Buffer.add_string buffer
      "/* This file is generated by styled-ppx, do not edit manually */\n";
    let emit (rule, _layer) =
      Buffer.add_string buffer rule;
      Buffer.add_string buffer separator
    in
    List.iter emit statement_rules;
    (match layered with
    | None -> List.iter emit other_rules
    | Some (registrations, rules_by_layer, layer_names) ->
      List.iter emit registrations;
      (* A repeated name in the statement doesn't declare a second layer, it
         only re-mentions the same slot, so list each name once (first
         occurrence): two colliding keys still get their own [@layer name {
         ... }] block below, which CSS itself merges by name. *)
      let layer_statement =
        let seen = Hashtbl.create (List.length layer_names) in
        List.filter_map
          (fun (_, name) ->
            if Hashtbl.mem seen name then None
            else begin
              Hashtbl.add seen name ();
              Some name
            end)
          layer_names
        |> String.concat ", "
      in
      Buffer.add_string buffer (Printf.sprintf "@layer %s;" layer_statement);
      Buffer.add_string buffer separator;
      List.iter
        (fun (key, name) ->
          Buffer.add_string buffer
            (if minify then Printf.sprintf "@layer %s{" name
             else Printf.sprintf "@layer %s {" name);
          Buffer.add_string buffer separator;
          List.iter emit (List.rev !(Hashtbl.find rules_by_layer key));
          Buffer.add_string buffer "}";
          Buffer.add_string buffer separator)
        layer_names);
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
  let rec parse acc ~output_file ~log_level ~order ~layers = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse acc ~output_file:(Some file) ~log_level ~order ~layers rest
    | "--log" :: level :: rest ->
      (match Logger.level_of_string level with
      | Some log_level -> parse acc ~output_file ~log_level ~order ~layers rest
      | None ->
        Logger.error
          "invalid --log level %S (expected \"error\", \"warning\", \"info\" \
           or \"debug\")"
          level;
        exit 2)
    | "--debug" :: rest ->
      parse acc ~output_file ~log_level:Logger.Debug ~order ~layers rest
    | "--order" :: "dependency" :: rest ->
      parse acc ~output_file ~log_level ~order:Dependency ~layers rest
    | "--order" :: "source" :: rest ->
      parse acc ~output_file ~log_level ~order:Source ~layers rest
    | "--order" :: mode :: _ ->
      Logger.error
        "invalid --order value %S (expected \"dependency\" or \"source\")" mode;
      exit 2
    | "--layers" :: rest ->
      parse acc ~output_file ~log_level ~order ~layers:true rest
    | [ (("-o" | "-output" | "--output" | "--log" | "--order") as flag) ] ->
      Logger.error "missing value for flag %S" flag;
      exit 2
    | arg :: _ when String.length arg > 0 && arg.[0] = '-' ->
      Logger.error "unknown flag %S" arg;
      exit 2
    | arg :: rest ->
      parse (arg :: acc) ~output_file ~log_level ~order ~layers rest
    | [] -> List.rev acc, output_file, log_level, order, layers
  in
  let tail = match Array.to_list args with [] -> [] | _ :: t -> t in
  parse [] ~output_file:None ~log_level:Logger.Warning ~order:Dependency
    ~layers:false tail

let () =
  let input_files, output_file, log_level, order, layers =
    parse_args Sys.argv
  in
  if layers && order = Source then begin
    Logger.error
      "--layers requires --order dependency: source order has no library \
       groups to layer";
    exit 2
  end;
  Logger.set_level log_level;
  run ~output_file ~order ~layers input_files
