let get_string_style_rules () =
  let content = CSS.get_stylesheet () in
  let _ = CSS.flush () in
  content

let one_property () =
  let classname = CSS.style [| CSS.display `block |] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" classname)

let multiple_properties () =
  let classname = CSS.style [| CSS.display `block; CSS.fontSize (`px 10) |] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { display: block; font-size: 10px; }" classname)

let multiple_declarations () =
  let classname1 = CSS.style [| CSS.display `block; CSS.fontSize (`px 10) |] in
  let classname2 = CSS.style [| CSS.display `block; CSS.fontSize (`px 99) |] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; font-size: 10px; } .%s { display: block; \
        font-size: 99px; }"
       classname1 classname2)

let label_should_not_be_rendered () =
  let classname = CSS.style [| CSS.label "classname"; CSS.display `block |] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { display: block; }" classname)

let selector_with_ppx () =
  let classname =
    [%cx
      {|
       position: relative;
       & > * {
         position: absolute;
       }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { position: relative; } .%s > * { position: absolute; }" classname
       classname)

let empty_selector_simple () =
  let is_active_classname = [%cx ""] in
  let classname =
    [%cx
      {|
           position: relative;

           & $(is_active_classname) {
             position: absolute;
           }
       |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { position: relative; } .%s %s { position: absolute; }"
       classname classname is_active_classname)

let avoid_hash_collision () =
  let classname1 =
    (* Use actual colors instead of CSS variables for this hash collision test *)
    let color = `hex "333333" in
    let hoverColor = `hex "111111" in
    let disabledColor = `hex "333333" in
    [%cx
      {|
         color: $(color);

         :disabled {
           color: $(disabledColor);
         }

         :hover {
           color: $(hoverColor);
         }
       |}]
  in
  let classname2 =
    let padding = `px 16 in
    [%cx
      {|
         display: flex;

         :before,
         :after {
           content: '';
           flex: 0 0 $(padding);
         }
       |}]
  in
  let classname3 =
    let padding = `px 16 in
    [%cx
      {|
         display: flex;

         :before,
         :after {
           content: '';
           flex: 0 1 $(padding);
         }
       |}]
  in
  let _css = get_string_style_rules () in
  assert_string_not_equal classname1 classname2;
  assert_string_not_equal classname2 classname3;
  assert_string_not_equal classname1 classname3

let float_values () =
  let classname = CSS.style [| CSS.padding (`rem 10.) |] in
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf ".%s { padding: 10rem; }" classname)

let simple_selector () =
  let classname =
    CSS.style
      [|
        CSS.margin @@ CSS.px 10;
        CSS.selectorMany [| "a" |] [| CSS.margin @@ CSS.px 60 |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { margin: 10px; } .%s a { margin: 60px; }" classname
       classname)

let selector_nested () =
  let classname =
    CSS.style
      [|
        CSS.margin @@ CSS.px 10;
        CSS.selectorMany [| "a" |]
          [|
            CSS.display `block;
            CSS.selectorMany [| "div" |] [| CSS.display `none |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { margin: 10px; } .%s a { display: block; } .%s a div { display: \
        none; }"
       classname classname classname)

let selector_nested_with_ampersand () =
  let classname =
    CSS.style
      [|
        CSS.margin @@ CSS.px 10;
        CSS.selectorMany [| "& > a" |]
          [|
            CSS.margin @@ CSS.px 11;
            CSS.selectorMany [| "& > div" |] [| CSS.margin @@ CSS.px 12 |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { margin: 10px; } .%s > a { margin: 11px; } .%s > a > div { \
        margin: 12px; }"
       classname classname classname)

let selector_nested_x10 () =
  let classname =
    CSS.style
      [|
        CSS.display `flex;
        CSS.selectorMany [| "a" |]
          [|
            CSS.display `block;
            CSS.selectorMany [| "div" |]
              [|
                CSS.display `none;
                CSS.selectorMany [| "span" |]
                  [|
                    CSS.display `none;
                    CSS.selectorMany [| "hr" |]
                      [|
                        CSS.display `none;
                        CSS.selectorMany [| "code" |] [| CSS.display `none |];
                      |];
                  |];
              |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: flex; } .%s a { display: block; } .%s a div { display: \
        none; } .%s a div span { display: none; } .%s a div span hr { display: \
        none; } .%s a div span hr code { display: none; }"
       classname classname classname classname classname classname)

let selector_ampersand_with_space () =
  let classname =
    CSS.style
      [|
        CSS.fontSize (`px 42);
        CSS.selectorMany [| "& .div" |] [| CSS.fontSize (`px 24) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s .div { font-size: 24px; }"
       classname classname)

let ampersand_everywhere () =
  let classname =
    [%cx
      {|
      font-size: 1px;
      & .lola {
        font-size: 2px;
      }
      & .lola & {
        font-size: 3px;
      }
      .lola & {
        font-size: 4px;
      }
      .lola {
        font-size: 5px;
      }
      .lola & & & & .lola {
        font-size: 6px;
      }
      .a {
        .b & {
          color: yellow;
          .c & {
            margin: 1px;
          }
        }
      }
    |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { font-size: 1px; } .%s .lola { font-size: 2px; } .%s .lola .%s { \
        font-size: 3px; } .lola .%s { font-size: 4px; } .%s .lola { font-size: \
        5px; } .lola .%s .%s .%s .%s .lola { font-size: 6px; } .b .%s .a { \
        color: #FFFF00; } .c .b .%s .a { margin: 1px; }"
       classname classname classname classname classname classname classname
       classname classname classname classname classname)

let ampersand_everywhere_2 () =
  let classname =
    [%cx
      {|
      font-size: 1px;
      & .lola {
        .felipe & {
          display: none;
        }
      }
      .lola {
        .felipe & {
          display: none;
        }
      }

      &:first-child {
        .felipe & {
          display: none;
        }
      }
      :first-child {
        .felipe & {
          display: none;
        }
      }
    |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { font-size: 1px; } .felipe .%s .lola { display: none; } .felipe \
        .%s .lola { display: none; } .felipe .%s:first-child { display: none; \
        } .felipe .%s:first-child { display: none; }"
       classname classname classname classname classname)

let ampersand_everywhere_3 () =
  let hasTwoColumnList = "css-1t4likh-hasTwoColumnList" in
  let borderColor = CSS.rgba 255 255 255 (`num 0.3) in
  let desktopDown = "(max-width: 1279px)" in
  let px16 = `px 16 in
  let classname =
    [%cx
      {|
        margin: 0;
        padding: 0;
        list-style-type: none;

        :first-child {
          .$(hasTwoColumnList) & {
            @media $(desktopDown) {
              padding-bottom: $(px16);
              border-bottom: 1px solid $(borderColor);
            }
          }
        }
    |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { margin: 0; padding: 0; list-style-type: none; } @media \
        (max-width: 1279px) { .css-1t4likh-hasTwoColumnList .%s:first-child { \
        padding-bottom: 16px; border-bottom: 1px solid rgba(255, 255, 255, \
        0.3); } }"
       classname classname)

let pseudo_selectors_everywhere () =
  let classname =
    [%cx
      {|
        display: block;

        ::before {
          display: none;
          ::after {
            display: none;
          }
        }
    |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } .%s::before { display: none; } \
        .%s::before::after { display: none; }"
       classname classname classname)

let selector_ampersand_with_no_space () =
  let classname =
    CSS.style
      [|
        CSS.fontSize (`px 42);
        CSS.selectorMany [| "&.div" |] [| CSS.fontSize (`px 24) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s.div { font-size: 24px; }"
       classname classname)

let selector_ampersand_at_the_middle () =
  let classname =
    CSS.style
      [|
        CSS.fontSize (`px 42);
        CSS.selectorMany [| "& div &" |] [| CSS.fontSize (`px 24) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { font-size: 42px; } .%s div .%s { font-size: 24px; }"
       classname classname classname)

let selector_nested_with_mq_and_declarations () =
  let mobile = "(max-width: 767px)" in
  let classname =
    [%cx
      {|
      li {
       list-style-type: none;

       ::before {
         position: absolute;
         left: -20px;
         content: "✓";
       }

       @media $(mobile) {
         position: relative;
       }
      }
    |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s li { list-style-type: none; } .%s li::before { position: absolute; \
        left: -20px; content: \"✓\"; } @media (max-width: 767px) { .%s li { \
        position: relative; } }"
       classname classname classname)

let selector_nested_with_mq_and_declarations2 () =
  let mobile = "(max-width: 767px)" in
  let classname =
    [%cx
      {|
      .a {
        color: red;
        @media $(mobile) {
          height: 1px;
          .d {
            color: green;
          }
        }
        .b {
          color: blue;
          @media $(mobile) {
            height: 2px;
            .c {
              color: yellow;
            }
          }
        }
      }
    |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s .a { color: #FF0000; } .%s .a .b { color: #0000FF; } @media \
        (max-width: 767px) { .%s .a .b { height: 2px; } .%s .a .b .c { color: \
        #FFFF00; } } @media (max-width: 767px) { .%s .a { height: 1px; } .%s \
        .a .d { color: #008000; } }"
       classname classname classname classname classname classname)

let mq () =
  let classname =
    CSS.style
      [|
        CSS.maxWidth (`px 800);
        CSS.media "(max-width: 768px)" [| CSS.width (`px 300) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (max-width: 768px) { .%s { width: \
        300px; } }"
       classname classname)

let selector_params () =
  let classname =
    CSS.style
      [|
        CSS.maxWidth (`px 800);
        CSS.selectorMany [| {js|:first-child|js} |] [| CSS.width (`px 300) |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } .%s:first-child { width: 300px; }" classname
       classname)

let keyframe () =
  let animationName =
    CSS.keyframes
      [|
        0, [| CSS.transform (`rotate (`deg 0.)) |];
        100, [| CSS.transform (`rotate (`deg (-360.))) |];
      |]
  in
  let classname = CSS.style [| CSS.animationName animationName |] in
  let animationName = Css_types.AnimationName.toString animationName in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       "@keyframes %s { 0%% { -webkit-transform: rotate(0deg); -moz-transform: \
        rotate(0deg); -ms-transform: rotate(0deg); transform: rotate(0deg); } \
        100%% { -webkit-transform: rotate(-360deg); -moz-transform: \
        rotate(-360deg); -ms-transform: rotate(-360deg); transform: \
        rotate(-360deg); } } .%s { -webkit-animation-name: %s; animation-name: \
        %s; }"
       animationName classname animationName animationName)

let global () =
  CSS.global
    [| CSS.selectorMany [| "html" |] [| CSS.lineHeight (`abs 1.15) |] |];
  let css = get_string_style_rules () in
  assert_string css (Printf.sprintf "html{line-height:1.15;}")

let fontFace () =
  let _ =
    CSS.fontFace ~fontFamily:(`quoted "foo") ~fontWeight:`bold
      ~src:[| `url "foo.bar" |]
      ~fontDisplay:`swap ~fontStyle:`normal ()
      ~unicodeRange:
        [| `wildcard ("30", "??"); `range ("3040", "309F"); `single "30A0" |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       "@font-face{font-style:normal;font-weight:700;font-display:swap;unicode-range:U+30??, \
        U+3040-309F, U+30A0;font-family:\"foo\";src:url(\"foo.bar\");}")

let duplicated_styles_unique () =
  let classname1 = CSS.style [| CSS.flexGrow 1. |] in
  let classname2 = CSS.style [| CSS.flexGrow 1. |] in
  let css = get_string_style_rules () in
  assert_string classname1 classname2;
  assert_string css (Printf.sprintf ".%s { flex-grow: 1; }" classname1)

let hover_selector () =
  let rules =
    [|
      CSS.color `currentColor;
      CSS.selectorMany [| ":hover" |] [| CSS.color `transparent |];
      CSS.selectorMany [| "&:hover" |] [| CSS.color `transparent |];
      CSS.selectorMany [| " :hover" |] [| CSS.color `transparent |];
    |]
  in
  let classname = CSS.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { color: currentColor; } .%s:hover { color: transparent; } \
        .%s:hover { color: transparent; } .%s  :hover { color: transparent; }"
       classname classname classname classname)

let multiple_pseudo () =
  let classname =
    [%cx
      {|
           padding: 0;

           &::before,
           &::after {
             content: " ";
             transform: translateX(-50%);
           }
           |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { padding: 0; } .%s::before { content: ' '; -webkit-transform: \
        translateX(-50%%); -moz-transform: translateX(-50%%); -ms-transform: \
        translateX(-50%%); transform: translateX(-50%%); } .%s::after { \
        content: ' '; -webkit-transform: translateX(-50%%); -moz-transform: \
        translateX(-50%%); -ms-transform: translateX(-50%%); transform: \
        translateX(-50%%); }"
       classname classname classname)

let functional_pseudo () =
  let classname =
    [%cx
      {|
        .foo, .bar {
          :is(ol, ul, menu:unsupported) :is(ol, ul) {
            color: green;
          }

          :is(ol, ul) :is(ol, ul) ol {
            list-style-type: lower-greek;
            color: chocolate;
          }

          p:not(.irrelevant) {
            font-weight: bold;
          }

          p > :not(strong, b.important) {
            color: darkmagenta;
          }

          :where(ol, ul, menu:unsupported) :where(ol, ul) {
            color: green;
          }

          :where(ol, ul) :where(ol, ul) ol {
            list-style-type: lower-greek;
            color: chocolate;
          }

          :is(h1, h2, h3):has(+ :is(h2, h3, h4)) {
            margin: 0 0 0.25rem 0;
          }

          body:has(video, audio), body:has(video):has(audio) {
            color: red;
          }
        }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s .foo:is(ol, ul, menu:unsupported) :is(ol, ul) { color: #008000; } \
        .%s .foo:is(ol, ul) :is(ol, ul) ol { list-style-type: lower-greek; \
        color: #D2691E; } .%s .foo p:not(.irrelevant) { font-weight: 700; } \
        .%s .foo p > :not(strong, b.important) { color: #8B008B; } .%s \
        .foo:where(ol, ul, menu:unsupported) :where(ol, ul) { color: #008000; \
        } .%s .foo:where(ol, ul) :where(ol, ul) ol { list-style-type: \
        lower-greek; color: #D2691E; } .%s .foo:is(h1, h2, h3):has(+ :is(h2, \
        h3, h4)) { margin: 0 0 0.25rem 0; } .%s .foo body:has(video, audio) { \
        color: #FF0000; } .%s .foo body:has(video):has(audio) { color: \
        #FF0000; } .%s .bar:is(ol, ul, menu:unsupported) :is(ol, ul) { color: \
        #008000; } .%s .bar:is(ol, ul) :is(ol, ul) ol { list-style-type: \
        lower-greek; color: #D2691E; } .%s .bar p:not(.irrelevant) { \
        font-weight: 700; } .%s .bar p > :not(strong, b.important) { color: \
        #8B008B; } .%s .bar:where(ol, ul, menu:unsupported) :where(ol, ul) { \
        color: #008000; } .%s .bar:where(ol, ul) :where(ol, ul) ol { \
        list-style-type: lower-greek; color: #D2691E; } .%s .bar:is(h1, h2, \
        h3):has(+ :is(h2, h3, h4)) { margin: 0 0 0.25rem 0; } .%s .bar \
        body:has(video, audio) { color: #FF0000; } .%s .bar \
        body:has(video):has(audio) { color: #FF0000; }"
       classname classname classname classname classname classname classname
       classname classname classname classname classname classname classname
       classname classname classname classname)

let nested_selectors () =
  let button_active = [%cx "position: relative;"] in
  let classname = [%cx {|
        &.$(button_active) { top: 50px; }
      |}] in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { position: relative; } .%s.%s { top: 50px; }"
       button_active classname button_active)

let nested_selectors_2 () =
  let button_active = [%cx "position: relative;"] in
  let classname =
    [%cx {|
        &.$(button_active) & { top: 50px; }
      |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { position: relative; } .%s.%s .%s { top: 50px; }"
       button_active classname button_active classname)

let selectors_with_coma () =
  let classname =
    [%cx
      {|
         position: relative;

         &.lola,
         & a {
           top: 50px;
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { position: relative; } .%s.lola { top: 50px; } .%s a { top: 50px; \
        }"
       classname classname classname)

let selectors_with_coma_simple () =
  let classname =
    [%cx {|
       .a, .b {
         top: 50px;
       }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s .a { top: 50px; } .%s .b { top: 50px; }" classname
       classname)

let selectors_with_coma_and_pseudo () =
  let classname =
    [%cx
      {|
         position: relative;

         &::before,
         &::after {
           top: 50px;
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { position: relative; } .%s::before { top: 50px; } .%s::after { \
        top: 50px; }"
       classname classname classname)

let selector_nested_with_pseudo () =
  let classname =
    [%cx
      {|
         position: relative;
         &:hover {
           &::after {
             top: 50px;
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { position: relative; } .%s:hover::after { top: 50px; }" classname
       classname)

let selector_nested_with_pseudo_2 () =
  let classname =
    [%cx
      {|
         position: relative;
         :hover {
           ::after {
             top: 50px;
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { position: relative; } .%s:hover::after { top: 50px; }" classname
       classname)

let selector_nested_with_pseudo_3 () =
  let classname =
    [%cx
      {|
         position: relative;
         &:hover {
           & ::after {
             top: 50px;
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { position: relative; } .%s:hover ::after { top: 50px; }" classname
       classname)

let selector_with_interp_and_pseudo () =
  let button_active = [%cx "position: absolute;"] in
  let rules =
    [|
      CSS.cursor `pointer;
      CSS.selectorMany
        [| {js|&.|js} ^ button_active ^ {js|::before|js} |]
        [| CSS.top (`pxFloat 50.) |];
    |]
  in
  let classname = CSS.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { position: absolute; } .%s { cursor: pointer; } .%s.%s::before { \
        top: 50px; }"
       button_active classname classname button_active)

let selector_with_empty_interp () =
  let empty_classname = [%cx ""] in
  let classname =
    [%cx
      {|
           position: absolute;
           &.$(empty_classname)::before {
             top: 50px;
           }
         |}]
  in

  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf ".%s { position: absolute; } .%s.%s::before { top: 50px; }"
       classname classname empty_classname)

let style_tag () =
  CSS.global
    [| CSS.selectorMany [| "html" |] [| CSS.lineHeight (`abs 1.15) |] |];
  let animationName =
    CSS.keyframes
      [|
        0, [| CSS.transform (`rotate (`deg 0.)) |];
        100, [| CSS.transform (`rotate (`deg (-360.))) |];
      |]
  in
  let animationName = Css_types.AnimationName.toString animationName in
  let animationNameHash =
    String.sub animationName 10 (String.length animationName - 10)
  in
  let classname = CSS.style [| CSS.display `block |] in
  let classname_hash = String.sub classname 4 (String.length classname - 4) in
  let css = CSS.style_tag () |> ReactDOM.renderToString in
  let _ = CSS.flush () in
  (* This is the hash of the global styles, since we don't capture it with global, we inline it for the test *)
  let global_hash = "18zdck7" in
  assert_string css
    (Printf.sprintf
       "<style data-emotion=\"css %s %s %s\" data-s>html{line-height:1.15;} \
        @keyframes %s { 0%% { -webkit-transform: rotate(0deg); -moz-transform: \
        rotate(0deg); -ms-transform: rotate(0deg); transform: rotate(0deg); } \
        100%% { -webkit-transform: rotate(-360deg); -moz-transform: \
        rotate(-360deg); -ms-transform: rotate(-360deg); transform: \
        rotate(-360deg); } } .%s { display: block; }</style>"
       global_hash animationNameHash classname_hash animationName classname)

let mq_inside_selector () =
  let classname =
    [%cx
      {|
         display: block;
         & div {
           @media (min-width: 768px) {
             height: auto;
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s div { height: \
        auto; } }"
       classname classname)

let mq_inside_selector_with_declarations () =
  let classname =
    [%cx
      {|
         display: block;
         & div {
           display: flex;
           @media (min-width: 768px) {
             height: auto;
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } .%s div { display: flex; } @media (min-width: \
        768px) { .%s div { height: auto; } }"
       classname classname classname)

let mq_and_selectors_2 () =
  let classname =
    [%cx
      {|
         display: block;
         & div {
           display: flex;
           @media (min-width: 768px) {
             a {
               height: auto;
             }
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } .%s div { display: flex; } @media (min-width: \
        768px) { .%s div a { height: auto; } }"
       classname classname classname)

let selector_nested_interpolation_with_multiple () =
  let languageIcon = [%cx {| opacity: 0.6; |}] in
  let menuOpened = [%cx {||}] in
  let classname =
    [%cx
      {|
  &:hover, .$(menuOpened) {
    &.$(languageIcon) {
      opacity: 1.0;
    }
  }
|}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { opacity: 0.6; } .%s:hover.%s { opacity: 1; } .%s .%s.%s { \
        opacity: 1; }"
       languageIcon classname languageIcon classname menuOpened languageIcon)

let selector_with_classname_and_mq () =
  let nested_classname = CSS.style [||] in
  let rules =
    [|
      CSS.display `block;
      CSS.selectorMany
        [| ".lola ." ^ nested_classname |]
        [| CSS.media "(min-width: 768px)" [| CSS.height `auto |] |];
    |]
  in
  let classname = CSS.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s .lola .%s { \
        height: auto; } }"
       classname classname nested_classname)

let mq_with_selectors () =
  let rules =
    [|
      CSS.display `block;
      CSS.media "(min-width: 768px)"
        [|
          CSS.height `auto;
          CSS.selectorMany [| ".lola" |] [| CSS.color `transparent |];
        |];
    |]
  in
  let classname = CSS.style rules in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { display: block; } @media (min-width: 768px) { .%s { height: \
        auto; } .%s .lola { color: transparent; } }"
       classname classname classname)

let mq_nested () =
  let classname =
    CSS.style
      [|
        CSS.maxWidth (`px 800);
        CSS.media "(min-width: 300px)"
          [| CSS.media "(max-width: 768px)" [| CSS.display `flex |] |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (min-width: 300px) and (max-width: \
        768px) { .%s { display: flex; } }"
       classname classname)

let mq_nested_2 () =
  let classname =
    CSS.style
      [|
        CSS.maxWidth (`px 800);
        CSS.media "(min-width: 300px)"
          [|
            CSS.position `fixed;
            CSS.media "(max-width: 768px)" [| CSS.display `flex |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (min-width: 300px) { .%s { position: \
        fixed; } } @media (min-width: 300px) and (max-width: 768px) { .%s { \
        display: flex; } }"
       classname classname classname)

let mq_nested_3 () =
  let classname =
    [%cx
      {|
         max-width: 800px;
         @media (min-width: 300px) {
           margin-left: 10px;
           @media (max-width: 768px) {
             position: fixed;
             @media (max-width: 1200px) {
               border: 1px solid transparent;
             }
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (min-width: 300px) { .%s { \
        margin-left: 10px; } } @media (min-width: 300px) and (max-width: \
        768px) { .%s { position: fixed; } } @media (min-width: 300px) and \
        (max-width: 768px) and (max-width: 1200px) { .%s { border: 1px solid \
        transparent; } }"
       classname classname classname classname)

let mq_nested_10 () =
  let classname =
    [%cx
      {|
         max-width: 800px;
         @media (min-width: 300px) {
           margin-left: 10px;
           @media (max-width: 768px) {
             position: fixed;
             @media (max-width: 1200px) {
               border: 1px solid transparent;
               @media (max-width: 1200px) {
                 border: 1px solid transparent;
                 @media (max-width: 1200px) {
                 border: 1px solid transparent;
                   @media (max-width: 1200px) {
                     border: 1px solid transparent;
                   }
                 }
               }
             }
           }
         }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { max-width: 800px; } @media (min-width: 300px) { .%s { \
        margin-left: 10px; } } @media (min-width: 300px) and (max-width: \
        768px) { .%s { position: fixed; } } @media (min-width: 300px) and \
        (max-width: 768px) and (max-width: 1200px) { .%s { border: 1px solid \
        transparent; } } @media (min-width: 300px) and (max-width: 768px) and \
        (max-width: 1200px) and (max-width: 1200px) { .%s { border: 1px solid \
        transparent; } } @media (min-width: 300px) and (max-width: 768px) and \
        (max-width: 1200px) and (max-width: 1200px) and (max-width: 1200px) { \
        .%s { border: 1px solid transparent; } } @media (min-width: 300px) and \
        (max-width: 768px) and (max-width: 1200px) and (max-width: 1200px) and \
        (max-width: 1200px) and (max-width: 1200px) { .%s { border: 1px solid \
        transparent; } }"
       classname classname classname classname classname classname classname)

let mq_nested_without_declarations () =
  let classname =
    CSS.style
      [|
        CSS.media "(min-width: 300px)"
          [| CSS.media "(max-width: 500px)" [| CSS.display `flex |] |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       "@media (min-width: 300px) and (max-width: 500px) { .%s { display: \
        flex; } }"
       classname)

let mq_nested_with_declarations () =
  let classname =
    CSS.style
      [|
        CSS.color `transparent;
        CSS.media "(min-width: 300px)"
          [|
            CSS.margin (`px 10);
            CSS.media "(max-width: 400px)" [| CSS.borderRadius (`px 10) |];
          |];
      |]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { color: transparent; } @media (min-width: 300px) { .%s { margin: \
        10px; } } @media (min-width: 300px) and (max-width: 400px) { .%s { \
        border-radius: 10px; } }"
       classname classname classname)

let pseudo_selectors () =
  let classname =
    [%cx
      {|
       box-sizing: border-box;
       padding-top: 9px;
       padding-bottom: 9px;
       border-radius: 0;

       ::placeholder {
         color: currentColor;
       }

       :hover {
         border: 1px solid transparent;
       }

       :focus {
         outline: none;
       }

       :disabled {
         color: transparent;
       }|}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { box-sizing: border-box; padding-top: 9px; padding-bottom: 9px; \
        border-radius: 0; } .%s::placeholder { color: currentColor; } \
        .%s:hover { border: 1px solid transparent; } .%s:focus { outline: \
        none; } .%s:disabled { color: transparent; }"
       classname classname classname classname classname)

let real_world () =
  let buttonActive = [%cx ""] in
  let classname =
    [%cx
      {|
           padding: 0;

           &.$(buttonActive) {
             margin: 0px;

             ::before,
             ::after {
               top: 40px;
             }
           }
     |}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { padding: 0; } .%s.%s { margin: 0px; } .%s.%s::before { top: \
        40px; } .%s.%s::after { top: 40px; }"
       classname classname buttonActive classname buttonActive classname
       buttonActive)

let pseudo_selectors_2 () =
  let classname =
    [%cx
      {|
       box-sizing: border-box;
       padding-top: 9px;
       padding-bottom: 9px;
       border-radius: 0;

       &::placeholder {
         color: currentColor;
       }

       &:hover {
         border: 1px solid transparent;
       }

       &:focus {
         outline: none;
       }

       &:disabled {
         color: transparent;
       }|}]
  in
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf
       ".%s { box-sizing: border-box; padding-top: 9px; padding-bottom: 9px; \
        border-radius: 0; } .%s::placeholder { color: currentColor; } \
        .%s:hover { border: 1px solid transparent; } .%s:focus { outline: \
        none; } .%s:disabled { color: transparent; }"
       classname classname classname classname classname)

let global_with_selector () =
  [%global
    {| html { line-height: 1.15; }
    a { :hover { padding: 0; } }
   |}];
  let css = get_string_style_rules () in
  assert_string css
    (Printf.sprintf "html{line-height:1.15;}a:hover{padding:0;}")

let ampersand_everywhere_global () =
  [%global
    {|
      .foo {
        &[data-foo=bar] .lola {
          font-size: 2px;
        }
        & .lola &::placeholder {
          font-size: 3px;
        }
        .lola &:not(a) {
          font-size: 4px;
        }
        .lola {
          font-size: 5px;
        }
        .lola & &:focus & & .lola {
          font-size: 6px;
        }
      }
    |}];
  let css = get_string_style_rules () in
  assert_string css
    ".foo[data-foo=bar] .lola{font-size:2px;}.foo .lola \
     .foo::placeholder{font-size:3px;}.lola .foo:not(a){font-size:4px;}.foo \
     .lola{font-size:5px;}.lola .foo .foo:focus .foo .foo \
     .lola{font-size:6px;}"

let css_variable () =
  [%global
    {|
      :root {
        --bs-dropdown-bg: #343a40;
        --bs-dropdown-border-color: var(--bs-border-color-translucent, black);
        --bs-dropdown-box-shadow: ;
      }
    |}];
  let css = get_string_style_rules () in
  assert_string css
    ":root{--bs-dropdown-bg:#343a40;--bs-dropdown-border-color:var(--bs-border-color-translucent, \
     black);--bs-dropdown-box-shadow:;}"

let attribute_selector () =
  [%global
    {|
      [list]:not([type=date]):not([type=datetime-local]):not([type=month]):not([type=week]):not([type=time])::-webkit-calendar-picker-indicator {
        display: none !important;
      }

      button,
      [type=button],
      [type=reset],
      [type=submit] {
        -webkit-appearance: button;
      }
      button:not(:disabled),
      [type=button]:not(:disabled),
      [type=reset]:not(:disabled),
      [type=submit]:not(:disabled) {
        cursor: pointer;
      }
    |}];
  let css = get_string_style_rules () in
  assert_string css
    "[list]:not([type=date]):not([type=datetime-local]):not([type=month]):not([type=week]):not([type=time])::-webkit-calendar-picker-indicator{display:none \
     !important;}button{-webkit-appearance:button;}[type=button]{-webkit-appearance:button;}[type=reset]{-webkit-appearance:button;}[type=submit]{-webkit-appearance:button;}button:not(:disabled){cursor:pointer;}[type=button]:not(:disabled){cursor:pointer;}[type=reset]:not(:disabled){cursor:pointer;}[type=submit]:not(:disabled){cursor:pointer;}"

let tests =
  [
    test "one_property" one_property;
    test "multiple_properties" multiple_properties;
    test "multiple_declarations" multiple_declarations;
    test "float_values" float_values;
    test "label_should_not_be_rendered" label_should_not_be_rendered;
    test "avoid_hash_collision" avoid_hash_collision;
    test "keyframe" keyframe;
    test "global" global;
    test "fontFace" fontFace;
    test "duplicated_styles_unique" duplicated_styles_unique;
    test "style_tag" style_tag;
    test "real_world" real_world;
    test "hover_selector" hover_selector;
    test "selector_with_classname_and_mq" selector_with_classname_and_mq;
    test "selector_with_empty_interp" selector_with_empty_interp;
    test "empty_selector_simple" empty_selector_simple;
    test "selector_with_ppx" selector_with_ppx;
    test "simple_selector" simple_selector;
    test "selector_nested" selector_nested;
    test "selector_nested_x10" selector_nested_x10;
    test "selector_ampersand_with_space" selector_ampersand_with_space;
    test "selector_ampersand_with_no_space" selector_ampersand_with_no_space;
    test "selector_nested_with_ampersand" selector_nested_with_ampersand;
    test "selector_ampersand_at_the_middle" selector_ampersand_at_the_middle;
    test "ampersand_everywhere" ampersand_everywhere;
    test "ampersand_everywhere_2" ampersand_everywhere_2;
    test "ampersand_everywhere_3" ampersand_everywhere_3;
    test "selector_params" selector_params;
    test "selectors_with_coma" selectors_with_coma;
    test "selectors_with_coma_simple" selectors_with_coma_simple;
    test "selectors_with_coma_and_pseudo" selectors_with_coma_and_pseudo;
    test "nested_selectors" nested_selectors;
    test "nested_selectors_2" nested_selectors_2;
    test "multiple_pseudo" multiple_pseudo;
    test "functional_pseudo" functional_pseudo;
    test "selector_with_interp_and_pseudo" selector_with_interp_and_pseudo;
    test "pseudo_selectors" pseudo_selectors;
    test "pseudo_selectors_2" pseudo_selectors_2;
    test "pseudo_selectors_everywhere" pseudo_selectors_everywhere;
    test "selector_nested_with_pseudo" selector_nested_with_pseudo;
    test "selector_nested_with_pseudo_2" selector_nested_with_pseudo_2;
    test "selector_nested_with_pseudo_3" selector_nested_with_pseudo_3;
    test "selector_nested_with_mq_and_declarations"
      selector_nested_with_mq_and_declarations;
    test "selector_nested_with_mq_and_declarations2"
      selector_nested_with_mq_and_declarations2;
    test "selector_nested_interpolation_with_multiple"
      selector_nested_interpolation_with_multiple;
    test "mq_with_selectors" mq_with_selectors;
    test "mq" mq;
    test "mq_nested" mq_nested;
    test "mq_nested_2" mq_nested_2;
    test "mq_nested_with_declarations" mq_nested_with_declarations;
    test "mq_nested_without_declarations" mq_nested_without_declarations;
    test "mq_nested_10" mq_nested_10;
    test "mq_nested_3" mq_nested_3;
    test "mq_inside_selector" mq_inside_selector;
    test "mq_inside_selector_with_declarations"
      mq_inside_selector_with_declarations;
    test "mq_and_selectors_2" mq_and_selectors_2;
    test "global_with_selector" global_with_selector;
    test "ampersand_everywhere_global" ampersand_everywhere_global;
    test "css_variable" css_variable;
    test "attribute_selector" attribute_selector;
  ]
