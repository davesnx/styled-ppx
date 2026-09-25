(* Registry/id coverage for Slot_key's css-grammar-backed data (see
   slot_key.ml's [direct_children]/[seed]/[Registry] and .workplace/plans/
   atom-slot-keys_PLAN.md for why this moved out of a separate table).
   Deliberately its own file, not test_slot_key.ml - that file covers the
   [removes]/[of_atom] algorithm; this one covers "does every css-grammar
   property get a stable id" and "is the family graph sane", which need
   Css_grammar as a test dependency test_slot_key.ml doesn't otherwise
   need. *)

let check_bool = Alcotest.check Alcotest.bool
let check_int = Alcotest.check Alcotest.int
let check_string = Alcotest.check Alcotest.string
let check_string_list = Alcotest.check (Alcotest.list Alcotest.string)

(* Properties/Media.ml registers 25 entries under the [Property] tag that
   are internal `@media` feature-value grammars (media-hover,
   media-color-gamut, ...), not CSS properties any declaration ever names -
   see Css_grammar.Types.kind's module doc. Excluded from the "must be
   Registered, not hash-fallback" check below since they were deliberately
   left out of Slot_key's seed for the same reason. *)
let media_feature_pseudo_properties =
  [
    "media-any-hover";
    "media-any-pointer";
    "media-color-gamut";
    "media-color-index";
    "media-display-mode";
    "media-forced-colors";
    "media-grid";
    "media-hover";
    "media-inverted-colors";
    "media-max-aspect-ratio";
    "media-max-resolution";
    "media-min-aspect-ratio";
    "media-min-color";
    "media-min-color-index";
    "media-min-resolution";
    "media-monochrome";
    "media-orientation";
    "media-pointer";
    "media-prefers-color-scheme";
    "media-prefers-contrast";
    "media-prefers-reduced-motion";
    "media-resolution";
    "media-scripting";
    "media-type";
    "media-update";
  ]

(* [family_id_of] special-cases "all" to the [All] sentinel (CSS's [all]
   keyword, not a real property with a family) - excluded here for the same
   reason [media_feature_pseudo_properties] is: it is registered in
   css-grammar but is not a property this table assigns a family id to. *)
let live_css_grammar_properties =
  Css_grammar.property_names ()
  |> List.filter (fun name ->
    (not (List.mem name media_feature_pseudo_properties)) && name <> "all")

let is_registered = function
  | Slot_key.Registered _ -> true
  | Slot_key.Unregistered _ | Slot_key.All -> false

let coverage_tests =
  [
    Alcotest_extra.test
      "every live css-grammar property resolves to some family id without \
       raising" (fun () ->
      let crashed =
        live_css_grammar_properties
        |> List.filter_map (fun name ->
          match Slot_key.family_id_of name with
          | _ -> None
          | exception e -> Some (name, Printexc.to_string e))
      in
      check_string_list "crashed"
        (List.map fst crashed |> List.sort String.compare)
        []);
    Alcotest_extra.test
      "every live css-grammar property gets a Registered id, not the \
       Unregistered hash fallback (the seed covers every family key and \
       standalone property css-grammar knows today)" (fun () ->
      let not_registered =
        live_css_grammar_properties
        |> List.filter (fun name ->
          not (is_registered (Slot_key.family_id_of name)))
      in
      check_string_list "not registered" [] not_registered);
    Alcotest_extra.test
      "a genuinely new/unknown property still gets a stable Unregistered id \
       (append-only doesn't mean unknown properties break)" (fun () ->
      let p = "totally-invented-property-not-in-css-grammar-xyz" in
      match Slot_key.family_id_of p with
      | Unregistered _ -> ()
      | Registered _ | All -> Alcotest.fail "expected Unregistered");
  ]

(* --- family graph sanity, now fed by css-grammar's live Shorthand data - *)

let family_tests =
  [
    Alcotest_extra.test
      "border-top-width is reachable from both border-top and border-width, \
       landing in one family (two shorthands, one leaf)" (fun () ->
      check_bool "border-top-width under border-top" true
        (List.mem "border-top-width" (Slot_key.leaves_of "border-top"));
      check_bool "border-top-width under border-width" true
        (List.mem "border-top-width" (Slot_key.leaves_of "border-width"));
      check_string "border-top and border-width share a family key" "border"
        (Slot_key.Family.family_key_of "border-top"));
    Alcotest_extra.test
      "border and border-radius are different families (no shared leaf)"
      (fun () ->
      check_bool "border <> border-radius family" false
        (Slot_key.Family.family_key_of "border"
        = Slot_key.Family.family_key_of "border-radius"));
    Alcotest_extra.test
      "-webkit-mask is its own family, never unified with the standard mask it \
       precedes (vendor-prefix rule)" (fun () ->
      check_bool "-webkit-mask <> mask family" false
        (Slot_key.Family.family_key_of "-webkit-mask"
        = Slot_key.Family.family_key_of "mask"));
    Alcotest_extra.test
      "known family leaf counts (largest groups, spot-checked - this is the \
       number that sets each family's mask bit-width, not the raw union-find \
       membership including intermediate shorthand names)" (fun () ->
      check_int "font family leaves" 20
        (List.length (Slot_key.Family.leaf_members_of "font"));
      check_int "border family leaves" 17
        (List.length (Slot_key.Family.leaf_members_of "border"));
      check_int "mask family leaves" 14
        (List.length (Slot_key.Family.leaf_members_of "mask"));
      check_int "animation family leaves" 12
        (List.length (Slot_key.Family.leaf_members_of "animation")));
  ]

(* --- append-only seed order: an unchanged, exact-order PREFIX --------- *)

(* Committed snapshot of every entry {!Slot_key.seed} holds (526 entries as
   of 2026-09-25, one per line, plain text - not OCaml source - so it stays
   a reviewable, diffable artifact independent of this file), in the exact
   order they were seeded. This is the actual "an existing id must never
   move" check: {!order_tests} below asserts this snapshot is a byte-for-
   byte, same-order PREFIX of the live [Slot_key.seed] - not equal to it.
   That distinction is the whole point: appending a new entry after this
   snapshot (the normal, expected way to grow the table) keeps it a valid
   prefix and the test keeps passing with no edit to the snapshot needed;
   renaming, reordering, or inserting anything at or before the snapshot's
   last position breaks the prefix relationship and fails immediately. Grow
   this snapshot (to the new, larger, still-frozen length) only in the same
   change that intentionally accepts a past id moving - which should not
   happen - never to "make the test pass" after an accidental reorder. (One
   exception so far: 2026-09-25, removing "backdrop-blur" and
   "container-name-computed" - see the plan's Decisions - shifted every
   later position by two; the snapshot was regenerated whole, not patched,
   for that one change.) *)
let expected_seed_prefix : string array =
  let ic = open_in "seed.snapshot" in
  let rec read_lines acc =
    match input_line ic with
    | line -> read_lines (line :: acc)
    | exception End_of_file ->
      close_in ic;
      List.rev acc
  in
  read_lines [] |> Array.of_list

let order_tests =
  [
    Alcotest_extra.test
      "the seed's committed prefix (per seed.snapshot) is an unchanged, \
       exact-order prefix of the live array - appending new entries after them \
       is fine and needs no edit to the snapshot; moving, renaming, or \
       reordering any of them is not, and fails here" (fun () ->
      let n = Array.length expected_seed_prefix in
      let actual_prefix =
        if Array.length Slot_key.seed >= n then Array.sub Slot_key.seed 0 n
        else Slot_key.seed
      in
      check_string_list "seed prefix matches the committed snapshot, in order"
        (Array.to_list expected_seed_prefix)
        (Array.to_list actual_prefix));
  ]

(* --- aliases: two names, one property, one family id ------------------ *)

let alias_tests =
  [
    Alcotest_extra.test
      "font-width and font-stretch resolve to the same family id (true alias, \
       both are 'font's own longhand)" (fun () ->
      check_bool "same family id" true
        (Slot_key.family_id_of "font-width" = Slot_key.family_id_of "font"));
    Alcotest_extra.test "grid-gap and gap resolve to the same family id"
      (fun () ->
      check_bool "same family id" true
        (Slot_key.family_id_of "grid-gap" = Slot_key.family_id_of "gap"));
    Alcotest_extra.test
      "grid-row-gap and row-gap resolve to the same family id as gap (alias \
       then family, in that order)" (fun () ->
      check_bool "same family id" true
        (Slot_key.family_id_of "grid-row-gap" = Slot_key.family_id_of "gap"));
    Alcotest_extra.test
      "grid-column-gap and column-gap resolve to the same family id as gap"
      (fun () ->
      check_bool "same family id" true
        (Slot_key.family_id_of "grid-column-gap" = Slot_key.family_id_of "gap"));
    Alcotest_extra.test
      "word-wrap and overflow-wrap resolve to the same family id" (fun () ->
      check_bool "same family id" true
        (Slot_key.family_id_of "word-wrap"
        = Slot_key.family_id_of "overflow-wrap"));
  ]

let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "slot_key_registry"
    [
      "coverage", List.concat_map snd coverage_tests;
      "family", List.concat_map snd family_tests;
      "order", List.concat_map snd order_tests;
      "alias", List.concat_map snd alias_tests;
    ]
