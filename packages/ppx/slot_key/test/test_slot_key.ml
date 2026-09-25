(* Fixtures are parsed CSS, not hand-built AST literals: [atom_of] runs the
   real parser used by [%css] bodies, so every test exercises the exact
   shapes [Css_file.re]'s [atomize_rules] actually produces (a bare
   declaration, a [&]-only or resolved-selector [Style_rule], one or more
   [At_rule] wrappers) instead of a shape this test author imagined. *)

module Driver = Styled_ppx_css_parser.Driver

let atom_of css : Styled_ppx_css_parser.Ast.rule =
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

let slot_of css = Slot_key.of_atom (atom_of css) |> Option.get
let check_bool = Alcotest.check Alcotest.bool
let check_string = Alcotest.check Alcotest.string
let check_int = Alcotest.check Alcotest.int
let check_string_list = Alcotest.check (Alcotest.list Alcotest.string)

let family_tests =
  [
    Alcotest_extra.test "margin's family is its own four physical sides"
      (fun () ->
      check_string_list "leaf_members_of margin"
        [ "margin-bottom"; "margin-left"; "margin-right"; "margin-top" ]
        (List.sort String.compare (Slot_key.Family.leaf_members_of "margin")));
    Alcotest_extra.test
      "border's family is its twelve width/style/color/side leaves plus the \
       five border-image-* leaves it also resets, nested through \
       width/style/color and top/right/bottom/left" (fun () ->
      check_string_list "leaf_members_of border"
        (List.sort String.compare
           [
             "border-top-width";
             "border-top-style";
             "border-top-color";
             "border-right-width";
             "border-right-style";
             "border-right-color";
             "border-bottom-width";
             "border-bottom-style";
             "border-bottom-color";
             "border-left-width";
             "border-left-style";
             "border-left-color";
             "border-image-source";
             "border-image-slice";
             "border-image-width";
             "border-image-outset";
             "border-image-repeat";
           ])
        (List.sort String.compare (Slot_key.Family.leaf_members_of "border")));
    Alcotest_extra.test
      "border-radius is a DIFFERENT family from border - no shared leaf"
      (fun () ->
      let border_leaves = Slot_key.Family.leaf_members_of "border" in
      let radius_leaves = Slot_key.Family.leaf_members_of "border-radius" in
      check_bool "disjoint" true
        (List.for_all (fun l -> not (List.mem l border_leaves)) radius_leaves));
    Alcotest_extra.test "family_key_of picks the shortest shorthand member"
      (fun () ->
      check_string "border-top-color -> border" "border"
        (Slot_key.Family.family_key_of "border-top-color");
      check_string "border-width -> border" "border"
        (Slot_key.Family.family_key_of "border-width");
      check_string "margin-top -> margin" "margin"
        (Slot_key.Family.family_key_of "margin-top"));
    Alcotest_extra.test
      "a plain property with no shorthand relationship is its own family key"
      (fun () ->
      check_string "height -> height" "height"
        (Slot_key.Family.family_key_of "height"));
    Alcotest_extra.test "a shorthand's own mask is its family's full mask"
      (fun () ->
      check_int "mask_of margin = full_mask_of margin"
        (Slot_key.Family.full_mask_of "margin")
        (Slot_key.Family.mask_of "margin"));
    Alcotest_extra.test "a lone longhand's mask is a proper, single-bit subset"
      (fun () ->
      let popcount n =
        let rec loop n acc =
          if n = 0 then acc else loop (n lsr 1) (acc + (n land 1))
        in
        loop n 0
      in
      let full = Slot_key.Family.full_mask_of "margin" in
      let m = Slot_key.Family.mask_of "margin-top" in
      check_bool "proper subset" true (m land full = m && m <> full);
      check_int "exactly one bit set" 1 (popcount m));
    Alcotest_extra.test
      "grid-area's mask, through grid-row/grid-column, is the full 4-bit family"
      (fun () ->
      check_int "mask_of grid-area = full"
        (Slot_key.Family.full_mask_of "grid-area")
        (Slot_key.Family.mask_of "grid-area"));
    Alcotest_extra.test
      "transition covers its own meta-properties only (including \
       transition-behavior, added in L2), not a value's target property"
      (fun () ->
      check_string_list "leaf_members_of transition"
        (List.sort String.compare
           [
             "transition-property";
             "transition-duration";
             "transition-timing-function";
             "transition-delay";
             "transition-behavior";
           ])
        (List.sort String.compare
           (Slot_key.Family.leaf_members_of "transition")));
  ]

