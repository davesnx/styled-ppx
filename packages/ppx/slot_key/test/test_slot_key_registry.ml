(* Registry/id coverage for Slot_key's css-grammar-backed data (see
   slot_key.ml's [direct_children]/[seed]/[Registry]). Deliberately its own
   file, not test_slot_key.ml - that file covers the
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
  | Slot_key.Unregistered _ | Slot_key.UnregisteredCustom _ | Slot_key.All ->
    false

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
      | Registered _ | UnregisteredCustom _ | All ->
        Alcotest.fail "expected Unregistered");
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
    Alcotest_extra.test
      "every shorthand's own depth is strictly below every one of its direct \
       longhands' depth, for every edge in the live css-grammar shorthand \
       graph (not just the hand-picked examples above) - the exact invariant \
       generate.ml's sort relies on to put a shorthand before its own \
       longhand; a shortest-path depth breaks this for a property reachable \
       through more than one shorthand (border-width/border-top-width above), \
       so only the longest-path definition can pass this check" (fun () ->
      let violations =
        Css_grammar.shorthands ()
        |> List.concat_map (fun (shorthand, longhands) ->
          longhands
          |> List.filter_map (fun longhand ->
            let sd = Slot_key.depth_of shorthand in
            let ld = Slot_key.depth_of longhand in
            if sd < ld then None
            else
              Some (Printf.sprintf "%s(%d) -> %s(%d)" shorthand sd longhand ld)))
      in
      check_string_list
        "shorthand/longhand pairs with depth NOT strictly increasing" []
        violations);
  ]

(* --- append-only seed order: an unchanged, exact-order PREFIX --------- *)

(* Committed snapshot of every entry {!Slot_key.seed} holds (526 entries, one
   per line, plain text - not OCaml source - so it stays a reviewable,
   diffable artifact independent of this file), in the exact
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
   happen - never to "make the test pass" after an accidental reorder.
   Removing an id entirely (e.g. dropping a property that turns out not to
   be real CSS) is the one case where regenerating the snapshot whole, not
   patching it, is correct: every later position shifts by the number of
   removed entries, which is an intentional, reviewed renumbering, not an
   accidental reorder. *)
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

(* --- mask invariant: a leaf's own mask must distinguish it from its -----
   family's other legs whenever there ARE other legs to distinguish from.
   This was found broken for the alias spellings "grid-row-gap"/
   "grid-column-gap": [of_atom] called
   [Family.mask_of]/[Family.full_mask_of] on the raw, unresolved alias name,
   which [Family]'s union-find (built only from [direct_children], itself
   built only from [Css_grammar.shorthands] - never [Css_grammar.aliases])
   treats as its own one-member family, where [mask_of = full_mask_of]
   always. That silently let a "row-gap" atom's mask-less class remove an
   earlier "column-gap" atom's class in [removes], even though the two set
   disjoint longhands. [of_atom] now resolves the alias first (see its own
   doc comment); these two tests pin the invariant that fix restores, at the
   registry/graph level, independent of [of_atom]'s own implementation -
   the first over every real shorthand's longhand list, the second over
   every real alias, resolved to canonical (both empty pre-fix and
   post-fix, since [Family.mask_of]/[full_mask_of] on an already-canonical
   name never had this bug - only [of_atom]'s failure to resolve one did;
   see test_merge_key.ml's runtime tests for the regression these two do
   NOT catch). *)
