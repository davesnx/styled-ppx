open Property_class_mint
module Format_ = Property_class_core.Css_class_format

type json =
  | Null
  | Bool of bool
  | Int of int
  | String of string
  | List of json list
  | Object of (string * json) list

let parse text =
  let pos = ref 0 in
  let peek () = text.[!pos] in
  let skip () =
    while !pos < String.length text && String.contains " \n\r\t" (peek ()) do
      incr pos
    done
  in
  let expect c =
    skip ();
    if peek () <> c then
      failwith (Printf.sprintf "json: expected %c at %d" c !pos);
    incr pos
  in
  let rec value () =
    skip ();
    match peek () with
    | '{' ->
      incr pos;
      skip ();
      if peek () = '}' then (
        incr pos;
        Object [])
      else (
        let rec members acc =
          skip ();
          let key = string () in
          expect ':';
          let v = value () in
          skip ();
          let acc = (key, v) :: acc in
          if peek () = ',' then (
            incr pos;
            members acc)
          else (
            expect '}';
            Object (List.rev acc))
        in
        members [])
    | '[' ->
      incr pos;
      skip ();
      if peek () = ']' then (
        incr pos;
        List [])
      else (
        let rec items acc =
          let v = value () in
          skip ();
          let acc = v :: acc in
          if peek () = ',' then (
            incr pos;
            items acc)
          else (
            expect ']';
            List (List.rev acc))
        in
        items [])
    | '"' -> String (string ())
    | 't' ->
      pos := !pos + 4;
      Bool true
    | 'f' ->
      pos := !pos + 5;
      Bool false
    | 'n' ->
      pos := !pos + 4;
      Null
    | _ ->
      let start = !pos in
      while
        !pos < String.length text && String.contains "-0123456789" (peek ())
      do
        incr pos
      done;
      Int (int_of_string (String.sub text start (!pos - start)))
  and string () =
    expect '"';
    let buf = Buffer.create 16 in
    let rec go () =
      match peek () with
      | '"' -> incr pos
      | '\\' ->
        let c = text.[!pos + 1] in
        pos := !pos + 2;
        (match c with
        | 'n' -> Buffer.add_char buf '\n'
        | 't' -> Buffer.add_char buf '\t'
        | 'r' -> Buffer.add_char buf '\r'
        | 'b' -> Buffer.add_char buf '\b'
        | 'f' -> Buffer.add_char buf '\012'
        | 'u' ->
          let code = int_of_string ("0x" ^ String.sub text !pos 4) in
          pos := !pos + 4;
          Buffer.add_utf_8_uchar buf (Uchar.of_int code)
        | c -> Buffer.add_char buf c);
        go ()
      | c ->
        Buffer.add_char buf c;
        incr pos;
        go ()
    in
    go ();
    Buffer.contents buf
  in
  value ()

let field name = function
  | Object members -> List.assoc name members
  | _ -> failwith "json: not an object"

let to_list = function List l -> l | _ -> failwith "json: not a list"
let to_string = function String s -> s | _ -> failwith "json: not a string"
let to_bool = function Bool b -> b | _ -> failwith "json: not a bool"
let to_int = function Int i -> i | _ -> failwith "json: not an int"

let decl json : Atomize.decl =
  {
    context =
      {
        scope = to_string (field "scope" json);
        conditions = List.map to_string (to_list (field "conditions" json));
        important = to_bool (field "important" json);
      };
    prop = to_string (field "prop" json);
    text = to_string (field "text" json);
  }

type expected = {
  unit_ : Atomize.unit_;
  dead : bool;
}

type block = {
  case : string;
  block : string;
  decls : Atomize.decl list;
  units : expected list;
}

let fixture =
  let ic = open_in_bin "../../gen/units_fixture.json" in
  let text = really_input_string ic (in_channel_length ic) in
  close_in ic;
  List.map
    (fun row ->
      {
        case = to_string (field "case" row);
        block = to_string (field "block" row);
        decls = List.map decl (to_list (field "decls" row));
        units =
          List.map
            (fun u ->
              {
                unit_ =
                  {
                    pieces = List.map decl (to_list (field "pieces" u));
                    bundle = to_bool (field "bundle" u);
                    tier = to_int (field "tier" u);
                    conds = to_int (field "conds" u);
                    cover = to_int (field "cover" u);
                  };
                dead = to_bool (field "dead" u);
              })
            (to_list (field "units" row));
      })
    (to_list (parse text))

