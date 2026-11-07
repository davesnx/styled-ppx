A selector ref can resolve to an earlier string literal binding.

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
  [@css.atoms
    [
      (
        "_c7fLnIaDasRUGv4",
        ["._c7fLnIaDasRUGv4.css-foo{color:red;}"],
        2,
        1,
        1,
        [
          ("ctx", "LnIaDa", "ctx\\0&.css-foo | "),
          ("value", "sRUGv4", "val\\07f\\0&.css-foo | \\0color:red"),
        ],
      ),
      (
        "_i2nV261Vg",
        [],
        1,
        0,
        0,
        [("id", "_i2nV261Vg", "bind\\0\\0Input\\0\\0bad\\00")],
      ),
    ]
  ];
  [@css.bindings [("Input.bad", "_i2nV261Vg _c7fLnIaDasRUGv4", "_i2nV261Vg")]];
  
  let undefined = "css-foo";
  
  let bad = CSS.make("_i2nV261Vg _c7fLnIaDasRUGv4", []);
  
  let _ = (undefined, bad);

  $ dune build
