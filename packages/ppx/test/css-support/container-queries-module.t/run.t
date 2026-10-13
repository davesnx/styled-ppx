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
  [@css "._a_4v0027ccc{container-type:normal;}"];
  [@css "._a_4v0026sj7{container-type:size;}"];
  [@css "._a_4v002zm71{container-type:inline-size;}"];
  [@css "._a_4v001nlpx{container-name:none;}"];
  [@css "._a_4v001baxz{container-name:sidebar;}"];
  [@css "._a_4v001qxl0{container-name:sidebar main;}"];
  [@css "._a_4ve1gg{container:sidebar / inline-size;}"];
  [@css "._a_4vbl4h{container:sidebar / size;}"];
  [@css "._a_4v1iko{container:none;}"];
  
  CSS.make("_a_4v0027ccc", []);
  CSS.make("_a_4v0026sj7", []);
  CSS.make("_a_4v002zm71", []);
  CSS.make("_a_4v001nlpx", []);
  CSS.make("_a_4v001baxz", []);
  CSS.make("_a_4v001qxl0", []);
  CSS.make("_a_4ve1gg", []);
  CSS.make("_a_4vbl4h", []);
  CSS.make("_a_4v1iko", []);
