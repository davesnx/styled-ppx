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
  [@css ".a-4pgt40{contain:none;}"];
  [@css ".a-4pyisx{contain:strict;}"];
  [@css ".a-4p7x2x{contain:content;}"];
  [@css ".a-4p1cha{contain:size;}"];
  [@css ".a-4pw7cp{contain:layout;}"];
  [@css ".a-4pyn5q{contain:paint;}"];
  [@css ".a-4pjwgs{contain:size layout;}"];
  [@css ".a-4p7zd4{contain:size paint;}"];
  [@css ".a-4pc7bb{contain:size layout paint;}"];
  [@css ".a-eclzv6{width:5cqw;}"];
  [@css ".a-ecsy8j{width:5cqh;}"];
  [@css ".a-ecq9h0{width:5cqi;}"];
  [@css ".a-eccz18{width:5cqb;}"];
  [@css ".a-ecidqw{width:5cqmin;}"];
  [@css ".a-ec8ucx{width:5cqmax;}"];
  [@css ".a-4v0027ccc{container-type:normal;}"];
  [@css ".a-4v0026sj7{container-type:size;}"];
  [@css ".a-4v002zm71{container-type:inline-size;}"];
  [@css ".a-4v001nlpx{container-name:none;}"];
  [@css ".a-4v0019f0l{container-name:x;}"];
  [@css ".a-4v001kmkr{container-name:x y;}"];
  [@css ".a-4v1iko{container:none;}"];
  [@css ".a-4v52qy{container:x / normal;}"];
  [@css ".a-4vcq8j{container:x / size;}"];
  [@css ".a-4va7f0{container:x / inline-size;}"];
  [@css ".a-4vppda{container:x y / size;}"];
  
  CSS.make("a-4pgt40", []);
  CSS.make("a-4pyisx", []);
  CSS.make("a-4p7x2x", []);
  CSS.make("a-4p1cha", []);
  CSS.make("a-4pw7cp", []);
  CSS.make("a-4pyn5q", []);
  CSS.make("a-4pjwgs", []);
  CSS.make("a-4p7zd4", []);
  CSS.make("a-4pc7bb", []);
  
  CSS.make("a-eclzv6", []);
  CSS.make("a-ecsy8j", []);
  CSS.make("a-ecq9h0", []);
  CSS.make("a-eccz18", []);
  CSS.make("a-ecidqw", []);
  CSS.make("a-ec8ucx", []);
  CSS.make("a-4v0027ccc", []);
  CSS.make("a-4v0026sj7", []);
  CSS.make("a-4v002zm71", []);
  CSS.make("a-4v001nlpx", []);
  CSS.make("a-4v0019f0l", []);
  CSS.make("a-4v001kmkr", []);
  CSS.make("a-4v1iko", []);
  CSS.make("a-4v52qy", []);
  CSS.make("a-4vcq8j", []);
  CSS.make("a-4va7f0", []);
  CSS.make("a-4vppda", []);
