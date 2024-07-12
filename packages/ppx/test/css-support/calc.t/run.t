This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re.ml | refmt --parse ml --print re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      load_path: [],
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      transparent_modules: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  CSS.width(`calc(`add((`percent(50.), `pxFloat(4.)))));
  CSS.width(`calc(`sub((`pxFloat(20.), `pxFloat(10.)))));
  CSS.width(
    `calc(`sub((`vh(100.), `calc(`add((`rem(2.), `pxFloat(120.))))))),
  );
  CSS.width(
    `calc(
      `sub((
        `vh(100.),
        `calc(
          `add((
            `rem(2.),
            `calc(
              `add((
                `rem(2.),
                `calc(
                  `add((
                    `rem(2.),
                    `calc(`add((`rem(2.), `pxFloat(120.)))),
                  )),
                ),
              )),
            ),
          )),
        ),
      )),
    ),
  );
  CSS.width(
    `calc(
      `mult((
        `vh(100.),
        `calc(
          `sub((
            `rem(2.),
            `calc(
              `mult((
                `rem(2.),
                `calc(
                  `mult((`rem(2.), `calc(`mult((`rem(2.), `num(4.)))))),
                ),
              )),
            ),
          )),
        ),
      )),
    ),
  );

  $ dune build