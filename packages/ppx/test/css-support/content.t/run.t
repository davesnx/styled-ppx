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

  $ dune build

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
  CSS.unsafe({js|quotes|js}, {js|auto|js});
  CSS.contentsRule([|`text({js|►|js})|], Some({js||js}));
  CSS.contentsRule([|`text({js|''|js})|], None);
  CSS.unsafe({js|content|js}, {js|unset|js});
  CSS.contentRule(`normal);
  CSS.contentRule(`none);
  CSS.contentsRule([|`url({js|http://www.example.com/test.png|js})|], None);
  CSS.contentRule(
    `linearGradient((
      None,
      [|
        (Some(`hex({js|e66465|js})), None),
        (Some(`hex({js|9198e5|js})), None),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.unsafe(
    {js|content|js},
    {js|image-set("image1x.png" 1x, "image2x.png" 2x)|js},
  );
  CSS.contentsRule(
    [|`url({js|../img/test.png|js})|],
    Some({js|This is the alt text|js}),
  );
  CSS.contentsRule([|`text({js|unparsed text|js})|], None);
  CSS.contentsRule([|`openQuote|], None);
  CSS.contentsRule([|`closeQuote|], None);
  CSS.contentsRule([|`noOpenQuote|], None);
  CSS.contentsRule([|`noCloseQuote|], None);
  CSS.contentsRule(
    [|`text({js|prefix|js}), `url({js|http://www.example.com/test.png|js})|],
    None,
  );
  CSS.contentsRule(
    [|
      `text({js|prefix|js}),
      `url({js|/img/test.png|js}),
      `text({js|suffix|js}),
    |],
    Some({js|Alt text|js}),
  );
  CSS.unsafe({js|content|js}, {js|inherit|js});
  CSS.unsafe({js|content|js}, {js|initial|js});
  CSS.unsafe({js|content|js}, {js|revert|js});
  CSS.unsafe({js|content|js}, {js|revert-layer|js});
  CSS.unsafe({js|content|js}, {js|unset|js});
  CSS.contentsRule([|`text({js|点|js})|], None);
  CSS.contentsRule([|`text({js|点|js})|], None);
  CSS.contentsRule([|`text({js|点|js})|], None);
  CSS.contentsRule([|`text({js|lola|js})|], None);
  CSS.contentsRule([|`text({js|lola|js})|], None);
  CSS.contentsRule([|`text({js|''|js})|], None);
  CSS.contentsRule([|`text({js|' '|js})|], None);
  CSS.contentsRule([|`text({js|' '|js})|], None);
  CSS.contentsRule([|`text({js|''|js})|], None);
  CSS.contentsRule([|`text({js|"'"|js})|], None);
  CSS.contentsRule([|`text({js|'"'|js})|], None);
