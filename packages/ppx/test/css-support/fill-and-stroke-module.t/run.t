CSS Fill and Stroke Module Level 3 (https://drafts.csswg.org/fill-stroke/):
the 16 fill- and stroke- properties this pass added. input.re carries valid
declarations for all of them (accepted silently); invalid.re carries
fill-origin's grammar (no view-box, unlike <geometry-box>), whose error
names the property.

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
  File "invalid.re", line 1, characters 21-29:
  1 | [%css {|fill-origin: view-box|}];
                           ^^^^^^^^
  Error: Property 'fill-origin' has an invalid value: 'view-box',
         Expected 'border-box', 'content-box', 'fill-box', 'match-parent',
         'padding-box', or 'stroke-box'. Did you mean 'fill-box'?
  [1]

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "._a_fj56cl{fill-break:slice;}"];
  [@css "._a_fjev2u{fill-break:clone;}"];
  [@css "._a_fke35e{fill-color:red;}"];
  [@css "._a_fll8sq{fill-image:none;}"];
  [@css "._a_flgv4m{fill-image:none, none;}"];
  [@css "._a_fmya6b{fill-origin:match-parent;}"];
  [@css "._a_fm29sd{fill-origin:fill-box;}"];
  [@css "._a_fnlyrj{fill-position:center;}"];
  [@css "._a_fnkrpk{fill-position:center, top left;}"];
  [@css "._a_fov7hi{fill-repeat:repeat-x;}"];
  [@css "._a_fo6jli{fill-repeat:repeat-x, space;}"];
  [@css "._a_fp0opq{fill-size:cover;}"];
  [@css "._a_fpgmie{fill-size:cover, 10px 20px;}"];
  [@css "._a_gkxdk3{stroke-align:inset;}"];
  [@css "._a_gl0rrf{stroke-break:bounding-box;}"];
  [@css "._a_gmvg6s{stroke-dash-corner:none;}"];
  [@css "._a_gmty9s{stroke-dash-corner:5px;}"];
  [@css "._a_gnokf8{stroke-dash-justify:none;}"];
  [@css "._a_gn7mdb{stroke-dash-justify:stretch dashes;}"];
  [@css "._a_gomj20{stroke-image:none;}"];
  [@css "._a_gpym2d{stroke-origin:stroke-box;}"];
  [@css "._a_gqpijn{stroke-position:50% 50%;}"];
  [@css "._a_grl4q4{stroke-repeat:round;}"];
  [@css "._a_gsg9ov{stroke-size:contain;}"];
  [@css.blocks
    [
      (5, "_a_fj56cl"),
      (6, "_a_fjev2u"),
      (7, "_a_fke35e"),
      (8, "_a_fll8sq"),
      (9, "_a_flgv4m"),
      (10, "_a_fmya6b"),
      (11, "_a_fm29sd"),
      (12, "_a_fnlyrj"),
      (13, "_a_fnkrpk"),
      (14, "_a_fov7hi"),
      (15, "_a_fo6jli"),
      (16, "_a_fp0opq"),
      (17, "_a_fpgmie"),
      (18, "_a_gkxdk3"),
      (19, "_a_gl0rrf"),
      (20, "_a_gmvg6s"),
      (21, "_a_gmty9s"),
      (22, "_a_gnokf8"),
      (23, "_a_gn7mdb"),
      (24, "_a_gomj20"),
      (25, "_a_gpym2d"),
      (26, "_a_gqpijn"),
      (27, "_a_grl4q4"),
      (28, "_a_gsg9ov"),
    ]
  ];
  
  CSS.make("_a_fj56cl", []);
  CSS.make("_a_fjev2u", []);
  CSS.make("_a_fke35e", []);
  CSS.make("_a_fll8sq", []);
  CSS.make("_a_flgv4m", []);
  CSS.make("_a_fmya6b", []);
  CSS.make("_a_fm29sd", []);
  CSS.make("_a_fnlyrj", []);
  CSS.make("_a_fnkrpk", []);
  CSS.make("_a_fov7hi", []);
  CSS.make("_a_fo6jli", []);
  CSS.make("_a_fp0opq", []);
  CSS.make("_a_fpgmie", []);
  CSS.make("_a_gkxdk3", []);
  CSS.make("_a_gl0rrf", []);
  CSS.make("_a_gmvg6s", []);
  CSS.make("_a_gmty9s", []);
  CSS.make("_a_gnokf8", []);
  CSS.make("_a_gn7mdb", []);
  CSS.make("_a_gomj20", []);
  CSS.make("_a_gpym2d", []);
  CSS.make("_a_gqpijn", []);
  CSS.make("_a_grl4q4", []);
  CSS.make("_a_gsg9ov", []);
