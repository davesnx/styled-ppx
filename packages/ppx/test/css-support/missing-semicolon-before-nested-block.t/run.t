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
    CSS.make("label:_case1 id-7yg861 a-39004yfbg a-e063z39004jebq", []);
  
  let _case2 =
    CSS.make(
      "label:_case2 id-147t2u6 a-dmhirp a-7rw2m8mctui a-7rw2mdm004yb5v",
      [],
    );
  
  let _case3 =
    CSS.make("label:_case3 id-1vot2jq a-7p0013pbo a-gnvk4ecewfy", []);
  
  let _case4 = CSS.make("label:_case4 id-jxylfo a-dmfqgp a-6e67vdig2jl", []);
  
  let _case5 =
    CSS.make(
      "label:_case5 id-ybfv30 a-3h007fik3 a-g0pq894001nnmp a-g0pq83h004k6wi",
      [],
    );
  
  let _case6 =
    CSS.make("label:_case6 id-1c9gvep a-9h002dmss a-p6loh9h002ynwb", []);
  
  let _case7 =
    CSS.make("label:_case7 id-1i9tlre a-ecckkm a-m0g6m94008l96r", []);
  
  let _case8 = CSS.make("label:_case8 id-8qqhh a-6llw3m a-56s4994am5k", []);
  
  let _case9 =
    CSS.make(
      "label:_case9 id-1pzdqgu a-dmsoaq a-7dsxf8cb0jf a-7dsxf88cclb a-7dsxf8mp7lg a-7dsxf8rsth4 a-7dsxf940027psf a-7dsxf9400400a4",
      [],
    );
  
  let _case10 = CSS.make("label:_case10 id-and7m a-4ekvmb a-3rgzi4e01wv", []);
  
  let _case11 = CSS.make("label:_case11 id-5o83hr a-4ekvmb a-jzkre4ezcut", []);
  
  let _case12 = CSS.make("label:_case12 id-a61d09 a-4ekvmb a-r9ykb4eekaf", []);
  
  let _case13 = CSS.make("label:_case13 id-1h260z2 a-4ekvmb a-nh52u5w3q3v", []);
  
  let _case14 = borderColor =>
    CSS.make(
      "label:_case14 id-1day2ma a-3h007mn6x a-g0pq894001nnmp a-g0pq83h004k6wi",
      [("--borderColor-knlnef", CSS.Types.Color.toString(borderColor))],
    );