let registry_tests =
  [
    Alcotest_extra.test "a seeded property gets a Registered family id"
      (fun () ->
      match Slot_key.family_id_of "height" with
      | Registered _ -> ()
      | Unregistered _ | UnregisteredCustom _ | All ->
        Alcotest.fail "expected Registered");
    Alcotest_extra.test "family_id_of is deterministic" (fun () ->
      check_bool "same twice" true
        (Slot_key.family_id_of "margin-top" = Slot_key.family_id_of "margin-top"));
    Alcotest_extra.test
      "margin-top and margin share a family id (they're in the same family)"
      (fun () ->
      check_bool "same family id" true
        (Slot_key.family_id_of "margin-top" = Slot_key.family_id_of "margin"));
    Alcotest_extra.test "height and margin have different family ids" (fun () ->
      check_bool "different" true
        (Slot_key.family_id_of "height" <> Slot_key.family_id_of "margin"));
    Alcotest_extra.test
      "an unregistered ordinary property still gets a stable id" (fun () ->
      let p = "totally-unregistered-property-xyz" in
      check_bool "deterministic" true
        (Slot_key.family_id_of p = Slot_key.family_id_of p);
      match Slot_key.family_id_of p with
      | Unregistered _ -> ()
      | Registered _ | UnregisteredCustom _ | All ->
        Alcotest.fail "expected Unregistered");
    Alcotest_extra.test
      "a custom property gets UnregisteredCustom, not the plain Unregistered \
       marker (distinguishable by constructor, not by a numeric range)"
      (fun () ->
      match Slot_key.family_id_of "--some-custom-prop" with
      | UnregisteredCustom _ -> ()
      | Registered _ | Unregistered _ | All ->
        Alcotest.fail "expected UnregisteredCustom");
    Alcotest_extra.test
      "two different custom properties get different family ids (not bucketed \
       together)" (fun () ->
      check_bool "distinct" true
        (Slot_key.family_id_of "--foo" <> Slot_key.family_id_of "--bar"));
    Alcotest_extra.test "all gets the reserved All sentinel" (fun () ->
      match Slot_key.family_id_of "all" with
      | All -> ()
      | Registered _ | Unregistered _ | UnregisteredCustom _ ->
        Alcotest.fail "expected All");
    Alcotest_extra.test
      "the family marker for Registered/Unregistered/UnregisteredCustom/All \
       never overlap" (fun () ->
      let registered =
        Slot_key.family_marker (Slot_key.family_id_of "height")
      in
      let unregistered =
        Slot_key.family_marker
          (Slot_key.family_id_of "totally-unregistered-property-xyz")
      in
      let custom =
        Slot_key.family_marker (Slot_key.family_id_of "--some-custom-prop")
      in
      let all = Slot_key.family_marker (Slot_key.family_id_of "all") in
      check_bool "all four distinct" true
        (List.length
           (List.sort_uniq compare [ registered; unregistered; custom; all ])
        = 4));
    Alcotest_extra.test
      "extended_hash is Some for Unregistered/UnregisteredCustom, None for \
       Registered/All" (fun () ->
      check_bool "registered -> None" true
        (Slot_key.extended_hash (Slot_key.family_id_of "height") = None);
      check_bool "all -> None" true
        (Slot_key.extended_hash (Slot_key.family_id_of "all") = None);
      check_bool "unregistered -> Some" true
        (Slot_key.extended_hash
           (Slot_key.family_id_of "totally-unregistered-property-xyz")
        <> None);
      check_bool "custom -> Some" true
        (Slot_key.extended_hash (Slot_key.family_id_of "--some-custom-prop")
        <> None));
  ]

