This test ensures the ppx generates the correct output against styled-ppx.css_native
If this test fail means that Css_Js_Core or CssJs_Legacy_Core (from styled-ppx.css or styled-ppx.css_native) are not in sync with the ppx

This test only runs against Css_Js_Core from styled-ppx.css_native

  $ cat >dune-project <<EOF
  > (lang dune 3.10)
  > EOF

  $ cat >dune <<EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.emotion_native styled-ppx.css_native)
  >  (preprocess (pps styled-ppx.lib)))
  > EOF

  $ dune build
  File "input.re", line 2, characters 16-24:
  Error: This expression has type [> `gri ]
         but an expression was expected of type
           [< `block
            | `contents
            | `flex
            | `flow
            | `flowRoot
            | `grid
            | `inherit_
            | `initial
            | `inline
            | `inlineBlock
            | `inlineFlex
            | `inlineGrid
            | `inlineTable
            | `listItem
            | `mozBox
            | `mozInlineBox
            | `mozInlineStack
            | `msFlexbox
            | `msGrid
            | `msInlineFlexbox
            | `msInlineGrid
            | `none
            | `revert
            | `revertLayer
            | `ruby
            | `rubyBase
            | `rubyBaseContainer
            | `rubyText
            | `rubyTextContainer
            | `runIn
            | `table
            | `tableCaption
            | `tableCell
            | `tableColumn
            | `tableColumnGroup
            | `tableFooterGroup
            | `tableHeaderGroup
            | `tableRow
            | `tableRowGroup
            | `unset
            | `var of string
            | `varDefault of string * string
            | `webkitBox
            | `webkitFlex
            | `webkitInlineBox
            | `webkitInlineFlex ]
         The second variant type does not allow tag(s) `gri
  [1]

  $ dune describe pp ./input.re.ml | refmt --parse ml --print re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      load_path: [],
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      transparent_modules: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  let grid = `gri;
  let a: CssJs.rule = CssJs.display(grid);
