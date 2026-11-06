This test locks down signed-fraction numbers (a sign directly followed by a
decimal point, with no leading digit, e.g. `-.5px`). CSS Syntax Level 3
allows this spelling; the lexer's `consume_number` used to only match a sign
when followed immediately by a digit, so it consumed nothing for `-.5`, left
an empty number representation, and crashed the whole PPX with
`Failure("float_of_string")` instead of producing a located error or a
token.

The renderer always normalizes the numeric spelling it emits. `-.5px`
renders as `-0.5px`: a leading zero is added, the same as the existing
`.5px` -> `0.5px` normalization. `+.5px` renders as `0.5px`: the leading
zero is added and the redundant "+" is dropped. `-.5e1px` renders as its
evaluated form, `-5px`. This normalization is pre-existing renderer
behavior. This fix only lets the lexer reach the renderer without crashing;
it does not change how numbers render.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      hidden_include_dirs: [],
      load_path: ([], []),
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      no_alias_deps: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  [@css.atoms
    [
      (
        "_actIrWqKA",
        ["._actIrWqKA{margin:-0.5px;}"],
        1,
        0,
        4,
        [("value", "IrWqKA", "val\\0ct\\0& | \\0margin:-0.5px")],
      ),
      (
        "_actd3s-SP",
        ["._actd3s-SP{margin:0.5px;}"],
        1,
        0,
        4,
        [("value", "d3s-SP", "val\\0ct\\0& | \\0margin:0.5px")],
      ),
      (
        "_amaxg6Ltf",
        ["._amaxg6Ltf{transition:opacity 0.3s ease -0.1s;}"],
        1,
        0,
        5,
        [
          (
            "value",
            "xg6Ltf",
            "val\\0ma\\0& | \\0transition:opacity 0.3s ease -0.1s",
          ),
        ],
      ),
      (
        "_am46EcT7N",
        ["._am46EcT7N{top:-5px;}"],
        1,
        0,
        1,
        [("value", "6EcT7N", "val\\0m4\\0& | \\0top:-5px")],
      ),
    ]
  ];
  CSS.make("_actIrWqKA", []);
  CSS.make("_actd3s-SP", []);
  CSS.make("_amaxg6Ltf", []);
  CSS.make("_am46EcT7N", []);

  $ dune build
