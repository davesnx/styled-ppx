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
     class name   `css-<hash(content)>[-<label>]`          (class_name)
     namespace    `css-<hash(content)>`                    (namespace_of_content)
                  the label-free identity of an atom; the seed for its vars
     variable     `var-<hash(namespace \0 path \0 type_key)>`   (variable)
     occurrence   `<variable>_<n>` when a name repeats in one declaration
     keyframes    `keyframe-<hash(body)>`                  (keyframe_name)
     global key   `global-<hash(rule)>`                    (global_key)
     scoped ns    `<kind> \0 <module> \0 <scope> \0 <hash(rules)>` (scoped_namespace)

   The atomic invariant this module protects
   ------------------------------------------
   Atomic CSS requires "one class name <=> one exact declaration body". The
   class name already honours that - it is a pure hash of the rendered
   declaration. The *variable* substituted into that declaration must honour
   it too: otherwise two modules that emit the byte-identical
   `.css-<h>-header{background-color:var(--...)}` rule can disagree on the
   `var(--...)` target, and an element that sets one variable ends up matched
   by a rule that reads the other -> undefined custom property -> missing
   style.

   [class_and_namespace] therefore derives the variable namespace from the
   atom's *own content* - the same string that backs the class name, with the
   `-<label>` suffix stripped. That makes every variable a pure function of
   the declaration content, independent of the binding's label, its sibling
   declarations, the file, and the scope. Identical declarations get identical
   class names AND identical variables everywhere they appear.

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

   Stability contract
   ------------------
   These formats are an on-disk contract. Changing a prefix, the separator,
   the hash function, or the field order rewrites EVERY class and variable
   name, which invalidates the cram snapshots and any already-shipped
   stylesheet. Keep them in lockstep with the runtime's `css-` / `var-`
   scheme. *)

let hash = Murmur2.default

(* NUL-join the fields of a composite hash input (see "Separator" above). *)
let nul_join parts = String.concat "\000" parts

(* -- Class names and the atom namespace -------------------------------- *)

(* The label-free identity of an atom: `css-<hash(content)>`. This is the
   seed for the atom's interpolation variables, so a variable stays a pure
   function of the declaration content regardless of the binding's label
   (see the invariant in the header). *)
let namespace_of_content content = Printf.sprintf "css-%s" (hash content)

(* A CSS identifier admits only `[A-Za-z0-9_-]` (ignoring escapes and
   non-ASCII). OCaml binding names are wider - notably the trailing prime in
   idiomatic names like [inputView'] - so embedding the label verbatim can
   emit an unmatchable selector (`.css-<hash>-inputView'`, where the `'` is an
   illegal identifier character). We drop every CSS-unsafe character rather
   than backslash-escape it: the returned string backs BOTH the emitted
   `.css-...-label{}` selector AND the runtime `className`, and an escape
   (`'` -> `\'`) would land literally in the `class` attribute while the
   selector matched the unescaped `'`, so the two would never meet. The label
   is a purely cosmetic debug suffix, so stripping loses nothing structural. *)
let css_safe_label name =
  let buffer = Buffer.create (String.length name) in
  String.iter
    (fun c ->
      match c with
      | 'A' .. 'Z' | 'a' .. 'z' | '0' .. '9' | '_' | '-' ->
        Buffer.add_char buffer c
      | _ -> ())
    name;
  Buffer.contents buffer

(* An atom's class name and its namespace, from a single content hash. The
   class name is `<namespace>-<label>` (or just the namespace for an
   anonymous binding, or a label that is empty once sanitized); the namespace
   is label-free on purpose. Returns [(class_name, namespace)]. *)
let class_and_namespace ?label content =
  let namespace = namespace_of_content content in
  let class_name =
    match label with
    | Some name ->
      (match css_safe_label name with
      | "" -> namespace
      | safe -> Printf.sprintf "%s-%s" namespace safe)
    | None -> namespace
  in
  class_name, namespace

(* Just the class name: `css-<hash(content)>[-<label>]`. *)
let class_name ?label content = fst (class_and_namespace ?label content)

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

(* `@keyframes` name from its rendered body: `keyframe-<hash(body)>`. *)
let keyframe_name rendered_body =
  Printf.sprintf "keyframe-%s" (hash rendered_body)

(* Dedup key for a single [%styled.global] rule: `global-<hash(rule)>`. *)
let global_key rendered_rule = Printf.sprintf "global-%s" (hash rendered_rule)
