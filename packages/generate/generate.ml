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
    tiebreak and the never-fail cycle policy apply at both levels for free. *)
let order_by_dependency (inputs : input list) : input list =
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
  List.concat_map (fun (_, ordered, _) -> ordered) ordered_groups

(** A rendered rule is a hoisted [\@import]/[\@namespace] statement when, after
    trimming, it starts with that keyword and ends with [';']. CSS only honors
    these two kinds when they precede every other rule (and Cascade 5
    additionally requires every [\@import] to precede every [\@namespace]), so
    the aggregator hoists them to the front of the output — [\@import] block
    first, then [\@namespace] — regardless of which module emitted a rule or
    where {!order_by_dependency} placed that module; relative order within each
    kind is left alone. Statement-form [\@layer a, b;] is deliberately NOT
    hoisted here: CSS permits it anywhere in a stylesheet, and a layer's
    priority is fixed by its name's FIRST occurrence across the whole page, so
    moving a user's own [\@layer] statement would silently change which layer it
    introduces first, relative to layers other stylesheets on the page may
    declare - a hazard independent of whether this aggregator emits any layer of
    its own. Textual prefix/suffix matching (not a search for ['{']) is required
    because an [\@import] URL can itself contain ['{'] (e.g.
    [\@import url("a{b.css");]), which a ['{']-search would misclassify as a
    block rule. *)
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
    (fun rule ->
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

(* -- Cascade tiers ---------------------------------------------------------

   Every rule this aggregator ships shares the atomic invariant "one class,
   no qualifiers", so two rules of EQUAL specificity for the same property
   only ever compete by stylesheet position - the later one wins. Content-
   hash dedup (and, before it, an atom's own author) has no say over WHERE
   two such rules land relative to each other once they come from different
   bindings, so a block's own `@media (min-width:...)` override could land
   BEFORE its base declaration in the emitted sheet, making the base
   declaration, unconditionally later, always win, even inside the media
   query.

   Fix: every rule that can compete for an element is emitted in one of
   three fixed-order groups - `global` ([%styled.global] rules), `base` (an
   atom's own, unconditional context), `conditional` (an atom wrapped in
   `@media`/`@supports`/`@container`, or carrying a pseudo-class/pseudo-
   element directly on its own selector - see {!rule_tier}) - each group
   independently sorted by {!sort_by_shorthand_first} (descendant-shaped
   rules first, then shorthand depth). No CSS layer separates the three:
   ordinary CSS cascade rules apply, SPECIFICITY first, stylesheet position
   only as the tie-break - which is exactly why a `conditional` rule still
   wins a genuine tie against a `base` one (it is textually later), and why
   a `[%styled.global]` rule with higher specificity than an atom now wins
   outright, same as any two plain, unlayered CSS rules would (an accepted
   consequence - see `global-tier.t`).

   Accepted, not fixed: two SEPARATE `styled-ppx.generate` invocations (two
   `<link>`s on one page) have no guaranteed relative order between their
   own tiered rules, for the rare case where the two sheets share a class -
   `--namespace` salts each library's atom classes (see `Hash_class.ml`),
   so two different libraries never mint the same one; sharing a class
   only happens for a native/Melange twin pair passing the same explicit
   `--namespace`, or for two runs with no namespace at all. When it does
   happen: each sheet's OWN tier order still holds internally
   (`tiers-two-stylesheets.t`), but a tie between two DIFFERENT sheets'
   rules depends on which `<link>` the browser loads first, exactly like
   plain CSS always has. *)

(** [@property]/[@keyframes]/[@font-face] are registrations, not style rules
    that compete for an element - a [@property] rule is a custom-property
    definition, a [@keyframes] rule is a name lookup, and [@font-face] has no
    per-element cascade to begin with - so none of the three take part in
    tiering; they stay wherever dedup/ordering already placed them, ahead of
    every tiered rule (see [run] below), exactly as [@import]/[@namespace]
    (hoisted separately, above) and dropped [@charset] do. A literal,
    user-authored [@layer] at-rule (statement form, ["@layer a, b;"], or block
    form, ["@layer name { ... }"]) stays there too, for a different reason: a
    layer's priority is fixed by its name's first occurrence across the whole
    page (see [is_import_statement]'s doc), so reordering it relative to the
    style rules around it - even without wrapping anything in a layer of our own
    \- risks changing which layer it introduces first on the page. Checked on
    the OUTERMOST at-rule name only - a [%styled.global] rule wrapped in its own
    [@media]/[@supports] still starts with that wrapper, never with one of these
    four names, so this is an exact, not just a heuristic, test. *)
let is_registration_rule rule_text =
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

(** [Conditional] or [Base] - a descendant-shaped rule (see
    {!is_descendant_shape}) is neither: it stays in the tier of its own context,
    exactly like any other rule, so specificity (not layer order) decides
    between a parent's blind reach (".x *", ".x li") and the child's own atom,
    the same way it did before tiers existed. [Descendant] used to be its own,
    lowest tier - removed: sitting below [Base] unconditionally made an
    ancestor's rule lose to EVERY child atom regardless of specificity, which
    broke five real, more-specific-ancestor patterns ([".list li"],
    [".field input"], [".clearButtonContainer span"], [":where(.stack) > *"],
    [".field button"]) to fix the one (an ancestor selector genuinely tied in
    specificity with a child's own atom, e.g. ".x *" tied at (0,1,0)) it was
    meant for. {!sort_by_shorthand_first} now protects that one case instead, by
    emitting descendant-shaped rules before own-element rules within whichever
    tier they land in, so a genuine specificity TIE still resolves to the child
    (later rule wins a tie); a real specificity difference is untouched by
    stylesheet position either way. [Conditional] when [rule_text] only applies
    under some extra condition beyond the plain presence of its own element:
    wrapped in an at-rule ([@media]/[@supports]/[@container] are the only ones
    that ever wrap an atom class - [@property]/[@keyframes]/[@font-face]/
    [%styled.global] rules carry no atom class at all and never reach this
    function, see the "no atom class" filter in {!run} below), or a
    pseudo-class/pseudo-element attached DIRECTLY to the atom's own compound
    selector (".x:hover", ".x::before", chained
    ".x:focus-visible:not(:disabled)"). [Base] otherwise, including a
    descendant/child selector whose subject DOES carry its own class (".x
    .id-...", ".x .tiptap" - see {!is_descendant_shape}'s doc) and any rule with
    no combinator at all. *)
type tier =
  | Base
  | Conditional

let rule_tier rule_text =
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
      else Base)

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

(** One rendered rule's own shorthand depth (see [Slot_key.depth_of]): the
    MINIMUM depth over every property its own declaration(s) touch - read from
    the rendered TEXT (generate.ml never sees the ppx's AST or a [Slot_key.t]).
    A bundle or family-atom group's several declarations can touch several
    different properties at once (no single [Slot_key.t] could represent that -
    see [Slot_key.t.bundle]'s doc), so there is no single "this rule's depth"
    fact the way there is for an ordinary, single-property atom; MIN is the
    choice that keeps the sort's guarantee correct for the SHALLOWEST
    declaration in the rule - at the cost of not being fully correct for a rule
    that mixes depths at all (see below). A rule with a depth-0 declaration (a
    plain shorthand, or an ordinary leaf like "color") MUST sort no later than
    anything that could override just that one declaration through a shallower
    or equal path, regardless of what ELSE is in the same rule - using the
    group's deepest (MAX) declaration instead would let a genuinely shallow
    declaration sort too LATE, keyed off an unrelated, deeper sibling in the
    same bundle, and end up winning a cascade fight it should have lost: a
    bundle of `margin-top: 0;` (depth 1) + `padding: 4px;` (depth 0) sorting by
    MAX (1) would land AFTER a `padding-top: 0;` atom (depth 1) that exists
    specifically to override this bundle's own `padding: 4px;` - putting the
    wide shorthand LATER than the narrow override it needs to lose to, exactly
    backwards. MIN (0 here) keeps it sorting no later than any depth-0 rule, so
    `padding-top: 0;` (depth 1) still lands after it and wins, same as it would
    for a lone atom.

    This is not fully correct for the OTHER declaration in that same bundle:
    `margin-top: 0;` is now keyed as if it were depth 0 too (the group's MIN),
    so a `margin: 10px;` atom elsewhere (depth 0, genuinely wider than
    `margin-top`) is no longer guaranteed to sort before this bundle's
    `margin-top: 0;` the way it would if `margin-top` sorted honestly at its own
    depth 1 - a real, accepted limitation: a multi-declaration rule that mixes
    depths cannot be correctly ordered against every OTHER rule simultaneously,
    only against rules competing for its shallowest declaration's own property.
    An empty or unparseable block (should not happen for a real atom, see
    [innermost_declaration_block]) has no properties to take a minimum over;
    treated as depth 0, the same safe direction MIN already protects. *)
let rule_depth rule_text =
  match innermost_declaration_block rule_text with
  | None -> 0
  | Some block ->
    (match
       property_names_in_block block
       |> List.map (fun property ->
         Slot_key.depth_of (Slot_key.normalize_property property))
     with
    | [] -> 0
    | d :: ds -> List.fold_left min d ds)

(** Sort key: descendant-shape first (see {!is_descendant_shape}'s doc),
    shorthand depth (see [Slot_key.depth_of]/{!rule_depth}) second - a TOTAL key
    computed once per rule, not a pairwise "do these two rules share a family"
    comparison. The earlier pairwise comparator returned "equal" for any two
    rules that share no property family, which is not transitive (two rules the
    comparator calls "equal" to a common third rule need not be equal to EACH
    OTHER), so [List.stable_sort] - a comparison sort, which only guarantees a
    correct order for a comparator that is a genuine strict weak ordering -
    could leave a shorthand stranded after its own longhand whenever enough
    family-unrelated rules sat between them in the pre-sort list (see
    tiers-shorthand-sort.t's stress-test cram case for a reproduction: 5 of 9
    checked pairs came out wrong in a 30-rule shuffle). A per-rule depth is a
    plain integer, so comparing it is always transitive by construction -
    [List.stable_sort]'s guarantee actually holds now.

    Depth reorders some genuinely UNRELATED rules relative to each other too
    (two rules at different depths that do not override each other at all -
    different properties, no shorthand relation between them), but that
    reordering can never change a winner: two rules only ever compete for the
    same computed property through a shorthand relationship (one sets the
    other's value directly, or via a longhand-of-a-longhand chain), and depth is
    defined exactly along that chain - shallower is always the more general
    declaration - so any two rules that DO compete are always ordered
    shallow-then-deep by this key; two rules that do not compete have no cascade
    winner for stylesheet position to protect in the first place, so reordering
    them is harmless by definition.

    Descendant-shape is primary, not depth, because the two guarantees are
    almost never both live for the same pair - a descendant rule and the child's
    own atom rarely share a property too - and on the rare pair where they would
    disagree (an ancestor's rule is itself a shallower shorthand than the
    child's own deeper longhand, or vice versa), protecting the child from an
    unrelated ancestor's blind reach (the case the [Descendant] tier's removal
    above needed a replacement for) is the invariant that removal exists for, so
    it must not be overridden by depth's narrower concern (restoring one
    binding's own shorthand-then-longhand override intent across atoms
    `CSS.merge` can't see inside a bundle to compare directly). Rules that are
    equally descendant-shaped (both, or neither) fall through to depth. *)
let compare_descendant_first_then_depth (is_descendant_a, depth_a, _)
  (is_descendant_b, depth_b, _) =
  if is_descendant_a <> is_descendant_b then
    compare is_descendant_b is_descendant_a
  else compare depth_a depth_b

(** Sort [rules] by {!compare_descendant_first_then_depth}, precomputing each
    rule's descendant-shape and depth once ("decorate-sort-undecorate") instead
    of re-parsing its text on every comparison a stable sort makes. *)
let sort_by_shorthand_first rules =
  rules
  |> List.map (fun rule_text ->
    is_descendant_shape rule_text, rule_depth rule_text, rule_text)
  |> List.stable_sort compare_descendant_first_then_depth
  |> List.map (fun (_, _, r) -> r)

(** Collect, index, resolve, dedup, output. *)
let run ~output_file ~order input_files =
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
  let inputs =
    match order with
    | Dependency -> order_by_dependency inputs
    | Source -> inputs
  in

  (* Resolve all rules across all inputs, collecting errors with locations. *)
  let errors =
    ref (List.concat_map (fun input -> input.protocol_errors) inputs)
  in
  let resolved_rules = ref [] in
  List.iter
    (fun input ->
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
          else resolved_rules := resolved :: !resolved_rules)
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
    |> List.filter (fun rule ->
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
  let import_rules, rest = List.partition is_import_statement ordered_rules in
  let namespace_rules, other_rules =
    List.partition is_namespace_statement rest
  in
  let statement_rules = import_rules @ namespace_rules in

  (* Cascade tiers: split [other_rules] into what takes no part in tiering
     ([@property]/[@keyframes]/[@font-face] registrations and a literal
     [@layer] at-rule - see [is_registration_rule] - never atom-classed, and
     never style rules that compete for an element either) and what does - a
     [%styled.global] style rule, ALSO never atom-classed but a real,
     cascading rule (`html{...}`, `*{...}`, `*::before{...}`, an author's own
     global selector), is [global]; every real atom, [_a_] or [_in_] alike,
     is [base] or [conditional] (no separate [descendant] tier - see
     [rule_tier]'s doc for why it was removed: a descendant-shaped rule
     stays in the tier of its own context instead, and
     {!sort_by_shorthand_first} orders it before own-element rules within
     that tier). Emission order below is [global], then [base], then
     [conditional] - each group independently sorted by
     {!sort_by_shorthand_first} - with no CSS layer around any of them:
     specificity decides first, exactly as in plain CSS, position only as
     the tie-break (see "Cascade tiers" above for the accepted
     consequences). *)
  let registrations, atomless_style_rules =
    List.partition is_registration_rule other_rules
  in
  let global_rules, tier_eligible_rules =
    List.partition
      (fun rule -> atom_class_name rule = None)
      atomless_style_rules
  in
  let base_rules, conditional_rules =
    List.partition (fun rule -> rule_tier rule = Base) tier_eligible_rules
  in

  let minify = production_mode inputs in
  Logger.info "environment: %s"
    (if minify then "production (from [@@@css.config])" else "development");
  let stylesheet =
    let separator = if minify then "" else "\n" in
    let buffer = Buffer.create 1024 in
    Buffer.add_string buffer
      "/* This file is generated by styled-ppx, do not edit manually */\n";
    let emit rule =
      Buffer.add_string buffer rule;
      Buffer.add_string buffer separator
    in
    List.iter emit statement_rules;
    List.iter emit registrations;
    List.iter emit (sort_by_shorthand_first global_rules);
    List.iter emit (sort_by_shorthand_first base_rules);
    List.iter emit (sort_by_shorthand_first conditional_rules);
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
  let rec parse acc ~output_file ~log_level ~order = function
    | "-o" :: file :: rest
    | "-output" :: file :: rest
    | "--output" :: file :: rest ->
      parse acc ~output_file:(Some file) ~log_level ~order rest
    | "--log" :: level :: rest ->
      (match Logger.level_of_string level with
      | Some log_level -> parse acc ~output_file ~log_level ~order rest
      | None ->
        Logger.error
          "invalid --log level %S (expected \"error\", \"warning\", \"info\" \
           or \"debug\")"
          level;
        exit 2)
    | "--debug" :: rest ->
      parse acc ~output_file ~log_level:Logger.Debug ~order rest
    | "--order" :: "dependency" :: rest ->
      parse acc ~output_file ~log_level ~order:Dependency rest
    | "--order" :: "source" :: rest ->
      parse acc ~output_file ~log_level ~order:Source rest
    | "--order" :: mode :: _ ->
      Logger.error
        "invalid --order value %S (expected \"dependency\" or \"source\")" mode;
      exit 2
    | [ (("-o" | "-output" | "--output" | "--log" | "--order") as flag) ] ->
      Logger.error "missing value for flag %S" flag;
      exit 2
    | arg :: _ when String.length arg > 0 && arg.[0] = '-' ->
      Logger.error "unknown flag %S" arg;
      exit 2
    | arg :: rest -> parse (arg :: acc) ~output_file ~log_level ~order rest
    | [] -> List.rev acc, output_file, log_level, order
  in
  let tail = match Array.to_list args with [] -> [] | _ :: t -> t in
  parse [] ~output_file:None ~log_level:Logger.Warning ~order:Dependency tail

let () =
  let input_files, output_file, log_level, order = parse_args Sys.argv in
  Logger.set_level log_level;
  run ~output_file ~order input_files
