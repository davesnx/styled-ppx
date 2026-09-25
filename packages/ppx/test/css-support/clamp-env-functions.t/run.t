This test ensures clamp() and env() are reachable from length and percentage
properties, not just registered as standalone functions.

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
  [@css ".a-ecelvd{width:clamp(10px, 5vw, 100px);}"];
  [@css ".a-94008u9ys{padding-top:env(safe-area-inset-top);}"];
  [@css ".a-94008hw7i{padding-top:env(safe-area-inset-top, 8px);}"];
  [@css ".a-6500wmp0b{font-size:clamp(1rem, 2.5vw, 2rem);}"];
  [@css ".a-88blas{max-width:clamp(20%, 50vw, 80%);}"];
  [@css ".a-ec0z9k{width:calc(clamp(1px, 2vw, 3px) + 1px);}"];
  CSS.make("a-ecelvd", []);
  CSS.make("a-94008u9ys", []);
  CSS.make("a-94008hw7i", []);
  CSS.make("a-6500wmp0b", []);
  CSS.make("a-88blas", []);
  CSS.make("a-ec0z9k", []);

  $ dune build
