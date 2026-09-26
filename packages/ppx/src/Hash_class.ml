(* Hash_class
   ==========

   Single source of truth for every *hashed identifier* that styled-ppx's
   static-extraction pipeline emits - the atomic class names, the variable
   namespaces, the `var(--...)` custom-property names, the occurrence
   suffixes, and the `@keyframes` / `[%styled.global]` keys.

   Before this module those recipes were scattered across `Css_file.re` (the
   class hash near the top, the `var(--...)` hash next to it, the keyframe
   name ~1000 lines down, the global key just below). Because the *class
   name* and the *variable baked inside that class* were computed far apart
   from different inputs, it was easy for them to drift out of sync - exactly
   the bug that emitted `.css-8rqac1-header{background-color:var(--var-...)}`
   rules that disagreed on their variable across modules, leaving elements
   pointing at undefined custom properties. Keeping the recipes side by side
   makes the invariants below auditable in one place.

   The hash primitive
   ------------------
   [hash] is murmur2, the same algorithm emotion uses, so the class names
   styled-ppx mints line up with the wider CSS-in-JS ecosystem and with the
   runtime's own hashing. Every identifier here is `<prefix>-<murmur2(...)>`.

   Separator
   ---------
   Composite hash inputs are joined with NUL ('\000') instead of a printable
   character so that, e.g., ["a"; "bc"] and ["ab"; "c"] cannot hash to the
   same value. NUL never appears in CSS source, selectors, or OCaml module
   paths, so it is an unambiguous field separator.

   The emitted identifier families
   -------------------------------
     class name   `_a_<context?><family><mask?><value>`    (class_and_namespace,
                  or `_a_<hash(content)>` for a rule shape   via Class_format.slot_class)
                  with no {!Slot_key.t} (should not happen
                  for a real atom - see {!class_of_content})
     namespace    `css-<hash(content)>`                    (namespace_of_content)
                  NOT the class name (see "Class vs. namespace prefixes"
                  below) - the same hash input, but its own literal prefix
                  never changes; the seed for its vars
     variable     `var-<hash(namespace \0 path \0 type_key)>`   (variable)
     occurrence   `<variable>_<n>` when a name repeats in one declaration
     identity     `_id_<hash(cli_namespace \0 module \0 scope \0 name
                  [\0 occurrence])>`                    (identity_class)
                  build-independent handle for a named binding; never a
                  path or dune library name
     keyframes    `_k_<hash(body)>`                        (keyframe_name)
     global key   `global-<hash(rule)>`                    (global_key)
     scoped ns    `<kind> \0 <module> \0 <scope> \0 <hash(rules)>` (scoped_namespace)

   The atomic invariant this module protects
   ------------------------------------------
   Atomic CSS requires "one class name <=> one exact declaration body". The
   class name already honours that - its VALUE field is a pure hash of the
   rendered declaration, unique within its (context, family[, mask]) bucket
   (see {!Class_format}'s doc comment; two atoms in different buckets never
   need to be told apart by the value field alone, since the bucket fields
   already differ). The *variable* substituted into that declaration must
   honour the same invariant too: otherwise two modules that emit the
   byte-identical `._a_<h>-header{background-color:var(--...)}` rule can
   disagree on the `var(--...)` target, and an element that sets one
   variable ends up matched by a rule that reads the other -> undefined
   custom property -> missing style.

   [class_and_namespace] therefore derives the variable namespace from the
   atom's *own content* alone, via {!namespace_of_content} - deliberately
   NOT from the class name's context/family/mask fields, even though both
   are computed from the same atom. A namespace that also varied with the
   slot would still satisfy the invariant, but would needlessly rename a
   variable whenever the SAME rendered content happened to land in a
   different (context, family[, mask]) bucket - the invariant only
   requires "same content -> same variable", not "same slot -> same
   variable". That makes every variable a pure function of the rendered
   atom content, independent of the enclosing binding, its sibling
   declarations, the file, and the scope. Identical rendered atoms get
   identical class names AND identical variables everywhere they appear.

   [scoped_namespace] is the deliberate exception. Keyframes and
   [%styled.global] blocks are not atomized: they carry their own explicit
   names / selectors, so their variables are namespaced by
   kind + module + scope + rendered-rules instead of by a single atom's
   content. They are therefore not subject to the cross-module class/var
   collision above.

   The [module] component is the compilation-unit module name (the source
   file's basename, capitalized - see [ppx.re]'s [module_name_of_file]), NOT
   the physical file path. This is what protects the cross-BUILD invariant:
   one module is routinely compiled twice from different paths - Dune
   `copy_files` into a Melange build dir, vendoring, or a native (SSR) build
   and a Melange (client) build of the same shared stylesheet. When this was
   keyed on the path, those builds minted DIFFERENT `var(--...)` names for the
   same global/keyframe declaration: the static rule extracted by one build
   referenced a custom property the other build's runtime `:root{}` binding
   never defined, so the declaration silently fell back to its initial value.
   The module name is identical across all of those paths (`copy_files`
   preserves the basename, and the name is taken from the source filename, so
   it ignores Dune library wrapping), so both builds now agree. [scope] (the
   enclosing submodule path) and [hash(rendered_rules)] keep distinct blocks
   apart within a project. Two distinct compilation units that share a
   basename would share a namespace; that is benign - identical content
   *should* yield identical variables (that is the cross-build invariant we
   want), and differing content is already separated by the rules hash.

   Class vs. namespace prefixes
   -----------------------------
   [class_of_content]'s prefix ([_a_]) and [namespace_of_content]'s prefix
   ([css-]) differ, and must go on differing: [namespace_of_content] is a
   hash *input* to [variable] (see [nul_join [namespace; path; type_key]]
   above), so changing its literal string would silently rename every
   already-shipped `var(--...)` custom property for no reason - only the
   class's own presentation needs a prefix a reader recognizes, not the
   seed every variable name is a pure function of. [identity_class] and
   [keyframe_name] carry no such downstream hash consumer (each result is
   a leaf identifier, never fed into another hash - see their own doc
   comments), so their prefixes ([_id_], [_k_]) are free to be whatever is
   most readable.

   Stability contract
   ------------------
   These formats are an on-disk contract. Changing a prefix, the separator,
   the hash function, or the field order rewrites EVERY class and variable
   name, which invalidates the cram snapshots and any already-shipped
   stylesheet. [namespace_of_content]'s prefix is pinned harder than the
   rest: it is a hash input, not just a display string, so it may never
   change without also accepting that every existing `var(--...)` name
   changes with it. *)

