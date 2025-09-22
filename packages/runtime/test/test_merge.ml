let get_string_style_rules () =
  let content = CSS.get_stylesheet () in
  let _ = CSS.flush () in
  content

module String = struct
  include Stdlib.String

  let contains substr str =
    try
      let _ = Str.search_forward (Str.regexp_string substr) str 0 in
      true
    with Not_found -> false
end

let get_style_prop propName (style : ReactDOM.Style.t) =
  let rec find_last acc = function
    | [] -> acc
    | (kebab, jsx, value) :: rest ->
      if jsx = propName || kebab = propName then find_last (Some value) rest
      else find_last acc rest
  in
  find_last None style

let has_style_prop propName (style : ReactDOM.Style.t) =
  match get_style_prop propName style with Some _ -> true | None -> false

let merge_classnames_only () =
  let className, _styles =
    CSS.merge (CSS.make "class1" []) (CSS.make "class2" [])
  in
  check ~__POS__ Alcotest.string className "class1 class2"

let merge_empty_first_classname () =
  let className, _styles = CSS.merge (CSS.make "" []) (CSS.make "class2" []) in
  check ~__POS__ Alcotest.string className "class2"

let merge_empty_second_classname () =
  let className, _styles = CSS.merge (CSS.make "class1" []) (CSS.make "" []) in
  check ~__POS__ Alcotest.string className "class1"

let merge_both_empty_classnames () =
  let className, styles = CSS.merge (CSS.make "" []) (CSS.make "" []) in
  check ~__POS__ Alcotest.string className "";
  check ~__POS__
    (Alcotest.list
       (Alcotest.triple Alcotest.string Alcotest.string Alcotest.string))
    styles []

let merge_css_generated_classnames () =
  let class1 = CSS.style [| CSS.display `block |] in
  let class2 = CSS.style [| CSS.color (CSS.hex "FF0000") |] in
  let className, styles = CSS.merge (CSS.make class1 []) (CSS.make class2 []) in
  let css = get_string_style_rules () in
  check ~__POS__ Alcotest.bool (String.contains class1 className) true;
  check ~__POS__ Alcotest.bool (String.contains class2 className) true;
  check ~__POS__ Alcotest.bool (String.contains "display: block" css) true;
  check ~__POS__ Alcotest.bool (String.contains "color: #FF0000" css) true;
  check ~__POS__
    (Alcotest.list
       (Alcotest.triple Alcotest.string Alcotest.string Alcotest.string))
    styles []

let merge_identical_classnames () =
  let class1 = CSS.style [| CSS.display `block |] in
  let className, _styles =
    CSS.merge (CSS.make class1 []) (CSS.make class1 [])
  in
  check ~__POS__ Alcotest.string className
    (Printf.sprintf "%s %s" class1 class1)

let merge_with_inline_styles () =
  let className, styles =
    CSS.merge
      (CSS.make "class1" [ "--text-color", "blue"; "--padding-size", "10px" ])
      (CSS.make "class2" [ "--text-color", "red"; "--margin-size", "5px" ])
  in
  check ~__POS__ Alcotest.string className "class1 class2";
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--text-color" styles)
    (Some "red");
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--padding-size" styles)
    (Some "10px");
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--margin-size" styles)
    (Some "5px")

let merge_generated_with_custom () =
  let generatedClass =
    CSS.style [| CSS.position `relative; CSS.top (`px 10) |]
  in
  let customClass = "my-custom-class" in
  let className, _styles =
    CSS.merge (CSS.make generatedClass []) (CSS.make customClass [])
  in
  check ~__POS__ Alcotest.bool (String.contains generatedClass className) true;
  check ~__POS__ Alcotest.bool (String.contains customClass className) true;
  let css = get_string_style_rules () in
  check ~__POS__ Alcotest.bool (String.contains "position: relative" css) true;
  check ~__POS__ Alcotest.bool (String.contains "top: 10px" css) true

let merge_complex_with_ppx () =
  let baseButton =
    [%cx
      {|
        padding: 10px 20px;
        border-radius: 4px;
        cursor: pointer;
      |}]
  in
  let primaryButton =
    [%cx {|
        background-color: blue;
        color: white;
      |}]
  in
  let className, _styles =
    CSS.merge (CSS.make baseButton []) (CSS.make primaryButton [])
  in
  let css = get_string_style_rules () in
  check ~__POS__ Alcotest.bool (String.contains baseButton className) true;
  check ~__POS__ Alcotest.bool (String.contains primaryButton className) true;
  check ~__POS__ Alcotest.bool (String.contains "padding: 10px 20px" css) true;
  check ~__POS__ Alcotest.bool (String.contains "border-radius: 4px" css) true;
  check ~__POS__ Alcotest.bool (String.contains "cursor: pointer" css) true;
  check ~__POS__ Alcotest.bool
    (String.contains "background-color: #0000FF" css)
    true;
  check ~__POS__ Alcotest.bool (String.contains "color: #FFFFFF" css) true

let merge_css_variables_appending () =
  let className, styles =
    CSS.merge
      (CSS.make "theme-light"
         [ "--primary-color", "#007bff"; "--spacing", "8px" ])
      (CSS.make "theme-custom"
         [ "--secondary-color", "#28a745"; "--font-size", "16px" ])
  in
  check ~__POS__ Alcotest.string className "theme-light theme-custom";
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--primary-color" styles)
    (Some "#007bff");
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--spacing" styles)
    (Some "8px");
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--secondary-color" styles)
    (Some "#28a745");
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--font-size" styles)
    (Some "16px")

let merge_css_variables_overriding () =
  let className, styles =
    CSS.merge
      (CSS.make "theme-light"
         [ "--primary-color", "#007bff"; "--spacing", "8px" ])
      (CSS.make "theme-custom"
         [ "--primary-color", "#28a745"; "--spacing", "16px" ])
  in
  check ~__POS__ Alcotest.string className "theme-light theme-custom";
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--primary-color" styles)
    (Some "#28a745");
  check ~__POS__
    Alcotest.(option string)
    (get_style_prop "--spacing" styles)
    (Some "16px")

let merge_css_variables_both_empty () =
  let className, styles =
    CSS.merge (CSS.make "theme-light" []) (CSS.make "theme-custom" [])
  in
  check ~__POS__ Alcotest.string className "theme-light theme-custom";
  check ~__POS__
    (Alcotest.list
       (Alcotest.triple Alcotest.string Alcotest.string Alcotest.string))
    styles []

let tests =
  [
    test "merge_classnames_only" merge_classnames_only;
    test "merge_empty_first_classname" merge_empty_first_classname;
    test "merge_empty_second_classname" merge_empty_second_classname;
    test "merge_both_empty_classnames" merge_both_empty_classnames;
    test "merge_css_generated_classnames" merge_css_generated_classnames;
    test "merge_identical_classnames" merge_identical_classnames;
    test "merge_with_inline_styles" merge_with_inline_styles;
    test "merge_generated_with_custom" merge_generated_with_custom;
    test "merge_complex_with_ppx" merge_complex_with_ppx;
    test "merge_css_variables_appending" merge_css_variables_appending;
    test "merge_css_variables_overriding" merge_css_variables_overriding;
    test "merge_css_variables_both_empty" merge_css_variables_both_empty;
  ]