let mask_tests =
  [
    Alcotest_extra.test
      "every longhand of a multi-leaf family has a mask that is not the \
       family's full mask - equal is only legitimate when the leaf is the \
       family's ONLY leaf (a shorthand with exactly one direct longhand, where \
       covering that one leaf covers the whole family by definition)" (fun () ->
      let violations =
        Css_grammar.shorthands ()
        |> List.concat_map (fun (shorthand, _longhands) ->
          let leaves = Slot_key.Family.leaf_members_of shorthand in
          if List.length leaves <= 1 then []
          else
            leaves
            |> List.filter_map (fun leaf ->
              let mask = Slot_key.Family.mask_of leaf in
              let full = Slot_key.Family.full_mask_of leaf in
              if mask <> full then None
              else
                Some
                  (Printf.sprintf
                     "%s: mask=%d = full=%d in a %d-leaf family (%s)" leaf mask
                     full (List.length leaves) shorthand)))
      in
      check_string_list
        "leaves whose own mask wrongly equals their family's full mask" []
        violations);
    Alcotest_extra.test
      "every alias, resolved to its canonical name, obeys the same invariant - \
       covers the alias names themselves (\"grid-row-gap\", not just \
       \"row-gap\"), which the shorthand/longhand check above never names \
       directly. Exempts an alias whose canonical name IS the family's own \
       shorthand root (\"grid-gap\" -> \"gap\" - a shorthand legitimately has \
       mask = full), the same one-leaf-family exemption as above, restated in \
       terms of \"is this a leaf at all\" rather than leaf count, since an \
       alias resolves straight to a family key, never to a leaf list" (fun () ->
      let violations =
        Css_grammar.aliases ()
        |> List.filter_map (fun (alias, _canonical) ->
          let resolved = Slot_key.resolve_alias alias in
          let family_key = Slot_key.Family.family_key_of resolved in
          if resolved = family_key then None
          else (
            let mask = Slot_key.Family.mask_of resolved in
            let full = Slot_key.Family.full_mask_of resolved in
            if mask <> full then None
            else (
              let leaves = Slot_key.Family.leaf_members_of family_key in
              Some
                (Printf.sprintf
                   "%s (-> %s): mask=%d = full=%d in a %d-leaf family (%s)"
                   alias resolved mask full (List.length leaves) family_key))))
      in
      check_string_list
        "aliases whose resolved mask wrongly equals their family's full mask" []
        violations);
  ]

(* --- family-id stability: a property already in [seed] never moves -----
   Without a guard, a later shorthand registration can silently move an
   already-seeded property off its own slot two ways: {!Family.family_key_of}'s
   shortest-name rule lets a shorter new shorthand win over an
   already-registered, longer one in the same family (a new "rule" shorthand
   unioning with the already-registered "column-rule"); separately, a new
   shorthand unioning two or more previously-standalone, already-registered
   properties (a new "max-size" shorthand unioning "max-width" and
   "max-height", each its own one-member family until then) is not even
   covered by the shortest-name rule at all, since neither is itself a
   shorthand - both would fall through to the brand-new shorthand's own,
   never-registered name. [Slot_key.family_id_of] guards against both: it
   prefers whichever member of the WHOLE family (shorthand or leaf) already
   has a seed slot, over the shortest-name rule. This test asserts the guard
   holds for every property in [seed] today, not just a hand-picked case, so
   a future shorthand registration that would silently move one of them
   fails here instead of shipping. Every seed entry is either a family key
   or a standalone (family-less) property today (see [seed]'s own doc), so
   each is expected to keep resolving to its own slot right now. A new
   shorthand that unions two already-seeded properties (for example a
   "max-size" over "max-width" and "max-height") can only keep one of their
   slots, so it fails here and needs an explicit decision. *)
let family_id_stability_tests =
  [
    Alcotest_extra.test
      "every property in seed keeps its own seed slot as its family id - an \
       already-registered family member always wins over a later shorthand \
       that joins its family, whether that shorthand is shorter (\"rule\" vs \
       \"column-rule\") or unions two previously-standalone properties \
       (\"max-size\" vs \"max-width\"/\"max-height\")" (fun () ->
      let seed_index =
        Slot_key.seed
        |> Array.to_list
        |> List.mapi (fun i name -> name, i)
        (* "all" is seeded to reserve its position in the append-only order,
           but [family_id_of] special-cases it to the [All] sentinel rather
           than looking it up in the registry - not a family-id regression,
           see coverage_tests above for the same exclusion. *)
        |> List.filter (fun (name, _) -> name <> "all")
      in
      let violations =
        seed_index
        |> List.filter_map (fun (name, index) ->
          match Slot_key.family_id_of name with
          | Registered i when i = index -> None
          | Registered i ->
            Some
              (Printf.sprintf
                 "%s: seeded at %d, family_id_of now resolves to %d" name index
                 i)
          | Unregistered _ | UnregisteredCustom _ | All ->
            Some (Printf.sprintf "%s: no longer Registered at all" name))
      in
      check_string_list
        "seeded properties whose family id moved away from their own seed slot"
        [] violations);
  ]

let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "slot_key_registry"
    [
      "coverage", List.concat_map snd coverage_tests;
      "family", List.concat_map snd family_tests;
      "order", List.concat_map snd order_tests;
      "alias", List.concat_map snd alias_tests;
      "mask", List.concat_map snd mask_tests;
      "family-id-stability", List.concat_map snd family_id_stability_tests;
    ]
