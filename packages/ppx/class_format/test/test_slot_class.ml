(* Concrete examples of the class-name format (Hash_class.slot_class) for
   every shape it can produce. Not wired into the real ppx/generate
   pipeline yet - this exercises Hash_class/Slot_key directly, the same way
   packages/ppx/slot_key/test does. *)

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
let check_string = Alcotest.check Alcotest.string

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
    "interpolating declaration (not a bundle by itself)", "color: $(theme);";
  ]

let examples_tests =
  List.map
    (fun (label, css) ->
      Alcotest_extra.test label (fun () ->
        let c = class_of css in
        (* Every example must at least parse into a well-formed class name:
           the right prefix, and a length this test can report. The actual
           strings are not asserted literally here - a literal hash
           assertion would just be re-deriving the implementation, not
           checking behavior. *)
        check_bool
          (Printf.sprintf "%s: %S starts with %s or %s" label c
             Class_format.atom_prefix Class_format.bundle_prefix)
          true
          (starts_with Class_format.atom_prefix c
          || starts_with Class_format.bundle_prefix c)))
    examples

let base_length = Class_format.floor_of_prefix Class_format.atom_prefix

let format_tests =
  [
    Alcotest_extra.test
      "a plain base atom (Registered family, no mask) is exactly \
       prefix+family+value - the shortest possible non-bundle form" (fun () ->
      let c = class_of "height: 0;" in
      check_int "length" base_length (String.length c));
    Alcotest_extra.test
      "an !important atom uses the SAME _a_ prefix as a plain atom - there is \
       no separate important-atom prefix - but is context_width chars longer, \
       since !important is folded into the context key and a base atom's \
       context is otherwise free" (fun () ->
      let plain = class_of "color: red;" in
      let important = class_of "color: red !important;" in
      check_bool "same _a_ prefix" true
        (starts_with Class_format.atom_prefix important);
      check_int "context_width chars longer (importance costs a context field)"
        (String.length plain + Class_format.context_width)
        (String.length important));
    Alcotest_extra.test
      "a non-base context costs exactly context_width more than base" (fun () ->
      let base = class_of "height: 0;" in
      let hover = class_of "&:hover{height: 0;}" in
      check_int "hover is context_width chars longer"
        (String.length base + Class_format.context_width)
        (String.length hover));
    Alcotest_extra.test
      "!important composes with a real selector context into ONE context \
       field, not two - hover alone, important alone, and hover+important \
       together are all exactly context_width longer than base, never \
       2*context_width, because the whole context key (however many pieces fed \
       into it) is hashed down to one fixed-width field" (fun () ->
      let base = class_of "color: red;" in
      let hover_important = class_of "&:hover{color: red !important;}" in
      check_int "context_width chars longer, not 2*context_width"
        (String.length base + Class_format.context_width)
        (String.length hover_important));
    Alcotest_extra.test
      "a lone longhand (needs a mask) costs exactly mask_width more than a \
       plain property of the same context" (fun () ->
      let plain = class_of "height: 0;" in
      let longhand = class_of "margin-top: 0;" in
      check_int "longhand is mask_width chars longer"
        (String.length plain + Class_format.mask_width)
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
      "a custom property has no mask, but pays the extended-hash field (it has \
       no table slot - a custom property's own name is never in the fixed \
       seed) - longer than a Registered plain property by exactly \
       extended_width, not the same length" (fun () ->
      let plain = class_of "height: 0;" in
      let custom = class_of "--brand-color: red;" in
      check_int "extended_width chars longer"
        (String.length plain + Class_format.extended_width)
        (String.length custom));
    Alcotest_extra.test
      "an unknown (non-custom) property also pays the extended-hash field, \
       same as a custom property" (fun () ->
      let custom = class_of "--brand-color: red;" in
      let unknown = class_of "totally-unregistered-frobnicate: 1;" in
      check_int "same length as a custom property" (String.length custom)
        (String.length unknown));
    Alcotest_extra.test
      "a single interpolating declaration is NOT a bundle: class_of (via \
       Slot_key.of_atom, which always returns bundle = false) mints a real, \
       structural _a_ class for it, same as any other atom - Css_file.re only \
       reaches for Class_format.bundle_class directly when two or more \
       interpolating declarations share one class" (fun () ->
      let c = class_of "color: $(theme);" in
      check_bool "_a_ prefix, not _in_" true
        (starts_with Class_format.atom_prefix c));
    Alcotest_extra.test
      "Class_format.bundle_class (Css_file.re's real, two-or-more-declaration \
       bundle path) uses the _in_ prefix, carries none of the other fields, \
       and its hash is exactly the same unpadded Murmur2 digest \
       class_and_namespace already computes for a single atom - only the \
       prefix changed, not the hash algorithm or width" (fun () ->
      let content = Render.rule (atom_of "color: $(theme);") in
      let c = Class_format.bundle_class content in
      check_bool "_in_ prefix" true (starts_with Class_format.bundle_prefix c);
      check_string "_in_ + unpadded Murmur2.default"
        (Class_format.bundle_prefix ^ Murmur2.default content)
        c;
      check_bool
        "length is at most len(_in_) + bundle_value_width (unpadded, so can be \
         shorter)"
        true
        (String.length c
        <= String.length Class_format.bundle_prefix
           + Class_format.bundle_value_width));
    Alcotest_extra.test
      "slot_class's own bundle branch (never reached by a real Slot_key.t - \
       see Slot_key.t.bundle's doc) still dispatches to bundle_class exactly, \
       for a hand-built slot that claims bundle = true" (fun () ->
      let content = Render.rule (atom_of "color: $(theme);") in
      let slot =
        {
          (Slot_key.of_atom (atom_of "color: $(theme);") |> Option.get) with
          bundle = true;
        }
      in
      check_string "slot_class with bundle=true = bundle_class"
        (Class_format.bundle_class content)
        (Class_format.slot_class slot content));
    Alcotest_extra.test
      "the six possible non-bundle extra-length values are pairwise distinct \
       (the property that makes runtime parsing unambiguous)" (fun () ->
      let lengths = Class_format.possible_extra_lengths in
      check_int "six values" 6 (List.length lengths);
      check_int "six DISTINCT values" 6
        (List.length (List.sort_uniq compare lengths)));
  ]

let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited
    "slot_class"
    [
      "examples", List.concat_map snd examples_tests;
      "format", List.concat_map snd format_tests;
    ]
