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
  [@css "@property --5fjx3z-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --3mj0eq-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-5fjx3z{color:var(--5fjx3z-0);}"];
  [@css ".css-3mj0eq:hover{color:var(--3mj0eq-0);}"];
  [@css ".css-1bptu1q::placeholder{color:var(--1bptu1q-0);}"];
  [@css.classes
    [
      ("css-5fjx3z", 2, "Input.topLevel", "input.re", 14, 24, 14, 37),
      ("css-3mj0eq", 3, "Input.hover", "input.re", 17, 21, 17, 46),
      ("css-1bptu1q", 4, "Input.placeholder", "input.re", 20, 27, 20, 59),
    ]
  ];
  [@css.bindings
    [
      ("Input.topLevel", "css-5fjx3z"),
      ("Input.hover", "css-3mj0eq"),
      ("Input.placeholder", "css-1bptu1q"),
    ]
  ];
  
  let c = CSS.hex("ff0000");
  
  let topLevel =
    CSS.make("css-5fjx3z", [("--5fjx3z-0", CSS.Types.Color.toString(c))]);
  
  let hover =
    CSS.make("css-3mj0eq", [("--3mj0eq-0", CSS.Types.Color.toString(c))]);
  
  let placeholder =
    CSS.make("css-1bptu1q", [("--1bptu1q-0", CSS.Types.Color.toString(c))]);
  
  let _ = (topLevel, hover, placeholder);
