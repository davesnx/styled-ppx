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
  [@css ".a-2agt40{contain:none;}"];
  [@css ".a-deyisx{contain:strict;}"];
  [@css ".a-1x07x2x{contain:content;}"];
  [@css ".a-eq1cha{contain:size;}"];
  [@css ".a-bzw7cp{contain:layout;}"];
  [@css ".a-52yn5q{contain:paint;}"];
  [@css ".a-j5jwgs{contain:size layout;}"];
  [@css ".a-567zd4{contain:size paint;}"];
  [@css ".a-1ubc7bb{contain:size layout paint;}"];
  [@css ".a-114lzv6{width:5cqw;}"];
  [@css ".a-1fqsy8j{width:5cqh;}"];
  [@css ".a-12zq9h0{width:5cqi;}"];
  [@css ".a-1q7cz18{width:5cqb;}"];
  [@css ".a-b0idqw{width:5cqmin;}"];
  [@css ".a-1a08ucx{width:5cqmax;}"];
  [@css ".a-1e77ccc{container-type:normal;}"];
  [@css ".a-14f6sj7{container-type:size;}"];
  [@css ".a-3qzm71{container-type:inline-size;}"];
  [@css ".a-glnlpx{container-name:none;}"];
  [@css ".a-jd9f0l{container-name:x;}"];
  [@css ".a-1qckmkr{container-name:x y;}"];
  [@css ".a-hs1iko{container:none;}"];
  [@css ".a-1q052qy{container:x / normal;}"];
  [@css ".a-m4cq8j{container:x / size;}"];
  [@css ".a-10da7f0{container:x / inline-size;}"];
  [@css ".a-lrppda{container:x y / size;}"];
  
  CSS.make("a-2agt40", []);
  CSS.make("a-deyisx", []);
  CSS.make("a-1x07x2x", []);
  CSS.make("a-eq1cha", []);
  CSS.make("a-bzw7cp", []);
  CSS.make("a-52yn5q", []);
  CSS.make("a-j5jwgs", []);
  CSS.make("a-567zd4", []);
  CSS.make("a-1ubc7bb", []);
  
  CSS.make("a-114lzv6", []);
  CSS.make("a-1fqsy8j", []);
  CSS.make("a-12zq9h0", []);
  CSS.make("a-1q7cz18", []);
  CSS.make("a-b0idqw", []);
  CSS.make("a-1a08ucx", []);
  CSS.make("a-1e77ccc", []);
  CSS.make("a-14f6sj7", []);
  CSS.make("a-3qzm71", []);
  CSS.make("a-glnlpx", []);
  CSS.make("a-jd9f0l", []);
  CSS.make("a-1qckmkr", []);
  CSS.make("a-hs1iko", []);
  CSS.make("a-1q052qy", []);
  CSS.make("a-m4cq8j", []);
  CSS.make("a-10da7f0", []);
  CSS.make("a-lrppda", []);
