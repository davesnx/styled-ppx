[%css ""] / [%css {||}] semantics. Two cases:

(1) Statement position (no enclosing `let`) and `let _ = ...` (the
fully anonymous binding) produce `CSS.make("", [])`. There is no name
to register, so no consumer can reference them via `$(...)`.

(2) A named `let` binding — including `let _a = ...`, where the
leading underscore only suppresses unused-variable warnings — mints a
deterministic synthetic class `a-<hash-of-empty>-<binding>` so
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
  [@css.bindings [("Input._a", "_id_r89ft7", "")]];
  [@css.blocks
    [
      (1, "", []),
      (2, "", []),
      (3, "", []),
      (6, "", []),
      (11, "_id_1235v4k", []),
      (12, "_id_se5qro", []),
      (13, "_id_qaab8t", []),
      (15, "_id_18cz83j", []),
      (19, "_id_1xwq9hp", []),
      (23, "_id_r89ft7", []),
    ]
  ];
  CSS.make("", []);
  CSS.make("", []);
  CSS.make("", []);
  
  let _ = CSS.make("", []);
  
  let _a = CSS.make("label:_a _id_1235v4k", []);
  let _a = CSS.make("label:_a _id_se5qro", []);
  let _a = CSS.make("label:_a _id_qaab8t", []);
  
  let _a = CSS.make("label:_a _id_18cz83j", []);
  
  let _a = CSS.make("label:_a _id_1xwq9hp", []);
  
  let _a = CSS.make("label:_a _id_r89ft7", []);




