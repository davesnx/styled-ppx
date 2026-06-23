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
  File "input.re", line 2, characters 14-18:
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
  [@css "@property --grid-1sb4gse{syntax:\"*\";inherits:false;}"];
  [@css ".css-48ak65-a{display:var(--grid-1sb4gse);}"];
  [@css.bindings [("Input.a", "css-48ak65-a")]];
  let grid = `gri;
  let a =
    CSS.make(
      "css-48ak65-a",
      [("--grid-1sb4gse", CSS.Types.Display.toString(grid))],
    );
