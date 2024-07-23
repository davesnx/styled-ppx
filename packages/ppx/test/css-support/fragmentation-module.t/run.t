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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  CSS.unsafe({js|breakBefore|js}, {js|auto|js});
  CSS.unsafe({js|breakBefore|js}, {js|avoid|js});
  CSS.unsafe({js|breakBefore|js}, {js|avoid-page|js});
  CSS.unsafe({js|breakBefore|js}, {js|page|js});
  CSS.unsafe({js|breakBefore|js}, {js|left|js});
  CSS.unsafe({js|breakBefore|js}, {js|right|js});
  CSS.unsafe({js|breakBefore|js}, {js|recto|js});
  CSS.unsafe({js|breakBefore|js}, {js|verso|js});
  CSS.unsafe({js|breakBefore|js}, {js|avoid-column|js});
  CSS.unsafe({js|breakBefore|js}, {js|column|js});
  CSS.unsafe({js|breakBefore|js}, {js|avoid-region|js});
  CSS.unsafe({js|breakBefore|js}, {js|region|js});
  CSS.unsafe({js|breakAfter|js}, {js|auto|js});
  CSS.unsafe({js|breakAfter|js}, {js|avoid|js});
  CSS.unsafe({js|breakAfter|js}, {js|avoid-page|js});
  CSS.unsafe({js|breakAfter|js}, {js|page|js});
  CSS.unsafe({js|breakAfter|js}, {js|left|js});
  CSS.unsafe({js|breakAfter|js}, {js|right|js});
  CSS.unsafe({js|breakAfter|js}, {js|recto|js});
  CSS.unsafe({js|breakAfter|js}, {js|verso|js});
  CSS.unsafe({js|breakAfter|js}, {js|avoid-column|js});
  CSS.unsafe({js|breakAfter|js}, {js|column|js});
  CSS.unsafe({js|breakAfter|js}, {js|avoid-region|js});
  CSS.unsafe({js|breakAfter|js}, {js|region|js});
  CSS.unsafe({js|breakInside|js}, {js|auto|js});
  CSS.unsafe({js|breakInside|js}, {js|avoid|js});
  CSS.unsafe({js|breakInside|js}, {js|avoid-page|js});
  CSS.unsafe({js|breakInside|js}, {js|avoid-column|js});
  CSS.unsafe({js|breakInside|js}, {js|avoid-region|js});
  CSS.unsafe({js|boxDecorationBreak|js}, {js|slice|js});
  CSS.unsafe({js|boxDecorationBreak|js}, {js|clone|js});
  CSS.unsafe({js|orphans|js}, {js|1|js});
  CSS.unsafe({js|orphans|js}, {js|2|js});
