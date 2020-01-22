open Css_types

let rec zip xs ys =
  match (xs, ys) with
  | ([], _) -> []
  | (_, []) -> []
  | (x :: xs, y :: ys) -> (x, y) :: (zip xs ys)

let eq_ast ast1 ast2 =
  let eq_list xs ys eq =
    List.fold_left
      (fun e (x, y) -> e && eq x y)
      true
      (zip xs ys)
  in
  let rec eq_component_value (cv1, _) (cv2, _) =
    let open Component_value in
    match (cv1, cv2) with
    | (Paren_block b1, Paren_block b2)
    | (Bracket_block b1, Bracket_block b2) ->
      eq_list b1 b2 eq_component_value
    | (Percentage x1, Percentage x2)
    | (Ident x1, Ident x2)
    | (String x1, String x2)
    | (Uri x1, Uri x2)
    | (Operator x1, Operator x2)
    | (Delim x1, Delim x2)
    | (Hash x1, Hash x2)
    | (Number x1, Number x2)
    | (Unicode_range x1, Unicode_range x2) ->
      x1 = x2
    | (Float_dimension x1, Float_dimension x2) ->
      x1 = x2
    | (Dimension x1, Dimension x2) ->
      x1 = x2
    | (Function ((n1, _), (b1, _)), Function ((n2, _), (b2, _))) ->
      n1 = n2 &&
      eq_list b1 b2 eq_component_value
    | _ -> false
  and eq_at_rule r1 r2 =
    let (n1, _) = r1.At_rule.name in
    let (n2, _) = r2.At_rule.name in
    let (pr1, _) = r1.At_rule.prelude in
    let (pr2, _) = r2.At_rule.prelude in
    (n1 = n2) &&
    (eq_list pr1 pr2 eq_component_value) &&
    begin match (r1.At_rule.block, r2.At_rule.block) with
      | (Brace_block.Empty, Brace_block.Empty) -> true
      | (Brace_block.Declaration_list dl1, Brace_block.Declaration_list dl2) ->
        eq_declaration_list dl1 dl2
      | (Brace_block.Stylesheet s1, Brace_block.Stylesheet s2) ->
        eq_stylesheet s1 s2
      | _ -> false
    end
  and eq_declaration d1 d2 =
    let (n1, _) = d1.Declaration.name in
    let (n2, _) = d2.Declaration.name in
    let (v1, _) = d1.Declaration.value in
    let (v2, _) = d2.Declaration.value in
    let (i1, _) = d1.Declaration.important in
    let (i2, _) = d2.Declaration.important in
    (n1 = n2) &&
    (eq_list v1 v2 eq_component_value) &&
    (i1 = i2)
  and eq_declaration_list (dl1, _) (dl2, _) =
    let eq_kind k1 k2 =
      match (k1, k2) with
      | (Declaration_list.Declaration d1, Declaration_list.Declaration d2) ->
        eq_declaration d1 d2
      | (Declaration_list.At_rule r1, Declaration_list.At_rule r2) ->
        eq_at_rule r1 r2
      | _ -> false
    in
    eq_list dl1 dl2 eq_kind
  and eq_style_rule r1 r2 =
    let (pr1, _) = r1.Style_rule.prelude in
    let (pr2, _) = r2.Style_rule.prelude in
    (eq_list pr1 pr2 eq_component_value) &&
    (eq_declaration_list r1.Style_rule.block r2.Style_rule.block)
  and eq_rule r1 r2 =
    match (r1, r2) with
    | (Rule.Style_rule r1, Rule.Style_rule r2) -> eq_style_rule r1 r2
    | (Rule.At_rule r1, Rule.At_rule r2) -> eq_at_rule r1 r2
    | _ -> false
  and eq_stylesheet (st1, _) (st2, _) =
    eq_list st1 st2 eq_rule
  in
  eq_stylesheet ast1 ast2

let parse_stylesheet css =
  try Css_lexer.parse_string css Css_parser.stylesheet with
  | Css_lexer.LexingError (pos, _) ->
    failwith
      ("Lexing error at: " ^ Css_lexer.position_to_string pos)
  | Css_lexer.ParseError (token, start, finish) ->
    failwith
      (Printf.sprintf "Parsing error: Unexpected token=%s start=%s end=%s"
         (Css_lexer.token_to_string token)
         (Css_lexer.position_to_string start)
         (Css_lexer.position_to_string finish))

