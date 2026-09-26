This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (flags :standard -short-paths)
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
  [@css "@property --cosas-112i897{syntax:\"*\";inherits:false;}"];
  [@css
    "._a_ecanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    "._a_6i00gkbxn{grid-template-columns:fit-content(20px) fit-content(10%);}"
  ];
  [@css
    "._a_cfdqmz{-webkit-text-decoration:var(--cosas-112i897);text-decoration:var(--cosas-112i897);}"
  ];
  let cosas = `bold;
  
  CSS.make("_a_ecanqs _a_6i00gkbxn", []);
  
  CSS.make(
    "_a_cfdqmz",
    [("--cosas-112i897", CSS.Types.TextDecoration.toString(cosas))],
  );
