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
    binding's build-independent identity class (a `id-...` handle, see
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

(** The leading `_a_`/`_in_` atom class name in a rendered rule, if any (see
    [Hash_class.slot_class] / [Class_format]). Every atom this generator emits
    opens with its own class as a leading compound-selector token, so the first
    occurrence in the rule text is always the atom's own class. Returns [None]
    for anything else ([_id_]/[_k_] classes, [@import]/ [@namespace] statements,
    etc.) - those aren't this check's concern. There is no separate
    important-atom prefix: an [!important] atom is still [_a_], just with a
    non-empty context (see [Slot_key.context_key]'s doc). *)
let atom_class_and_end rule_text =
  (* Real output is lowercase base36 preceded by the prefix's own trailing
     "_", but this must not stop early on other test-fixture shapes (existing
     generate.ml cram tests fabricate raw [@@@css ...] payloads with
     hand-written names like "._a_A-y") - under-matching here would truncate
     two different class names down to the same prefix and report a false
     collision. The two prefixes differ in length (3 vs 4), so the matched
     prefix's own length - not a fixed constant - decides where the rest of
     the class name starts; neither is a prefix of the other, so trying them
     in either order is unambiguous. *)
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
  let prefixes = [ "_a_"; "_in_" ] in
  let rec scan i =
    if i >= n then None
    else if rule_text.[i] <> '.' then scan (i + 1)
    else (
      match List.find_opt (fun p -> has_prefix (i + 1) p) prefixes with
      | None -> scan (i + 1)
      | Some p ->
        let start = i + 1 in
        let j = ref (start + String.length p) in
        while !j < n && is_class_char rule_text.[!j] do
          incr j
        done;
        Some (String.sub rule_text start (!j - start), !j))
  in
  scan 0

(** The atom's own class name alone, dropping the end position
    {!atom_class_and_end} also returns (used by {!rule_tier} to look at what
    immediately follows the class token). *)
let atom_class_name rule_text = Option.map fst (atom_class_and_end rule_text)

(** Collision check for the new atom-class format: its value hash is only unique
    within one (context, family[, mask]) bucket, not globally (see
    [Class_format]'s doc comment), so a coincidental collision would otherwise
    let two genuinely different atoms silently share one class - whichever rule
    text is deduped away would then apply to every element using that class,
    everywhere, for the OTHER atom's declaration too. Same shape as [Index]'s
    `_id_` identity-collision check: same key, different content, is a hard
    build error naming both sides, never a silently wrong stylesheet.

    An `_in_` (interpolation-bundle) class is explicitly exempt, in both
    directions - never recorded, never compared, never flagged. [Css_file.re]'s
    bundling already, legitimately, gives several different declarations from
    one binding the SAME class when they all carry a [$(...)] interpolation;
    that is not a hash collision, it is the bundling mechanism working as
    designed. Without this exemption, `minify-interpolation.t` and the
    `reason-cx-*` snapshot tests would report false collisions on exactly that
    legitimate sharing. Call after [ordered_rules]'s exact-text dedup, so only
    genuinely different rule bodies remain to compare. *)
let check_atom_class_collisions rules =
  let seen : (string, string) Hashtbl.t = Hashtbl.create 256 in
  List.filter_map
    (fun (rule, _layer) ->
      match atom_class_name rule with
      | None -> None
      | Some class_name
        when String.length class_name >= 4 && String.sub class_name 0 4 = "_in_"
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

(* -- Cascade tiers -------------------------------------------------------

   Every rule this aggregator ships shares the atomic invariant "one class,
   no qualifiers", so two rules for the same property only ever compete by
   stylesheet position - the later one wins. Content-hash dedup (and,
   before it, an atom's own author) has no say over WHERE two such rules
   land relative to each other once they come from different bindings, so
   two real bugs fell out of this: a block's own `@media (min-width:...)`
   override landing BEFORE its base declaration in the emitted sheet (so
   the base declaration, unconditionally later, always won, even inside
   the media query), and the same base rule emitted by two different
   generate.ml runs (two stylesheets on one page) landing in a different
   relative position to some OTHER sheet's conditional rule on the same
   property, depending only on which sheet the browser loaded last.

   Two fixed, always-in-this-order CSS layers fix both: every "unconditional"
   rule goes in `styled-ppx.base`, every rule that only applies under some
   extra condition (a media/feature query, or a pseudo-class/pseudo-element
   on the rule's own selector) goes in `styled-ppx.conditional`, and
   `@layer` order beats source order regardless of which stylesheet, or
   which position within one stylesheet, either rule came from. *)

let global_layer_name = "styled-ppx.global"
let descendant_layer_name = "styled-ppx.descendant"
let base_layer_name = "styled-ppx.base"
let conditional_layer_name = "styled-ppx.conditional"

(** [@property]/[@keyframes]/[@font-face] are registrations, not style rules
    that compete for an element: a [@property] inside a layer would make the
    custom-property registration itself depend on layer order, a [@keyframes]
    name lookup would too, and [@font-face] has no per-element cascade to begin
    with. All three stay outside every layer, exactly as [@import]/[@namespace]
    (hoisted separately, above) and dropped [@charset] do. A literal,
    user-authored [@layer] at-rule (statement form, ["@layer a, b;"], or block
    form, ["@layer name { ... }"]) stays outside every tier layer for a
    different reason: nesting it inside one of styled-ppx's own layers would
    rescope whatever sub-layer NAME it declares to live underneath that tier
    specifically, silently changing what the user's own [@layer] statement means
    \- the exact hazard the "Dedup and write" doc section already explains for
    why it is never hoisted with [@import]/[@namespace] either. Checked on the
    OUTERMOST at-rule name only - a [%styled.global] rule wrapped in its own
    [@media]/[@supports] still starts with that wrapper, never with one of these
    four names, so this is an exact, not just a heuristic, test. *)
let stays_outside_all_layers rule_text =
  let trimmed = String.trim rule_text in
  String.starts_with ~prefix:"@property" trimmed
  || String.starts_with ~prefix:"@keyframes" trimmed
  || String.starts_with ~prefix:"@font-face" trimmed
  || String.starts_with ~prefix:"@layer" trimmed

(** The selector text and the declaration-body text of the innermost
    (deepest-nested) [{...}] span in [text] - the actual style rule, whether
    [text] is a bare rule (depth 1) or wrapped in one or more at-rules (depth
    2+: [@media]/[@supports]/[@container] can themselves nest; the selector
    returned is that rule's own prelude, never an enclosing at-rule's media
    condition). [None] for text with no balanced brace pair at all. *)
let innermost_selector_and_block text =
  let n = String.length text in
  let stack = ref [] in
  let last_boundary = ref 0 in
  let best = ref None in
  for i = 0 to n - 1 do
    match text.[i] with
    | '{' ->
      let selector = String.sub text !last_boundary (i - !last_boundary) in
      stack := (i + 1, selector) :: !stack;
      last_boundary := i + 1
    | '}' ->
      (match !stack with
      | (start, selector) :: rest ->
        let depth = List.length !stack in
        stack := rest;
        last_boundary := i + 1;
        let better =
          match !best with
          | None -> true
          | Some (best_depth, _, _, _) -> depth > best_depth
        in
        if better then best := Some (depth, selector, start, i)
      | [] -> ())
    | _ -> ()
  done;
  match !best with
  | None -> None
  | Some (_, selector, start, end_) ->
    Some (selector, String.sub text start (end_ - start))

let innermost_declaration_block text =
  Option.map snd (innermost_selector_and_block text)

(** A combinator character outside any parenthesised pseudo-class argument (so
    `:not(:last-child)`'s inner `:` never counts, but a real descendant space
    does). *)
let is_combinator_char = function
  | ' ' | '\t' | '\n' | '>' | '+' | '~' -> true
  | _ -> false

let has_top_level_combinator selector =
  let depth = ref 0 in
  let found = ref false in
  String.iter
    (fun c ->
      match c with
      | '(' -> incr depth
      | ')' -> decr depth
      | c when !depth = 0 && is_combinator_char c -> found := true
      | _ -> ())
    selector;
  !found

(** The rightmost compound selector - the subject, in CSS Selectors terms - of a
    (possibly multi-compound) selector: everything after the LAST top-level
    combinator, or the whole (trimmed) selector when there is none. *)
let rightmost_compound selector =
  let n = String.length selector in
  let depth = ref 0 in
  let last_combinator = ref (-1) in
  for i = 0 to n - 1 do
    match selector.[i] with
    | '(' -> incr depth
    | ')' -> decr depth
    | c when !depth = 0 && is_combinator_char c -> last_combinator := i
    | _ -> ()
  done;
  let start = if !last_combinator = -1 then 0 else !last_combinator + 1 in
  String.trim (String.sub selector start (n - start))

(** True when [rule_text]'s own selector reaches, via a combinator, for a
    DIFFERENT element than the atom's own class (every atom's class is always
    that selector's leading token - see {!atom_class_name}'s doc), and that
    different element's subject compound has no class of its own: a bare element
    type or `*` (".x > div", ".x span", ".x > *"). A subject that DOES carry its
    own class (".x .id-..." from a `$(binding)` reference, ".x .tiptap") is not
    this shape - seeing a class there means the rule targets a specific,
    identified element, not "whatever happens to be under here". No combinator
    at all (".x", ".x:hover") means the atom's own compound IS the subject -
    never this shape either. *)
let is_descendant_shape rule_text =
  match innermost_selector_and_block rule_text with
  | None -> false
  | Some (selector, _) ->
    has_top_level_combinator selector
    && not (String.contains (rightmost_compound selector) '.')

(** [Descendant] (below), [Conditional], or [Base]. [Descendant] is checked
    FIRST, independent of at-rule/pseudo wrapping: it is a question about what
    element the rule reaches for, not about when it applies, so a
    descendant-shaped rule that also happens to sit inside `@media` is still
    [Descendant], not [Conditional] - reasoned out from the `/gbp-monitor` bug
    this closes: an ancestor's blind ".x *"-shaped reach must lose to the
    CHILD's own rule regardless of whether that child's own rule is itself
    unconditional or conditional, so "reaches for a different, unspecified
    element" has to outrank both, not just [Base]. [Conditional] otherwise when
    [rule_text] only applies under some extra condition beyond the plain
    presence of its own element: wrapped in an at-rule
    ([@media]/[@supports]/[@container] are the only ones that ever wrap an atom
    class - [@property]/[@keyframes]/[@font-face]/ [%styled.global] rules carry
    no atom class at all and never reach this function, see the "no atom class"
    filter in {!run} below), or a pseudo-class/pseudo-element attached DIRECTLY
    to the atom's own compound selector (".x:hover", ".x::before", chained
    ".x:focus-visible:not(:disabled)"). [Base] otherwise, including a
    descendant/child selector whose subject DOES carry its own class (".x
    .id-...", ".x .tiptap" - see {!is_descendant_shape}'s doc) and any rule with
    no combinator at all. *)
type tier =
  | Descendant
  | Base
  | Conditional

let rule_tier rule_text =
  if is_descendant_shape rule_text then Descendant
  else (
    let trimmed = String.trim rule_text in
    if String.length trimmed > 0 && trimmed.[0] = '@' then Conditional
    else (
      match atom_class_and_end rule_text with
      | None ->
        Base
        (* unreachable here - callers only ask for tier-eligible rules, i.e. atom_class_name <> None *)
      | Some (_, after) ->
        if after < String.length rule_text && rule_text.[after] = ':' then
          Conditional
        else Base))

(** The property name of each top-level (";"-separated) declaration in a
    declaration-block's text. CSS property names never contain [:] or [;]
    themselves, so splitting on [;] and taking each piece up to its first [:] is
    exact even though a VALUE can legally contain either character later on (a
    color, a calc() expression, a quoted string). *)
let property_names_in_block block_text =
  block_text
  |> String.split_on_char ';'
  |> List.filter_map (fun decl ->
    let decl = String.trim decl in
    if decl = "" then None
    else (
      match String.index_opt decl ':' with
      | None -> None
      | Some i -> Some (String.trim (String.sub decl 0 i))))

let popcount n =
  let rec loop n acc =
    if n = 0 then acc else loop (n lsr 1) (acc + (n land 1))
  in
  loop n 0

(** One rendered rule's own (family key, combined leaf mask) pairs, one entry
    per DISTINCT property family its own declaration(s) touch - read from the
    rendered TEXT (generate.ml never sees the ppx's AST or a [Slot_key.t]),
    through [Slot_key.Family] for the actual shorthand/leaf data (the same
    css-grammar-sourced table [Slot_key.of_atom] uses to build a real atom's own
    mask). A bundle's several declarations can touch several different families
    at once (no single [Slot_key.t] could represent that - a bundle spans more
    than one property, sometimes more than one context, which is exactly why it
    has no context/family/mask fields of its own); each of ITS OWN families
    still gets a mask, OR-ed across every declaration of that family in this one
    rule, mirroring how [Slot_key.of_atom] combines a same-file
    multi-declaration group. *)
let families_of_rule rule_text =
  match innermost_declaration_block rule_text with
  | None -> []
  | Some block ->
    let by_family : (string, int) Hashtbl.t = Hashtbl.create 4 in
    property_names_in_block block
    |> List.iter (fun property ->
      let property = Slot_key.normalize_property property in
      let family = Slot_key.Family.family_key_of property in
      let mask = Slot_key.Family.mask_of property in
      let existing =
        Option.value (Hashtbl.find_opt by_family family) ~default:0
      in
      Hashtbl.replace by_family family (existing lor mask));
    Hashtbl.fold (fun family mask acc -> (family, mask) :: acc) by_family []

(** Stable sort: within families [a] and [b] BOTH touch, the one covering MORE
    of that family's leaves (more bits set - a shorthand, or a wider family
    atom) sorts first, so a later, narrower override (a lone longhand from a
    different atom or bundle) still lands after it and wins by ordinary cascade
    position - exactly the guarantee `CSS.merge` gives two atoms it CAN see
    inside, extended here to a bundle merge can't. Rules that share no family at
    all compare equal, so a stable sort leaves their relative order exactly as
    dependency/ source order already placed them: this only ever reorders rules
    that are already fighting over the same property family, never anything
    else. Overlapping declarations *within* one block are already one atom (see
    [Css_file.re]'s family-atom grouping), so this never reorders an author's
    own single binding, only two different bindings' atoms. *)
let compare_by_shorthand_first (families_a, _) (families_b, _) =
  match
    List.find_map
      (fun (family, mask_a) ->
        List.assoc_opt family families_b
        |> Option.map (fun mask_b -> mask_a, mask_b))
      families_a
  with
  | None -> 0
  | Some (mask_a, mask_b) -> compare (popcount mask_b) (popcount mask_a)

(** Sort [rules] by {!compare_by_shorthand_first}, precomputing each rule's
    families once ("decorate-sort-undecorate") instead of re-parsing its text on
    every comparison a stable sort makes. *)
let sort_by_shorthand_first rules =
  rules
  |> List.map (fun ((rule_text, _layer) as r) -> families_of_rule rule_text, r)
  |> List.stable_sort compare_by_shorthand_first
  |> List.map snd

(** Bucket [rules] by library key (using [library_order] for both the bucket set
    and the emission order), the same grouping {!run}'s [--layers] used to apply
    once to every rule; reused per-tier once tiers exist, so a library still
    gets exactly one nested [\@layer] block per tier it actually contributes a
    rule to, never an empty one. *)
let bucket_by_library ~library_order (rules : (string * string) list) =
  let rules_by_layer : (string, (string * string) list ref) Hashtbl.t =
    Hashtbl.create 16
  in
  List.iter
    (fun ((_, key) as rule) ->
      match Hashtbl.find_opt rules_by_layer key with
      | Some acc -> acc := rule :: !acc
      | None -> Hashtbl.add rules_by_layer key (ref [ rule ]))
    rules;
  let layer_names =
    library_order
    |> List.filter (Hashtbl.mem rules_by_layer)
    |> List.map (fun key -> key, sanitize_layer_name key)
  in
  warn_layer_name_collisions layer_names;
  rules_by_layer, layer_names

(** Render the nested [\@layer lib1, lib2; \@layer lib1 { ... } ...] sequence
    for one tier's rules, appended to [buffer]. Each library's own rules are
    sorted by {!sort_by_shorthand_first} - the family fight this sort resolves
    can just as easily be between two atoms in the SAME library as between two
    different ones. *)
let emit_library_layers ~buffer ~separator ~minify ~library_order ~tier_name
  ~emit rules =
  let rules_by_layer, layer_names = bucket_by_library ~library_order rules in
  Logger.info "layers (%s): %s" tier_name
    (String.concat ", " (List.map snd layer_names));
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
      List.iter emit
        (sort_by_shorthand_first (List.rev !(Hashtbl.find rules_by_layer key)));
      Buffer.add_string buffer "}";
      Buffer.add_string buffer separator)
    layer_names

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

  (* Cascade tiers: split [other_rules] into what stays outside every layer
     ([@property]/[@keyframes]/[@font-face] registrations and a literal
     [@layer] at-rule - see [stays_outside_all_layers] - never atom-classed,
     and never style rules that compete for an element either) and what
     tiers - a [%styled.global] style rule, ALSO never atom-classed but a
     real, cascading rule (`html{...}`, `*{...}`, `*::before{...}`, an
     author's own global selector), lands in [styled-ppx.global], the
     LOWEST tier; every real atom, [_a_] or [_in_] alike, lands in
     [descendant]/[base]/[conditional] as before. Global rules MUST be
     layered, not left unlayered like registrations: CSS lets an unlayered
     normal declaration beat ANY layered one regardless of layer or
     specificity, so leaving globals unlayered while atoms became layered
     would let a `[%styled.global]` default (`*{box-sizing:inherit}`, a
     global `a{color:blue}`) beat an atom on the same element,
     `!important` aside - the exact regression this tier was almost shipped
     with. Putting `styled-ppx.global` FIRST (lowest of all four) instead
     restores "an element's own atom always beats a global default", now
     unconditionally instead of only when the atom happened to be more
     specific or later in the stylesheet - see "Cascade tiers" in the docs
     for the specificity change this is. *)
  let registrations, atomless_style_rules =
    List.partition
      (fun (rule, _layer) -> stays_outside_all_layers rule)
      other_rules
  in
  let global_rules, tier_eligible_rules =
    List.partition
      (fun (rule, _layer) -> atom_class_name rule = None)
      atomless_style_rules
  in
  let descendant_rules, non_descendant_rules =
    List.partition
      (fun (rule, _layer) -> rule_tier rule = Descendant)
      tier_eligible_rules
  in
  let base_rules, conditional_rules =
    List.partition
      (fun (rule, _layer) -> rule_tier rule = Base)
      non_descendant_rules
  in
  let any_tiered =
    global_rules <> []
    || descendant_rules <> []
    || base_rules <> []
    || conditional_rules <> []
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
    List.iter emit registrations;
    if any_tiered then begin
      (* Unconditional and in this fixed order whenever THIS sheet ships any
         tiered rule at all, regardless of whether a given tier is locally
         empty: two different generate.ml outputs loaded on the same page
         share these four layer names, and CSS layer order is fixed by
         each name's FIRST occurrence across every stylesheet on the page -
         if one sheet only ever populates `conditional` and loads before
         another sheet that only populates `base`, omitting the empty tier
         from either sheet's own statement would let load order flip which
         one wins, exactly the bug tiers exist to remove. A sheet that
         ships NO tiered rule at all (only registrations) skips the whole
         apparatus (this branch) instead - it contributes nothing to any
         layer, so there is nothing to guarantee order for. *)
      Buffer.add_string buffer
        (Printf.sprintf "@layer %s, %s, %s, %s;" global_layer_name
           descendant_layer_name base_layer_name conditional_layer_name);
      Buffer.add_string buffer separator;
      let emit_tier name rules =
        (* A tier with no rule in THIS sheet gets no block at all - the
           statement above already reserved its position in the global
           layer order, so an empty block would add nothing (mirrors
           [--layers]'s own "no rule, no block" rule for a library). *)
        if rules <> [] then begin
          Buffer.add_string buffer
            (if minify then Printf.sprintf "@layer %s{" name
             else Printf.sprintf "@layer %s {" name);
          Buffer.add_string buffer separator;
          if not layers then List.iter emit (sort_by_shorthand_first rules)
          else
            emit_library_layers ~buffer ~separator ~minify ~library_order
              ~tier_name:name ~emit rules;
          Buffer.add_string buffer "}";
          Buffer.add_string buffer separator
        end
      in
      emit_tier global_layer_name global_rules;
      emit_tier descendant_layer_name descendant_rules;
      emit_tier base_layer_name base_rules;
      emit_tier conditional_layer_name conditional_rules
    end;
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
