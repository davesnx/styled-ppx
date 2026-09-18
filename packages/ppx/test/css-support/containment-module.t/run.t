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
  [@css ".css-2agt40{contain:none}"];
  [@css ".css-deyisx{contain:strict}"];
  [@css ".css-1x07x2x{contain:content}"];
  [@css ".css-eq1cha{contain:size}"];
  [@css ".css-bzw7cp{contain:layout}"];
  [@css ".css-52yn5q{contain:paint}"];
  [@css ".css-j5jwgs{contain:size layout}"];
  [@css ".css-567zd4{contain:size paint}"];
  [@css ".css-1ubc7bb{contain:size layout paint}"];
  [@css ".css-114lzv6{width:5cqw}"];
  [@css ".css-1fqsy8j{width:5cqh}"];
  [@css ".css-12zq9h0{width:5cqi}"];
  [@css ".css-1q7cz18{width:5cqb}"];
  [@css ".css-b0idqw{width:5cqmin}"];
  [@css ".css-1a08ucx{width:5cqmax}"];
  [@css ".css-1e77ccc{container-type:normal}"];
  [@css ".css-14f6sj7{container-type:size}"];
  [@css ".css-3qzm71{container-type:inline-size}"];
  [@css ".css-glnlpx{container-name:none}"];
  [@css ".css-jd9f0l{container-name:x}"];
  [@css ".css-1qckmkr{container-name:x y}"];
  [@css ".css-hs1iko{container:none}"];
  [@css ".css-1q052qy{container:x / normal}"];
  [@css ".css-m4cq8j{container:x / size}"];
  [@css ".css-10da7f0{container:x / inline-size}"];
  [@css ".css-lrppda{container:x y / size}"];
  
  CSS.make("css-2agt40", []);
  CSS.make("css-deyisx", []);
  CSS.make("css-1x07x2x", []);
  CSS.make("css-eq1cha", []);
  CSS.make("css-bzw7cp", []);
  CSS.make("css-52yn5q", []);
  CSS.make("css-j5jwgs", []);
  CSS.make("css-567zd4", []);
  CSS.make("css-1ubc7bb", []);
  
  CSS.make("css-114lzv6", []);
  CSS.make("css-1fqsy8j", []);
  CSS.make("css-12zq9h0", []);
  CSS.make("css-1q7cz18", []);
  CSS.make("css-b0idqw", []);
  CSS.make("css-1a08ucx", []);
  CSS.make("css-1e77ccc", []);
  CSS.make("css-14f6sj7", []);
  CSS.make("css-3qzm71", []);
  CSS.make("css-glnlpx", []);
  CSS.make("css-jd9f0l", []);
  CSS.make("css-1qckmkr", []);
  CSS.make("css-hs1iko", []);
  CSS.make("css-1q052qy", []);
  CSS.make("css-m4cq8j", []);
  CSS.make("css-10da7f0", []);
  CSS.make("css-lrppda", []);