let test_stylesheet_parser () =
  let css =
    {|
{
  /* This is a comment */
  color: red !important; /* This is another comment */
  background-color: red;
}

p q r {
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.Style_rule
        {Style_rule.prelude = ([], Location.none);
         block =
           ([Declaration_list.Declaration
               {Declaration.name = ("color", Location.none);
                value = ([(Component_value.Ident "red", Location.none)], Location.none);
                important = (true, Location.none);
                loc = Location.none;
               };
             Declaration_list.Declaration
               {Declaration.name = ("background-color", Location.none);
                value = ([(Component_value.Ident "red", Location.none)], Location.none);
                important = (false, Location.none);
                loc = Location.none;
               }
            ], Location.none);
         loc = Location.none;
        };
      Rule.Style_rule
        {Style_rule.prelude = (
            [(Component_value.Ident "p", Location.none);
             (Ident "q", Location.none);
             (Ident "r", Location.none)
            ], Location.none);
         block = ([], Location.none);
         loc = Location.none;
        }
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_css_functions () =
  let css =
    {|
{
  color: rgb(1, 2, 3);
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.Style_rule
        {Style_rule.prelude = ([], Location.none);
         block =
           ([Declaration_list.Declaration
               {Declaration.name = ("color", Location.none);
                value = (
                  [(Component_value.Function (
                       ("rgb", Location.none),
                       ([(Component_value.Number "1", Location.none);
                         (Component_value.Delim ",", Location.none);
                         (Component_value.Number "2", Location.none);
                         (Component_value.Delim ",", Location.none);
                         (Component_value.Number "3", Location.none);
                        ], Location.none)),
                    Location.none);
                  ],
                  Location.none);
                important = (false, Location.none);
                loc = Location.none;
               };
            ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_page () =
  let css =
    {|
@page {
  margin: 1cm;
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("page", Location.none);
         prelude = ([], Location.none);
         block = Brace_block.Declaration_list
             ([Declaration_list.Declaration
                 {Declaration.name = ("margin", Location.none);
                  value = ([(Component_value.Float_dimension ("1", "cm", Length), Location.none)], Location.none);
                  important = (false, Location.none);
                  loc = Location.none;
                 };
              ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_charset () =
  let css =
    {|
@charset "utf-8";
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("charset", Location.none);
         prelude = ([(Component_value.String "utf-8", Location.none)], Location.none);
         block = Brace_block.Empty;
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_import () =
  let css =
    {|
@import url("fineprint.css") print;
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("import", Location.none);
         prelude = (
           [(Component_value.Uri "\"fineprint.css\"", Location.none);
            (Component_value.Ident "print", Location.none);
           ],
           Location.none);
         block = Brace_block.Empty;
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_namespace () =
  let css =
    {|
@namespace url(http://www.w3.org/1999/xhtml);
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("namespace", Location.none);
         prelude = (
           [(Component_value.Uri "http://www.w3.org/1999/xhtml", Location.none)], Location.none);
         block = Brace_block.Empty;
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_media () =
  let css =
    {|
@media screen and (min-width: 900px) {
  article {
    padding: 1rem 3rem;
  }
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("media", Location.none);
         prelude = (
           [(Component_value.Ident "screen", Location.none);
            (Component_value.Ident "and", Location.none);
            (Component_value.Paren_block (
                [(Component_value.Ident "min-width", Location.none);
                 (Component_value.Delim ":", Location.none);
                 (Component_value.Float_dimension ("900", "px", Length), Location.none);
                ]), Location.none);
           ],
           Location.none);
         block = Brace_block.Stylesheet
             ([Rule.Style_rule
                 {Style_rule.prelude = ([(Component_value.Ident "article", Location.none)], Location.none);
                  block =
                    ([Declaration_list.Declaration
                        {Declaration.name = ("padding", Location.none);
                         value = (
                           [(Component_value.Float_dimension ("1", "rem", Length), Location.none);
                            (Component_value.Float_dimension ("3", "rem", Length), Location.none);
                           ],
                           Location.none);
                         important = (false, Location.none);
                         loc = Location.none;
                        };
                     ], Location.none);
                  loc = Location.none;
                 };],
              Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_supports () =
  let css =
    {|
@supports (display: flex) {
  @media screen and (min-width: 900px) {
    article {
      display: flex;
    }
  }
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("supports", Location.none);
         prelude = (
           [(Component_value.Paren_block (
                [(Component_value.Ident "display", Location.none);
                 (Component_value.Delim ":", Location.none);
                 (Component_value.Ident "flex", Location.none);
                ]), Location.none);
           ],
           Location.none);
         block = Brace_block.Stylesheet
             ([Rule.At_rule
                 {At_rule.name = ("media", Location.none);
                  prelude = (
                    [(Component_value.Ident "screen", Location.none);
                     (Component_value.Ident "and", Location.none);
                     (Component_value.Paren_block (
                         [(Component_value.Ident "min-width", Location.none);
                          (Component_value.Delim ":", Location.none);
                          (Component_value.Float_dimension ("900", "px", Length), Location.none);
                         ]), Location.none);
                    ],
                    Location.none);
                  block = Brace_block.Stylesheet
                      ([Rule.Style_rule
                          {Style_rule.prelude = ([(Component_value.Ident "article", Location.none)], Location.none);
                           block =
                             ([Declaration_list.Declaration
                                 {Declaration.name = ("display", Location.none);
                                  value = ([(Component_value.Ident "flex", Location.none)], Location.none);
                                  important = (false, Location.none);
                                  loc = Location.none;
                                 };
                              ], Location.none);
                           loc = Location.none;
                          };],
                       Location.none);
                  loc = Location.none;
                 };
              ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_document () =
  let css =
    {|
@document url("https://www.example.com/") {
  h1 {
    color: green;
  }
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("document", Location.none);
         prelude = (
           [(Component_value.Uri "\"https://www.example.com/\"", Location.none)], Location.none);
         block = Brace_block.Stylesheet
             ([Rule.Style_rule
                 {Style_rule.prelude = ([(Component_value.Ident "h1", Location.none)], Location.none);
                  block =
                    ([Declaration_list.Declaration
                        {Declaration.name = ("color", Location.none);
                         value = ([(Component_value.Ident "green", Location.none)], Location.none);
                         important = (false, Location.none);
                         loc = Location.none;
                        };
                     ], Location.none);
                  loc = Location.none;
                 };],
              Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_font_face () =
  let css =
    {|
@font-face {
  font-family: "Open Sans";
  src: url("/fonts/OpenSans-Regular-webfont.woff2") format("woff2"),
       url("/fonts/OpenSans-Regular-webfont.woff") format("woff");
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("font-face", Location.none);
         prelude = ([], Location.none);
         block = Brace_block.Declaration_list
             ([Declaration_list.Declaration
                 {Declaration.name = ("font-family", Location.none);
                  value = ([(Component_value.String "Open Sans", Location.none)], Location.none);
                  important = (false, Location.none);
                  loc = Location.none;
                 };
               Declaration_list.Declaration
                 {Declaration.name = ("src", Location.none);
                  value = (
                    [(Component_value.Uri "\"/fonts/OpenSans-Regular-webfont.woff2\"", Location.none);
                     (Component_value.Function (
                         ("format", Location.none),
                         ([(Component_value.String "woff2", Location.none)], Location.none)), Location.none);
                     (Component_value.Delim ",", Location.none);
                     (Component_value.Uri "\"/fonts/OpenSans-Regular-webfont.woff\"", Location.none);
                     (Component_value.Function (
                         ("format", Location.none),
                         ([(Component_value.String "woff", Location.none)], Location.none)), Location.none);
                    ], Location.none);
                  important = (false, Location.none);
                  loc = Location.none;
                 };
              ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_keyframes () =
  let css =
    {|
@keyframes slidein {
  from {
    margin-left: 100%;
    width: 300%;
  }

  to {
    margin-left: 0%;
    width: 100%;
  }
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("keyframes", Location.none);
         prelude = (
           [(Component_value.Ident "slidein", Location.none)], Location.none);
         block = Brace_block.Stylesheet
             ([Rule.Style_rule
                 {Style_rule.prelude = ([(Component_value.Ident "from", Location.none)], Location.none);
                  block =
                    ([Declaration_list.Declaration
                        {Declaration.name = ("margin-left", Location.none);
                         value = ([(Component_value.Percentage "100", Location.none)], Location.none);
                         important = (false, Location.none);
                         loc = Location.none;
                        };
                      Declaration_list.Declaration
                        {Declaration.name = ("width", Location.none);
                         value = ([(Component_value.Percentage "300", Location.none)], Location.none);
                         important = (false, Location.none);
                         loc = Location.none;
                        };
                     ], Location.none);
                  loc = Location.none;
                 };
               Rule.Style_rule
                 {Style_rule.prelude = ([(Component_value.Ident "to", Location.none)], Location.none);
                  block =
                    ([Declaration_list.Declaration
                        {Declaration.name = ("margin-left", Location.none);
                         value = ([(Component_value.Percentage "0", Location.none)], Location.none);
                         important = (false, Location.none);
                         loc = Location.none;
                        };
                      Declaration_list.Declaration
                        {Declaration.name = ("width", Location.none);
                         value = ([(Component_value.Percentage "100", Location.none)], Location.none);
                         important = (false, Location.none);
                         loc = Location.none;
                        };
                     ], Location.none);
                  loc = Location.none;
                 };
              ],
              Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_viewport () =
  let css =
    {|
@viewport {
  width: device-width;
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("viewport", Location.none);
         prelude = ([], Location.none);
         block = Brace_block.Declaration_list
             ([Declaration_list.Declaration
                 {Declaration.name = ("width", Location.none);
                  value = ([(Component_value.Ident "device-width", Location.none)], Location.none);
                  important = (false, Location.none);
                  loc = Location.none;
                 };
              ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_counter_style () =
  let css =
    {|
@counter-style thumbs {
  system: cyclic;
  symbols: "\1F44D";
  suffix: " ";
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("counter-style", Location.none);
         prelude = ([(Component_value.Ident "thumbs", Location.none)], Location.none);
         block = Brace_block.Declaration_list
             ([Declaration_list.Declaration
                 {Declaration.name = ("system", Location.none);
                  value = ([(Component_value.Ident "cyclic", Location.none)], Location.none);
                  important = (false, Location.none);
                  loc = Location.none;
                 };
               Declaration_list.Declaration
                 {Declaration.name = ("symbols", Location.none);
                  value = ([(Component_value.String "\\1F44D", Location.none)], Location.none);
                  important = (false, Location.none);
                  loc = Location.none;
                 };
               Declaration_list.Declaration
                 {Declaration.name = ("suffix", Location.none);
                  value = ([(Component_value.String " ", Location.none)], Location.none);
                  important = (false, Location.none);
                  loc = Location.none;
                 };
              ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_at_rule_font_feature_values () =
  let css =
    {|
@font-feature-values Font One {
  @styleset {
    nice-style: 12;
  }
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.At_rule
        {At_rule.name = ("font-feature-values", Location.none);
         prelude = (
           [(Component_value.Ident "Font", Location.none);
            (Component_value.Ident "One", Location.none);
           ], Location.none);
         block = Brace_block.Declaration_list
             ([Declaration_list.At_rule
                 {At_rule.name = ("styleset", Location.none);
                  prelude = ([], Location.none);
                  block = Brace_block.Declaration_list
                      ([Declaration_list.Declaration
                          {Declaration.name = ("nice-style", Location.none);
                           value = ([(Component_value.Number "12", Location.none)], Location.none);
                           important = (false, Location.none);
                           loc = Location.none;
                          };
                       ], Location.none);
                  loc = Location.none;
                 };
              ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_hover_selector () =
  let css =
    {|
:hover {
  color: blue
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.Style_rule
        {Style_rule.prelude = (
            [(Component_value.Delim ":", Location.none);
             (Component_value.Ident "hover", Location.none);
            ], Location.none);
         block = (
           [Declaration_list.Declaration
              {Declaration.name = ("color", Location.none);
               value = ([(Component_value.Ident "blue", Location.none)], Location.none);
               important = (false, Location.none);
               loc = Location.none;
              };
           ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_id_selector () =
  let css =
    {|
#element {
  color: blue
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.Style_rule
        {Style_rule.prelude = (
            [(Component_value.Hash "element", Location.none);
            ], Location.none);
         block = (
           [Declaration_list.Declaration
              {Declaration.name = ("color", Location.none);
               value = ([(Component_value.Ident "blue", Location.none)], Location.none);
               important = (false, Location.none);
               loc = Location.none;
              };
           ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_class_selector () =
  let css =
    {|
.element {
  color: blue
}
|}
  in
  let ast = parse_stylesheet css in
  let expected_ast =
    ([Rule.Style_rule
        {Style_rule.prelude = (
            [(Component_value.Delim ".", Location.none);
             (Component_value.Ident "element", Location.none);
            ], Location.none);
         block = (
           [Declaration_list.Declaration
              {Declaration.name = ("color", Location.none);
               value = ([(Component_value.Ident "blue", Location.none)], Location.none);
               important = (false, Location.none);
               loc = Location.none;
              };
           ], Location.none);
         loc = Location.none;
        };
     ], Location.none)
  in
  Alcotest.(check (testable Css_fmt_printer.dump_stylesheet eq_ast))
    "different CSS AST" expected_ast ast

let test_set =
  [("CSS parser", `Quick, test_stylesheet_parser);
   ("CSS functions", `Quick, test_css_functions);
   ("@page", `Quick, test_at_rule_page);
   ("@charset", `Quick, test_at_rule_charset);
   ("@import", `Quick, test_at_rule_import);
   ("@namespace", `Quick, test_at_rule_namespace);
   ("@media", `Quick, test_at_rule_media);
   ("@supports", `Quick, test_at_rule_supports);
   ("@document", `Quick, test_at_rule_document);
   ("@font-face", `Quick, test_at_rule_font_face);
   ("@keyframes", `Quick, test_at_rule_keyframes);
   ("@viewport", `Quick, test_at_rule_viewport);
   ("@counter-style", `Quick, test_at_rule_counter_style);
   ("@font-feature-values", `Quick, test_at_rule_font_feature_values);
   (":hover selector", `Quick, test_hover_selector);
   ("id selector", `Quick, test_id_selector);
   ("class selector", `Quick, test_class_selector);
  ]
