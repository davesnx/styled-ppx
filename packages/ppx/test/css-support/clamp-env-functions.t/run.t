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
  [@css "._a_ecelvd{width:clamp(10px, 5vw, 100px);}"];
  [@css "._a_94008u9ys{padding-top:env(safe-area-inset-top);}"];
  [@css "._a_94008hw7i{padding-top:env(safe-area-inset-top, 8px);}"];
  [@css "._a_6500wmp0b{font-size:clamp(1rem, 2.5vw, 2rem);}"];
  [@css "._a_88blas{max-width:clamp(20%, 50vw, 80%);}"];
  [@css "._a_ec0z9k{width:calc(clamp(1px, 2vw, 3px) + 1px);}"];
  CSS.make("_a_ecelvd", []);
  CSS.make("_a_94008u9ys", []);
  CSS.make("_a_94008hw7i", []);
  CSS.make("_a_6500wmp0b", []);
  CSS.make("_a_88blas", []);
  CSS.make("_a_ec0z9k", []);

  $ dune build
