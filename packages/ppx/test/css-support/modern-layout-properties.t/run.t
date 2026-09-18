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
  [@css ".css-gdqw8{place-content:center}"];
  [@css ".css-16c5dhv{place-content:start}"];
  [@css ".css-16pnyc7{place-content:end}"];
  [@css ".css-1jag07y{place-content:space-between}"];
  [@css ".css-fhn9tt{place-content:space-around}"];
  [@css ".css-1lz8p3p{place-content:space-evenly}"];
  [@css ".css-auwium{place-content:stretch}"];
  [@css ".css-3gpzp{place-content:center start}"];
  [@css ".css-17vq2g{place-content:start end}"];
  [@css ".css-18s4mkx{place-content:space-between center}"];
  [@css ".css-yoym04{place-items:center}"];
  [@css ".css-racea0{place-items:start}"];
  [@css ".css-16qqbga{place-items:end}"];
  [@css ".css-dnwgtc{place-items:stretch}"];
  [@css ".css-yzp3r0{place-items:baseline}"];
  [@css ".css-1wgkxp5{place-items:center start}"];
  [@css ".css-6me9sr{place-items:start end}"];
  [@css ".css-1q8rl8b{place-self:auto}"];
  [@css ".css-7ye2kp{place-self:center}"];
  [@css ".css-1gq5pw6{place-self:start}"];
  [@css ".css-12zgxw{place-self:end}"];
  [@css ".css-1ccxvva{place-self:stretch}"];
  [@css ".css-14nr5sl{place-self:center start}"];
  [@css ".css-s93gqb{place-self:start end}"];
  [@css ".css-hi8d29{accent-color:auto}"];
  [@css ".css-sfjc5t{accent-color:red}"];
  [@css ".css-1p2rnk{accent-color:#ff0000}"];
  [@css ".css-1gxkspc{accent-color:rgb(255,0,0)}"];
  [@css ".css-1bn2far{touch-action:auto}"];
  [@css ".css-z0sbrd{touch-action:none}"];
  [@css ".css-rvsu0a{touch-action:pan-x}"];
  [@css ".css-1gecb00{touch-action:pan-y}"];
  [@css ".css-1cw4v8x{touch-action:manipulation}"];
  [@css ".css-11ee94{touch-action:pan-x pan-y}"];
  [@css ".css-1gqcmp3{aspect-ratio:auto}"];
  [@css ".css-1fwebk2{aspect-ratio:1 / 1}"];
  [@css ".css-1amvr3s{aspect-ratio:16 / 9}"];
  [@css ".css-12pvip7{aspect-ratio:0.5}"];
  
  CSS.make("css-gdqw8", []);
  CSS.make("css-16c5dhv", []);
  CSS.make("css-16pnyc7", []);
  CSS.make("css-1jag07y", []);
  CSS.make("css-fhn9tt", []);
  CSS.make("css-1lz8p3p", []);
  CSS.make("css-auwium", []);
  CSS.make("css-3gpzp", []);
  CSS.make("css-17vq2g", []);
  CSS.make("css-18s4mkx", []);
  
  CSS.make("css-yoym04", []);
  CSS.make("css-racea0", []);
  CSS.make("css-16qqbga", []);
  CSS.make("css-dnwgtc", []);
  CSS.make("css-yzp3r0", []);
  CSS.make("css-1wgkxp5", []);
  CSS.make("css-6me9sr", []);
  
  CSS.make("css-1q8rl8b", []);
  CSS.make("css-7ye2kp", []);
  CSS.make("css-1gq5pw6", []);
  CSS.make("css-12zgxw", []);
  CSS.make("css-1ccxvva", []);
  CSS.make("css-14nr5sl", []);
  CSS.make("css-s93gqb", []);
  
  CSS.make("css-hi8d29", []);
  CSS.make("css-sfjc5t", []);
  CSS.make("css-1p2rnk", []);
  CSS.make("css-1gxkspc", []);
  
  CSS.make("css-1bn2far", []);
  CSS.make("css-z0sbrd", []);
  CSS.make("css-rvsu0a", []);
  CSS.make("css-1gecb00", []);
  CSS.make("css-1cw4v8x", []);
  CSS.make("css-11ee94", []);
  
  CSS.make("css-1gqcmp3", []);
  CSS.make("css-1fwebk2", []);
  CSS.make("css-1amvr3s", []);
  CSS.make("css-12pvip7", []);
