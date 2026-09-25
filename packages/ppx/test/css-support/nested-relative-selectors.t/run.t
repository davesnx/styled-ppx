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
  [@css ".a-hfkiz4e0lf8 .parent > .child{color:red;}"];
  [@css ".a-oicak4emckf .parent + .sibling{color:red;}"];
  [@css ".a-ehmrb4ewq26 .parent ~ .sibling{color:red;}"];
  [@css ".a-f8a2u4eqd0b .parent > .a.b:hover{color:red;}"];
  [@css ".a-ew2o54eviu8 .parent > .a{color:red;}"];
  [@css ".a-ornrm4e0uum .parent + .b{color:red;}"];
  [@css "@media (min-width: 1px) {.a-7gls64e9ouy .parent > .child{color:red;}}"];
  
  CSS.make("a-hfkiz4e0lf8", []);
  CSS.make("a-hfkiz4e0lf8", []);
  
  CSS.make("a-oicak4emckf", []);
  CSS.make("a-oicak4emckf", []);
  
  CSS.make("a-ehmrb4ewq26", []);
  CSS.make("a-ehmrb4ewq26", []);
  
  CSS.make("a-f8a2u4eqd0b", []);
  CSS.make("a-f8a2u4eqd0b", []);
  
  CSS.make("a-ew2o54eviu8 a-ornrm4e0uum", []);
  CSS.make("a-ew2o54eviu8 a-ornrm4e0uum", []);
  
  CSS.make("a-7gls64e9ouy", []);
  CSS.make("a-7gls64e9ouy", []);
