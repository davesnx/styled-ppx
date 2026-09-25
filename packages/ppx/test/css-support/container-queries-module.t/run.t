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
  [@css ".a-1e77ccc{container-type:normal;}"];
  [@css ".a-14f6sj7{container-type:size;}"];
  [@css ".a-3qzm71{container-type:inline-size;}"];
  [@css ".a-glnlpx{container-name:none;}"];
  [@css ".a-6zbaxz{container-name:sidebar;}"];
  [@css ".a-1ctqxl0{container-name:sidebar main;}"];
  [@css ".a-1use1gg{container:sidebar / inline-size;}"];
  [@css ".a-vubl4h{container:sidebar / size;}"];
  [@css ".a-hs1iko{container:none;}"];
  
  CSS.make("a-1e77ccc", []);
  CSS.make("a-14f6sj7", []);
  CSS.make("a-3qzm71", []);
  CSS.make("a-glnlpx", []);
  CSS.make("a-6zbaxz", []);
  CSS.make("a-1ctqxl0", []);
  CSS.make("a-1use1gg", []);
  CSS.make("a-vubl4h", []);
  CSS.make("a-hs1iko", []);
