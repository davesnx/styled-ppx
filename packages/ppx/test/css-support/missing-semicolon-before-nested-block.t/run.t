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
  let _case1 = CSS.make("label:_case1 id-7yg861 a-f5yfbg a-dtjebq", []);
  
  let _case2 =
    CSS.make("label:_case2 id-147t2u6 a-1mzhirp a-lwctui a-15xyb5v", []);
  
  let _case3 = CSS.make("label:_case3 id-1vot2jq a-i3pbo a-1h5ewfy", []);
  
  let _case4 = CSS.make("label:_case4 id-jxylfo a-xrfqgp a-19gg2jl", []);
  
  let _case5 =
    CSS.make("label:_case5 id-ybfv30 a-ycfik3 a-yhnnmp a-dyk6wi", []);
  
  let _case6 = CSS.make("label:_case6 id-1c9gvep a-x4dmss a-iaynwb", []);
  
  let _case7 = CSS.make("label:_case7 id-1i9tlre a-17hckkm a-1ffl96r", []);
  
  let _case8 = CSS.make("label:_case8 id-8qqhh a-10klw3m a-xkam5k", []);
  
  let _case9 =
    CSS.make(
      "label:_case9 id-1pzdqgu a-tjsoaq a-jvb0jf a-18jcclb a-v8p7lg a-8asth4 a-cs7psf a-1u700a4",
      [],
    );
  
  let _case10 = CSS.make("label:_case10 id-and7m a-tokvmb a-1bx01wv", []);
  
  let _case11 = CSS.make("label:_case11 id-5o83hr a-tokvmb a-1rwzcut", []);
  
  let _case12 = CSS.make("label:_case12 id-a61d09 a-tokvmb a-zvekaf", []);
  
  let _case13 = CSS.make("label:_case13 id-1h260z2 a-tokvmb a-1jt3q3v", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "label:_case14 id-1day2ma in-17mmn6x a-yhnnmp a-dyk6wi",
      [("--borderColor-knlnef", CSS.Types.Color.toString(borderColor))],
    );


