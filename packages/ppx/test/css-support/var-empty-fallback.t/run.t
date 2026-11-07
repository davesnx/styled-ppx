This test ensures var() accepts an explicitly empty fallback (`var(--x,)`),
per css-variables-1 where the fallback is `<declaration-value>?` (may be
empty), while still accepting a non-empty multi-token fallback and still
rejecting nothing where a comma isn't present at all.

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
  [@css.atoms
    [
      (
        "_a7feP5DlB",
        ["._a7feP5DlB{color:var(--x);}"],
        1,
        0,
        1,
        [("value", "eP5DlB", "val\\07f\\0& | \\0color:var(--x)")],
      ),
      (
        "_a7fM17PPE",
        ["._a7fM17PPE{color:var(--x,);}"],
        1,
        0,
        1,
        [("value", "M17PPE", "val\\07f\\0& | \\0color:var(--x,)")],
      ),
      (
        "_a7fKXck9M",
        ["._a7fKXck9M{color:var(--x, );}"],
        1,
        0,
        1,
        [("value", "KXck9M", "val\\07f\\0& | \\0color:var(--x, )")],
      ),
      (
        "_act1VKqwV",
        ["._act1VKqwV{margin:var(--m, 1px 2px);}"],
        1,
        0,
        4,
        [("value", "1VKqwV", "val\\0ct\\0& | \\0margin:var(--m, 1px 2px)")],
      ),
      (
        "_a7f6C_vUz",
        ["._a7f6C_vUz{color:var(--x, var(--y,));}"],
        1,
        0,
        1,
        [("value", "6C_vUz", "val\\07f\\0& | \\0color:var(--x, var(--y,))")],
      ),
    ]
  ];
  
  CSS.make("_a7feP5DlB", []);
  CSS.make("_a7fM17PPE", []);
  CSS.make("_a7fKXck9M", []);
  CSS.make("_act1VKqwV", []);
  CSS.make("_a7f6C_vUz", []);
