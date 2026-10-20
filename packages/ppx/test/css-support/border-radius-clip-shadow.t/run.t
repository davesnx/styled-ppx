CSS Borders and Box Decorations L4 (https://drafts.csswg.org/css-borders-4/):
per-side border radius/clip shorthands, border-limit, and the box-shadow-*
longhands (not yet wired as box-shadow's own reset set). input.re carries
valid declarations (accepted silently); invalid.re carries an out-of-grammar
keyword, whose error names the property.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executables
  >  (names input invalid)
  >  (libraries styled-ppx.native)
  >  (flags (:standard -w -32))
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build
  File "invalid.re", line 1, characters 22-30:
  1 | [%css {|border-limit: diagonal|}];
                            ^^^^^^^^
  Error: Property 'border-limit' has an invalid value: 'diagonal',
         Expected 'all', 'bottom', 'corners', 'left', 'right', 'sides', or
         'top'.
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_3n000cl1tb{border-top-radius:10px;}"];
  [@css "._a_3n000c0ay0{border-top-radius:10px 5px / 2px 1px;}"];
  [@css "._a_3n000avogz{border-right-radius:4px;}"];
  [@css "._a_3n00033qjb{border-bottom-radius:4px;}"];
  [@css "._a_3n0005n019{border-left-radius:4px;}"];
  [@css "._a_h1g86n{border-block-start-radius:4px;}"];
  [@css "._a_f7b3em{border-block-end-radius:4px;}"];
  [@css "._a_h3hyd2{border-inline-start-radius:4px;}"];
  [@css "._a_h2dz7t{border-inline-end-radius:4px;}"];
  [@css "._a_fbpvas{border-limit:all;}"];
  [@css "._a_fbqqxc{border-limit:sides 50%;}"];
  [@css "._a_fbjp28{border-limit:corners;}"];
  [@css "._a_fbue5t{border-limit:corners 10px;}"];
  [@css "._a_fbbzmt{border-limit:left 4em;}"];
  [@css "._a_f90008az3q{border-top-clip:10px 1fr 10px;}"];
  [@css "._a_f90004yn5u{border-right-clip:none;}"];
  [@css "._a_f900019q3s{border-bottom-clip:0 10px 1fr 10px;}"];
  [@css "._a_f90002emob{border-left-clip:5px;}"];
  [@css "._a_f600021ui5{border-block-start-clip:10px;}"];
  [@css "._a_f60001l7yx{border-block-end-clip:10px;}"];
  [@css "._a_fa0002ufja{border-inline-start-clip:10px;}"];
  [@css "._a_fa0001u3cc{border-inline-end-clip:10px;}"];
  [@css "._a_f6ysgj{border-block-clip:10px 1fr;}"];
  [@css "._a_favz6k{border-inline-clip:10px 1fr;}"];
  [@css "._a_f9e3gi{border-clip:0 1fr;}"];
  [@css "._a_fduw20{box-shadow-color:red;}"];
  [@css "._a_fd3mmo{box-shadow-color:red, blue;}"];
  [@css "._a_fejo2u{box-shadow-offset:4px 4px;}"];
  [@css "._a_fetafk{box-shadow-offset:none, 4px 4px;}"];
  [@css "._a_fcxgmz{box-shadow-blur:12px;}"];
  [@css "._a_fgpgkn{box-shadow-spread:40px;}"];
  [@css "._a_ffw7at{box-shadow-position:inset;}"];
  [@css "._a_ffp1t5{box-shadow-position:outset, inset;}"];
  [@css.blocks
    [
      (4, "_a_3n000cl1tb"),
      (5, "_a_3n000c0ay0"),
      (6, "_a_3n000avogz"),
      (7, "_a_3n00033qjb"),
      (8, "_a_3n0005n019"),
      (9, "_a_h1g86n"),
      (10, "_a_f7b3em"),
      (11, "_a_h3hyd2"),
      (12, "_a_h2dz7t"),
      (15, "_a_fbpvas"),
      (16, "_a_fbqqxc"),
      (17, "_a_fbjp28"),
      (18, "_a_fbue5t"),
      (19, "_a_fbbzmt"),
      (22, "_a_f90008az3q"),
      (23, "_a_f90004yn5u"),
      (24, "_a_f900019q3s"),
      (25, "_a_f90002emob"),
      (26, "_a_f600021ui5"),
      (27, "_a_f60001l7yx"),
      (28, "_a_fa0002ufja"),
      (29, "_a_fa0001u3cc"),
      (30, "_a_f6ysgj"),
      (31, "_a_favz6k"),
      (32, "_a_f9e3gi"),
      (35, "_a_fduw20"),
      (36, "_a_fd3mmo"),
      (37, "_a_fejo2u"),
      (38, "_a_fetafk"),
      (39, "_a_fcxgmz"),
      (40, "_a_fgpgkn"),
      (41, "_a_ffw7at"),
      (42, "_a_ffp1t5"),
    ]
  ];
  
  CSS.make("_a_3n000cl1tb", []);
  CSS.make("_a_3n000c0ay0", []);
  CSS.make("_a_3n000avogz", []);
  CSS.make("_a_3n00033qjb", []);
  CSS.make("_a_3n0005n019", []);
  CSS.make("_a_h1g86n", []);
  CSS.make("_a_f7b3em", []);
  CSS.make("_a_h3hyd2", []);
  CSS.make("_a_h2dz7t", []);
  
  CSS.make("_a_fbpvas", []);
  CSS.make("_a_fbqqxc", []);
  CSS.make("_a_fbjp28", []);
  CSS.make("_a_fbue5t", []);
  CSS.make("_a_fbbzmt", []);
  
  CSS.make("_a_f90008az3q", []);
  CSS.make("_a_f90004yn5u", []);
  CSS.make("_a_f900019q3s", []);
  CSS.make("_a_f90002emob", []);
  CSS.make("_a_f600021ui5", []);
  CSS.make("_a_f60001l7yx", []);
  CSS.make("_a_fa0002ufja", []);
  CSS.make("_a_fa0001u3cc", []);
  CSS.make("_a_f6ysgj", []);
  CSS.make("_a_favz6k", []);
  CSS.make("_a_f9e3gi", []);
  
  CSS.make("_a_fduw20", []);
  CSS.make("_a_fd3mmo", []);
  CSS.make("_a_fejo2u", []);
  CSS.make("_a_fetafk", []);
  CSS.make("_a_fcxgmz", []);
  CSS.make("_a_fgpgkn", []);
  CSS.make("_a_ffw7at", []);
  CSS.make("_a_ffp1t5", []);