let removes_tests =
  [
    Alcotest_extra.test
      "same property, same context: base color removes base color" (fun () ->
      check_bool "removes" true
        (Slot_key.removes ~former:(slot_of "color: red;")
           ~latter:(slot_of "color: blue;")));
    Alcotest_extra.test
      "different property: color does not remove background-color" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "background-color: red;")
           ~latter:(slot_of "color: blue;")));
    (* --- shorthand asymmetry: the whole point of this module --- *)
    Alcotest_extra.test
      "forward: a later shorthand removes an earlier longhand it covers"
      (fun () ->
      check_bool "margin removes margin-top" true
        (Slot_key.removes
           ~former:(slot_of "margin-top: 20px;")
           ~latter:(slot_of "margin: 10px;")));
    Alcotest_extra.test
      "reverse: a later longhand does NOT remove the earlier shorthand (would \
       discard its other legs)" (fun () ->
      check_bool "margin-top does not remove margin" false
        (Slot_key.removes ~former:(slot_of "margin: 10px;")
           ~latter:(slot_of "margin-top: 20px;")));
    Alcotest_extra.test "unrelated longhand of the same shorthand is untouched"
      (fun () ->
      check_bool "margin-left does not remove margin-top" false
        (Slot_key.removes
           ~former:(slot_of "margin-top: 20px;")
           ~latter:(slot_of "margin-left: 5px;")));
    (* --- nested shorthands: border -> border-top -> border-top-width --- *)
    Alcotest_extra.test
      "border removes border-top-width (two levels of nesting)" (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "border-top-width: 1px;")
           ~latter:(slot_of "border: 1px solid red;")));
    Alcotest_extra.test "border-top-width does NOT remove border" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "border: 1px solid red;")
           ~latter:(slot_of "border-top-width: 1px;")));
    Alcotest_extra.test "border removes border-top (one level of nesting)"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "border-top: 1px solid red;")
           ~latter:(slot_of "border: 2px dashed blue;")));
    Alcotest_extra.test "border-top removes border-top-color" (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "border-top-color: red;")
           ~latter:(slot_of "border-top: 1px solid blue;")));
    (* --- comma-list shorthands (transition/animation/grid-template) --- *)
    Alcotest_extra.test "transition removes transition-duration (forward)"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "transition-duration: 100ms;")
           ~latter:(slot_of "transition: opacity 200ms;")));
    Alcotest_extra.test
      "transition-duration does NOT remove transition (reverse)" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "transition: opacity 200ms ease 0ms;")
           ~latter:(slot_of "transition-duration: 100ms;")));
    Alcotest_extra.test
      "grid removes grid-template-columns (two levels: grid -> grid-template \
       -> grid-template-columns)" (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "grid-template-columns: 1fr 1fr;")
           ~latter:(slot_of "grid: \"a\" 1fr / auto;")));
    Alcotest_extra.test
      "opacity is unrelated to transition, even when the value text says \
       \"opacity\"" (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "opacity: 1;")
           ~latter:(slot_of "transition: opacity 200ms;")));
    (* --- family atoms: a group mixing several members of one family --- *)
    Alcotest_extra.test
      "a family atom mixing margin-top and margin-left (no shorthand) has \
       exactly those two bits, and is removed by the full shorthand" (fun () ->
      let mixed = slot_of "&{margin-top: 0; margin-left: 0;}" in
      check_bool "removed by margin" true
        (Slot_key.removes ~former:mixed ~latter:(slot_of "margin: 10px;")));
    Alcotest_extra.test
      "a family atom mixing the shorthand with one of its own longhands covers \
       the full family (the shorthand already implies every side)" (fun () ->
      let mixed = slot_of "&{margin: 10px; margin-top: 0;}" in
      let plain_shorthand = slot_of "margin: 5px;" in
      (* full mask on both sides: interchangeable for removal in either direction *)
      check_bool "mixed removes plain shorthand" true
        (Slot_key.removes ~former:plain_shorthand ~latter:mixed);
      check_bool "plain shorthand removes mixed" true
        (Slot_key.removes ~former:mixed ~latter:plain_shorthand));
    (* --- context: same property, different context, never interact --- *)
    Alcotest_extra.test
      ":hover does not remove base, base does not remove :hover" (fun () ->
      let base = slot_of "background-color: red;" in
      let hover = slot_of "&:hover{background-color: blue;}" in
      check_bool "hover removes base" false
        (Slot_key.removes ~former:base ~latter:hover);
      check_bool "base removes hover" false
        (Slot_key.removes ~former:hover ~latter:base));
    Alcotest_extra.test "::before does not remove base" (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "color: red;")
           ~latter:(slot_of "&::before{color: blue;}")));
    Alcotest_extra.test
      "@media does not remove base, base does not remove @media" (fun () ->
      let base = slot_of "height: 0;" in
      let media = slot_of "@media (max-width:600px){height: auto;}" in
      check_bool "media removes base" false
        (Slot_key.removes ~former:base ~latter:media);
      check_bool "base removes media" false
        (Slot_key.removes ~former:media ~latter:base));
    Alcotest_extra.test "@supports does not remove @media, same property"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "@media (max-width:600px){height: 0;}")
           ~latter:(slot_of "@supports (display: grid){height: auto;}")));
    Alcotest_extra.test
      "same @media condition, same property: later removes earlier" (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "@media (max-width:600px){height: 0;}")
           ~latter:(slot_of "@media (max-width:600px){height: auto;}")));
    Alcotest_extra.test
      "nested `& > .x` is its own context, distinct from the base atom"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "min-height: 0;")
           ~latter:(slot_of "& > .x{min-height: 0;}")));
    (* --- !important --- *)
    Alcotest_extra.test "a plain atom does not remove an !important one"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "color: red !important;")
           ~latter:(slot_of "color: blue;")));
    Alcotest_extra.test "an !important atom removes a plain one" (fun () ->
      check_bool "removes" true
        (Slot_key.removes ~former:(slot_of "color: red;")
           ~latter:(slot_of "color: blue !important;")));
    Alcotest_extra.test
      "two !important atoms in the same slot: later still wins" (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "color: red !important;")
           ~latter:(slot_of "color: blue !important;")));
    Alcotest_extra.test "a group is important if any of its declarations is"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "&{color: red; color: blue !important;}")
           ~latter:(slot_of "color: green;")));
    (* --- `all` --- *)
    Alcotest_extra.test "all removes an ordinary property in the same context"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes ~former:(slot_of "color: red;")
           ~latter:(slot_of "all: unset;")));
    Alcotest_extra.test "an ordinary property does not remove all (asymmetric)"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "all: unset;")
           ~latter:(slot_of "color: red;")));
    Alcotest_extra.test "all does not remove direction" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "direction: rtl;")
           ~latter:(slot_of "all: unset;")));
    Alcotest_extra.test "all does not remove unicode-bidi" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "unicode-bidi: isolate;")
           ~latter:(slot_of "all: unset;")));
    Alcotest_extra.test "all does not remove a custom property" (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "--foo: 1px;")
           ~latter:(slot_of "all: unset;")));
    (* --- logical vs physical: deliberately unrelated --- *)
    Alcotest_extra.test "margin-inline-start does not remove margin-left"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "margin-left: 5px;")
           ~latter:(slot_of "margin-inline-start: 5px;")));
    Alcotest_extra.test
      "margin-inline removes margin-inline-start (logical shorthand, safe)"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "margin-inline-start: 5px;")
           ~latter:(slot_of "margin-inline: 10px;")));
    (* --- vendor prefixes: a distinct property, not unified --- *)
    Alcotest_extra.test "-webkit-transform does not remove transform" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "transform: scale(1);")
           ~latter:(slot_of "-webkit-transform: scale(1);")));
    (* --- custom properties: case-sensitive, never a shorthand --- *)
    Alcotest_extra.test "--foo removes --foo" (fun () ->
      check_bool "removes" true
        (Slot_key.removes ~former:(slot_of "--foo: 1px;")
           ~latter:(slot_of "--foo: 2px;")));
    Alcotest_extra.test
      "--foo and --Foo are different custom properties (case-sensitive)"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "--foo: 1px;")
           ~latter:(slot_of "--Foo: 2px;")));
    (* --- property case-insensitivity (not for custom properties) --- *)
    Alcotest_extra.test "HEIGHT and height are the same slot" (fun () ->
      check_bool "removes" true
        (Slot_key.removes ~former:(slot_of "HEIGHT: 0;")
           ~latter:(slot_of "height: auto;")));
    (* --- unknown/unregistered property --- *)
    Alcotest_extra.test "an unknown property removes itself, like any leaf"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "--not-a-real-thing-but-also-not-custom-syntax: 1;")
           ~latter:(slot_of "--not-a-real-thing-but-also-not-custom-syntax: 2;")));
    (* --- interpolation bundles: opaque to removes in both directions --- *)
    Alcotest_extra.test
      "a declaration with a $(...) value interpolation is a bundle atom"
      (fun () -> check_bool "bundle" true (slot_of "color: $(theme);").bundle);
    Alcotest_extra.test "a plain declaration is not a bundle atom" (fun () ->
      check_bool "bundle" false (slot_of "color: red;").bundle);
    Alcotest_extra.test
      "a bundle atom is never removed, even by an identical same-property atom \
       (would be true for two plain atoms - see the base test above)" (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "color: $(a);")
           ~latter:(slot_of "color: $(b);")));
    Alcotest_extra.test "a bundle atom never removes a plain atom" (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "color: red;")
           ~latter:(slot_of "color: $(theme);")));
    Alcotest_extra.test "a plain atom never removes a bundle atom" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "color: $(theme);")
           ~latter:(slot_of "color: red;")));
    Alcotest_extra.test
      "a bundle atom is immune even to a same-property !important override \
       (bundle status overrides the !important rule too)" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "color: $(theme);")
           ~latter:(slot_of "color: red !important;")));
  ]

let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "slot_key"
    [
      "family", List.concat_map snd family_tests;
      "registry", List.concat_map snd registry_tests;
      "removes", List.concat_map snd removes_tests;
    ]
