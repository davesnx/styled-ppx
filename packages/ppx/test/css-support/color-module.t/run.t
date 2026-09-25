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
  [@css ".a-1klg0jz{color:rgba(0,0,0,0.5);}"];
  [@css ".a-19aau8k{color:#F06;}"];
  [@css ".a-show2y{color:#FF0066;}"];
  [@css ".a-12w3rs3{color:hsl(0,0%,0%);}"];
  [@css ".a-682uz0{color:hsl(0,0%,0%,0.5);}"];
  [@css ".a-1wq4akx{color:transparent;}"];
  [@css ".a-thzv76{color:currentColor;}"];
  [@css ".a-1aguouh{background-color:rgba(0,0,0,0.5);}"];
  [@css ".a-1o97rsf{background-color:#F06;}"];
  [@css ".a-p9u22v{background-color:#FF0066;}"];
  [@css ".a-12vo0zw{background-color:hsl(0,0%,0%);}"];
  [@css ".a-8rxhyp{background-color:hsl(0,0%,0%,0.5);}"];
  [@css ".a-1rm7u2e{background-color:transparent;}"];
  [@css ".a-dltmcs{background-color:currentColor;}"];
  [@css ".a-1xkgeh2{border-color:rgba(0,0,0,0.5);}"];
  [@css ".a-d8xfod{border-color:#F06;}"];
  [@css ".a-ngwiga{border-color:#FF0066;}"];
  [@css ".a-o1a70m{border-color:hsl(0,0%,0%);}"];
  [@css ".a-4aeh3t{border-color:hsl(0,0%,0%,0.5);}"];
  [@css ".a-roftna{border-color:transparent;}"];
  [@css ".a-1hs94su{border-color:currentColor;}"];
  [@css ".a-o5763g{text-decoration-color:rgba(0,0,0,0.5);}"];
  [@css ".a-1sjelkb{text-decoration-color:#F06;}"];
  [@css ".a-hy9y29{text-decoration-color:#FF0066;}"];
  [@css ".a-1j28iw5{text-decoration-color:hsl(0,0%,0%);}"];
  [@css ".a-1m667jc{text-decoration-color:hsl(0,0%,0%,0.5);}"];
  [@css ".a-1ks6wvt{text-decoration-color:transparent;}"];
  [@css ".a-1spw3fg{text-decoration-color:currentColor;}"];
  [@css
    ".a-1dqtlwt{-webkit-column-rule-color:rgba(0,0,0,0.5);column-rule-color:rgba(0,0,0,0.5);}"
  ];
  [@css ".a-ey6q4n{-webkit-column-rule-color:#F06;column-rule-color:#F06;}"];
  [@css
    ".a-1pel08{-webkit-column-rule-color:#FF0066;column-rule-color:#FF0066;}"
  ];
  [@css
    ".a-jyf49a{-webkit-column-rule-color:hsl(0,0%,0%);column-rule-color:hsl(0,0%,0%);}"
  ];
  [@css
    ".a-1hgrow3{-webkit-column-rule-color:hsl(0,0%,0%,0.5);column-rule-color:hsl(0,0%,0%,0.5);}"
  ];
  [@css
    ".a-1vyru4n{-webkit-column-rule-color:transparent;column-rule-color:transparent;}"
  ];
  [@css
    ".a-l03e1{-webkit-column-rule-color:currentColor;column-rule-color:currentColor;}"
  ];
  [@css ".a-106elx5{color:rgb(0% 20% 70%);}"];
  [@css ".a-169x4dj{color:rgb(0 64 185);}"];
  [@css ".a-itsf2n{color:hsl(0 0% 0%);}"];
  [@css ".a-10z9r5f{color:rgba(0% 20% 70% / 50%);}"];
  [@css ".a-i8e91{color:rgba(0% 20% 70% / 0.5);}"];
  [@css ".a-k2ko2n{color:rgba(0 64 185 / 50%);}"];
  [@css ".a-1jq4wb0{color:rgba(0 64 185 / 0.5);}"];
  [@css ".a-1deabkw{color:hsla(0 0% 0% /0.5);}"];
  [@css ".a-1chilpd{color:rgb(0% 20% 70% / 50%);}"];
  [@css ".a-cm2qa9{color:rgb(0% 20% 70% / 0.5);}"];
  [@css ".a-tnjacv{color:rgb(0 64 185 / 50%);}"];
  [@css ".a-1nl0tkw{color:rgb(0 64 185 / 0.5);}"];
  [@css ".a-ikl566{color:hsl(0 0% 0% / 0.5);}"];
  [@css ".a-1wfylgf{color:#000F;}"];
  [@css ".a-1o5x0fw{color:#000000FF;}"];
  [@css ".a-1j7dx2f{color:rebeccapurple;}"];
  [@css ".a-1lzhslh{background-color:rgb(0% 20% 70%);}"];
  [@css ".a-6ez43m{background-color:rgb(0 64 185);}"];
  [@css ".a-2v74s8{background-color:hsl(0 0% 0%);}"];
  [@css ".a-fqa3ju{background-color:rgba(0% 20% 70% / 50%);}"];
  [@css ".a-1ulf2tb{background-color:rgba(0% 20% 70% / 0.5);}"];
  [@css ".a-99atwn{background-color:rgba(0 64 185 / 50%);}"];
  [@css ".a-1mk7sx6{background-color:rgba(0 64 185 / 0.5);}"];
  [@css ".a-1nu3sdc{background-color:hsla(0 0% 0% /0.5);}"];
  [@css ".a-98qi4x{background-color:rgb(0% 20% 70% / 50%);}"];
  [@css ".a-1f60zw7{background-color:rgb(0% 20% 70% / 0.5);}"];
  [@css ".a-1sopvf5{background-color:rgb(0 64 185 / 50%);}"];
  [@css ".a-1xjr5yh{background-color:rgb(0 64 185 / 0.5);}"];
  [@css ".a-ase6sp{background-color:hsl(0 0% 0% / 0.5);}"];
  [@css ".a-131nvgj{background-color:#000F;}"];
  [@css ".a-1xqbf4a{background-color:#000000FF;}"];
  [@css ".a-9ss56r{background-color:rebeccapurple;}"];
  [@css ".a-1k5i3r2{border-color:rgb(0% 20% 70%);}"];
  [@css ".a-17269e2{border-color:rgb(0 64 185);}"];
  [@css ".a-1kpl970{border-color:hsl(0 0% 0%);}"];
  [@css ".a-scxvdj{border-color:rgba(0% 20% 70% / 50%);}"];
  [@css ".a-2a1dto{border-color:rgba(0% 20% 70% / 0.5);}"];
  [@css ".a-tvijrw{border-color:rgba(0 64 185 / 50%);}"];
  [@css ".a-1fp9ko3{border-color:rgba(0 64 185 / 0.5);}"];
  [@css ".a-1qn5w0z{border-color:hsla(0 0% 0% /0.5);}"];
  [@css ".a-1hr8e0z{border-color:rgb(0% 20% 70% / 50%);}"];
  [@css ".a-3y6gcy{border-color:rgb(0% 20% 70% / 0.5);}"];
  [@css ".a-1ymoio{border-color:rgb(0 64 185 / 50%);}"];
  [@css ".a-1mjjpk9{border-color:rgb(0 64 185 / 0.5);}"];
  [@css ".a-8bj0kf{border-color:hsl(0 0% 0% / 0.5);}"];
  [@css ".a-n5b9dq{border-color:#000F;}"];
  [@css ".a-12wm3pc{border-color:#000000FF;}"];
  [@css ".a-1c73fhh{border-color:rebeccapurple;}"];
  [@css ".a-ln3bxw{text-decoration-color:rgb(0% 20% 70%);}"];
  [@css ".a-lkgw6s{text-decoration-color:rgb(0 64 185);}"];
  [@css ".a-14o54z6{text-decoration-color:hsl(0 0% 0%);}"];
  [@css ".a-80it8b{text-decoration-color:rgba(0% 20% 70% / 50%);}"];
  [@css ".a-c8v6ky{text-decoration-color:rgba(0% 20% 70% / 0.5);}"];
  [@css ".a-pvd63l{text-decoration-color:rgba(0 64 185 / 50%);}"];
  [@css ".a-14bmep{text-decoration-color:rgba(0 64 185 / 0.5);}"];
  [@css ".a-17xi8yb{text-decoration-color:hsla(0 0% 0% /0.5);}"];
  [@css ".a-kv6m7{text-decoration-color:rgb(0% 20% 70% / 50%);}"];
  [@css ".a-135snjr{text-decoration-color:rgb(0% 20% 70% / 0.5);}"];
  [@css ".a-tm0vqt{text-decoration-color:rgb(0 64 185 / 50%);}"];
  [@css ".a-1bkqk8j{text-decoration-color:rgb(0 64 185 / 0.5);}"];
  [@css ".a-68bkrk{text-decoration-color:hsl(0 0% 0% / 0.5);}"];
  [@css ".a-40xjkw{text-decoration-color:#000F;}"];
  [@css ".a-zlfh32{text-decoration-color:#000000FF;}"];
  [@css ".a-18j2zim{text-decoration-color:rebeccapurple;}"];
  [@css
    ".a-1oj6vui{-webkit-column-rule-color:rgb(0% 20% 70%);column-rule-color:rgb(0% 20% 70%);}"
  ];
  [@css
    ".a-4i3dyf{-webkit-column-rule-color:rgb(0 64 185);column-rule-color:rgb(0 64 185);}"
  ];
  [@css
    ".a-1maqvl6{-webkit-column-rule-color:hsl(0 0% 0%);column-rule-color:hsl(0 0% 0%);}"
  ];
  [@css
    ".a-1wm8yii{-webkit-column-rule-color:rgba(0% 20% 70% / 50%);column-rule-color:rgba(0% 20% 70% / 50%);}"
  ];
  [@css
    ".a-11jt9pq{-webkit-column-rule-color:rgba(0% 20% 70% / 0.5);column-rule-color:rgba(0% 20% 70% / 0.5);}"
  ];
  [@css
    ".a-sjwwr9{-webkit-column-rule-color:rgba(0 64 185 / 50%);column-rule-color:rgba(0 64 185 / 50%);}"
  ];
  [@css
    ".a-1k0c8ch{-webkit-column-rule-color:rgba(0 64 185 / 0.5);column-rule-color:rgba(0 64 185 / 0.5);}"
  ];
  [@css
    ".a-2guu68{-webkit-column-rule-color:hsla(0 0% 0% /0.5);column-rule-color:hsla(0 0% 0% /0.5);}"
  ];
  [@css
    ".a-514t4f{-webkit-column-rule-color:rgb(0% 20% 70% / 50%);column-rule-color:rgb(0% 20% 70% / 50%);}"
  ];
  [@css
    ".a-6yxjvr{-webkit-column-rule-color:rgb(0% 20% 70% / 0.5);column-rule-color:rgb(0% 20% 70% / 0.5);}"
  ];
  [@css
    ".a-gqmwf4{-webkit-column-rule-color:rgb(0 64 185 / 50%);column-rule-color:rgb(0 64 185 / 50%);}"
  ];
  [@css
    ".a-11xt3by{-webkit-column-rule-color:rgb(0 64 185 / 0.5);column-rule-color:rgb(0 64 185 / 0.5);}"
  ];
  [@css
    ".a-1kkf3h2{-webkit-column-rule-color:hsl(0 0% 0% / 0.5);column-rule-color:hsl(0 0% 0% / 0.5);}"
  ];
  [@css ".a-19rpsoy{-webkit-column-rule-color:#000F;column-rule-color:#000F;}"];
  [@css
    ".a-g596r0{-webkit-column-rule-color:#000000FF;column-rule-color:#000000FF;}"
  ];
  [@css
    ".a-107t3it{-webkit-column-rule-color:rebeccapurple;column-rule-color:rebeccapurple;}"
  ];
  [@css ".a-xv7eia{color:color-mix(in srgb, teal 65%, olive);}"];
  [@css ".a-1q9agm7{color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}"];
  [@css
    ".a-rzb0m8{color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css
    ".a-6hx6yd{color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css ".a-1dr2vpr{color:color-mix(in lch, teal 65%, olive);}"];
  [@css ".a-i9v2e0{color:color-mix(in hsl, teal 65%, olive);}"];
  [@css ".a-13pap82{color:color-mix(in hwb, teal 65%, olive);}"];
  [@css ".a-s4rji0{color:color-mix(in xyz, teal 65%, olive);}"];
  [@css ".a-1imxr44{color:color-mix(in lab, teal 65%, olive);}"];
  [@css
    ".a-bvuxb0{color:color-mix(in lch longer hue, hsl(200deg 50% 80%), coral);}"
  ];
  [@css ".a-vzawmn{background-color:color-mix(in srgb, teal 65%, olive);}"];
  [@css
    ".a-1bh658x{background-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}"
  ];
  [@css
    ".a-xdjnak{background-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css
    ".a-z2tmhh{background-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css ".a-sr14q8{background-color:color-mix(in lch, teal 65%, olive);}"];
  [@css ".a-15xujv5{background-color:color-mix(in hsl, teal 65%, olive);}"];
  [@css ".a-5j5l1n{background-color:color-mix(in hwb, teal 65%, olive);}"];
  [@css ".a-1layqra{background-color:color-mix(in xyz, teal 65%, olive);}"];
  [@css ".a-iqo7xf{background-color:color-mix(in lab, teal 65%, olive);}"];
  [@css ".a-1dvgebh{border-color:color-mix(in srgb, teal 65%, olive);}"];
  [@css
    ".a-1cpjoz7{border-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}"
  ];
  [@css
    ".a-qokah8{border-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css
    ".a-tlegxc{border-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css ".a-xd9u6g{border-color:color-mix(in lch, teal 65%, olive);}"];
  [@css ".a-19dtqog{border-color:color-mix(in hsl, teal 65%, olive);}"];
  [@css ".a-4czslf{border-color:color-mix(in hwb, teal 65%, olive);}"];
  [@css ".a-7we9z4{border-color:color-mix(in xyz, teal 65%, olive);}"];
  [@css ".a-15anzfj{border-color:color-mix(in lab, teal 65%, olive);}"];
  [@css
    ".a-1laj5fb{text-decoration-color:color-mix(in srgb, teal 65%, olive);}"
  ];
  [@css
    ".a-2vgokw{text-decoration-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}"
  ];
  [@css
    ".a-nnawx{text-decoration-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css
    ".a-1w9gyza{text-decoration-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css ".a-10gmjvl{text-decoration-color:color-mix(in lch, teal 65%, olive);}"];
  [@css ".a-5dhj6n{text-decoration-color:color-mix(in hsl, teal 65%, olive);}"];
  [@css ".a-13of0y0{text-decoration-color:color-mix(in hwb, teal 65%, olive);}"];
  [@css ".a-1qogihm{text-decoration-color:color-mix(in xyz, teal 65%, olive);}"];
  [@css ".a-1huznhc{text-decoration-color:color-mix(in lab, teal 65%, olive);}"];
  [@css
    ".a-1cbt29u{-webkit-column-rule-color:color-mix(in srgb, teal 65%, olive);column-rule-color:color-mix(in srgb, teal 65%, olive);}"
  ];
  [@css
    ".a-lh3exx{-webkit-column-rule-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);column-rule-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}"
  ];
  [@css
    ".a-tznjzz{-webkit-column-rule-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);column-rule-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css
    ".a-bomvwj{-webkit-column-rule-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);column-rule-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}"
  ];
  [@css
    ".a-10mgb0{-webkit-column-rule-color:color-mix(in lch, teal 65%, olive);column-rule-color:color-mix(in lch, teal 65%, olive);}"
  ];
  [@css
    ".a-64iyg8{-webkit-column-rule-color:color-mix(in hsl, teal 65%, olive);column-rule-color:color-mix(in hsl, teal 65%, olive);}"
  ];
  [@css
    ".a-1dpa2h1{-webkit-column-rule-color:color-mix(in hwb, teal 65%, olive);column-rule-color:color-mix(in hwb, teal 65%, olive);}"
  ];
  [@css
    ".a-8f641x{-webkit-column-rule-color:color-mix(in xyz, teal 65%, olive);column-rule-color:color-mix(in xyz, teal 65%, olive);}"
  ];
  [@css
    ".a-r6gkgb{-webkit-column-rule-color:color-mix(in lab, teal 65%, olive);column-rule-color:color-mix(in lab, teal 65%, olive);}"
  ];
  [@css ".a-161ii5p{color:rgba(0, 0, 0, calc(1));}"];
  [@css ".a-1ikqmml{color:rgba(0, 0, 0, calc(10 - 1));}"];
  
  CSS.make("a-1klg0jz", []);
  CSS.make("a-19aau8k", []);
  CSS.make("a-show2y", []);
  CSS.make("a-12w3rs3", []);
  CSS.make("a-682uz0", []);
  CSS.make("a-1wq4akx", []);
  CSS.make("a-thzv76", []);
  CSS.make("a-1aguouh", []);
  CSS.make("a-1o97rsf", []);
  CSS.make("a-p9u22v", []);
  CSS.make("a-12vo0zw", []);
  CSS.make("a-8rxhyp", []);
  CSS.make("a-1rm7u2e", []);
  CSS.make("a-dltmcs", []);
  CSS.make("a-1xkgeh2", []);
  CSS.make("a-d8xfod", []);
  CSS.make("a-ngwiga", []);
  CSS.make("a-o1a70m", []);
  CSS.make("a-4aeh3t", []);
  CSS.make("a-roftna", []);
  CSS.make("a-1hs94su", []);
  CSS.make("a-o5763g", []);
  CSS.make("a-1sjelkb", []);
  CSS.make("a-hy9y29", []);
  CSS.make("a-1j28iw5", []);
  CSS.make("a-1m667jc", []);
  CSS.make("a-1ks6wvt", []);
  CSS.make("a-1spw3fg", []);
  CSS.make("a-1dqtlwt", []);
  CSS.make("a-ey6q4n", []);
  CSS.make("a-1pel08", []);
  CSS.make("a-jyf49a", []);
  CSS.make("a-1hgrow3", []);
  CSS.make("a-1vyru4n", []);
  CSS.make("a-l03e1", []);
  
  CSS.make("a-106elx5", []);
  CSS.make("a-169x4dj", []);
  CSS.make("a-itsf2n", []);
  CSS.make("a-10z9r5f", []);
  CSS.make("a-i8e91", []);
  CSS.make("a-k2ko2n", []);
  CSS.make("a-1jq4wb0", []);
  CSS.make("a-1deabkw", []);
  CSS.make("a-1chilpd", []);
  CSS.make("a-cm2qa9", []);
  CSS.make("a-tnjacv", []);
  CSS.make("a-1nl0tkw", []);
  CSS.make("a-ikl566", []);
  CSS.make("a-1wfylgf", []);
  CSS.make("a-1o5x0fw", []);
  CSS.make("a-1j7dx2f", []);
  
  CSS.make("a-1lzhslh", []);
  CSS.make("a-6ez43m", []);
  CSS.make("a-2v74s8", []);
  CSS.make("a-fqa3ju", []);
  CSS.make("a-1ulf2tb", []);
  CSS.make("a-99atwn", []);
  CSS.make("a-1mk7sx6", []);
  CSS.make("a-1nu3sdc", []);
  CSS.make("a-98qi4x", []);
  CSS.make("a-1f60zw7", []);
  CSS.make("a-1sopvf5", []);
  CSS.make("a-1xjr5yh", []);
  CSS.make("a-ase6sp", []);
  CSS.make("a-131nvgj", []);
  CSS.make("a-1xqbf4a", []);
  CSS.make("a-9ss56r", []);
  CSS.make("a-1k5i3r2", []);
  CSS.make("a-17269e2", []);
  CSS.make("a-1kpl970", []);
  CSS.make("a-scxvdj", []);
  CSS.make("a-2a1dto", []);
  CSS.make("a-tvijrw", []);
  CSS.make("a-1fp9ko3", []);
  CSS.make("a-1qn5w0z", []);
  CSS.make("a-1hr8e0z", []);
  CSS.make("a-3y6gcy", []);
  CSS.make("a-1ymoio", []);
  CSS.make("a-1mjjpk9", []);
  CSS.make("a-8bj0kf", []);
  CSS.make("a-n5b9dq", []);
  CSS.make("a-12wm3pc", []);
  CSS.make("a-1c73fhh", []);
  CSS.make("a-ln3bxw", []);
  CSS.make("a-lkgw6s", []);
  CSS.make("a-14o54z6", []);
  CSS.make("a-80it8b", []);
  CSS.make("a-c8v6ky", []);
  CSS.make("a-pvd63l", []);
  CSS.make("a-14bmep", []);
  CSS.make("a-17xi8yb", []);
  CSS.make("a-kv6m7", []);
  CSS.make("a-135snjr", []);
  CSS.make("a-tm0vqt", []);
  CSS.make("a-1bkqk8j", []);
  CSS.make("a-68bkrk", []);
  CSS.make("a-40xjkw", []);
  CSS.make("a-zlfh32", []);
  CSS.make("a-18j2zim", []);
  CSS.make("a-1oj6vui", []);
  CSS.make("a-4i3dyf", []);
  CSS.make("a-1maqvl6", []);
  CSS.make("a-1wm8yii", []);
  CSS.make("a-11jt9pq", []);
  CSS.make("a-sjwwr9", []);
  CSS.make("a-1k0c8ch", []);
  CSS.make("a-2guu68", []);
  CSS.make("a-514t4f", []);
  CSS.make("a-6yxjvr", []);
  CSS.make("a-gqmwf4", []);
  CSS.make("a-11xt3by", []);
  CSS.make("a-1kkf3h2", []);
  CSS.make("a-19rpsoy", []);
  CSS.make("a-g596r0", []);
  CSS.make("a-107t3it", []);
  
  CSS.make("a-xv7eia", []);
  CSS.make("a-1q9agm7", []);
  CSS.make("a-rzb0m8", []);
  CSS.make("a-6hx6yd", []);
  CSS.make("a-1dr2vpr", []);
  CSS.make("a-i9v2e0", []);
  CSS.make("a-13pap82", []);
  CSS.make("a-s4rji0", []);
  CSS.make("a-1imxr44", []);
  CSS.make("a-bvuxb0", []);
  
  CSS.make("a-vzawmn", []);
  CSS.make("a-1bh658x", []);
  CSS.make("a-xdjnak", []);
  CSS.make("a-z2tmhh", []);
  CSS.make("a-sr14q8", []);
  CSS.make("a-15xujv5", []);
  CSS.make("a-5j5l1n", []);
  CSS.make("a-1layqra", []);
  CSS.make("a-iqo7xf", []);
  
  CSS.make("a-1dvgebh", []);
  CSS.make("a-1cpjoz7", []);
  CSS.make("a-qokah8", []);
  CSS.make("a-tlegxc", []);
  CSS.make("a-xd9u6g", []);
  CSS.make("a-19dtqog", []);
  CSS.make("a-4czslf", []);
  CSS.make("a-7we9z4", []);
  CSS.make("a-15anzfj", []);
  
  CSS.make("a-1laj5fb", []);
  CSS.make("a-2vgokw", []);
  CSS.make("a-nnawx", []);
  CSS.make("a-1w9gyza", []);
  CSS.make("a-10gmjvl", []);
  CSS.make("a-5dhj6n", []);
  CSS.make("a-13of0y0", []);
  CSS.make("a-1qogihm", []);
  CSS.make("a-1huznhc", []);
  
  CSS.make("a-1cbt29u", []);
  CSS.make("a-lh3exx", []);
  CSS.make("a-tznjzz", []);
  CSS.make("a-bomvwj", []);
  CSS.make("a-10mgb0", []);
  CSS.make("a-64iyg8", []);
  CSS.make("a-1dpa2h1", []);
  CSS.make("a-8f641x", []);
  CSS.make("a-r6gkgb", []);
  
  CSS.make("a-161ii5p", []);
  CSS.make("a-1ikqmml", []);
