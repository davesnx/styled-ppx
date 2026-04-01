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
  File "input.re", lines 10-12, characters 6-4:
  10 | ......{|
  11 |     text-decoration: $(cosas);
  12 |   |}..
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
    ".css-1gtanqs{width:fit-content;}\n.css-1jqkbxn{grid-template-columns:fit-content(20px) fit-content(10%);}\n.css-1wxdqmz{text-decoration:var(--var-z052by);}\n"
  ];
  let cosas = `bold;
  
  CSS.make("css-1gtanqs css-1jqkbxn", []);
  
  CSS.make(
    "css-1wxdqmz",
    [("--var-z052by", CSS.Types.TextDecoration.toString(cosas))],
  );


