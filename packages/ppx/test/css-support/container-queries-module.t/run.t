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
  [@css ".css-1e77ccc{container-type:normal}"];
  [@css ".css-14f6sj7{container-type:size}"];
  [@css ".css-3qzm71{container-type:inline-size}"];
  [@css ".css-glnlpx{container-name:none}"];
  [@css ".css-6zbaxz{container-name:sidebar}"];
  [@css ".css-1ctqxl0{container-name:sidebar main}"];
  [@css ".css-1use1gg{container:sidebar / inline-size}"];
  [@css ".css-vubl4h{container:sidebar / size}"];
  [@css ".css-hs1iko{container:none}"];
  
  CSS.make("css-1e77ccc", []);
  CSS.make("css-14f6sj7", []);
  CSS.make("css-3qzm71", []);
  CSS.make("css-glnlpx", []);
  CSS.make("css-6zbaxz", []);
  CSS.make("css-1ctqxl0", []);
  CSS.make("css-1use1gg", []);
  CSS.make("css-vubl4h", []);
  CSS.make("css-hs1iko", []);
