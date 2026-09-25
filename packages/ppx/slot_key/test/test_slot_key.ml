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

let slot_of ?important css =
  match Slot_key.of_atom (atom_of css) with
  | None -> failwith (Printf.sprintf "of_atom returned None for %S" css)
  | Some t ->
    (match important with None -> t | Some important -> { t with important })

let check_bool = Alcotest.check Alcotest.bool
let check_string = Alcotest.check Alcotest.string
let check_string_list = Alcotest.check (Alcotest.list Alcotest.string)

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
    (* --- comma-list shorthands (transition/animation/grid-template): these
       cover their own meta-property longhands only (see the `opacity`/
       `transition` test in [leaves_tests] below for why that's the right
       scope), but that flat longhand list still needs the same
       both-directions [removes] check as any other shorthand. --- *)
    Alcotest_extra.test "transition removes transition-duration (forward)"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "transition-duration: 100ms;")
           ~latter:(slot_of "transition: opacity 200ms;")));
    Alcotest_extra.test
      "transition-duration does NOT remove transition (reverse, would drop its \
       other longhands)" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "transition: opacity 200ms ease 0ms;")
           ~latter:(slot_of "transition-duration: 100ms;")));
    Alcotest_extra.test "animation removes animation-name (forward)" (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "animation-name: spin;")
           ~latter:(slot_of "animation: spin 1s linear;")));
    Alcotest_extra.test "animation-name does NOT remove animation (reverse)"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "animation: spin 1s linear;")
           ~latter:(slot_of "animation-name: fade;")));
    Alcotest_extra.test "grid-template removes grid-template-columns (forward)"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "grid-template-columns: 1fr 1fr;")
           ~latter:(slot_of "grid-template: \"a\" 1fr / auto;")));
    Alcotest_extra.test
      "grid-template-columns does NOT remove grid-template (reverse)" (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "grid-template: \"a\" 1fr / auto;")
           ~latter:(slot_of "grid-template-columns: 2fr 2fr;")));
    Alcotest_extra.test
      "grid removes grid-template-columns (two levels: grid -> grid-template \
       -> grid-template-columns)" (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "grid-template-columns: 1fr 1fr;")
           ~latter:(slot_of "grid: \"a\" 1fr / auto;")));
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
    Alcotest_extra.test
      "a group is important if any of its declarations is (color:red; \
       color:blue !important;) is not removable by a plain color" (fun () ->
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
    Alcotest_extra.test
      "an ordinary property does not remove all (asymmetric, like a shorthand)"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "all: unset;")
           ~latter:(slot_of "color: red;")));
    Alcotest_extra.test
      "all does not remove direction (CSS Cascade's own exclusion)" (fun () ->
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
    Alcotest_extra.test "margin-left does not remove margin-inline-start"
      (fun () ->
      check_bool "removes" false
        (Slot_key.removes
           ~former:(slot_of "margin-inline-start: 5px;")
           ~latter:(slot_of "margin-left: 5px;")));
    Alcotest_extra.test
      "margin-inline removes margin-inline-start (logical shorthand, safe)"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "margin-inline-start: 5px;")
           ~latter:(slot_of "margin-inline: 10px;")));
    (* --- vendor prefixes: a distinct property, not unified with the unprefixed one --- *)
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
    (* --- unknown/unregistered property: behaves like a plain leaf --- *)
    Alcotest_extra.test "an unknown property removes itself, like any leaf"
      (fun () ->
      check_bool "removes" true
        (Slot_key.removes
           ~former:(slot_of "--not-a-real-thing-but-also-not-custom-syntax: 1;")
           ~latter:(slot_of "--not-a-real-thing-but-also-not-custom-syntax: 2;")));
  ]

