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
  [@css "._a_hfkiz4e0lf8 .parent > .child{color:red;}"];
  [@css "._a_oicak4emckf .parent + .sibling{color:red;}"];
  [@css "._a_ehmrb4ewq26 .parent ~ .sibling{color:red;}"];
  [@css "._a_f8a2u4eqd0b .parent > .a.b:hover{color:red;}"];
  [@css "._a_ew2o54eviu8 .parent > .a{color:red;}"];
  [@css "._a_ornrm4e0uum .parent + .b{color:red;}"];
  [@css
    "@media (min-width: 1px) {._a_7gls64e9ouy .parent > .child{color:red;}}"
  ];
  
  CSS.make("_a_hfkiz4e0lf8", []);
  CSS.make("_a_hfkiz4e0lf8", []);
  
  CSS.make("_a_oicak4emckf", []);
  CSS.make("_a_oicak4emckf", []);
  
  CSS.make("_a_ehmrb4ewq26", []);
  CSS.make("_a_ehmrb4ewq26", []);
  
  CSS.make("_a_f8a2u4eqd0b", []);
  CSS.make("_a_f8a2u4eqd0b", []);
  
  CSS.make("_a_ew2o54eviu8 _a_ornrm4e0uum", []);
  CSS.make("_a_ew2o54eviu8 _a_ornrm4e0uum", []);
  
  CSS.make("_a_7gls64e9ouy", []);
  CSS.make("_a_7gls64e9ouy", []);
