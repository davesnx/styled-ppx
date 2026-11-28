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
  File "input.re", line 11, characters 23-28:
  11 |     text-decoration: $(cosas);
                              ^^^^^
  Error: The value cosas has type [> `bold ]
         but an expression was expected of type
           [< `inherit_
            | `initial
            | `none
            | `revert
            | `revertLayer
            | `unset
            | `value of Css_types.TextDecoration.value
            | `var of string
            | `varDefault of string * string ]
         The second variant type does not allow tag(s) `bold
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --ivpc7mj{syntax:\"*\";inherits:false;}"];
  [@css
    ".css-ivpcd7i{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;grid-template-columns:fit-content(20px) fit-content(10%);}"
  ];
  [@css
    ".css-ivpcbpx{-webkit-text-decoration:var(--ivpc7mj);text-decoration:var(--ivpc7mj);}"
  ];
  [@css.classes
    [
      ("css-ivpcd7i", 1, "", "input.re", 5, 4, 7, 2),
      ("css-ivpcbpx", 2, "", "input.re", 11, 4, 12, 2),
    ]
  ];
  let cosas = `bold;
  
  CSS.make("css-ivpcd7i", []);
  
  CSS.make(
    "css-ivpcbpx",
    [("--ivpc7mj", CSS.Types.TextDecoration.toString(cosas))],
  );
