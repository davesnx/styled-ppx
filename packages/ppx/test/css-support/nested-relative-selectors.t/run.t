This test ensures CSS Nesting's relative-selector shorthand (a nested rule's
prelude starting with a bare combinator, `> .child`/`+ .sib`/`~ .sib`) parses
and resolves `&` identically to writing the combinator after an explicit `&`.
Each pair below must render and hash to the same atom.

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
  [@css ".css-6r0lf8 .parent > .child{color:red;}"];
  [@css ".css-1hamckf .parent + .sibling{color:red;}"];
  [@css ".css-n0wq26 .parent ~ .sibling{color:red;}"];
  [@css ".css-n5qd0b .parent > .a.b:hover{color:red;}"];
  [@css ".css-1haviu8 .parent > .a{color:red;}"];
  [@css ".css-1ym0uum .parent + .b{color:red;}"];
  [@css "@media (min-width: 1px) {.css-h19ouy .parent > .child{color:red;}}"];
  
  CSS.make("css-6r0lf8", []);
  CSS.make("css-6r0lf8", []);
  
  CSS.make("css-1hamckf", []);
  CSS.make("css-1hamckf", []);
  
  CSS.make("css-n0wq26", []);
  CSS.make("css-n0wq26", []);
  
  CSS.make("css-n5qd0b", []);
  CSS.make("css-n5qd0b", []);
  
  CSS.make("css-1haviu8 css-1ym0uum", []);
  CSS.make("css-1haviu8 css-1ym0uum", []);
  
  CSS.make("css-h19ouy", []);
  CSS.make("css-h19ouy", []);
