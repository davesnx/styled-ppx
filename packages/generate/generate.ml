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
    coincide (same module basename, submodule path and binding name in two
    libraries) but whose atomized content differs. Two entries with the SAME
    identity and the SAME [class_string] are not a collision — that's the same
    module compiled twice (native + melange [copy_files], vendoring), which is
    expected and benign. *)
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
       but carry different CSS (%S vs %S). An identity hashes only the module \
       name, the submodule path and the binding name, so two libraries that \
       each define %s share it. Rename the module or the binding in one of \
       them."
      other_longident other_filename entry.longident filename entry.identity
      other_class_string entry.class_string entry.longident

  (* [`Malformed] is a payload the PPX could not have produced (a decode
     failure); [`Collision] is a well-formed payload that names a real
     identity collision. The two read very differently to whoever hits them,
     so the caller reports them with different wording. *)
  let add_from_payload ~filename (idx : t) payload :
    (unit, [ `Malformed of string | `Collision of string ]) result =
    match Css_extraction.decode_bindings_payload payload with
    | Error msg -> Error (`Malformed msg)
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
      | msgs -> Error (`Collision (String.concat "; " msgs)))
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
  rules : Css_extraction.rule list;
  refs : Refs.ref_loc list;
  env : string option;
  library : string option;
  protocol_errors : string list;
  references : string list;
  blocks : Css_extraction.block list;
  merges : Css_extraction.merge list;
}

let extract_structure ~filename ~idx structure : input =
  let rules = ref [] in
  let refs = ref [] in
  let env = ref None in
  let library = ref None in
  let protocol_errors = ref [] in
  let blocks = ref [] in
  let merges = ref [] in
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
        | Error (`Malformed msg) ->
          add_protocol_error Css_extraction.bindings_attribute_name msg
        | Error (`Collision msg) ->
          protocol_errors :=
            Printf.sprintf "%s: %s" filename msg :: !protocol_errors)
      | [%stri [@@@css.blocks [%e? value]]] ->
        (match Css_extraction.decode_blocks_payload value with
        | Ok entries -> blocks := List.rev_append entries !blocks
        | Error msg ->
          add_protocol_error Css_extraction.blocks_attribute_name msg)
      | [%stri [@@@css.merges [%e? value]]] ->
        (match Css_extraction.decode_merges_payload value with
        | Ok entries -> merges := List.rev_append entries !merges
        | Error msg ->
          add_protocol_error Css_extraction.merges_attribute_name msg)
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
  let rule_count = List.length !rules in
  let block_count = List.length !blocks in
  List.iter
    (fun (block : Css_extraction.block) ->
      if List.exists (fun i -> i < 0 || i >= rule_count) block.rules then
        add_protocol_error Css_extraction.blocks_attribute_name
          (Printf.sprintf "block at line %d names a rule this file lacks"
             block.line))
    !blocks;
  List.iter
    (fun (merge : Css_extraction.merge) ->
      if
        List.exists
          (function
            | Css_extraction.Block i -> i < 0 || i >= block_count
            | Binding _ -> false)
          merge.operands
      then
        add_protocol_error Css_extraction.merges_attribute_name
          (Printf.sprintf "merge at line %d names a block this file lacks"
             merge.merge_line))
    !merges;
  {
    filename;
    rules = List.rev !rules;
    refs = List.rev !refs;
    env = !env;
    library = !library;
    protocol_errors = List.rev !protocol_errors;
    references = Order.references structure;
    blocks = List.rev !blocks;
    merges = List.rev !merges;
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

(** Derive the module name from a file path the way dune does: take the basename
    up to its first [.] and capitalize it. A module name cannot contain [.], so
    this covers [m.ml], [m.re], [m.mlx] and every name dune gives them on the
    way ([m.pp.ml], [m.re.ml], [m.re.pp.ml], [m.mlx.pp.ml]). *)
let module_of_filename filename =
  let base = Filename.basename filename in
  let stem =
    match String.index_opt base '.' with
    | Some i -> String.sub base 0 i
    | None -> base
  in
  String.capitalize_ascii stem

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
    module references), then, within each library, the same per-module
    dependency order used across the whole input set
    ({!order_modules_within_scope}). Both levels reuse {!Order.sort}, so the
    alphabetical tiebreak and the never-fail cycle policy apply at both levels
    for free. *)
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
let check_atom_class_collisions (rules : Css_extraction.rule list) =
  let seen : (string, string) Hashtbl.t = Hashtbl.create 256 in
  List.filter_map
    (fun (rule : Css_extraction.rule) ->
      match rule.key with
      | None -> None
      | Some key when String.starts_with ~prefix:"_in_" key.class_name -> None
      | Some key ->
        (match Hashtbl.find_opt seen key.class_name with
        | Some other when other <> rule.text ->
          Some
            (Printf.sprintf
               "atom class collision: %S and %S both use class %S but render \
                different CSS. The class ends in a %d-character base-36 hash \
                of the declaration (%d values per context, family and mask), \
                so two different declarations can share it by chance. Write \
                one of the two declarations differently (an equivalent value \
                or unit), and report the pair at \
                https://github.com/davesnx/styled-ppx/issues."
               other rule.text key.class_name Class_format.value_width
               (int_of_float (36. ** float_of_int Class_format.value_width)))
        | _ ->
          Hashtbl.replace seen key.class_name rule.text;
          None))
    rules

