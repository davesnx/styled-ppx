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
  [@css ".a-9hdqw8{place-content:center;}"];
  [@css ".a-9h5dhv{place-content:start;}"];
  [@css ".a-9hnyc7{place-content:end;}"];
  [@css ".a-9hg07y{place-content:space-between;}"];
  [@css ".a-9hn9tt{place-content:space-around;}"];
  [@css ".a-9h8p3p{place-content:space-evenly;}"];
  [@css ".a-9hwium{place-content:stretch;}"];
  [@css ".a-9hgpzp{place-content:center start;}"];
  [@css ".a-9hvq2g{place-content:start end;}"];
  [@css ".a-9h4mkx{place-content:space-between center;}"];
  [@css ".a-9iym04{place-items:center;}"];
  [@css ".a-9icea0{place-items:start;}"];
  [@css ".a-9iqbga{place-items:end;}"];
  [@css ".a-9iwgtc{place-items:stretch;}"];
  [@css ".a-9ip3r0{place-items:baseline;}"];
  [@css ".a-9ikxp5{place-items:center start;}"];
  [@css ".a-9ie9sr{place-items:start end;}"];
  [@css ".a-9jrl8b{place-self:auto;}"];
  [@css ".a-9je2kp{place-self:center;}"];
  [@css ".a-9j5pw6{place-self:start;}"];
  [@css ".a-9jzgxw{place-self:end;}"];
  [@css ".a-9jxvva{place-self:stretch;}"];
  [@css ".a-9jr5sl{place-self:center start;}"];
  [@css ".a-9j3gqb{place-self:start end;}"];
  [@css ".a-2t8d29{accent-color:auto;}"];
  [@css ".a-2tjc5t{accent-color:red;}"];
  [@css ".a-2t2rnk{accent-color:#ff0000;}"];
  [@css ".a-2tauhw{accent-color:rgb(255, 0, 0);}"];
  [@css ".a-dh2far{touch-action:auto;}"];
  [@css ".a-dhsbrd{touch-action:none;}"];
  [@css ".a-dhsu0a{touch-action:pan-x;}"];
  [@css ".a-dhcb00{touch-action:pan-y;}"];
  [@css ".a-dh4v8x{touch-action:manipulation;}"];
  [@css ".a-dhee94{touch-action:pan-x pan-y;}"];
  [@css ".a-35cmp3{aspect-ratio:auto;}"];
  [@css ".a-35ebk2{aspect-ratio:1 / 1;}"];
  [@css ".a-35vr3s{aspect-ratio:16 / 9;}"];
  [@css ".a-35vip7{aspect-ratio:0.5;}"];
  
  CSS.make("a-9hdqw8", []);
  CSS.make("a-9h5dhv", []);
  CSS.make("a-9hnyc7", []);
  CSS.make("a-9hg07y", []);
  CSS.make("a-9hn9tt", []);
  CSS.make("a-9h8p3p", []);
  CSS.make("a-9hwium", []);
  CSS.make("a-9hgpzp", []);
  CSS.make("a-9hvq2g", []);
  CSS.make("a-9h4mkx", []);
  
  CSS.make("a-9iym04", []);
  CSS.make("a-9icea0", []);
  CSS.make("a-9iqbga", []);
  CSS.make("a-9iwgtc", []);
  CSS.make("a-9ip3r0", []);
  CSS.make("a-9ikxp5", []);
  CSS.make("a-9ie9sr", []);
  
  CSS.make("a-9jrl8b", []);
  CSS.make("a-9je2kp", []);
  CSS.make("a-9j5pw6", []);
  CSS.make("a-9jzgxw", []);
  CSS.make("a-9jxvva", []);
  CSS.make("a-9jr5sl", []);
  CSS.make("a-9j3gqb", []);
  
  CSS.make("a-2t8d29", []);
  CSS.make("a-2tjc5t", []);
  CSS.make("a-2t2rnk", []);
  CSS.make("a-2tauhw", []);
  
  CSS.make("a-dh2far", []);
  CSS.make("a-dhsbrd", []);
  CSS.make("a-dhsu0a", []);
  CSS.make("a-dhcb00", []);
  CSS.make("a-dh4v8x", []);
  CSS.make("a-dhee94", []);
  
  CSS.make("a-35cmp3", []);
  CSS.make("a-35ebk2", []);
  CSS.make("a-35vr3s", []);
  CSS.make("a-35vip7", []);
