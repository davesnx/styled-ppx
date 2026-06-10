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
  File "input.re", line 10, characters 6-11:
  10 | ......{|
  10 |   ............................
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
  [@css
    ".css-1gtanqs{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}"
  ];
  [@css
    ".css-1jqkbxn{grid-template-columns:fit-content(20px) fit-content(10%);}"
  ];
  [@css
    ".css-1wxdqmz{-webkit-text-decoration:var(--var-112i897);text-decoration:var(--var-112i897);}"
  ];
  let cosas = `bold;
  
  CSS.make("css-1gtanqs css-1jqkbxn", []);
  
  CSS.make(
    "css-1wxdqmz",
    [("--var-112i897", CSS.Types.TextDecoration.toString(cosas))],
  );