(* -- Sheet order ---------------------------------------------------------

   Content-hash dedup has no say over WHERE two rules of different bindings
   land relative to each other, and two rules of equal specificity for the
   same property compete by stylesheet position only. So the generator
   orders the style rules itself: [%styled.global] rules first, in source
   and dependency order (hand-written CSS keeps its own order), then every
   atom rule in the order "Ordered sheet" below defines. No CSS layer wraps
   anything: specificity decides first, position only breaks a tie, so a
   [%styled.global] rule with higher specificity than an atom wins outright
   (`global-tier.t`).

   Class hashes take no library name (see `Hash_class.ml`), so two
   libraries that declare the same atom share its class. One run per app
   orders, dedups and collision-checks every library together. Two
   SEPARATE runs (two `<link>`s on one page) have no guaranteed relative
   order between the rules they share (`tiers-two-stylesheets.t`). *)

(** [@property]/[@keyframes]/[@font-face] are registrations, not style rules
    that compete for an element - a [@property] rule is a custom-property
    definition, a [@keyframes] rule is a name lookup, and [@font-face] has no
    per-element cascade to begin with - so none of the three take part in
    ordering; they stay wherever dedup/ordering already placed them, ahead of
    every style rule (see [run] below), exactly as [@import]/[@namespace]
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

(* -- Ordered sheet -------------------------------------------------------

   Atom rules (every [[@@@css]] entry that carries an
   [Css_extraction.atom_key]) are emitted in one topological order. The ppx
   computes each key from the rule's AST; generate reads only the key, never
   the rule text. Two atom rules need a fixed relative order only when they
   COMPETE ({!competes}): the same scope (importance, specificity, the
   element and pseudo-element they style) and at least one shared longhand.
   For any other pair the cascade never reads the sheet position. The order
   comes from, in priority:

   1. Descendant-shaped rules first ([atom_key.descendant]): a parent's
      blind reach (".x > *") loses a specificity tie to the child's own atom.
      Such a rule only competes with rules of the same selector, so this key
      never works against an edge.
   2. Edges. Block edges: in one block's rule list ([[@@@css.blocks]],
      emotion order: the block's declarations, then its nested rules), an
      earlier competing rule comes first. Merge edges: in a [CSS.merge(a,
      b)] or [a +++ b] the ppx resolved ([[@@@css.merges]]), each competing
      rule of [a] comes before each rule of [b].
   3. Definition order (the first time [ordered_rules] lists the rule) for
      every pair the edges leave open.

   There is no "shorthand before a longhand it covers" edge: through an
   unrelated block's longhand in the same context, such an edge can pull a
   merge's later argument ahead of the earlier one
   (`ordered-sheet-monorepo-regressions.t`). [CSS.merge] already drops a
   longhand that a later argument's shorthand covers.

   The sheet is built from its END: among the rules whose successors are all
   placed, the latest by priority is placed next. So a rule keeps its
   definition position unless an edge pulls it ahead of a rule it must
   precede.

   Two blocks or merges that order the same two rules in opposite directions
   are a conflict: generate warns, names both, drops both edges and keeps
   definition order for that pair. A longer cycle is cut at one rule, with a
   warning that names the blocks and merges whose order it drops. *)

type order_stats = {
  conflicts : int;  (** pairs two orders put in opposite directions *)
  cycles : int;  (** cycles cut at one rule each *)
}

(** Two rules compete when the sheet position can decide between them: the
    cascade reaches position only after importance and specificity, and only for
    rules that style the same element and set the same longhand. *)
let competes (a : Css_extraction.atom_key) (b : Css_extraction.atom_key) =
  String.equal a.scope b.scope && Css_extraction.overlaps a b

(** Order [atoms] (atom rule texts and keys, in definition order) as described
    in "Ordered sheet" above. [orders] is every block and merge: its name and
    its groups of rule indices into [atoms], in order. Each competing rule of a
    group comes before each rule of a later group. *)
let order_atom_rules ~(orders : (string * int list list) list)
  (atoms : (string * Css_extraction.atom_key) array) =
  let n = Array.length atoms in
  let text i = fst atoms.(i) in
  let key i = snd atoms.(i) in
  (* (i, j) -> the order that puts rule i before rule j *)
  let edges : (int * int, string) Hashtbl.t = Hashtbl.create n in
  List.iter
    (fun (name, groups) ->
      let rec add = function
        | [] -> ()
        | group :: later ->
          List.iter
            (fun i ->
              List.iter
                (List.iter (fun j ->
                   if
                     i <> j
                     && competes (key i) (key j)
                     && not (Hashtbl.mem edges (i, j))
                   then Hashtbl.replace edges (i, j) name))
                later)
            group;
          add later
      in
      add groups)
    orders;
  let short text =
    if String.length text <= 80 then text else String.sub text 0 77 ^ "..."
  in
  let conflicts =
    Hashtbl.fold
      (fun (i, j) a acc ->
        match Hashtbl.find_opt edges (j, i) with
        | Some b when i < j -> (i, j, a, b) :: acc
        | _ -> acc)
      edges []
    |> List.sort compare
  in
  List.iter
    (fun (i, j, a, b) ->
      Logger.warning
        "%s and %s put two competing rules in opposite orders (%s and %s); the \
         sheet keeps their definition order"
        a b
        (short (text i))
        (short (text j));
      Hashtbl.remove edges (i, j);
      Hashtbl.remove edges (j, i))
    conflicts;
  (* The sheet is built from its end: a rule is placed once every rule that
     must follow it is placed, and among those the latest by priority goes
     first. So a rule stays at its definition position unless an edge pulls
     it earlier, ahead of a rule it must precede. *)
  let succ = Array.make n [] in
  let pending = Array.make n 0 in
  Hashtbl.iter
    (fun (i, j) _ ->
      succ.(j) <- i :: succ.(j);
      pending.(i) <- pending.(i) + 1)
    edges;
  let priority i = ((if (key i).descendant then 0 else 1) * n) + i in
  let module Ready = Set.Make (Int) in
  let ready = ref Ready.empty in
  Array.iteri
    (fun i p -> if p = 0 then ready := Ready.add (priority i) !ready)
    pending;
  let placed = Array.make n false in
  let result = ref [] in
  let count = ref 0 in
  let place i =
    placed.(i) <- true;
    incr count;
    result := text i :: !result;
    List.iter
      (fun j ->
        if not placed.(j) then begin
          pending.(j) <- pending.(j) - 1;
          if pending.(j) = 0 then ready := Ready.add (priority j) !ready
        end)
      succ.(i)
  in
  let cycles = ref 0 in
  while !count < n do
    match Ready.max_elt_opt !ready with
    | Some p ->
      ready := Ready.remove p !ready;
      place (if p >= n then p - n else p)
    | None ->
      (* A cycle. Place the rule that waits on the fewest edges, then the
         latest by priority, and drop the edges it waits on. *)
      let best = ref (-1) in
      for i = 0 to n - 1 do
        if
          (not placed.(i))
          && (!best < 0
             || compare
                  (pending.(i), -priority i)
                  (pending.(!best), -priority !best)
                < 0)
        then best := i
      done;
      let i = !best in
      let names =
        Hashtbl.fold
          (fun (from, to_) name acc ->
            if from = i && not placed.(to_) then name :: acc else acc)
          edges []
        |> List.sort_uniq String.compare
      in
      incr cycles;
      Logger.warning
        "the orders of %s form a cycle over competing rules; the sheet emits \
         %s after rules they put after it"
        (String.concat ", " names)
        (short (text i));
      pending.(i) <- 0;
      place i
  done;
  !result, { conflicts = List.length conflicts; cycles = !cycles }

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

  (* Resolve all rules across all inputs, collecting errors with locations.
     [resolved] keeps, per input, each rule's resolved form at its index in
     the file ([None] for a dropped [@charset]), so blocks can name rules
     by index. *)
  let errors =
    ref (List.concat_map (fun input -> input.protocol_errors) inputs)
  in
  let resolved =
    List.map
      (fun input ->
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
        let resolve ~on_unresolved ~on_malformed text =
          Css_extraction.resolve_sentinels ~lookup:(Index.lookup idx)
            ~on_unresolved ~on_malformed text
        in
        let ignore_error _ = () in
        ( input,
          input.rules
          |> List.map (fun ({ text; key } : Css_extraction.rule) ->
            let text = resolve ~on_unresolved:on_error ~on_malformed text in
            let key =
              Option.map
                (fun (key : Css_extraction.atom_key) ->
                  Css_extraction.atom_key ~class_name:key.class_name
                    ~scope:
                      (resolve ~on_unresolved:ignore_error
                         ~on_malformed:ignore_error key.scope)
                    ~family:key.family ~mask:key.mask ~descendant:key.descendant)
                key
            in
            if is_charset text then begin
              Logger.warning
                "%s: dropping @charset: the output already starts with a \
                 leading comment, so @charset could never be the first bytes \
                 of the stylesheet; output is UTF-8 regardless."
                input.filename;
              None
            end
            else Some { Css_extraction.text; key })
          |> Array.of_list ))
      inputs
  in

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

     Keeping the first forward occurrence (rather than the last) places
     shared rules at the position dune first encounters them, which makes
     the output stable regardless of which file's later occurrence is
     deduped. *)
  let ordered_rules =
    let seen = Hashtbl.create 64 in
    resolved
    |> List.concat_map (fun (_, rules) ->
      List.filter_map Fun.id (Array.to_list rules))
    |> List.filter (fun (rule : Css_extraction.rule) ->
      if Hashtbl.mem seen rule.text then false
      else begin
        Hashtbl.add seen rule.text ();
        true
      end)
  in

  (match check_atom_class_collisions ordered_rules with
  | [] -> ()
  | msgs ->
    List.iter (fun msg -> Logger.error "%s" msg) msgs;
    exit 1);

  (* Atom rules carry a key; the rest is [%styled.global] CSS,
     [@keyframes] and [@property]. Of the rest, [@import] before
     [@namespace] (Cascade 5), each preserving its own relative order, then
     what takes no part in ordering ([@property]/[@keyframes]/[@font-face]
     registrations and a literal [@layer] at-rule - see
     [is_registration_rule]), then the [%styled.global] style rules in
     source order. Atoms come last, in the ordered-sheet order (see "Sheet
     order" and "Ordered sheet" above). *)
  let atoms, other_rules =
    List.partition_map
      (fun (rule : Css_extraction.rule) ->
        match rule.key with
        | Some key -> Left (rule.text, key)
        | None -> Right rule.text)
      ordered_rules
  in
  let import_rules, rest = List.partition is_import_statement other_rules in
  let namespace_rules, rest = List.partition is_namespace_statement rest in
  let statement_rules = import_rules @ namespace_rules in
  let registrations, global_rules = List.partition is_registration_rule rest in
  let atoms = Array.of_list atoms in
  let atom_index : (string, int) Hashtbl.t =
    Hashtbl.create (Array.length atoms)
  in
  Array.iteri (fun i (text, _) -> Hashtbl.replace atom_index text i) atoms;
  let source filename =
    if String.ends_with filename ~suffix:".pp.ml" then
      String.sub filename 0 (String.length filename - String.length ".pp.ml")
    else filename
  in
  let block_atoms rules (block : Css_extraction.block) =
    List.filter_map
      (fun i ->
        Option.bind rules.(i) (fun (rule : Css_extraction.rule) ->
          Hashtbl.find_opt atom_index rule.text))
      block.rules
  in
  let blocks_of_identity : (string, int list) Hashtbl.t = Hashtbl.create 64 in
  List.iter
    (fun (input, rules) ->
      List.iter
        (fun (block : Css_extraction.block) ->
          match block.identity with
          | Some identity when not (Hashtbl.mem blocks_of_identity identity) ->
            Hashtbl.add blocks_of_identity identity (block_atoms rules block)
          | _ -> ())
        input.blocks)
    resolved;
  let block_orders =
    List.concat_map
      (fun (input, rules) ->
        List.map
          (fun (block : Css_extraction.block) ->
            let name =
              match
                Option.bind block.identity (Hashtbl.find_opt idx.by_identity)
              with
              | Some (longident, _, _) -> longident
              | None ->
                Printf.sprintf "%s:%d" (source input.filename) block.line
            in
            let members =
              block_atoms rules block
              |> List.fold_left
                   (fun acc i -> if List.mem i acc then acc else i :: acc)
                   []
              |> List.rev
            in
            "block " ^ name, List.map (fun i -> [ i ]) members)
          input.blocks)
      resolved
  in
  (* A rule of one merge argument whose class a later argument drops at run
     time ([Merge_key.removes], what [CSS.merge] applies) takes no part in
     the merge's order. *)
  let survivors operands =
    let atom_of i = Merge_key.parse_atom (snd atoms.(i)).class_name in
    let rec go = function
      | [] -> []
      | operand :: later ->
        let later_atoms = List.concat_map (List.filter_map atom_of) later in
        let survives i =
          match atom_of i with
          | None -> true
          | Some former ->
            not
              (List.exists
                 (fun latter -> Merge_key.removes ~former ~latter)
                 later_atoms)
        in
        List.filter survives operand :: go later
    in
    go operands
  in
  let merge_orders =
    List.concat_map
      (fun (input, rules) ->
        let blocks = Array.of_list input.blocks in
        List.map
          (fun (merge : Css_extraction.merge) ->
            ( Printf.sprintf "merge at %s:%d" (source input.filename)
                merge.merge_line,
              List.filter_map
                (function
                  | Css_extraction.Block i ->
                    Some (block_atoms rules blocks.(i))
                  | Binding longident ->
                    Option.bind
                      (Index.lookup idx longident)
                      (Hashtbl.find_opt blocks_of_identity))
                merge.operands
              |> survivors ))
          input.merges)
      resolved
  in
  let atom_rules, stats =
    order_atom_rules ~orders:(block_orders @ merge_orders) atoms
  in
  if stats.conflicts + stats.cycles > 0 then
    Logger.info "ordered sheet: %d conflict(s), %d longer cycle(s)"
      stats.conflicts stats.cycles;

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
    List.iter emit global_rules;
    List.iter emit atom_rules;
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
