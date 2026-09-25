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
  [@css ".a-zpelvd{width:clamp(10px, 5vw, 100px);}"];
  [@css ".a-2ju9ys{padding-top:env(safe-area-inset-top);}"];
  [@css ".a-1qehw7i{padding-top:env(safe-area-inset-top, 8px);}"];
  [@css ".a-ojmp0b{font-size:clamp(1rem, 2.5vw, 2rem);}"];
  [@css ".a-1k5blas{max-width:clamp(20%, 50vw, 80%);}"];
  [@css ".a-1vs0z9k{width:calc(clamp(1px, 2vw, 3px) + 1px);}"];
  CSS.make("a-zpelvd", []);
  CSS.make("a-2ju9ys", []);
  CSS.make("a-1qehw7i", []);
  CSS.make("a-ojmp0b", []);
  CSS.make("a-1k5blas", []);
  CSS.make("a-1vs0z9k", []);

  $ dune build
