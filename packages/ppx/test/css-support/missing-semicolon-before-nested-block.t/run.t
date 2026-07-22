This test ensures declaration lists accept nested selectors and `@media` blocks even when the preceding declaration omits its trailing semicolon.

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

  $ dune describe pp ./input.re | sed -n '/let _case1/,$p'
  let _case1 = CSS.make("css-f5yfbg-_case1 css-rntvzb-_case1", []);
  
  let _case2 =
    CSS.make("css-1mzhirp-_case2 css-jy52wp-_case2 css-1afm41n-_case2", []);
  
  let _case3 = CSS.make("css-i3pbo-_case3 css-19bz9l9-_case3", []);
  
  let _case4 = CSS.make("css-xrfqgp-_case4 css-np97y8-_case4", []);
  
  let _case5 =
    CSS.make("css-ycfik3-_case5 css-1q9hbts-_case5 css-s6p7f0-_case5", []);
  
  let _case6 = CSS.make("css-x4dmss-_case6 css-1g7ygnk-_case6", []);
  
  let _case7 = CSS.make("css-17hckkm-_case7 css-xxbxfl-_case7", []);
  
  let _case8 = CSS.make("css-10klw3m-_case8 css-1jo4nz5-_case8", []);
  
  let _case9 =
    CSS.make(
      "css-tjsoaq-_case9 css-gse13n-_case9 css-cc710w-_case9 css-1dqdpzj-_case9 css-7evi7q-_case9 css-i2ub5k-_case9 css-1hockt5-_case9",
      [],
    );
  
  let _case10 = CSS.make("css-tokvmb-_case10 css-1s2ecku-_case10", []);
  
  let _case11 = CSS.make("css-tokvmb-_case11 css-rrt8ue-_case11", []);
  
  let _case12 = CSS.make("css-tokvmb-_case12 css-g4st34-_case12", []);
  
  let _case13 = CSS.make("css-tokvmb-_case13 css-qcmw4v-_case13", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "css-17mmn6x-_case14 css-1q9hbts-_case14 css-s6p7f0-_case14",
      [("--borderColor-knlnef", CSS.Types.Color.toString(borderColor))],
    );


