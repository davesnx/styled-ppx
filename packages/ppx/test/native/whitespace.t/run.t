Whitespace native PPX transformations are checked as a cram snapshot.

  $ ppx-native-test-runner whitespace
  ## Whitespace
  - ignore in empty
    "[%cx \" \"]"
  - ignore in style_rule
    "[%cx \".bar{}\"]"
  - ignore in style_rule
    "[%cx \".bar { } \"]"
  - ignore in declaration list
    "[%cx \"display: block; box-sizing: border-box          ; \"]"
  - ignore in declaration
    "[%cx \" display : block; \"]"
  - ignore in declaration
    "[%cx \" display : block ; \"]"
  - ignore in declaration
    "[%cx \"display:block;\"]"
  - ignore in at_rule inside declarations
    "[%cx \"@media all {  }\"]"
  - ignore in at_rule inside declarations
    "[%cx \"@media all  {  } \"]"
  - ignore in at_rule inside declarations
    "[%cx \"@media(min-width: 30px) {}\"]"
  - ignore in at_rule inside declarations
    "[%cx \"@media screen    and    (min-width: 30px) {}\"]"
  - media with declarations
    "[%cx \"@media    screen and (min-width: 30px  ) { color: red; }\"]"
  - media with multiple preludes
    "[%cx\n  \"@media screen and (min-width: 30px) and (max-height: 16rem) { color: red; }\"]"
  - media with declarations
    "[%cx \".clar {  background-image : url( 'img_tree.gif') ; }\"]"
  - ignore space on declaration url
    "CSS.make \"css-150tv9y-cases\" []"
  - ignore space on values, such as box-shadow
    "[%cx \"box-shadow:    12px 12px 2px 1px rgba(0, 0, 255, 0.2)\"]"
  - ignore space before/after comments values
    "[%cx\n  {|\n  /* standard width 240px - standard padding 8px * 2 */\n  width: 214px;\n|}]"
  - ignore space after comments after rules
    "[%cx {|\n  width: 100%; /* otherwise will overflow container */\n|}]"
  - html, body, #root, .class
    "[%styled.global {|\n    html, body, #root, .class {\n      margin: 0;\n    } |}]"
  - html, body, #root, .class
    "[%styled.global\n  {|\n    html,             body, #root, .class   {     margin: 0    } |}]"
