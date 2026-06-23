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
  let _case1 = CSS.make("css-f5yfbg-_case1 css-dtjebq-_case1", []);
  
  let _case2 =
    CSS.make("css-1mzhirp-_case2 css-lwctui-_case2 css-15xyb5v-_case2", []);
  
  let _case3 = CSS.make("css-i3pbo-_case3 css-1h5ewfy-_case3", []);
  
  let _case4 = CSS.make("css-xrfqgp-_case4 css-19gg2jl-_case4", []);
  
  let _case5 =
    CSS.make("css-ycfik3-_case5 css-yhnnmp-_case5 css-dyk6wi-_case5", []);
  
  let _case6 = CSS.make("css-x4dmss-_case6 css-iaynwb-_case6", []);
  
  let _case7 = CSS.make("css-17hckkm-_case7 css-1ffl96r-_case7", []);
  
  let _case8 = CSS.make("css-10klw3m-_case8 css-xkam5k-_case8", []);
  
  let _case9 =
    CSS.make(
      "css-tjsoaq-_case9 css-jvb0jf-_case9 css-18jcclb-_case9 css-v8p7lg-_case9 css-8asth4-_case9 css-cs7psf-_case9 css-1u700a4-_case9",
      [],
    );
  
  let _case10 = CSS.make("css-tokvmb-_case10 css-1bx01wv-_case10", []);
  
  let _case11 = CSS.make("css-tokvmb-_case11 css-1rwzcut-_case11", []);
  
  let _case12 = CSS.make("css-tokvmb-_case12 css-zvekaf-_case12", []);
  
  let _case13 = CSS.make("css-tokvmb-_case13 css-1jt3q3v-_case13", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "css-17mmn6x-_case14 css-yhnnmp-_case14 css-dyk6wi-_case14",
      [("--borderColor-knlnef", CSS.Types.Color.toString(borderColor))],
    );


