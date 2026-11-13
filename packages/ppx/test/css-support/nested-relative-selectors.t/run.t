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
  [@css ".css-ea4l9v .parent > .child{color:red;}"];
  [@css ".css-1sl1lmt .parent + .sibling{color:red;}"];
  [@css ".css-87opuf .parent ~ .sibling{color:red;}"];
  [@css ".css-1cw7z7t .parent > .a.b:hover{color:red;}"];
  [@css
    ".css-1o9ckul .parent > .a{color:red;}.css-1o9ckul .parent + .b{color:red;}"
  ];
  [@css "@media (min-width: 1px) {.css-1q6v2t4 .parent > .child{color:red;}}"];
  [@css.classes
    [
      ("css-ea4l9v", 0, "", "input.re", 7, 9, 7, 46),
      ("css-1sl1lmt", 1, "", "input.re", 10, 9, 10, 48),
      ("css-87opuf", 2, "", "input.re", 13, 9, 13, 48),
      ("css-1cw7z7t", 3, "", "input.re", 17, 9, 17, 50),
      ("css-1o9ckul", 4, "", "input.re", 21, 9, 21, 48),
      ("css-1q6v2t4", 5, "", "input.re", 25, 9, 25, 74),
    ]
  ];
  
  CSS.make("css-ea4l9v", []);
  CSS.make("css-ea4l9v", []);
  
  CSS.make("css-1sl1lmt", []);
  CSS.make("css-1sl1lmt", []);
  
  CSS.make("css-87opuf", []);
  CSS.make("css-87opuf", []);
  
  CSS.make("css-1cw7z7t", []);
  CSS.make("css-1cw7z7t", []);
  
  CSS.make("css-1o9ckul", []);
  CSS.make("css-1o9ckul", []);
  
  CSS.make("css-1q6v2t4", []);
  CSS.make("css-1q6v2t4", []);
