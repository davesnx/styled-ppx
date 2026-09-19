[%css ""] / [%css {||}] semantics. Two cases:

(1) Statement position (no enclosing `let`) and `let _ = ...` (the
fully anonymous binding) produce `CSS.make("", [])`. There is no name
to register, so no consumer can reference them via `$(...)`.

(2) A named `let` binding — including `let _a = ...`, where the
leading underscore only suppresses unused-variable warnings — mints a
deterministic synthetic class `css-<hash-of-empty>-<binding>` so
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
  [@css.bindings [("Input._a", "cid-1gt4t9l", "")]];
  CSS.make("", []);
  CSS.make("", []);
  CSS.make("", []);
  
  let _ = CSS.make("", []);
  
  let _a = CSS.make("cx-_a cid-1quemw0", []);
  let _a = CSS.make("cx-_a cid-s7r0d8", []);
  let _a = CSS.make("cx-_a cid-g7564k", []);
  
  let _a = CSS.make("cx-_a cid-i8v0tw", []);
  
  let _a = CSS.make("cx-_a cid-gyvl29", []);
  
  let _a = CSS.make("cx-_a cid-1gt4t9l", []);




