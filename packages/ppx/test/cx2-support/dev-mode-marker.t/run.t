When the PPX is invoked with --dev, every named [%cx2] binding gets a
leading `cx-<name>` marker class. The marker is a plain string token
prepended to the className list inside CSS.make; it is not emitted as
a CSS rule.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- --dev)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css ".css-k008qs-layout{display:flex;}"];
  [@css ".css-38zrbw-layout{padding:12px;}"];
  [@css ".css-tokvmb-button{color:red;}"];
  
  let layout = CSS.make("cx-layout css-k008qs-layout css-38zrbw-layout", []);
  
  let button = CSS.make("cx-button css-tokvmb-button", []);
  
  let _ = (layout, button);

  $ dune build
