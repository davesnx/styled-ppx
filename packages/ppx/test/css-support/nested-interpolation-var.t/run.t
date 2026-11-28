Regression test: a runtime interpolation `$(x)` used inside a nested
pseudo-element selector (`&::placeholder`) must still emit the inline
`--var-...` definition (the 2nd argument of `CSS.make`), exactly like a
top-level interpolation does. If the inline list is empty `[]` for the
`::placeholder` case while the extracted `[@css ...]` payload references
`var(--var-...)`, the variable is undefined at runtime and the value falls back.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --ivpcpc4{syntax:\"*\";inherits:false;}"];
  [@css "@property --ivpc3y5{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpczg9{color:var(--ivpcpc4);}"];
  [@css ".css-ivpcny6:hover{color:var(--ivpc3y5);}"];
  [@css ".css-ivpc37r::placeholder{color:var(--ivpcd2y);}"];
  [@css.classes
    [
      ("css-ivpczg9", 2, "Input.topLevel", "input.re", 14, 24, 14, 37),
      ("css-ivpcny6", 3, "Input.hover", "input.re", 17, 21, 17, 46),
      ("css-ivpc37r", 4, "Input.placeholder", "input.re", 20, 27, 20, 59),
    ]
  ];
  [@css.bindings
    [
      ("Input.topLevel", "css-ivpczg9"),
      ("Input.hover", "css-ivpcny6"),
      ("Input.placeholder", "css-ivpc37r"),
    ]
  ];
  
  let c = CSS.hex("ff0000");
  
  let topLevel =
    CSS.make("css-ivpczg9", [("--ivpcpc4", CSS.Types.Color.toString(c))]);
  
  let hover =
    CSS.make("css-ivpcny6", [("--ivpc3y5", CSS.Types.Color.toString(c))]);
  
  let placeholder =
    CSS.make("css-ivpc37r", [("--ivpcd2y", CSS.Types.Color.toString(c))]);
  
  let _ = (topLevel, hover, placeholder);
