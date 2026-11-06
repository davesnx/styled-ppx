Anonymous bindings (`let _ = ...`) and statement-position [%css] (no
enclosing let) get no marker even with --dev. The `_` filter inside
`Dev_mode.marker` matches `Local_selector_environment.register`'s anonymous-binding
behavior; this keeps the two debug affordances symmetric.

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
  [@css.atoms
    [
      (
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_a7fCPHFf-",
        ["._a7fCPHFf-{color:blue;}"],
        1,
        0,
        1,
        [("value", "CPHFf-", "val\\07f\\0& | \\0color:blue")],
      ),
      (
        "_a7fBq58Im",
        ["._a7fBq58Im{color:green;}"],
        1,
        0,
        1,
        [("value", "Bq58Im", "val\\07f\\0& | \\0color:green")],
      ),
      (
        "_iIOVPy4Xu",
        [],
        1,
        0,
        0,
        [("id", "_iIOVPy4Xu", "bind\\0\\0Input\\0\\0named\\00")],
      ),
    ]
  ];
  [@css.bindings [("Input.named", "_iIOVPy4Xu _a7fBq58Im", "_iIOVPy4Xu")]];
  
  let _ = CSS.make("_a7fadbhEW", []);
  
  CSS.make("_a7fCPHFf-", []);
  
  let named = CSS.make("cx-named _iIOVPy4Xu _a7fBq58Im", []);
  
  let _ = named;

  $ dune build
