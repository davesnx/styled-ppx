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
  [@css "._a_9hdqw8{place-content:center;}"];
  [@css "._a_9h5dhv{place-content:start;}"];
  [@css "._a_9hnyc7{place-content:end;}"];
  [@css "._a_9hg07y{place-content:space-between;}"];
  [@css "._a_9hn9tt{place-content:space-around;}"];
  [@css "._a_9h8p3p{place-content:space-evenly;}"];
  [@css "._a_9hwium{place-content:stretch;}"];
  [@css "._a_9hgpzp{place-content:center start;}"];
  [@css "._a_9hvq2g{place-content:start end;}"];
  [@css "._a_9h4mkx{place-content:space-between center;}"];
  [@css "._a_9iym04{place-items:center;}"];
  [@css "._a_9icea0{place-items:start;}"];
  [@css "._a_9iqbga{place-items:end;}"];
  [@css "._a_9iwgtc{place-items:stretch;}"];
  [@css "._a_9ip3r0{place-items:baseline;}"];
  [@css "._a_9ikxp5{place-items:center start;}"];
  [@css "._a_9ie9sr{place-items:start end;}"];
  [@css "._a_9jrl8b{place-self:auto;}"];
  [@css "._a_9je2kp{place-self:center;}"];
  [@css "._a_9j5pw6{place-self:start;}"];
  [@css "._a_9jzgxw{place-self:end;}"];
  [@css "._a_9jxvva{place-self:stretch;}"];
  [@css "._a_9jr5sl{place-self:center start;}"];
  [@css "._a_9j3gqb{place-self:start end;}"];
  [@css "._a_2t8d29{accent-color:auto;}"];
  [@css "._a_2tjc5t{accent-color:red;}"];
  [@css "._a_2t2rnk{accent-color:#ff0000;}"];
  [@css "._a_2tauhw{accent-color:rgb(255, 0, 0);}"];
  [@css "._a_dh2far{touch-action:auto;}"];
  [@css "._a_dhsbrd{touch-action:none;}"];
  [@css "._a_dhsu0a{touch-action:pan-x;}"];
  [@css "._a_dhcb00{touch-action:pan-y;}"];
  [@css "._a_dh4v8x{touch-action:manipulation;}"];
  [@css "._a_dhee94{touch-action:pan-x pan-y;}"];
  [@css "._a_35cmp3{aspect-ratio:auto;}"];
  [@css "._a_35ebk2{aspect-ratio:1 / 1;}"];
  [@css "._a_35vr3s{aspect-ratio:16 / 9;}"];
  [@css "._a_35vip7{aspect-ratio:0.5;}"];
  
  CSS.make("_a_9hdqw8", []);
  CSS.make("_a_9h5dhv", []);
  CSS.make("_a_9hnyc7", []);
  CSS.make("_a_9hg07y", []);
  CSS.make("_a_9hn9tt", []);
  CSS.make("_a_9h8p3p", []);
  CSS.make("_a_9hwium", []);
  CSS.make("_a_9hgpzp", []);
  CSS.make("_a_9hvq2g", []);
  CSS.make("_a_9h4mkx", []);
  
  CSS.make("_a_9iym04", []);
  CSS.make("_a_9icea0", []);
  CSS.make("_a_9iqbga", []);
  CSS.make("_a_9iwgtc", []);
  CSS.make("_a_9ip3r0", []);
  CSS.make("_a_9ikxp5", []);
  CSS.make("_a_9ie9sr", []);
  
  CSS.make("_a_9jrl8b", []);
  CSS.make("_a_9je2kp", []);
  CSS.make("_a_9j5pw6", []);
  CSS.make("_a_9jzgxw", []);
  CSS.make("_a_9jxvva", []);
  CSS.make("_a_9jr5sl", []);
  CSS.make("_a_9j3gqb", []);
  
  CSS.make("_a_2t8d29", []);
  CSS.make("_a_2tjc5t", []);
  CSS.make("_a_2t2rnk", []);
  CSS.make("_a_2tauhw", []);
  
  CSS.make("_a_dh2far", []);
  CSS.make("_a_dhsbrd", []);
  CSS.make("_a_dhsu0a", []);
  CSS.make("_a_dhcb00", []);
  CSS.make("_a_dh4v8x", []);
  CSS.make("_a_dhee94", []);
  
  CSS.make("_a_35cmp3", []);
  CSS.make("_a_35ebk2", []);
  CSS.make("_a_35vr3s", []);
  CSS.make("_a_35vip7", []);
