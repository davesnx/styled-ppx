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
     scoped ns    `<kind> \0 <file> \0 <scope> \0 <hash(rules)>` (scoped_namespace)

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
   kind + file + scope + rendered-rules instead of by a single atom's content.
   They are therefore not subject to the cross-module class/var collision
   above. (Audit note: identical keyframe/global content in two different
   files still receives different variable names because of the file/scope
   component. Lower risk, since the keyframe name and global selectors are
   explicit rather than content-hashed, but worth revisiting if a cross-file
   collision ever surfaces there.)

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

(* An atom's class name and its namespace, from a single content hash. The
   class name is `<namespace>-<label>` (or just the namespace for an
   anonymous binding); the namespace is label-free on purpose. Returns
   [(class_name, namespace)]. *)
let class_and_namespace ?label content =
  let namespace = namespace_of_content content in
  let class_name =
    match label with
    | Some name -> Printf.sprintf "%s-%s" namespace name
    | None -> namespace
  in
  (class_name, namespace)

(* Just the class name: `css-<hash(content)>[-<label>]`. *)
let class_name ?label content = fst (class_and_namespace ?label content)

(* -- Interpolation variables ------------------------------------------- *)

(* The custom-property name for an interpolation: `var-<hash>`, where the hash
   mixes the owning [namespace], the interpolation [path] (the source text of
   the `$(...)` expression) and a [type_key] discriminator. The caller derives
   [type_key] from the interpolation's resolved runtime type so that two
   interpolations differing only by target type get distinct variables and
   distinct serializers. The leading `--` is added by the caller when it
   writes `var(--<name>)`. *)
let variable ~namespace ~type_key path =
  Printf.sprintf "var-%s" (hash (nul_join [ namespace; path; type_key ]))

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
   [%styled.global]). Unlike an atom namespace this is file- and
   scope-sensitive:
     `<kind> \0 <file> \0 <scope-dotted> \0 <hash(rendered rules)>`.
   [rendered_rules] are the already-serialized rule strings; [scope] is the
   enclosing module path. *)
let scoped_namespace ~kind ~file ~scope ~rendered_rules =
  let scope_key = String.concat "." scope in
  let rules_key = String.concat "\n" rendered_rules in
  nul_join [ kind; file; scope_key; hash rules_key ]

(* `@keyframes` name from its rendered body: `keyframe-<hash(body)>`. *)
let keyframe_name rendered_body =
  Printf.sprintf "keyframe-%s" (hash rendered_body)

(* Dedup key for a single [%styled.global] rule: `global-<hash(rule)>`. *)
let global_key rendered_rule = Printf.sprintf "global-%s" (hash rendered_rule)
