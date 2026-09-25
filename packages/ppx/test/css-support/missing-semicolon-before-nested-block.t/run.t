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
  let _case1 = CSS.make("label:_case1 cid-7yg861 css-f5yfbg css-dtjebq", []);
  
  let _case2 =
    CSS.make("label:_case2 cid-147t2u6 css-1mzhirp css-lwctui css-15xyb5v", []);
  
  let _case3 = CSS.make("label:_case3 cid-1vot2jq css-i3pbo css-1h5ewfy", []);
  
  let _case4 = CSS.make("label:_case4 cid-jxylfo css-xrfqgp css-19gg2jl", []);
  
  let _case5 =
    CSS.make("label:_case5 cid-ybfv30 css-ycfik3 css-yhnnmp css-dyk6wi", []);
  
  let _case6 = CSS.make("label:_case6 cid-1c9gvep css-x4dmss css-iaynwb", []);
  
  let _case7 = CSS.make("label:_case7 cid-1i9tlre css-17hckkm css-1ffl96r", []);
  
  let _case8 = CSS.make("label:_case8 cid-8qqhh css-10klw3m css-xkam5k", []);
  
  let _case9 =
    CSS.make(
      "label:_case9 cid-1pzdqgu css-tjsoaq css-jvb0jf css-18jcclb css-v8p7lg css-8asth4 css-cs7psf css-1u700a4",
      [],
    );
  
  let _case10 = CSS.make("label:_case10 cid-and7m css-tokvmb css-1bx01wv", []);
  
  let _case11 = CSS.make("label:_case11 cid-5o83hr css-tokvmb css-1rwzcut", []);
  
  let _case12 = CSS.make("label:_case12 cid-a61d09 css-tokvmb css-zvekaf", []);
  
  let _case13 =
    CSS.make("label:_case13 cid-1h260z2 css-tokvmb css-1jt3q3v", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "label:_case14 cid-1day2ma csv-17mmn6x css-yhnnmp css-dyk6wi",
      [("--borderColor-knlnef", CSS.Types.Color.toString(borderColor))],
    );


