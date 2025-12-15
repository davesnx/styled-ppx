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
  [@css
    ".css-1tmhzf0 { text-decoration-line: none; }\n.css-194wct1 { text-decoration-line: underline; }\n.css-4isbds { text-decoration-line: overline; }\n.css-1u05q8d { text-decoration-line: line-through; }\n.css-1f0osz0 { text-decoration-line: underline overline; }\n.css-18nq3qo { text-decoration-color: white; }\n.css-iz5ul5 { text-decoration-style: solid; }\n.css-e4zkrk { text-decoration-style: double; }\n.css-3lni4u { text-decoration-style: dotted; }\n.css-1lqakv0 { text-decoration-style: dashed; }\n.css-gags4 { text-decoration-style: wavy; }\n.css-gm68ej { text-underline-position: auto; }\n.css-16l9oyb { text-underline-position: under; }\n.css-1ykvjj2 { text-underline-position: left; }\n.css-u9yojm { text-underline-position: right; }\n.css-gft6b2 { text-underline-position: under left; }\n.css-1i0zesz { text-underline-position: under right; }\n.css-12otyfd { text-emphasis-style: none; }\n.css-2ekpqm { text-emphasis-style: filled; }\n.css-16adqch { text-emphasis-style: open; }\n.css-s06gec { text-emphasis-style: dot; }\n.css-11a6a0e { text-emphasis-style: circle; }\n.css-i032tr { text-emphasis-style: double-circle; }\n.css-1hpoy0i { text-emphasis-style: triangle; }\n.css-1hrbr69 { text-emphasis-style: sesame; }\n.css-asa1kg { text-emphasis-style: open dot; }\n.css-1pexv1o { text-emphasis-style: \"foo\"; }\n.css-1ii7sw { text-emphasis-color: green; }\n.css-bmksov { text-emphasis: open dot green; }\n.css-bk99lj { text-emphasis-position: over; }\n.css-jnw78h { text-emphasis-position: under; }\n.css-hlr1yf { text-emphasis-position: over left; }\n.css-15dz1ma { text-emphasis-position: over right; }\n.css-147oqpt { text-emphasis-position: under left; }\n.css-1orzwv5 { text-emphasis-position: left under; }\n.css-18icj3x { text-emphasis-position: under right; }\n.css-95jyyb { text-shadow: none; }\n.css-aevlrh { text-shadow: 1px 1px; }\n.css-ihdw70 { text-shadow: 0 0 black; }\n.css-1dwzmri { text-shadow: 1px 2px 3px; }\n.css-s66vah { text-shadow: 1px 2px 3px black; }\n.css-u5q18p { text-shadow: 1px 1px, 2px 2px red; }\n.css-1f994bw { text-shadow: 1px 2px 3px black, 0 0 5px white; }\n.css-16tg8sw { text-decoration-skip: none; }\n.css-1tv4m3l { text-decoration-skip: objects; }\n.css-1ypqwcs { text-decoration-skip: objects spaces; }\n.css-rawjlh { text-decoration-skip: objects leading-spaces; }\n.css-vzrmeg { text-decoration-skip: objects trailing-spaces; }\n.css-rp5ffn { text-decoration-skip: objects leading-spaces trailing-spaces; }\n.css-zt6ork { text-decoration-skip: objects leading-spaces trailing-spaces edges; }\n.css-1007loe { text-decoration-skip: objects leading-spaces trailing-spaces edges box-decoration; }\n.css-152z4qs { text-decoration-skip: objects edges; }\n.css-18jkl0m { text-decoration-skip: objects box-decoration; }\n.css-cljugi { text-decoration-skip: spaces; }\n.css-1yhuhmm { text-decoration-skip: spaces edges; }\n.css-mnvn3y { text-decoration-skip: spaces edges box-decoration; }\n.css-1nhfs9u { text-decoration-skip: spaces box-decoration; }\n.css-16awjk5 { text-decoration-skip: leading-spaces; }\n.css-1i4fms2 { text-decoration-skip: leading-spaces trailing-spaces edges; }\n.css-19v4xbp { text-decoration-skip: edges; }\n.css-1az6w23 { text-decoration-skip: edges box-decoration; }\n.css-1s8u3sb { text-decoration-skip: box-decoration; }\n.css-1r744un { text-decoration-skip-ink: none; }\n.css-1ei9tlf { text-decoration-skip-ink: auto; }\n.css-1je70z9 { text-decoration-skip-ink: all; }\n.css-5mkx5j { text-decoration-skip-box: none; }\n.css-13kd31 { text-decoration-skip-box: all; }\n.css-vmiv8y { text-decoration-skip-inset: none; }\n.css-1qwx4v2 { text-decoration-skip-inset: auto; }\n.css-k0twl3 { text-underline-offset: auto; }\n.css-1cukedk { text-underline-offset: 3px; }\n.css-462cnh { text-underline-offset: 10%; }\n.css-mddpgs { text-decoration-thickness: auto; }\n.css-7jb2yy { text-decoration-thickness: from-font; }\n.css-cwt2mu { text-decoration-thickness: 3px; }\n.css-zvh6k8 { text-decoration-thickness: 10%; }\n"
  ];
  
  CSS.make("css-1tmhzf0", []);
  CSS.make("css-194wct1", []);
  CSS.make("css-4isbds", []);
  CSS.make("css-1u05q8d", []);
  CSS.make("css-1f0osz0", []);
  CSS.make("css-18nq3qo", []);
  CSS.make("css-iz5ul5", []);
  CSS.make("css-e4zkrk", []);
  CSS.make("css-3lni4u", []);
  CSS.make("css-1lqakv0", []);
  CSS.make("css-gags4", []);
  CSS.make("css-gm68ej", []);
  CSS.make("css-16l9oyb", []);
  CSS.make("css-1ykvjj2", []);
  CSS.make("css-u9yojm", []);
  CSS.make("css-gft6b2", []);
  CSS.make("css-1i0zesz", []);
  CSS.make("css-12otyfd", []);
  CSS.make("css-2ekpqm", []);
  CSS.make("css-16adqch", []);
  CSS.make("css-s06gec", []);
  CSS.make("css-11a6a0e", []);
  CSS.make("css-i032tr", []);
  CSS.make("css-1hpoy0i", []);
  CSS.make("css-1hrbr69", []);
  CSS.make("css-asa1kg", []);
  CSS.make("css-1pexv1o", []);
  CSS.make("css-1ii7sw", []);
  CSS.make("css-bmksov", []);
  
  CSS.make("css-bk99lj", []);
  CSS.make("css-jnw78h", []);
  CSS.make("css-hlr1yf", []);
  CSS.make("css-15dz1ma", []);
  CSS.make("css-147oqpt", []);
  CSS.make("css-1orzwv5", []);
  CSS.make("css-18icj3x", []);
  
  CSS.make("css-95jyyb", []);
  
  CSS.make("css-aevlrh", []);
  
  CSS.make("css-ihdw70", []);
  
  CSS.make("css-1dwzmri", []);
  
  CSS.make("css-s66vah", []);
  
  CSS.make("css-u5q18p", []);
  CSS.make("css-1f994bw", []);
  
  CSS.make("css-16tg8sw", []);
  CSS.make("css-1tv4m3l", []);
  CSS.make("css-1ypqwcs", []);
  CSS.make("css-rawjlh", []);
  CSS.make("css-vzrmeg", []);
  CSS.make("css-rp5ffn", []);
  CSS.make("css-zt6ork", []);
  CSS.make("css-1007loe", []);
  CSS.make("css-152z4qs", []);
  CSS.make("css-18jkl0m", []);
  CSS.make("css-cljugi", []);
  CSS.make("css-1yhuhmm", []);
  CSS.make("css-mnvn3y", []);
  CSS.make("css-1nhfs9u", []);
  CSS.make("css-16awjk5", []);
  CSS.make("css-1i4fms2", []);
  CSS.unsafe({js|textDecorationSkip|js}, {js|leading-spaces trailing-spaces edges box-decoration|js});
  CSS.make("css-19v4xbp", []);
  CSS.make("css-1az6w23", []);
  CSS.make("css-1s8u3sb", []);
  CSS.make("css-1r744un", []);
  CSS.make("css-1ei9tlf", []);
  CSS.make("css-1je70z9", []);
  CSS.make("css-5mkx5j", []);
  CSS.make("css-13kd31", []);
  CSS.make("css-vmiv8y", []);
  CSS.make("css-1qwx4v2", []);
  CSS.make("css-k0twl3", []);
  CSS.make("css-1cukedk", []);
  CSS.make("css-462cnh", []);
  CSS.make("css-mddpgs", []);
  CSS.make("css-7jb2yy", []);
  CSS.make("css-cwt2mu", []);
  CSS.make("css-zvh6k8", []);
