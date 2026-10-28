When the PPX is invoked with --dev, every named [%css] binding gets a
leading `label:<name>` marker class. The marker is a plain string token
prepended to the className list inside CSS.make; it is not emitted as
a CSS rule.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- --dev)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)
  ];
  [@css
    ("._a_94zrbw{padding:12px;}", "_a_94zrbw", "0,1,0 own", "328", 15, false)
  ];
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css.bindings
    [
      ("Input.layout", "_id_1xb8ads", "_a_5r08qs _a_94zrbw"),
      ("Input.button", "_id_1enkfbb", "_a_4ekvmb"),
    ]
  ];
  [@css.blocks [(6, "_id_1xb8ads", [0, 1]), (8, "_id_1enkfbb", [2])]];
  
  let layout = CSS.make("label:layout _id_1xb8ads _a_5r08qs _a_94zrbw", []);
  
  let button = CSS.make("label:button _id_1enkfbb _a_4ekvmb", []);
  
  let _ = (layout, button);

  $ dune build
