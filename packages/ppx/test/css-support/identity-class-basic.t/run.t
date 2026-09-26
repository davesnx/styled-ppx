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
  [@css "._a_5r08qs{display:flex;}"];
  [@css "._a_4ekvmb{color:red;}"];
  [@css.bindings [("Input.layout", "_id_1jj5tmt", "_a_5r08qs")]];
  let layout = CSS.make("label:layout _id_1jj5tmt _a_5r08qs", []);
  
  let _ = CSS.make("_a_4ekvmb", []);
  
  let _ = layout;




  $ dune build
