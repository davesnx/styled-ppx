This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "input.re", line 2, characters 28-32:
  2 | let a = [%css {| display: $(grid); |}];
                                  ^^^^
  Error: The value grid has type [> `gri ]
         but an expression was expected of type
           [< `block
            | `contents
            | `flex
            | `flow
            | `flowRoot
            | `grid
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
            | `webkitBox
            | `webkitFlex
            | `webkitInlineBox
            | `webkitInlineFlex ]
         The second variant type does not allow tag(s) `gri
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --94l21-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-94l21{display:var(--94l21-0);}"];
  [@css.classes [("css-94l21", 1, "Input.a", "input.re", 2, 17, 2, 35)]];
  [@css.bindings [("Input.a", "css-94l21")]];
  let grid = `gri;
  let a =
    CSS.make("css-94l21", [("--94l21-0", CSS.Types.Display.toString(grid))]);
