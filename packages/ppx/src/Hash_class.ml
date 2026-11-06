(* Hash_class
   ==========

   Single source of truth for the identifiers that the static-extraction
   pipeline mints: atom classes, binding ids, interpolation variables,
   keyframe names and global keys.

   Separator
   ---------
   Composite hash inputs are joined with NUL ('\000') so that ["a"; "bc"] and
   ["ab"; "c"] cannot hash to the same value. NUL never appears in CSS source,
   selectors, or OCaml module paths.

   Identifier families
   -------------------
     atom class   `_a|_c|_x|_b<ids><hash64>`               (atom_class)
     binding id   `_i<hash64(bind \0 library \0 module \0 scope \0 name \0 n)>`
                                                           (binding_id)
     variable     `<prefix>-<murmur2(namespace \0 path \0 type_key)>` (variable)
     occurrence   `<variable>_<n>` when a name repeats in one declaration
     keyframes    `keyframe-<murmur2(body)>`               (keyframe_name)
     global key   `global-<murmur2(rule)>`                 (global_key)
     scoped ns    `<kind> \0 <module> \0 <scope> \0 <murmur2(rules)>`
                                                           (scoped_namespace)

   The variable namespace of an atom is its class token, so a variable is a
   pure function of the atom. Keyframes and [%styled.global] blocks are not
   atomized; their variables are namespaced by [scoped_namespace].

   The [module] component is the compilation-unit module name (the source
   file's basename, capitalized - see [ppx.re]'s [module_name_of_file]), NOT
   the physical file path. One module is routinely compiled twice from
   different paths (Dune `copy_files` into a Melange build dir, vendoring, a
   native SSR build and a Melange client build). The module name is identical
   across all of those paths, so both builds mint the same names.

   Stability contract
   ------------------
   These formats are an on-disk contract. Changing a prefix, the separator,
   the hash function, or the field order rewrites every class and variable
   name, which invalidates the cram snapshots and any already-shipped
   stylesheet. *)

let hash = Murmur2.default

(* NUL-join the fields of a composite hash input (see "Separator" above). *)
let nul_join parts = String.concat "\000" parts
let atom_class unit_ = Property_class_mint.Mint.token unit_

let binding_id_input ~library ~module_name ~scope ~name ~occurrence =
  nul_join
    [
      "bind";
      library;
      module_name;
      String.concat "." scope;
      name;
      string_of_int occurrence;
    ]

(* [occurrence] separates bindings that share [scope] and [name] (shadowing).
   [module_name] is path-independent, as in [scoped_namespace]. *)
let binding_id ~library ~module_name ~scope ~name ~occurrence =
  let input = binding_id_input ~library ~module_name ~scope ~name ~occurrence in
  Property_class_core.Css_class_format.encode_binding_id
    (Property_class_mint.Hash64.chars (Property_class_mint.Hash64.hash input) 8)

(* The hash input of [binding_id], NUL and backslash escaped as in
   [Property_class_mint.Mint.hashes]. *)
let binding_id_source ~library ~module_name ~scope ~name ~occurrence =
  let buf = Buffer.create 64 in
  String.iter
    (function
      | '\\' -> Buffer.add_string buf "\\\\"
      | '\000' -> Buffer.add_string buf "\\0"
      | c -> Buffer.add_char buf c)
    (binding_id_input ~library ~module_name ~scope ~name ~occurrence);
  Buffer.contents buf

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
