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
  [@css ".a-4exvk3{color:var(--c-dq4mhq);}"];
  [@css ".a-qyw7u4eh0hp:hover{color:var(--c-11hlefi);}"];
  [@css ".a-wu9h64eac4l::placeholder{color:var(--c-gzgct8);}"];
  [@css.bindings
    [
      ("Input.topLevel", "id-1pfdov9", "a-4exvk3"),
      ("Input.hover", "id-zu568x", "a-qyw7u4eh0hp"),
      ("Input.placeholder", "id-1xk9ylj", "a-wu9h64eac4l"),
    ]
  ];
  
  let c = CSS.hex("ff0000");
  
  let topLevel =
    CSS.make(
      "label:topLevel id-1pfdov9 a-4exvk3",
      [("--c-dq4mhq", CSS.Types.Color.toString(c))],
    );
  
  let hover =
    CSS.make(
      "label:hover id-zu568x a-qyw7u4eh0hp",
      [("--c-11hlefi", CSS.Types.Color.toString(c))],
    );
  
  let placeholder =
    CSS.make(
      "label:placeholder id-1xk9ylj a-wu9h64eac4l",
      [("--c-gzgct8", CSS.Types.Color.toString(c))],
    );
  
  let _ = (topLevel, hover, placeholder);
