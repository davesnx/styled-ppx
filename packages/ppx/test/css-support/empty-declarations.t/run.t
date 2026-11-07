[%css ""] / [%css {||}] semantics. Two cases:

(1) Statement position (no enclosing `let`) and `let _ = ...` (the
fully anonymous binding) produce `CSS.make("", [])`. There is no name
to register, so no consumer can reference them via `$(...)`.

(2) A named `let` binding — including `let _a = ...`, where the
leading underscore only suppresses unused-variable warnings — mints a
deterministic synthetic class `css-<hash(module, scope, binding)>-<binding>` so
`let m = [%css {||}]` produces a real handle that a sibling [%css]
block can target via `&.$(m)`. No `[@@@css ...]` rule is emitted
because there's nothing to write. See
selector-class-interpolation-empty.t for the full end-to-end behavior.

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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css.atoms
    [
      (
        "_it88Ph5gF",
        [],
        1,
        0,
        0,
        [("id", "_it88Ph5gF", "bind\\0\\0Input\\0\\0_a\\00")],
      ),
      (
        "_iynpFOdZF",
        [],
        1,
        0,
        0,
        [("id", "_iynpFOdZF", "bind\\0\\0Input\\0\\0_a\\01")],
      ),
      (
        "_iIP0pViGl",
        [],
        1,
        0,
        0,
        [("id", "_iIP0pViGl", "bind\\0\\0Input\\0\\0_a\\02")],
      ),
      (
        "_it5YP-owZ",
        [],
        1,
        0,
        0,
        [("id", "_it5YP-owZ", "bind\\0\\0Input\\0\\0_a\\03")],
      ),
      (
        "_iq9Y2kRyc",
        [],
        1,
        0,
        0,
        [("id", "_iq9Y2kRyc", "bind\\0\\0Input\\0\\0_a\\04")],
      ),
      (
        "_ilSGLR_wc",
        [],
        1,
        0,
        0,
        [("id", "_ilSGLR_wc", "bind\\0\\0Input\\0\\0_a\\05")],
      ),
    ]
  ];
  [@css.bindings [("Input._a", "_ilSGLR_wc", "_ilSGLR_wc")]];
  CSS.make("", []);
  CSS.make("", []);
  CSS.make("", []);
  
  let _ = CSS.make("", []);
  
  let _a = CSS.make("_it88Ph5gF", []);
  let _a = CSS.make("_iynpFOdZF", []);
  let _a = CSS.make("_iIP0pViGl", []);
  
  let _a = CSS.make("_it5YP-owZ", []);
  
  let _a = CSS.make("_iq9Y2kRyc", []);
  
  let _a = CSS.make("_ilSGLR_wc", []);




