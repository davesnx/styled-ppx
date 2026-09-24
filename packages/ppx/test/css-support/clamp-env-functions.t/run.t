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
  [@css ".css-zpelvd{width:clamp(10px, 5vw, 100px);}"];
  [@css ".css-2ju9ys{padding-top:env(safe-area-inset-top);}"];
  [@css ".css-1qehw7i{padding-top:env(safe-area-inset-top, 8px);}"];
  [@css ".css-ojmp0b{font-size:clamp(1rem, 2.5vw, 2rem);}"];
  [@css ".css-1k5blas{max-width:clamp(20%, 50vw, 80%);}"];
  [@css ".css-1vs0z9k{width:calc(clamp(1px, 2vw, 3px) + 1px);}"];
  CSS.make("css-zpelvd", []);
  CSS.make("css-2ju9ys", []);
  CSS.make("css-1qehw7i", []);
  CSS.make("css-ojmp0b", []);
  CSS.make("css-1k5blas", []);
  CSS.make("css-1vs0z9k", []);

  $ dune build
