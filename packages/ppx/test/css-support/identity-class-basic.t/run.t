Every named `[%css]` binding mints a build-independent identity class
(`cid-<hash>`, see `Hash_class.identity_class`). It is prepended to the
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
  [@css ".css-k008qs{display:flex;}"];
  [@css ".css-tokvmb{color:red;}"];
  [@css.bindings [("Input.layout", "cid-1jj5tmt", "css-k008qs")]];
  let layout = CSS.make("label:layout cid-1jj5tmt css-k008qs", []);
  
  let _ = CSS.make("css-tokvmb", []);
  
  let _ = layout;




  $ dune build
