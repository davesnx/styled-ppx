open Property_class_mint
module Format_ = Property_class_core.Css_class_format

let case name fn = Alcotest.test_case name `Quick fn
let hex h = Printf.sprintf "%016Lx" h

let hash_tests =
  [
    case "MurmurHash64A reference vectors" (fun () ->
      List.iter
        (fun (input, expected) ->
          assert_string (hex (Hash64.hash input)) expected)
        [
          "", "0000000000000000";
          "a", "071717d2d36b6b11";
          "abc", "9cc9c33498a95efb";
          "hello", "1e68d17c457bf117";
          "abcdefg", "241aa52b0a62005d";
          "12345678", "758f67d162b2d202";
          "123456789", "4977490251674330";
          "abcdefgh1234567", "2d8462f780c1e968";
          "The quick brown fox jumps over the lazy dog", "5589ca33042a861b";
          "color:red", "bdedb54d30efe35d";
        ]);
    case "hashes UTF-8 bytes, not UTF-16 code units" (fun () ->
      assert_string (hex (Hash64.hash "\xe2\x96\xb2")) "964d7e7700408d48";
      assert_string (hex (Hash64.hash "\xc2\xb2")) "66e8d98feaf6a202";
      Alcotest.(check bool)
        "differ" true
        (Hash64.hash "\xe2\x96\xb2" <> Hash64.hash "\xc2\xb2"));
    case "NUL separated fields do not collide with their concatenation"
      (fun () ->
      Alcotest.(check bool)
        "differ" true
        (Hash64.hash "a\000bc" <> Hash64.hash "ab\000c"));
    case "chars writes the low bits, most significant symbol first" (fun () ->
      assert_string (Hash64.chars 0L 6) "AAAAAA";
      assert_string (Hash64.chars 63L 6) "AAAAA-";
      assert_string (Hash64.chars 64L 6) "AAAABA";
      assert_string (Hash64.chars 62L 1) "_";
      assert_string (Hash64.chars (-1L) 8) "--------";
      assert_string (Hash64.chars 0x1_0000_0000_0L 6) "AAAAAA";
      assert_string (Hash64.chars 26L 2) "Aa";
      assert_string (Hash64.chars 0x7fL 2) "B-");
    case "chars output is valid in a class token" (fun () ->
      let h = Hash64.hash "color:red" in
      let token =
        Format_.encode_atom ~prop:(Id "0a") ~ctx:(Hash64.chars h 6)
          ~value:(Hash64.chars (Int64.shift_right_logical h 20) 6)
      in
      Alcotest.(check bool) "atom" true (Format_.decode token <> Foreign);
      Alcotest.(check bool)
        "binding id" true
        (Format_.decode (Format_.encode_binding_id (Hash64.chars h 8))
        <> Foreign));
    case "chars rejects unsupported lengths" (fun () ->
      List.iter
        (fun n ->
          Alcotest.(check bool)
            (string_of_int n) true
            (try
               ignore (Hash64.chars 0L n);
               false
             with Invalid_argument _ -> true))
        [ 0; 11 ]);
  ]

let ctx ?(conditions = []) ?(important = false) scope : Context_key.context =
  { scope; conditions; important }

let key c = Context_key.key c

let context_tests =
  [
    case "pseudo-classes of one compound are sorted" (fun () ->
      assert_string (key (ctx "&:hover:focus")) (key (ctx "&:focus:hover"));
      assert_string
        (Context_key.normalize_selector "&:hover:focus")
        "&:focus:hover";
      assert_string
        (Context_key.normalize_selector ":hover:focus")
        ":focus:hover";
      assert_string
        (Context_key.normalize_selector "& .a:not(.b):hover:active")
        "& .a:not(.b):active:hover";
      assert_string
        (Context_key.normalize_selector "&:nth-child(2):hover:active")
        "&:nth-child(2):active:hover");
    case "a NUL-separated tail is part of the key and not normalized" (fun () ->
      assert_string
        (key (ctx "&:hover:focus\000module:A"))
        (key (ctx "&:focus:hover\000module:A"));
      assert (
        key (ctx "&.$(M.m)\000module:A") <> key (ctx "&.$(M.m)\000module:B"));
      assert (key (ctx "&.$(M.m)\000module:A") <> key (ctx "&.$(M.m)")));
    case "pseudo-classes are not sorted across a pseudo-element" (fun () ->
      List.iter
        (fun s -> assert_string (Context_key.normalize_selector s) s)
        [ "&::before:hover:focus"; "&::before"; "&::before:focus:hover" ]);
    case "legacy single-colon pseudo-elements end the sorted run" (fun () ->
      List.iter
        (fun s -> assert_string (Context_key.normalize_selector s) s)
        [
          "&:hover:after";
          "&:after:hover";
          "&:before:focus:hover";
          "&:first-line:hover";
          "&:first-letter:hover";
        ];
      Alcotest.(check bool)
        "different keys" true
        (key (ctx "&:hover:after") <> key (ctx "&:after:hover")));
    case "pseudo names are lowercased outside strings and attributes" (fun () ->
      assert_string (key (ctx "&:HOVER")) (key (ctx "&:hover"));
      assert_string
        (Context_key.normalize_selector "&:FOCUS:Hover")
        "&:focus:hover";
      assert_string
        (Context_key.normalize_selector "&::BEFORE:HOVER")
        "&::before:hover";
      assert_string
        (Context_key.normalize_selector "&:NOT(.Foo):HOVER")
        "&:not(.Foo):hover";
      List.iter
        (fun s -> assert_string (Context_key.normalize_selector s) s)
        [ "&[data-x=\"A:B\"]"; "&[data-x=A]"; "& .sm\\:Hidden"; "&.Foo" ]);
    case "media feature names are lowercased" (fun () ->
      assert_string
        (key (ctx ~conditions:[ "@media (MIN-WIDTH: 1px)" ] "&"))
        (key (ctx ~conditions:[ "@media (min-width: 1px)" ] "&"));
      assert_string
        (Context_key.canonical_condition "@media (MIN-WIDTH: 1px) and (HOVER)")
        "@media (min-width: 1px) and (hover)";
      assert_string
        (Context_key.canonical_condition "@media (WIDTH >= 1PX)")
        "@media (width >= 1PX)";
      List.iter
        (fun s -> assert_string (Context_key.canonical_condition s) s)
        [
          "@media SCREEN";
          "@media (min-width: var(--Bp))";
          "@supports (content: \"(A: b)\")";
          "@supports selector(:HOVER)";
          "@container Card (min-width: 1px)";
        ]);
    case "other selectors are unchanged" (fun () ->
      List.iter
        (fun s -> assert_string (Context_key.normalize_selector s) s)
        [
          "&";
          "& > *";
          "& + &";
          "& .child";
          "a:";
          "&:";
          "";
          "& [data-x=\"a:b\"]";
        ]);
    case "conditions ignore whitespace around punctuation" (fun () ->
      assert_string
        (Context_key.normalize_condition "@media  (min-width :  1px)")
        "@media(min-width:1px)";
      assert_string
        (Context_key.normalize_condition "  (min-width: 1px)  ")
        "(min-width:1px)";
      assert_string
        (Context_key.normalize_condition "@media screen   and (min-width: 1px)")
        "@media screen and(min-width:1px)";
      assert_string
        (key (ctx ~conditions:[ "(min-width: 1px)" ] "&"))
        (key (ctx ~conditions:[ "(min-width:1px)" ] "&")));
    case "conditions are a sorted set" (fun () ->
      assert_string
        (key (ctx ~conditions:[ "(b)"; "(a)" ] "&"))
        (key (ctx ~conditions:[ "(a)"; "(b)" ] "&"));
      assert_string
        (key (ctx ~conditions:[ "(b)"; "(a)" ] "&"))
        "& | (a) | (b) | ");
    case "importance and scope are part of the key" (fun () ->
      assert_string (key (ctx "&")) "& | ";
      assert_string (key (ctx ~important:true "&")) "& | !important";
      Alcotest.(check bool)
        "important differs" true
        (key (ctx "&") <> key (ctx ~important:true "&"));
      Alcotest.(check bool)
        "scope differs" true
        (key (ctx "&") <> key (ctx "& > *"));
      Alcotest.(check bool)
        "condition differs" true
        (key (ctx "&") <> key (ctx ~conditions:[ "(a)" ] "&")));
  ]

let binding_id ?(library = "") ?(module_name = "M") ?(scope = [ "A"; "B" ])
  ?(name = "x") ?(occurrence = 0) () =
  Hash_class.binding_id ~library ~module_name ~scope ~name ~occurrence

let binding_tests =
  [
    case "a binding id is a binding id token" (fun () ->
      let id = binding_id () in
      Alcotest.(check int) "width" 10 (String.length id);
      match Format_.decode id with
      | Binding_id _ -> ()
      | _ -> Alcotest.fail "not a binding id");
    case "a binding id is stable" (fun () ->
      assert_string (binding_id ()) (binding_id ()));
    case "every input changes the binding id" (fun () ->
      let base = binding_id () in
      List.iter
        (fun other -> assert_string_not_equal other base)
        [
          binding_id ~library:"lib" ();
          binding_id ~module_name:"N" ();
          binding_id ~scope:[ "A" ] ();
          binding_id ~scope:[ "A"; "C" ] ();
          binding_id ~name:"y" ();
          binding_id ~occurrence:1 ();
        ]);
    case "scope segments do not run together" (fun () ->
      assert_string_not_equal
        (binding_id ~scope:[ "A"; "B" ] ~name:"x" ())
        (binding_id ~scope:[ "A" ] ~name:"B.x" ()));
  ]

let () =
  Alcotest.run "property_class_mint"
    [
      "hash64", hash_tests;
      "context_key", context_tests;
      "binding_id", binding_tests;
    ]