let hash = Murmur2.default

(* NUL-join the fields of a composite hash input (see "Separator" above). *)
let nul_join parts = String.concat "\000" parts

(* -- Class names and the atom namespace -------------------------------- *)

(* The variable-namespace seed. Literal prefix pinned to [css-] forever -
   see "Prefix rename" above; never rename this one. *)
let namespace_of_content content = Printf.sprintf "css-%s" (hash content)

(* Fallback class name for {!class_and_namespace} - a plain hash of the
   content, same input as the namespace, only the presentation prefix
   differs (see "Prefix rename"). Reached only when there is no
   {!Slot_key.t} at all, which in practice never happens for a real atom
   (see {!Slot_key.of_atom}'s own doc: it returns [None] only for a rule
   shape [atomize_rules] never actually produces). *)
let class_of_content content = Printf.sprintf "_a_%s" (hash content)

(* An atom's class name and its namespace, from a single content hash - two
   different literal strings sharing one hash input (see the header's
   "atomic invariant"). [namespace] is always the plain content hash - it
   seeds every interpolation variable's name, so it must stay independent
   of merge-key data (see the header's "Prefix rename"/"Stability
   contract"). [class_name] carries the merge-key data instead
   ({!Class_format.slot_class}'s context/family/mask/value fields), built
   from the atom's {!Slot_key.t} - the caller's own [Slot_key.of_atom] on
   the exact same rule value [content] renders (see its doc for why that
   shape match matters).

   [slot.bundle] is always [false] here (see {!Slot_key.t.bundle}'s doc):
   this function is [Css_file.re]'s NON-bundle path - a genuine, two-or-more
   -declaration bundle mints its class directly via {!bundle_class_and_namespace}
   below, never through this function or [Slot_key] at all - so
   [Class_format.slot_class] always takes its real, structural encoding
   here, never its [_in_] branch. *)
let class_and_namespace ~slot content =
  let namespace = namespace_of_content content in
  let class_name =
    match slot with
    | Some (s : Slot_key.t) -> Class_format.slot_class s content
    | None -> class_of_content content
  in
  class_name, namespace

(* Same shape as [class_and_namespace] (a [(class_name, namespace)] pair
   from one content hash), for [Css_file.re]'s bundle path specifically: the
   CLASS half gets the [_in_] prefix (see [Class_format.bundle_class]) so
   `CSS.merge`'s future runtime and `generate`'s atom-class collision check
   can recognize a bundle atom and treat it as opaque - never dropped,
   never dropping another atom, never flagged as a collision even though
   several different declarations from one binding share it by design. The
   NAMESPACE half is deliberately UNCHANGED (still [namespace_of_content],
   `css-<hash>`) - it seeds every interpolation variable's name (see the
   header's "atomic invariant"), and changing it would rename every
   existing bundle's `var(--...)` custom properties for no reason; only
   the class's own presentation needed to change, not the content-hash
   input every variable name is still a pure function of. *)
let bundle_class_and_namespace content =
  Class_format.bundle_class content, namespace_of_content content

(* -- Interpolation variables ------------------------------------------- *)

(* A readable, CSS-identifier-safe prefix for an interpolation's source path.
   Keeps `[A-Za-z0-9_]`, collapses other runs to one `-`, truncates to 40, and
   falls back to "var" when nothing identifier-like survives. The hash suffix
   owns uniqueness, so the prefix is cosmetic.
     color           -> "color"
     Theme.spacing.md -> "spacing-md"   (leading module qualifiers dropped)
     Color.Border.line -> "line"
     props.x          -> "props-x"      (lowercase head is not a module)  *)
let interpolation_name_prefix path =
  (* Drop contiguous leading module segments (uppercase head), keeping the last
     segment. The hash uses the full path, so this never affects identity. *)
  let path =
    let rec drop = function
      | [ last ] -> [ last ]
      | seg :: rest
        when String.length seg > 0 && seg.[0] >= 'A' && seg.[0] <= 'Z' ->
        drop rest
      | segs -> segs
    in
    String.concat "." (drop (String.split_on_char '.' path))
  in
  let buf = Buffer.create (String.length path) in
  let pending_dash = ref false in
  String.iter
    (fun c ->
      let ident =
        (c >= 'a' && c <= 'z')
        || (c >= 'A' && c <= 'Z')
        || (c >= '0' && c <= '9')
        || c = '_'
      in
      if ident then (
        if !pending_dash && Buffer.length buf > 0 then Buffer.add_char buf '-';
        pending_dash := false;
        Buffer.add_char buf c)
      else pending_dash := true)
    path;
  let s = Buffer.contents buf in
  let s = if String.length s > 40 then String.sub s 0 40 else s in
  if s = "" then "var" else s

(* The custom-property name for an interpolation: `<prefix>-<hash>`. [prefix] is
   readable (see [interpolation_name_prefix]); the hash over [namespace], [path]
   and [type_key] owns uniqueness and cross-module identity. Both derive only
   from the source, so the name is identical in dev and prod. [type_key] comes
   from the resolved runtime type, so interpolations differing only by target
   type get distinct variables and serializers. Caller adds the leading `--`. *)
let variable ~namespace ~type_key path =
  Printf.sprintf "%s-%s"
    (interpolation_name_prefix path)
    (hash (nul_join [ namespace; path; type_key ]))

(* As [variable], but when the same interpolation name appears more than once
   within a single declaration each occurrence gets a `_<index>` suffix, so N
   distinct runtime values map to N distinct custom properties. A lone
   occurrence keeps the bare name. [occurrence] is 1-based; [total] is the
   number of times the name appears in the declaration. *)
let variable_for_occurrence ~namespace ~type_key ~occurrence ~total path =
  let name = variable ~namespace ~type_key path in
  if total > 1 then Printf.sprintf "%s_%d" name occurrence else name

(* -- Scoped namespaces, keyframes and globals -------------------------- *)

(* The variable namespace for the non-atomized emitters (keyframes,
   [%styled.global]). Unlike an atom namespace this is module- and
   scope-sensitive:
     `<kind> \0 <module> \0 <scope-dotted> \0 <hash(rendered rules)>`.
   [module_name] is the compilation-unit module name, which is path-
   independent - the same module compiled from two different paths produces
   the same namespace, so a static rule and the runtime `:root{}` binding it
   relies on agree across builds (see the header note). [rendered_rules] are
   the already-serialized rule strings; [scope] is the enclosing submodule
   path. *)
let scoped_namespace ~kind ~module_name ~scope ~rendered_rules =
  let scope_key = String.concat "." scope in
  let rules_key = String.concat "\n" rendered_rules in
  nul_join [ kind; module_name; scope_key; hash rules_key ]

(* `@keyframes` name from its rendered body: `_k_<hash(body)>`. A leaf
   identifier - its variable namespace comes from [scoped_namespace]
   instead (module + scope + rendered-rules, not this string), so renaming
   this prefix cannot rename any `var(--...)` name. A valid CSS
   <custom-ident>: starts with `_`, which is a valid identifier-start
   character, so it needs no escaping in the `@keyframes` name, the
   `animation-name` value that references it, or the runtime
   [CSS.Types.AnimationName] that carries it dynamically. *)
let keyframe_name rendered_body = Printf.sprintf "_k_%s" (hash rendered_body)

(* Dedup key for a single [%styled.global] rule: `global-<hash(rule)>`. *)
let global_key rendered_rule = Printf.sprintf "global-%s" (hash rendered_rule)

(* -- Merge-aware atom class names --------------------------------------

   Not wired into [class_and_namespace] yet - [Css_file.re]'s atomization
   will call [slot_class] instead once it also mints family atoms.
   Implementation lives in the standalone [Class_format] library
   (unit-tested directly there; `packages/ppx/src` is a ppx_rewriter-kind,
   wrapped library whose internal modules aren't cleanly reachable from an
   external test executable) - re-exported here because this file is the
   single source of truth for every hashed identifier this pipeline emits.
   See `packages/ppx/class_format/class_format.mli` for the format. *)
let slot_class = Class_format.slot_class

(* The build-independent identity class for a named binding:
   `_id_<hash(cli_namespace \0 module_name \0 scope \0 name [\0 occurrence])>`.
   A leaf identifier, never fed into another hash, so renaming this prefix
   cannot rename any `var(--...)` name. Inputs are deliberately the ones an
   author writes, never a physical path or dune library name (those differ
   between native and Melange builds of the same source - see the header
   note on [module]). [cli_namespace] is the
   `--namespace` flag value (empty by default), mixed in so two libraries that
   happen to share a module basename and binding name can still be told apart
   (see documents/css-extraction.md, "Identity classes"). [module_name] is the
   compilation-unit module name (as in [scoped_namespace]); [scope] is the
   enclosing submodule path; [name] is the binding name or `[%styled.<tag>]`
   module name. [occurrence] is folded into the hash only when greater than 1,
   so a name seen exactly once keeps a stable identity independent of whether
   a later occurrence of the same (scope, name) ever appears. *)
let identity_class ~namespace ~module_name ~scope ~name ~occurrence =
  let scope_key = String.concat "." scope in
  let parts = [ namespace; module_name; scope_key; name ] in
  let parts =
    if occurrence > 1 then parts @ [ string_of_int occurrence ] else parts
  in
  Printf.sprintf "_id_%s" (hash (nul_join parts))
