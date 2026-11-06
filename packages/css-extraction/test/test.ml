module Builder = Ppxlib.Ast_builder.Default

let loc = Ppxlib.Location.none
let case name fn = Alcotest.test_case name `Quick fn

let payload (item : Ppxlib.structure_item) =
  match item.pstr_desc with
  | Pstr_attribute
      { attr_payload = PStr [ { pstr_desc = Pstr_eval (e, _); _ } ]; _ } ->
    e
  | _ -> Alcotest.fail "expected an attribute with an expression payload"

let atom : Css_extraction.atom =
  {
    cls = "_a0aXk3_9w";
    rules =
      [ "._a0aXk3_9w{color:red}"; "@media (min-width:1px){._a0aXk3_9w{x:y}}" ];
    tier = 2;
    conds = 1;
    cover = 3;
    hashes =
      [
        { kind = "ctx"; token = "3fQ-zT"; source = "&:hover | (min-width:1px)" };
        {
          kind = "value";
          token = "Xk3_9w";
          source = "val\000color\000\000red\n\"q\"";
        };
      ];
  }

let empty_atom : Css_extraction.atom =
  { cls = "_c"; rules = []; tier = 0; conds = 0; cover = 0; hashes = [] }

let atoms_result =
  Alcotest.(
    result
      (list
         (testable
            (fun fmt (a : Css_extraction.atom) -> Fmt.string fmt a.cls)
            ( = )))
      string)

let reference = "\000Lib.Mod.x\000"

let tests =
  [
    case "atoms attribute has the documented name" (fun () ->
      assert_string Css_extraction.atoms_attribute_name "css.atoms";
      match (Css_extraction.atoms_attribute [ atom ]).pstr_desc with
      | Pstr_attribute { attr_name; _ } ->
        assert_string attr_name.txt "css.atoms"
      | _ -> Alcotest.fail "expected an attribute");
    case "atoms round trip" (fun () ->
      List.iter
        (fun atoms ->
          check ~__POS__ atoms_result
            (Css_extraction.decode_atoms_payload
               (payload (Css_extraction.atoms_attribute atoms)))
            (Ok atoms))
        [
          [];
          [ atom ];
          [ atom; empty_atom; { atom with cls = "_i" ^ reference } ];
        ]);
    case "malformed atoms name the entry" (fun () ->
      let decode e = Css_extraction.decode_atoms_payload e in
      Alcotest.(check (result unit string))
        "not a list" (Error "expected css.atoms payload to be a list")
        (Result.map ignore (decode (Builder.estring ~loc "x")));
      Alcotest.(check (result unit string))
        "bad entry"
        (Error
           "malformed css.atoms payload at entry 1: expected (cls, rules, \
            tier, conds, cover, hashes) tuple")
        (Result.map ignore
           (decode
              (Builder.elist ~loc
                 (List.map
                    (fun (a : Css_extraction.atom) ->
                      Builder.pexp_tuple ~loc
                        [
                          Builder.estring ~loc a.cls;
                          Builder.elist ~loc [];
                          Builder.eint ~loc a.tier;
                          Builder.eint ~loc a.conds;
                          Builder.eint ~loc a.cover;
                          Builder.elist ~loc [];
                        ])
                    [ empty_atom ]
                 @ [ Builder.estring ~loc "x" ]))));
      Alcotest.(check (result unit string))
        "bad hash"
        (Error
           "malformed css.atoms payload at entry 0: malformed hashes payload \
            at entry 0: expected (kind, token, source) tuple")
        (Result.map ignore
           (decode
              (Builder.elist ~loc
                 [
                   Builder.pexp_tuple ~loc
                     [
                       Builder.estring ~loc "_c";
                       Builder.elist ~loc [];
                       Builder.eint ~loc 0;
                       Builder.eint ~loc 0;
                       Builder.eint ~loc 0;
                       Builder.elist ~loc [ Builder.estring ~loc "x" ];
                     ];
                 ]))));
    case "bindings keep the two-field shape without an id" (fun () ->
      let entry = Css_extraction.binding ~longident:"M.x" ~class_string:"a b" in
      Alcotest.(check string) "id" "" entry.binding_id;
      match
        Css_extraction.decode_bindings_payload
          (payload (Css_extraction.bindings_attribute [ entry ]))
      with
      | Ok [ { longident = "M.x"; class_string = "a b"; binding_id = "" } ] ->
        ()
      | _ -> Alcotest.fail "unexpected decode");
    case "bindings round trip an id" (fun () ->
      let entry =
        Css_extraction.binding_with_id ~longident:"M.x" ~class_string:"a b"
          ~binding_id:"_iaB3_-zZ9"
      in
      match
        Css_extraction.decode_bindings_payload
          (payload (Css_extraction.bindings_attribute [ entry ]))
      with
      | Ok [ decoded ] ->
        assert_string decoded.longident "M.x";
        assert_string decoded.class_string "a b";
        assert_string decoded.binding_id "_iaB3_-zZ9"
      | _ -> Alcotest.fail "unexpected decode");
    case "a binding without an id is emitted as a pair" (fun () ->
      match
        (payload
           (Css_extraction.bindings_attribute
              [ Css_extraction.binding ~longident:"M.x" ~class_string:"a" ]))
          .pexp_desc
      with
      | Pexp_construct
          ( _,
            Some
              {
                pexp_desc = Pexp_tuple [ { pexp_desc = Pexp_tuple pair; _ }; _ ];
                _;
              } ) ->
        Alcotest.(check int) "fields" 2 (List.length pair)
      | _ -> Alcotest.fail "expected a list holding a tuple");
  ]

let () = Alcotest.run "css_extraction" [ "payload", tests ]
