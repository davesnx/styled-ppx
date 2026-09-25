(* Phase 2 checkpoint: concrete examples of the new class-name format
   (Hash_class.slot_class) for every shape .workplace/plans/
   atom-slot-keys_PLAN.md's checkpoint asks for. Not wired into the real
   ppx/generate pipeline yet (phase 3+) - this exercises Hash_class/Slot_key
   directly, the same way packages/ppx/slot_key/test does. *)

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

(* [content] mirrors what Css_file.re passes to [class_and_namespace] today:
   the atom's own rendered text, unprefixed. *)
let class_of css =
  let rule = atom_of css in
  let slot = Slot_key.of_atom rule |> Option.get in
  Class_format.slot_class slot (Render.rule rule)

let check_bool = Alcotest.check Alcotest.bool
let check_int = Alcotest.check Alcotest.int

let starts_with prefix s =
  String.length s >= String.length prefix
  && String.sub s 0 (String.length prefix) = prefix

let examples =
  [
    "base (no context, no family, no mask)", "height: 0;";
    "pseudo-class (:hover)", "&:hover{color: red;}";
    "@media", "@media (max-width:600px){height: auto;}";
    "family longhand (margin-top alone)", "margin-top: 20px;";
    ( "family atom (margin + margin-top mixed in one binding)",
      "&{margin: 10px; margin-top: 0;}" );
    "custom property", "--brand-color: #ff0000;";
    "unknown/unregistered property", "totally-unregistered-frobnicate: 1;";
    "!important", "color: red !important;";
  ]

let examples_tests =
  List.map
    (fun (label, css) ->
      Alcotest_extra.test label (fun () ->
        let c = class_of css in
        (* Every example must at least parse into a well-formed class name:
           the right prefix, and a length this test can report. The actual
           strings are inspected by hand in the checkpoint report (they are
           printed by the length-distribution tool, not asserted literally
           here - a literal hash assertion would just be re-deriving the
           implementation, not checking behavior). *)
        check_bool
          (Printf.sprintf "%s: %S starts with css- or csi-" label c)
          true
          (starts_with "css-" c || starts_with "csi-" c)))
    examples

let format_tests =
  [
    Alcotest_extra.test
      "a plain base atom has no context and no mask token (shortest possible \
       form)" (fun () ->
      let c = class_of "height: 0;" in
      (* css- (4) + family (3) + value (5) = 12, and no more *)
      check_int "length" 12 (String.length c));
    Alcotest_extra.test
      "an !important atom uses the csi- prefix, same length as css-" (fun () ->
      let plain = class_of "color: red;" in
      let important = class_of "color: red !important;" in
      check_bool "csi- prefix" true (starts_with "csi-" important);
      check_int "same total length" (String.length plain)
        (String.length important));
    Alcotest_extra.test
      "a non-base context costs exactly context_width more than base" (fun () ->
      let base = class_of "height: 0;" in
      let hover = class_of "&:hover{height: 0;}" in
      check_int "hover is 4 chars longer"
        (String.length base + 4)
        (String.length hover));
    Alcotest_extra.test
      "a lone longhand (needs a mask) costs exactly mask_width more than a \
       plain property of the same context" (fun () ->
      let plain = class_of "height: 0;" in
      let longhand = class_of "margin-top: 0;" in
      check_int "longhand is 3 chars longer"
        (String.length plain + 3)
        (String.length longhand));
    Alcotest_extra.test
      "a bare shorthand alone has no mask token (same length as a plain \
       property)" (fun () ->
      let plain = class_of "height: 0;" in
      let shorthand = class_of "margin: 10px;" in
      check_int "same length" (String.length plain) (String.length shorthand));
    Alcotest_extra.test
      "same content, computed twice, is byte-identical (deterministic)"
      (fun () ->
      check_bool "deterministic" true
        (class_of "margin: 10px;" = class_of "margin: 10px;"));
    Alcotest_extra.test
      "different values in the same (context,family) bucket get different \
       classes" (fun () ->
      check_bool "distinct" true
        (class_of "height: 0;" <> class_of "height: auto;"));
    Alcotest_extra.test
      "a custom property alone has no mask (it is its own singleton family)"
      (fun () ->
      let plain = class_of "height: 0;" in
      let custom = class_of "--brand-color: red;" in
      check_int "same length as a plain property" (String.length plain)
        (String.length custom));
  ]

let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "slot_class"
    [
      "examples", List.concat_map snd examples_tests;
      "format", List.concat_map snd format_tests;
    ]
