(* CSS.merge's removal rule, exercised end to end: real atom class names
   from Class_format.slot_class (the ppx-side encoder) fed into the real
   runtime CSS.merge (Merge_key, the runtime-side decoder) - proving the
   two independently-implemented halves of this protocol agree, not just
   that Merge_key's own parser round-trips a hand-rolled string. *)

module Driver = Styled_ppx_css_parser.Driver
module Ast = Styled_ppx_css_parser.Ast
module Render = Styled_ppx_css_parser.Render

let atom_of css : Ast.rule =
  match
    Driver.parse_declaration_list ~source_position_start:Lexing.dummy_pos css
  with
  | Error (_loc, msg) ->
    failwith (Printf.sprintf "parse error in %S: %s" css msg)
  | Ok (rules, _) ->
    (match rules with
    | [ rule ] -> rule
    | _ ->
      failwith
        (Printf.sprintf "expected exactly one atom in %S, got %d" css
           (List.length rules)))

(* The real atom class for one declaration - the same recipe
   [Hash_class.class_and_namespace] uses once [Class_format] is wired in
   (context/family/mask/value fields, no shorthand table). *)
let class_of css =
  let rule = atom_of css in
  let slot = Slot_key.of_atom rule |> Option.get in
  Class_format.slot_class slot (Render.rule rule)

let make css = CSS.make (class_of css) []

(* -- The Faq repro (merge-order-flip-under-dedup.md) --------------------

   `Faq.content = height: auto`, `Faq.collapsed = height: 0`,
   `answer = CSS.merge content collapsed`. Under content-hash dedup, an
   unrelated module's `height: auto` atom (e.g. `Unrelated.image`) can be
   minted before `Faq.content`'s, so which of `height:auto`/`height:0`
   wins depends on stylesheet position, not on this `merge` call's own
   argument order - collapsed FAQ answers render open. The fix: `answer`'s
   className must contain ONLY `collapsed`'s atom regardless of stylesheet
   position, because `content`'s atom is dropped by the merge call
   itself, before any stylesheet position is even decided. *)
let faq_repro () =
  let content = make "height: auto;" in
  let collapsed = make "height: 0;" in
  let answer = CSS.merge content collapsed in
  Alcotest_extra.assert_string (CSS.className answer) (class_of "height: 0;")

(* -- The CaptionNumber repro (same doc, same shape, different property) *)
let caption_number_repro () =
  let default = make "background-color: #333;" in
  let accented = make "background-color: #f60;" in
  let styles = CSS.merge default accented in
  Alcotest_extra.assert_string (CSS.className styles)
    (class_of "background-color: #f60;")

(* -- shorthand vs longhand: both directions, only one is the accepted
   limit -------------------------------------------------------------- *)

(* A later shorthand safely absorbs an earlier lone longhand it covers -
   the normal case, not a limit: margin's mask is [None] ("full"), which
   is a superset of margin-top's single-leaf mask. *)
let longhand_then_shorthand_drops_longhand () =
  let narrow = make "margin-top: 0;" in
  let wide = make "margin: 10px;" in
  let merged = CSS.merge narrow wide in
  Alcotest_extra.assert_string (CSS.className merged) (class_of "margin: 10px;")

(* The accepted limit: a lone longhand cannot remove an earlier shorthand
   - doing so would silently drop the shorthand's other legs. Both
   classes survive; which one the browser applies still depends on
   stylesheet position, exactly as the plan's "accepted limit" pins. *)
let shorthand_then_longhand_keeps_both () =
  let wide = make "margin: 10px;" in
  let narrow = make "margin-top: 0;" in
  let merged = CSS.merge wide narrow in
  Alcotest_extra.assert_string (CSS.className merged)
    (Printf.sprintf "%s %s" (class_of "margin: 10px;")
       (class_of "margin-top: 0;"))

(* -- :hover and @media contexts ------------------------------------------

   Same property, same selector/at-rule context: merges exactly like the
   base case. Same property, DIFFERENT context: never merges - context
   is a real differentiator, not accidentally ignored. *)
let hover_context_merges_like_base () =
  let former = make "&:hover{color: red;}" in
  let latter = make "&:hover{color: blue;}" in
  let merged = CSS.merge former latter in
  Alcotest_extra.assert_string (CSS.className merged)
    (class_of "&:hover{color: blue;}")

let media_context_merges_like_base () =
  let former = make "@media (max-width:600px){color: red;}" in
  let latter = make "@media (max-width:600px){color: blue;}" in
  let merged = CSS.merge former latter in
  Alcotest_extra.assert_string (CSS.className merged)
    (class_of "@media (max-width:600px){color: blue;}")

let different_contexts_never_merge () =
  let base = make "color: red;" in
  let hovered = make "&:hover{color: blue;}" in
  let merged = CSS.merge base hovered in
  Alcotest_extra.assert_string (CSS.className merged)
    (Printf.sprintf "%s %s" (class_of "color: red;")
       (class_of "&:hover{color: blue;}"))

(* -- !important: folded into the context, so a plain atom and its
   !important twin never remove each other in either direction, even for
   the identical property; same importance on both sides still merges
   normally. *)
let mismatched_importance_never_merges () =
  let plain = make "color: red;" in
  let important = make "color: blue !important;" in
  let merged = CSS.merge plain important in
  Alcotest_extra.assert_string (CSS.className merged)
    (Printf.sprintf "%s %s" (class_of "color: red;")
       (class_of "color: blue !important;"))

let mismatched_importance_never_merges_reversed () =
  let important = make "color: red !important;" in
  let plain = make "color: blue;" in
  let merged = CSS.merge important plain in
  Alcotest_extra.assert_string (CSS.className merged)
    (Printf.sprintf "%s %s"
       (class_of "color: red !important;")
       (class_of "color: blue;"))

let matched_importance_merges_normally () =
  let former = make "color: red !important;" in
  let latter = make "color: blue !important;" in
  let merged = CSS.merge former latter in
  Alcotest_extra.assert_string (CSS.className merged)
    (class_of "color: blue !important;")

(* -- custom properties: same name merges (family + extended hash agree);
   different names never do (different extended hash). *)
let same_custom_property_merges () =
  let former = make "--brand-color: red;" in
  let latter = make "--brand-color: blue;" in
  let merged = CSS.merge former latter in
  Alcotest_extra.assert_string (CSS.className merged)
    (class_of "--brand-color: blue;")

let different_custom_properties_never_merge () =
  let foo = make "--foo: red;" in
  let bar = make "--bar: blue;" in
  let merged = CSS.merge foo bar in
  Alcotest_extra.assert_string (CSS.className merged)
    (Printf.sprintf "%s %s" (class_of "--foo: red;") (class_of "--bar: blue;"))

(* -- merge of merges (associativity): a chain of merges must reach the
   same result a single pass over every atom would, not just agree
   pairwise. `a` (base, unrelated slot) survives every merge in the
   chain; `b` and `c` share `b`'s slot (same selector, both !important)
   so `c` drops `b`, however many merges apart they are called. *)
let merge_of_merges_is_associative () =
  let a = make "color: red;" in
  let b = make "&:hover{color: green !important;}" in
  let c = make "&:hover{color: blue !important;}" in
  let chained = CSS.merge (CSS.merge a b) c in
  Alcotest_extra.assert_string (CSS.className chained)
    (Printf.sprintf "%s %s" (class_of "color: red;")
       (class_of "&:hover{color: blue !important;}"))

(* -- Merge_key's own hardcoded constants, cross-checked against the real
   Slot_key/Class_format values, not just against a comment. Merge_key
   cannot depend on Slot_key for real (see its own doc comment: it ships
   in the melange browser bundle), so its five family-marker constants
   are a deliberate, narrow duplication - this is the test that catches
   them drifting if the registry ever grows past today's seed or the
   family field's width ever changes. *)
let base36 n = Class_format.to_base36_padded ~width:Class_format.family_width n

let marker_hardcoded_constants_match_real_registry () =
  let real_direction =
    base36 (Slot_key.family_marker (Slot_key.family_id_of "direction"))
  in
  let real_unicode_bidi =
    base36 (Slot_key.family_marker (Slot_key.family_id_of "unicode-bidi"))
  in
  let real_all =
    base36 (Slot_key.family_marker (Slot_key.family_id_of "all"))
  in
  let real_custom_marker =
    base36
      (Slot_key.family_marker (Slot_key.family_id_of "--any-custom-property"))
  in
  Alcotest_extra.assert_string Merge_key.direction_marker real_direction;
  Alcotest_extra.assert_string Merge_key.unicode_bidi_marker real_unicode_bidi;
  Alcotest_extra.assert_string Merge_key.all_sentinel real_all;
  Alcotest_extra.assert_string Merge_key.unregistered_custom_marker
    real_custom_marker

let tests =
  [
    Alcotest_extra.test
      "Merge_key's hardcoded direction/unicode-bidi/all/custom-marker \
       constants match the real Slot_key registry"
      marker_hardcoded_constants_match_real_registry;
    Alcotest_extra.test
      "Faq repro: merge(content, collapsed) is collapsed alone, independent of \
       stylesheet position"
      faq_repro;
    Alcotest_extra.test "CaptionNumber repro: same shape, background-color"
      caption_number_repro;
    Alcotest_extra.test
      "a later shorthand drops an earlier lone longhand it covers (not a limit)"
      longhand_then_shorthand_drops_longhand;
    Alcotest_extra.test
      "accepted limit: an earlier shorthand is NOT dropped by a later lone \
       longhand - both survive"
      shorthand_then_longhand_keeps_both;
    Alcotest_extra.test
      "same property under &:hover merges like the base context"
      hover_context_merges_like_base;
    Alcotest_extra.test
      "same property under @media merges like the base context"
      media_context_merges_like_base;
    Alcotest_extra.test
      "different contexts (base vs &:hover) never merge, same property"
      different_contexts_never_merge;
    Alcotest_extra.test
      "a plain atom and its !important twin never merge, in either direction \
       (plain former)"
      mismatched_importance_never_merges;
    Alcotest_extra.test
      "a plain atom and its !important twin never merge, in either direction \
       (important former)"
      mismatched_importance_never_merges_reversed;
    Alcotest_extra.test "two !important atoms of the same slot merge normally"
      matched_importance_merges_normally;
    Alcotest_extra.test "the same custom property name merges normally"
      same_custom_property_merges;
    Alcotest_extra.test "different custom property names never merge"
      different_custom_properties_never_merge;
    Alcotest_extra.test
      "merge of merges is associative: a chain reaches the same result a \
       single pass over every atom would"
      merge_of_merges_is_associative;
  ]
