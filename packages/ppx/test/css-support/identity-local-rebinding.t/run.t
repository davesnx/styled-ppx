Two functions each with their own function-local `let a = [%css ...]`
share the same (scope, name) = `([], "a")` - functions aren't modules, so
they don't extend `scope`. Without an occurrence counter this would mint
the same identity for two unrelated bindings. `Css_file.push` bumps a
per-compilation-unit occurrence count keyed by (scope, name), so the
second occurrence's identity differs even though both `a`s carry
byte-identical CSS (same atoms, same atomized class).

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
  [@css ".css-tokvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.f", "cid-fo0igp", "css-tokvmb"),
      ("Input.g", "cid-smthfn", "css-tokvmb"),
    ]
  ];
  let f = () => {
    let a = CSS.make(~label="a", "cid-fo0igp css-tokvmb", []);
    a;
  };
  
  let g = () => {
    let a = CSS.make(~label="a", "cid-smthfn css-tokvmb", []);
    a;
  };
  
  let _ = (f, g);

  $ dune build