let leaves_tests =
  [
    Alcotest_extra.test "margin expands to its four physical sides" (fun () ->
      check_string_list "leaves_of margin"
        [ "margin-bottom"; "margin-left"; "margin-right"; "margin-top" ]
        (List.sort String.compare (Slot_key.leaves_of "margin")));
    Alcotest_extra.test
      "border expands (through border-width/style/color and the four sides) to \
       its twelve leaves" (fun () ->
      check_string_list "leaves_of border"
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
           ])
        (List.sort String.compare (Slot_key.leaves_of "border")));
    Alcotest_extra.test
      "grid-area expands through grid-row/grid-column to its four leaves"
      (fun () ->
      check_string_list "leaves_of grid-area"
        (List.sort String.compare
           [
             "grid-row-start";
             "grid-row-end";
             "grid-column-start";
             "grid-column-end";
           ])
        (List.sort String.compare (Slot_key.leaves_of "grid-area")));
    Alcotest_extra.test "font expands to its seven longhands" (fun () ->
      check_string_list "leaves_of font"
        (List.sort String.compare
           [
             "font-style";
             "font-variant";
             "font-weight";
             "font-stretch";
             "font-size";
             "line-height";
             "font-family";
           ])
        (List.sort String.compare (Slot_key.leaves_of "font")));
    Alcotest_extra.test
      "transition covers its own meta-properties, not a value's target property"
      (fun () ->
      check_string_list "leaves_of transition"
        (List.sort String.compare
           [
             "transition-property";
             "transition-duration";
             "transition-timing-function";
             "transition-delay";
           ])
        (List.sort String.compare (Slot_key.leaves_of "transition")));
    Alcotest_extra.test
      "opacity is unrelated to transition, even when the value text says \
       \"opacity\"" (fun () ->
      check_bool "removes" false
        (Slot_key.removes ~former:(slot_of "opacity: 1;")
           ~latter:(slot_of "transition: opacity 200ms;")));
    Alcotest_extra.test "flex expands to grow/shrink/basis" (fun () ->
      check_string_list "leaves_of flex"
        (List.sort String.compare [ "flex-grow"; "flex-shrink"; "flex-basis" ])
        (List.sort String.compare (Slot_key.leaves_of "flex")));
    Alcotest_extra.test "inset expands to the four physical offsets" (fun () ->
      check_string_list "leaves_of inset"
        (List.sort String.compare [ "top"; "right"; "bottom"; "left" ])
        (List.sort String.compare (Slot_key.leaves_of "inset")));
    Alcotest_extra.test "background expands to its eight longhands" (fun () ->
      check_string_list "leaves_of background"
        (List.sort String.compare
           [
             "background-image";
             "background-position";
             "background-size";
             "background-repeat";
             "background-origin";
             "background-clip";
             "background-attachment";
             "background-color";
           ])
        (List.sort String.compare (Slot_key.leaves_of "background")));
    Alcotest_extra.test "animation expands to its eight longhands" (fun () ->
      check_string_list "leaves_of animation"
        (List.sort String.compare
           [
             "animation-name";
             "animation-duration";
             "animation-timing-function";
             "animation-delay";
             "animation-iteration-count";
             "animation-direction";
             "animation-fill-mode";
             "animation-play-state";
           ])
        (List.sort String.compare (Slot_key.leaves_of "animation")));
    Alcotest_extra.test "place-items expands to align-items/justify-items"
      (fun () ->
      check_string_list "leaves_of place-items"
        (List.sort String.compare [ "align-items"; "justify-items" ])
        (List.sort String.compare (Slot_key.leaves_of "place-items")));
    Alcotest_extra.test "gap expands to row-gap/column-gap" (fun () ->
      check_string_list "leaves_of gap"
        (List.sort String.compare [ "row-gap"; "column-gap" ])
        (List.sort String.compare (Slot_key.leaves_of "gap")));
    Alcotest_extra.test "overflow expands to overflow-x/overflow-y" (fun () ->
      check_string_list "leaves_of overflow"
        (List.sort String.compare [ "overflow-x"; "overflow-y" ])
        (List.sort String.compare (Slot_key.leaves_of "overflow")));
    Alcotest_extra.test "text-decoration expands to its four longhands"
      (fun () ->
      check_string_list "leaves_of text-decoration"
        (List.sort String.compare
           [
             "text-decoration-line";
             "text-decoration-style";
             "text-decoration-color";
             "text-decoration-thickness";
           ])
        (List.sort String.compare (Slot_key.leaves_of "text-decoration")));
    Alcotest_extra.test "a plain, non-shorthand property expands to itself"
      (fun () ->
      check_string_list "leaves_of height" [ "height" ]
        (Slot_key.leaves_of "height"));
    Alcotest_extra.test "an unknown property expands to itself" (fun () ->
      check_string_list "leaves_of unknown"
        [ "totally-unregistered-property" ]
        (Slot_key.leaves_of "totally-unregistered-property"));
  ]

let key_tests =
  [
    Alcotest_extra.test "key is deterministic for the same atom" (fun () ->
      let a = slot_of "height: 0;" in
      let b = slot_of "height: auto;" in
      check_string "same slot, computed twice" (Slot_key.key a) (Slot_key.key a);
      (* Different VALUES, same property/context: same slot key - this is
           the entire point (see merge-order-flip-under-dedup.md). *)
      check_string "height:0 and height:auto share a slot" (Slot_key.key a)
        (Slot_key.key b));
    Alcotest_extra.test "key differs when the property differs" (fun () ->
      check_bool "distinct" true
        (Slot_key.key (slot_of "height: 0;")
        <> Slot_key.key (slot_of "min-height: 0;")));
    Alcotest_extra.test "key differs when the selector context differs"
      (fun () ->
      check_bool "distinct" true
        (Slot_key.key (slot_of "color: red;")
        <> Slot_key.key (slot_of "&:hover{color: red;}")));
    Alcotest_extra.test "key differs when the at-rule context differs"
      (fun () ->
      check_bool "distinct" true
        (Slot_key.key (slot_of "height: 0;")
        <> Slot_key.key (slot_of "@media (max-width:600px){height: 0;}")));
    Alcotest_extra.test
      "leading whitespace in an at-rule prelude doesn't change the key"
      (fun () ->
      check_string "same key"
        (Slot_key.key (slot_of "@media (max-width:600px){height: 0;}"))
        (Slot_key.key (slot_of "@media  (max-width:600px){height: 0;}")));
    Alcotest_extra.test "covered_keys is None for `all`, Some for a shorthand"
      (fun () ->
      check_bool "all -> None" true
        (Option.is_none (Slot_key.covered_keys (slot_of "all: unset;")));
      check_bool "margin -> Some 4" true
        (List.length
           (Option.value ~default:[]
              (Slot_key.covered_keys (slot_of "margin: 0;")))
        = 4));
  ]

let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "slot_key"
    [
      "removes", List.concat_map snd removes_tests;
      "leaves_of", List.concat_map snd leaves_tests;
      "key", List.concat_map snd key_tests;
    ]
