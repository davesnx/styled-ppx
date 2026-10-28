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
  let _case1 =
    CSS.make("label:_case1 _id_1g4qrfg _a_390004yfbg _a_e063z390004jebq", []);
  
  let _case2 =
    CSS.make(
      "label:_case2 _id_1xkzaxa _a_dmhirp _a_7rw2m8mctui _a_7rw2mdm0004yb5v",
      [],
    );
  
  let _case3 =
    CSS.make("label:_case3 _id_1q4ovzk _a_7p00013pbo _a_gnvk4ecewfy", []);
  
  let _case4 =
    CSS.make("label:_case4 _id_18o8lh4 _a_dmfqgp _a_6e67vdig2jl", []);
  
  let _case5 =
    CSS.make(
      "label:_case5 _id_2k1xa0 _a_3h0007fik3 _a_g0pq8940001nnmp _a_g0pq83h0004k6wi",
      [],
    );
  
  let _case6 =
    CSS.make("label:_case6 _id_1mh9kij _a_9h0002dmss _a_p6loh9h0002ynwb", []);
  
  let _case7 =
    CSS.make("label:_case7 _id_13w0lqz _a_ecckkm _a_m0g6m940008l96r", []);
  
  let _case8 = CSS.make("label:_case8 _id_zq2s7q _a_6llw3m _a_56s4994am5k", []);
  
  let _case9 =
    CSS.make(
      "label:_case9 _id_17v7ye8 _a_dmsoaq _a_7dsxf8cb0jf _a_7dsxf88cclb _a_7dsxf8mp7lg _a_7dsxf8rsth4 _a_7dsxf9400027psf _a_7dsxf94000400a4",
      [],
    );
  
  let _case10 =
    CSS.make("label:_case10 _id_1a9g5sj _a_4ekvmb _a_3rgzi4e01wv", []);
  
  let _case11 =
    CSS.make("label:_case11 _id_rop0xf _a_4ekvmb _a_jzkre4ezcut", []);
  
  let _case12 =
    CSS.make("label:_case12 _id_z2x9tb _a_4ekvmb _a_r9ykb4eekaf", []);
  
  let _case13 =
    CSS.make("label:_case13 _id_t3e7g _a_4ekvmb _a_nh52u5w3q3v", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "label:_case14 _id_dfqj6e _a_3h0007mn6x _a_g0pq8940001nnmp _a_g0pq83h0004k6wi",
      [("--borderColor-knlnef", CSS.Types.Color.toString(borderColor))],
    );


