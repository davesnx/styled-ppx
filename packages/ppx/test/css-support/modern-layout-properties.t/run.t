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
  [@css ".a-gdqw8{place-content:center;}"];
  [@css ".a-16c5dhv{place-content:start;}"];
  [@css ".a-16pnyc7{place-content:end;}"];
  [@css ".a-1jag07y{place-content:space-between;}"];
  [@css ".a-fhn9tt{place-content:space-around;}"];
  [@css ".a-1lz8p3p{place-content:space-evenly;}"];
  [@css ".a-auwium{place-content:stretch;}"];
  [@css ".a-3gpzp{place-content:center start;}"];
  [@css ".a-17vq2g{place-content:start end;}"];
  [@css ".a-18s4mkx{place-content:space-between center;}"];
  [@css ".a-yoym04{place-items:center;}"];
  [@css ".a-racea0{place-items:start;}"];
  [@css ".a-16qqbga{place-items:end;}"];
  [@css ".a-dnwgtc{place-items:stretch;}"];
  [@css ".a-yzp3r0{place-items:baseline;}"];
  [@css ".a-1wgkxp5{place-items:center start;}"];
  [@css ".a-6me9sr{place-items:start end;}"];
  [@css ".a-1q8rl8b{place-self:auto;}"];
  [@css ".a-7ye2kp{place-self:center;}"];
  [@css ".a-1gq5pw6{place-self:start;}"];
  [@css ".a-12zgxw{place-self:end;}"];
  [@css ".a-1ccxvva{place-self:stretch;}"];
  [@css ".a-14nr5sl{place-self:center start;}"];
  [@css ".a-s93gqb{place-self:start end;}"];
  [@css ".a-hi8d29{accent-color:auto;}"];
  [@css ".a-sfjc5t{accent-color:red;}"];
  [@css ".a-1p2rnk{accent-color:#ff0000;}"];
  [@css ".a-l9auhw{accent-color:rgb(255, 0, 0);}"];
  [@css ".a-1bn2far{touch-action:auto;}"];
  [@css ".a-z0sbrd{touch-action:none;}"];
  [@css ".a-rvsu0a{touch-action:pan-x;}"];
  [@css ".a-1gecb00{touch-action:pan-y;}"];
  [@css ".a-1cw4v8x{touch-action:manipulation;}"];
  [@css ".a-11ee94{touch-action:pan-x pan-y;}"];
  [@css ".a-1gqcmp3{aspect-ratio:auto;}"];
  [@css ".a-1fwebk2{aspect-ratio:1 / 1;}"];
  [@css ".a-1amvr3s{aspect-ratio:16 / 9;}"];
  [@css ".a-12pvip7{aspect-ratio:0.5;}"];
  
  CSS.make("a-gdqw8", []);
  CSS.make("a-16c5dhv", []);
  CSS.make("a-16pnyc7", []);
  CSS.make("a-1jag07y", []);
  CSS.make("a-fhn9tt", []);
  CSS.make("a-1lz8p3p", []);
  CSS.make("a-auwium", []);
  CSS.make("a-3gpzp", []);
  CSS.make("a-17vq2g", []);
  CSS.make("a-18s4mkx", []);
  
  CSS.make("a-yoym04", []);
  CSS.make("a-racea0", []);
  CSS.make("a-16qqbga", []);
  CSS.make("a-dnwgtc", []);
  CSS.make("a-yzp3r0", []);
  CSS.make("a-1wgkxp5", []);
  CSS.make("a-6me9sr", []);
  
  CSS.make("a-1q8rl8b", []);
  CSS.make("a-7ye2kp", []);
  CSS.make("a-1gq5pw6", []);
  CSS.make("a-12zgxw", []);
  CSS.make("a-1ccxvva", []);
  CSS.make("a-14nr5sl", []);
  CSS.make("a-s93gqb", []);
  
  CSS.make("a-hi8d29", []);
  CSS.make("a-sfjc5t", []);
  CSS.make("a-1p2rnk", []);
  CSS.make("a-l9auhw", []);
  
  CSS.make("a-1bn2far", []);
  CSS.make("a-z0sbrd", []);
  CSS.make("a-rvsu0a", []);
  CSS.make("a-1gecb00", []);
  CSS.make("a-1cw4v8x", []);
  CSS.make("a-11ee94", []);
  
  CSS.make("a-1gqcmp3", []);
  CSS.make("a-1fwebk2", []);
  CSS.make("a-1amvr3s", []);
  CSS.make("a-12pvip7", []);
