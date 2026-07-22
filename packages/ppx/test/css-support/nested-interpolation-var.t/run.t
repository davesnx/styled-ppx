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
  [@css "@property --c-dq4mhq{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-11hlefi{syntax:\"*\";inherits:false;}"];
  [@css ".css-1b5xvk3-topLevel{color:var(--c-dq4mhq);}"];
  [@css ".css-1orh0hp-hover:hover{color:var(--c-11hlefi);}"];
  [@css ".css-zjac4l-placeholder::placeholder{color:var(--c-gzgct8);}"];
  [@css.bindings
    [
      ("Input.topLevel", "css-1b5xvk3-topLevel"),
      ("Input.hover", "css-1orh0hp-hover"),
      ("Input.placeholder", "css-zjac4l-placeholder"),
    ]
  ];
  
  let c = CSS.hex("ff0000");
  
  let topLevel =
    CSS.make_labeled(
      "topLevel",
      "css-1b5xvk3-topLevel",
      [("--c-dq4mhq", CSS.Types.Color.toString(c))],
    );
  
  let hover =
    CSS.make_labeled(
      "hover",
      "css-1orh0hp-hover",
      [("--c-11hlefi", CSS.Types.Color.toString(c))],
    );
  
  let placeholder =
    CSS.make_labeled(
      "placeholder",
      "css-zjac4l-placeholder",
      [("--c-gzgct8", CSS.Types.Color.toString(c))],
    );
  
  let _ = (topLevel, hover, placeholder);
