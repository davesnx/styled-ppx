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
  [@css "@property --grid-w2gxnr{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_a9fXV7aDK",
        ["._a9fXV7aDK{display:var(--grid-w2gxnr);}"],
        1,
        0,
        1,
        [("value", "XV7aDK", "val\\09f\\0& | \\0display:$(grid)")],
      ),
      (
        "_i48HNyA_r",
        [],
        1,
        0,
        0,
        [("id", "_i48HNyA_r", "bind\\0\\0Input\\0\\0a\\00")],
      ),
    ]
  ];
  [@css.bindings [("Input.a", "_i48HNyA_r _a9fXV7aDK", "_i48HNyA_r")]];
  let grid = `gri;
  let a =
    CSS.make(
      "_i48HNyA_r _a9fXV7aDK",
      [("--grid-w2gxnr", CSS.Types.Display.toString(grid))],
    );
