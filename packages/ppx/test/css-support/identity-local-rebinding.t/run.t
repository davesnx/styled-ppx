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
  [@css "._a_4ekvmb{color:red;}"];
  [@css.bindings
    [
      ("Input.f", "_id_fo0igp", "_a_4ekvmb"),
      ("Input.g", "_id_smthfn", "_a_4ekvmb"),
    ]
  ];
  let f = () => {
    let a = CSS.make("label:a _id_fo0igp _a_4ekvmb", []);
    a;
  };
  
  let g = () => {
    let a = CSS.make("label:a _id_smthfn _a_4ekvmb", []);
    a;
  };
  
  let _ = (f, g);

  $ dune build
