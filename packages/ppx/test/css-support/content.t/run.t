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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  
  CSS.unsafe({js|quotes|js}, {js|auto|js});
  
  CSS.contentsRule([|`text({js|►|js})|], Some({js||js}));
  
  CSS.contentsRule([|`text({js|''|js})|], None);
  
  CSS.contentsRule(
    [|`counter(({js|count|js}, Some(`Custom({js|decimal|js}))))|],
    None,
  );
  CSS.contentsRule(
    [|
      `counter(({js|count|js}, Some(`Custom({js|decimal|js})))),
      `text({js|) |js}),
    |],
    None,
  );
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
  
  CSS.contentsRule([|`attr({js|href|js})|], None);
  CSS.contentsRule([|`attrWithType(({js|data-width|js}, {js|px|js}))|], None);
  
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
  
  CSS.contentsRule([|`attr({js|href|js})|], None);
  CSS.contentsRule([|`attr({js|data-value|js})|], None);
  
  CSS.contentsRule(
    [|`attrWithType(({js|data-value|js}, {js|raw-string|js}))|],
    None,
  );
  CSS.contentsRule([|`attrWithType(({js|data-value|js}, {js|em|js}))|], None);
  CSS.contentsRule([|`attrWithType(({js|data-value|js}, {js|px|js}))|], None);