let case name fn = Alcotest.test_case name `Quick fn

let live block =
  List.filter_map (fun e -> if e.dead then None else Some e.unit_) block.units

let find case_id block_name =
  List.find (fun b -> b.case = case_id && b.block = block_name) fixture

let describe (u : Atomize.unit_) =
  Printf.sprintf "[%s] bundle=%b tier=%d conds=%d cover=%d"
    (String.concat "; "
       (List.map
          (fun (d : Atomize.decl) ->
            Printf.sprintf "%s | %s | %s" d.context.scope d.text
              (if d.context.important then "!" else ""))
          u.pieces))
    u.bundle u.tier u.conds u.cover

let replay_tests =
  [
    case "every block of every case matches the model, unit for unit" (fun () ->
      let failures =
        List.filter_map
          (fun b ->
            let got = Atomize.units b.decls in
            let want = live b in
            if got = want then None
            else
              Some
                (Printf.sprintf "%s/%s\n  got:\n    %s\n  want:\n    %s" b.case
                   b.block
                   (String.concat "\n    " (List.map describe got))
                   (String.concat "\n    " (List.map describe want))))
          fixture
      in
      if failures <> [] then
        Alcotest.fail
          (Printf.sprintf "%d of %d blocks differ\n%s" (List.length failures)
             (List.length fixture)
             (String.concat "\n" failures)));
    case "the fixture covers every case" (fun () ->
      let cases = List.sort_uniq compare (List.map (fun b -> b.case) fixture) in
      Alcotest.(check bool) "at least 389 cases" true (List.length cases >= 389);
      Alcotest.(check bool) "has blocks" true (List.length fixture >= 800));
  ]

let props (u : Atomize.unit_) =
  List.map (fun (d : Atomize.decl) -> d.prop) u.pieces

let units_of case_id block_name = Atomize.units (find case_id block_name).decls
let int_list = Alcotest.(list int)

let case_tests =
  [
    case "important and normal declarations of one property split" (fun () ->
      List.iter
        (fun (id, order) ->
          let units = units_of id "a" in
          Alcotest.(check int) (id ^ " units") 2 (List.length units);
          Alcotest.(check (list bool))
            (id ^ " importance") order
            (List.map
               (fun (u : Atomize.unit_) -> (List.hd u.pieces).context.important)
               units);
          List.iter
            (fun (u : Atomize.unit_) ->
              Alcotest.(check bool) (id ^ " not a bundle") false u.bundle;
              Alcotest.(check (list string))
                (id ^ " property") [ "color" ] (props u))
            units)
        [
          "important-03", [ true; false ];
          "important-04", [ true; false ];
          "important-05", [ false; true ];
        ]);
    case "a later shorthand drops the dead longhand of its block" (fun () ->
      List.iter
        (fun (id, block_name, want) ->
          let units = units_of id block_name in
          Alcotest.(check (list (list string)))
            (id ^ "/" ^ block_name)
            want (List.map props units))
        [
          "groups-09", "a", [ [ "margin" ] ];
          "groups-10", "a", [ [ "position" ]; [ "inset" ] ];
          "groups-12", "a", [ [ "font" ] ];
          "groups-13", "a", [ [ "margin" ] ];
          "groups-13", "b", [ [ "margin-left" ] ];
        ]);
    case "a longhand after its shorthand stays" (fun () ->
      let decl prop text : Atomize.decl =
        {
          context = { scope = "&"; conditions = []; important = false };
          prop;
          text;
        }
      in
      let units =
        Atomize.units
          [ decl "margin" "margin:0"; decl "margin-top" "margin-top:1px" ]
      in
      Alcotest.(check (list (list string)))
        "both"
        [ [ "margin" ]; [ "margin-top" ] ]
        (List.map props units);
      Alcotest.check int_list "cover" [ 4; 1 ]
        (List.map (fun (u : Atomize.unit_) -> u.cover) units));
    case "in-block overlaps become one bundle" (fun () ->
      List.iter
        (fun (id, block_name, want) ->
          let bundles =
            List.filter_map
              (fun (u : Atomize.unit_) ->
                if u.bundle then Some (List.length u.pieces) else None)
              (units_of id block_name)
          in
          Alcotest.check int_list (id ^ "/" ^ block_name) want bundles)
        [
          "T36", "a", [ 2 ];
          "groups-11", "a", [ 2 ];
          "groups-14", "a", [ 2 ];
          "groups-14", "b", [];
          "conditions-29", "a", [ 3 ];
          "conditions-30", "a", [];
          "conditions-30", "b", [ 2 ];
          "monorepo-04", "definition", [ 2; 2; 6 ];
          "monorepo-10", "colorWhite", [ 5; 4; 4 ];
          "monorepo-10", "iconGhost", [ 2 ];
          "monorepo-10", "buttonDisabled", [];
        ]);
    case "an alias and its canonical property in one context are one atom"
      (fun () ->
      let decl prop text : Atomize.decl =
        {
          context = { scope = "&"; conditions = []; important = false };
          prop;
          text;
        }
      in
      match
        Atomize.units
          [
            decl "word-wrap" "word-wrap:break-word";
            decl "overflow-wrap" "overflow-wrap:anywhere";
          ]
      with
      | [ u ] ->
        Alcotest.(check bool) "bundle" false u.bundle;
        Alcotest.(check (list string))
          "texts"
          [ "word-wrap:break-word"; "overflow-wrap:anywhere" ]
          (List.map (fun (d : Atomize.decl) -> d.text) u.pieces)
      | units -> Alcotest.failf "%d units" (List.length units));
    case "a legacy single-colon pseudo-element is its own subject" (fun () ->
      let decl scope text : Atomize.decl =
        {
          context = { scope; conditions = []; important = false };
          prop = "color";
          text;
        }
      in
      List.iter
        (fun scope ->
          let units =
            Atomize.units [ decl scope "color:red"; decl "&" "color:blue" ]
          in
          Alcotest.(check (list bool))
            scope [ false; false ]
            (List.map (fun (u : Atomize.unit_) -> u.bundle) units))
        [ "&::after"; "&:after"; "&:before"; "&:first-line"; "&:first-letter" ]);
    case "a repeated property in one context is an atom, not a bundle"
      (fun () ->
      let decl text : Atomize.decl =
        {
          context = { scope = "&"; conditions = []; important = false };
          prop = "color";
          text;
        }
      in
      match Atomize.units [ decl "color:red"; decl "color:blue" ] with
      | [ u ] ->
        Alcotest.(check bool) "bundle" false u.bundle;
        Alcotest.(check int) "pieces" 2 (List.length u.pieces)
      | units -> Alcotest.failf "%d units" (List.length units));
  ]

let ctx ?(conditions = []) ?(important = false) scope : Atomize.context =
  { scope; conditions; important }

let tier_tests =
  [
    case "tier and the sheet order key" (fun () ->
      List.iter
        (fun (context, want) ->
          Alcotest.(check int) context.Atomize.scope want (Atomize.tier context))
        [
          ctx "&", 1;
          ctx ~important:true "&", 1;
          ctx "&:hover", 2;
          ctx "&::before", 2;
          ctx ~conditions:[ "@media(a)" ] "&", 2;
          ctx "& > *", 0;
          ctx "& span", 0;
          ctx "& + &", 0;
          ctx "& [data-x=\"a b\"]:hover", 0;
          ctx "&[data-x=\"a b\"]", 2;
          ctx "&:not(& span)", 2;
          ctx ".parent &", 2;
        ]);
    case "brackets inside quoted strings do not change the tier" (fun () ->
      List.iter
        (fun (context, want) ->
          Alcotest.(check int) context.Atomize.scope want (Atomize.tier context))
        [
          ctx "&[title=\")\"] > *", 0;
          ctx "&[title=']'] > *", 0;
          ctx "&[title=\"(\"] > *", 0;
          ctx "&[title=\"a > b\"]", 2;
        ]);
  ]

let decl ?(conditions = []) ?(important = false) ?(scope = "&") prop text :
  Atomize.decl =
  { context = { scope; conditions; important }; prop; text }

let unit_of decls : Atomize.unit_ =
  match Atomize.units decls with
  | [ u ] -> u
  | units -> Alcotest.failf "%d units" (List.length units)

let is_identifier token =
  token <> ""
  && token.[0] = '_'
  && String.for_all (fun c -> String.contains Format_.alphabet c) token

let width token = String.length token

let mint_tests =
  [
    case "a plain context atom is 10 wide and decodes to its property"
      (fun () ->
      let token = Mint.token (unit_of [ decl "color" "color:red" ]) in
      Alcotest.(check int) "width" 10 (width token);
      Alcotest.(check bool) "identifier" true (is_identifier token);
      match Format_.decode token with
      | Atom { prop = Id id; ctx; _ } ->
        Alcotest.(check (option string))
          "id"
          (Property_class_core.Css_cover.id_of_name "color")
          (Some id);
        Alcotest.(check string) "ctx" Format_.plain_ctx ctx
      | _ -> Alcotest.fail "not an atom");
    case "another context atom is 16 wide" (fun () ->
      let token =
        Mint.token (unit_of [ decl ~scope:"&:hover" "color" "color:red" ])
      in
      Alcotest.(check int) "width" 16 (width token);
      Alcotest.(check bool) "identifier" true (is_identifier token);
      match Format_.decode token with
      | Atom { ctx; _ } ->
        Alcotest.(check bool) "ctx is not plain" true (ctx <> Format_.plain_ctx)
      | _ -> Alcotest.fail "not an atom");
    case "a custom property atom is 20 wide" (fun () ->
      let token = Mint.token (unit_of [ decl "--gap" "--gap:1px" ]) in
      Alcotest.(check int) "width" 20 (width token);
      Alcotest.(check bool) "identifier" true (is_identifier token);
      match Format_.decode token with
      | Atom { prop = Name _; ctx; _ } ->
        Alcotest.(check string) "plain ctx" Format_.plain_ctx ctx
      | _ -> Alcotest.fail "not a name atom");
    case "an unknown property atom is 20 wide" (fun () ->
      let token =
        Mint.token (unit_of [ decl "-moz-future-thing" "-moz-future-thing:1" ])
      in
      Alcotest.(check int) "width" 20 (width token));
    case "a bundle is 10 + 8n wide and decodes to its cells" (fun () ->
      let u =
        unit_of
          [
            decl "border-top" "border-top:1px solid red";
            decl "border-color" "border-color:blue";
          ]
      in
      Alcotest.(check bool) "bundle" true u.bundle;
      let token = Mint.token u in
      Alcotest.(check int) "width" 26 (width token);
      Alcotest.(check bool) "identifier" true (is_identifier token);
      match Format_.decode token with
      | Bundle { cells; _ } ->
        Alcotest.(check int) "cells" 2 (List.length cells)
      | _ -> Alcotest.fail "not a bundle");
    case "bundle cells are one per property and context" (fun () ->
      let u =
        unit_of
          [
            decl ~scope:"& span" "margin" "margin:1px";
            decl ~scope:"& span"
              ~conditions:[ "@media(min-width:1px)" ]
              "margin" "margin:2px";
            decl ~scope:"& span" "margin" "margin:3px";
          ]
      in
      Alcotest.(check bool) "bundle" true u.bundle;
      match Format_.decode (Mint.token u) with
      | Bundle { cells; _ } ->
        Alcotest.(check int) "cells" 2 (List.length cells)
      | _ -> Alcotest.fail "not a bundle");
    case "a bundle with a custom property decodes to its name cells" (fun () ->
      let u =
        unit_of
          [
            decl ~conditions:[ "@media(min-width:1px)" ] "--x" "--x:2";
            decl "--x" "--x:1";
          ]
      in
      Alcotest.(check bool) "bundle" true u.bundle;
      let token = Mint.token u in
      Alcotest.(check int) "width" 38 (width token);
      Alcotest.(check bool) "identifier" true (is_identifier token);
      match Format_.decode token with
      | Bundle { cells = [ (Name a, ca); (Name b, cb) ]; _ } ->
        Alcotest.(check string) "same name" a b;
        Alcotest.(check bool) "contexts differ" true (ca <> cb)
      | _ -> Alcotest.fail "not a bundle of name cells");
    case "a bundle of known and custom properties mixes cell widths" (fun () ->
      let u : Atomize.unit_ =
        {
          pieces = [ decl "margin" "margin:2px"; decl "--x" "--x:1" ];
          bundle = true;
          tier = 1;
          conds = 0;
          cover = 5;
        }
      in
      let token = Mint.token u in
      Alcotest.(check int) "width" (10 + 8 + 14) (width token);
      match Format_.decode token with
      | Bundle { cells = [ (Id _, _); (Name _, _) ]; _ } -> ()
      | _ -> Alcotest.fail "not a mixed bundle");
    case "the declaration changes the value field only" (fun () ->
      let red = Mint.token (unit_of [ decl "color" "color:red" ]) in
      let blue = Mint.token (unit_of [ decl "color" "color:blue" ]) in
      Alcotest.(check string)
        "prefix" (String.sub red 0 4) (String.sub blue 0 4);
      Alcotest.(check bool) "differ" true (red <> blue));
    case "the context changes the context field" (fun () ->
      let hover =
        Mint.token (unit_of [ decl ~scope:"&:hover" "color" "color:red" ])
      in
      let focus =
        Mint.token (unit_of [ decl ~scope:"&:focus" "color" "color:red" ])
      in
      let important =
        Mint.token (unit_of [ decl ~important:true "color" "color:red" ])
      in
      Alcotest.(check bool) "hover vs focus" true (hover <> focus);
      Alcotest.(check bool)
        "ctx field" true
        (String.sub hover 4 6 <> String.sub focus 4 6);
      Alcotest.(check bool)
        "important differs" true
        (important <> Mint.token (unit_of [ decl "color" "color:red" ])));
    case "equivalent contexts mint one name" (fun () ->
      Alcotest.(check string)
        "pseudo order"
        (Mint.token
           (unit_of [ decl ~scope:"&:hover:focus" "color" "color:red" ]))
        (Mint.token
           (unit_of [ decl ~scope:"&:focus:hover" "color" "color:red" ]));
      Alcotest.(check string)
        "condition spacing"
        (Mint.token
           (unit_of
              [
                decl
                  ~conditions:[ "@media  ( min-width : 1px )" ]
                  "color" "color:red";
              ]))
        (Mint.token
           (unit_of
              [
                decl
                  ~conditions:[ "@media (min-width:1px)" ]
                  "color" "color:red";
              ])));
    case "aliases mint the property of their canonical name" (fun () ->
      let alias = Mint.token (unit_of [ decl "word-wrap" "x" ]) in
      let canonical = Mint.token (unit_of [ decl "overflow-wrap" "x" ]) in
      Alcotest.(check string)
        "property id" (String.sub canonical 2 2) (String.sub alias 2 2);
      Alcotest.(check string) "name" canonical alias);
    case "a repeated property is one atom with a value over every text"
      (fun () ->
      let one = Mint.token (unit_of [ decl "color" "color:red" ]) in
      let two =
        Mint.token
          (unit_of [ decl "color" "color:red"; decl "color" "color:blue" ])
      in
      Alcotest.(check int) "width" 10 (width two);
      Alcotest.(check bool) "differ" true (one <> two));
    case "minting is stable and a bundle depends on the block order" (fun () ->
      let a = decl "border-top" "border-top:1px solid red" in
      let b = decl "border-color" "border-color:blue" in
      Alcotest.(check string)
        "stable"
        (Mint.token (unit_of [ a; b ]))
        (Mint.token (unit_of [ a; b ]));
      Alcotest.(check bool)
        "order" true
        (Mint.token (unit_of [ a; b ]) <> Mint.token (unit_of [ b; a ])));
    case "a unit without pieces is rejected" (fun () ->
      Alcotest.(check bool)
        "raises" true
        (try
           ignore
             (Mint.token
                { pieces = []; bundle = false; tier = 1; conds = 0; cover = 0 });
           false
         with Invalid_argument _ -> true));
    case "every unit of the fixture mints a valid identifier" (fun () ->
      let widths = Hashtbl.create 16 in
      List.iter
        (fun b ->
          List.iter
            (fun (u : Atomize.unit_) ->
              let token = Mint.token u in
              Alcotest.(check bool) token true (is_identifier token);
              Hashtbl.replace widths (width token) ())
            (Atomize.units b.decls))
        fixture;
      List.iter
        (fun w ->
          Alcotest.(check bool) (string_of_int w) true (Hashtbl.mem widths w))
        [ 10; 16 ]);
    case "hashes list every hashed field with its source" (fun () ->
      let u = unit_of [ decl ~scope:"&:hover" "color" "color:red" ] in
      let token = Mint.token u in
      let hashes = Mint.hashes u in
      Alcotest.(check (list string))
        "kinds" [ "ctx"; "value" ]
        (List.map (fun (h : Mint.hashed) -> h.kind) hashes);
      let ctx = List.nth hashes 0
      and value = List.nth hashes 1 in
      Alcotest.(check string) "ctx token" (String.sub token 4 6) ctx.token;
      Alcotest.(check string) "value token" (String.sub token 10 6) value.token;
      Alcotest.(check string) "ctx source" "ctx\\0&:hover | " ctx.source;
      let id = Option.get (Property_class_core.Css_cover.id_of_name "color") in
      Alcotest.(check string)
        "value source"
        ("val\\0" ^ id ^ "\\0&:hover | \\0color:red")
        value.source;
      let plain = Mint.hashes (unit_of [ decl "color" "color:red" ]) in
      Alcotest.(check (list string))
        "plain kinds" [ "value" ]
        (List.map (fun (h : Mint.hashed) -> h.kind) plain);
      let custom = Mint.hashes (unit_of [ decl "--gap" "--gap:1px" ]) in
      Alcotest.(check (list string))
        "custom kinds" [ "name"; "value" ]
        (List.map (fun (h : Mint.hashed) -> h.kind) custom);
      Alcotest.(check string)
        "name source" "name\\0--gap" (List.hd custom).source);
  ]

let () =
  Alcotest.run "property_class_atomize"
    [
      "replay", replay_tests;
      "cases", case_tests;
      "tier", tier_tests;
      "mint", mint_tests;
    ]
