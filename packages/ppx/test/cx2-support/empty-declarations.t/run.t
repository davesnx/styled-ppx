[%cx2 ""] / [%cx2 {||}] semantics. Two cases:

(1) Statement position (no enclosing `let`) and `let _ = ...` (the
fully anonymous binding) produce `CSS.make("", [])`. There is no name
to register, so no consumer can reference them via `$(...)`.

(2) A named `let` binding — including `let _a = ...`, where the
leading underscore only suppresses unused-variable warnings — mints a
deterministic synthetic class `css-<hash-of-empty>-<binding>` so
`let m = [%cx2 {||}]` produces a real handle that a sibling [%cx2]
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
  [@css.bindings [("Input._a", "css-0-_a")]];
  CSS.make("", []);
  CSS.make("", []);
  CSS.make("", []);
  
  let _ = CSS.make("", []);
  
  let _a = CSS.make("css-0-_a", []);
  let _a = CSS.make("css-0-_a", []);
  let _a = CSS.make("css-0-_a", []);
  
  let _a = CSS.make("css-0-_a", []);
  
  let _a = CSS.make("css-0-_a", []);
  
  let _a = CSS.make("css-0-_a", []);




