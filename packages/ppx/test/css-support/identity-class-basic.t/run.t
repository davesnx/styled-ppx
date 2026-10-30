Every named `[%css]` binding mints a build-independent identity class
(`id-<hash>`, see `Hash_class.identity_class`). It is prepended to the
className string ahead of the atomized classes, and recorded as the
second element of the `[@@@css.bindings ...]` triple
`(longident, identity, class_string)` - `class_string` keeps only the
atoms, as a content fingerprint for the aggregator's collision check.

An anonymous (`let _ = ...`) binding gets no identity: it cannot be
referenced cross-module, so it has no `[@@@css.bindings ...]` entry and
its className carries only atoms.

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
  [@css
    ("._a_5r08qs{display:flex;}", "_a_5r08qs", "0,1,0 own", "207", 1, false)
  ];
  [@css ("._a_4ekvmb{color:red;}", "_a_4ekvmb", "0,1,0 own", "158", 1, false)];
  [@css.bindings [("Input.layout", "_id_1xb8ads", "_a_5r08qs")]];
  [@css.blocks [(1, "_id_1xb8ads", [0]), (3, "", [1])]];
  let layout = CSS.make("label:layout _id_1xb8ads _a_5r08qs", []);
  
  let _ = CSS.make("_a_4ekvmb", []);
  
  let _ = layout;




  $ dune build
