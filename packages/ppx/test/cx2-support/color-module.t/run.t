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
  [@css
    ".css-1klg0jz{color:rgba(0,0,0,0.5);}\n.css-19aau8k{color:#F06;}\n.css-show2y{color:#FF0066;}\n.css-12w3rs3{color:hsl(0,0%,0%);}\n.css-682uz0{color:hsl(0,0%,0%,0.5);}\n.css-1wq4akx{color:transparent;}\n.css-thzv76{color:currentColor;}\n.css-1aguouh{background-color:rgba(0,0,0,0.5);}\n.css-1o97rsf{background-color:#F06;}\n.css-p9u22v{background-color:#FF0066;}\n.css-12vo0zw{background-color:hsl(0,0%,0%);}\n.css-8rxhyp{background-color:hsl(0,0%,0%,0.5);}\n.css-1rm7u2e{background-color:transparent;}\n.css-dltmcs{background-color:currentColor;}\n.css-1xkgeh2{border-color:rgba(0,0,0,0.5);}\n.css-d8xfod{border-color:#F06;}\n.css-ngwiga{border-color:#FF0066;}\n.css-o1a70m{border-color:hsl(0,0%,0%);}\n.css-4aeh3t{border-color:hsl(0,0%,0%,0.5);}\n.css-roftna{border-color:transparent;}\n.css-1hs94su{border-color:currentColor;}\n.css-o5763g{text-decoration-color:rgba(0,0,0,0.5);}\n.css-1sjelkb{text-decoration-color:#F06;}\n.css-hy9y29{text-decoration-color:#FF0066;}\n.css-1j28iw5{text-decoration-color:hsl(0,0%,0%);}\n.css-1m667jc{text-decoration-color:hsl(0,0%,0%,0.5);}\n.css-1ks6wvt{text-decoration-color:transparent;}\n.css-1spw3fg{text-decoration-color:currentColor;}\n.css-1dqtlwt{column-rule-color:rgba(0,0,0,0.5);}\n.css-ey6q4n{column-rule-color:#F06;}\n.css-1pel08{column-rule-color:#FF0066;}\n.css-jyf49a{column-rule-color:hsl(0,0%,0%);}\n.css-1hgrow3{column-rule-color:hsl(0,0%,0%,0.5);}\n.css-1vyru4n{column-rule-color:transparent;}\n.css-l03e1{column-rule-color:currentColor;}\n.css-106elx5{color:rgb(0% 20% 70%);}\n.css-169x4dj{color:rgb(0 64 185);}\n.css-itsf2n{color:hsl(0 0% 0%);}\n.css-10z9r5f{color:rgba(0% 20% 70% / 50%);}\n.css-i8e91{color:rgba(0% 20% 70% / 0.5);}\n.css-k2ko2n{color:rgba(0 64 185 / 50%);}\n.css-1jq4wb0{color:rgba(0 64 185 / 0.5);}\n.css-1deabkw{color:hsla(0 0% 0% /0.5);}\n.css-1chilpd{color:rgb(0% 20% 70% / 50%);}\n.css-cm2qa9{color:rgb(0% 20% 70% / 0.5);}\n.css-tnjacv{color:rgb(0 64 185 / 50%);}\n.css-1nl0tkw{color:rgb(0 64 185 / 0.5);}\n.css-ikl566{color:hsl(0 0% 0% / 0.5);}\n.css-1wfylgf{color:#000F;}\n.css-1o5x0fw{color:#000000FF;}\n.css-1j7dx2f{color:rebeccapurple;}\n.css-1lzhslh{background-color:rgb(0% 20% 70%);}\n.css-6ez43m{background-color:rgb(0 64 185);}\n.css-2v74s8{background-color:hsl(0 0% 0%);}\n.css-fqa3ju{background-color:rgba(0% 20% 70% / 50%);}\n.css-1ulf2tb{background-color:rgba(0% 20% 70% / 0.5);}\n.css-99atwn{background-color:rgba(0 64 185 / 50%);}\n.css-1mk7sx6{background-color:rgba(0 64 185 / 0.5);}\n.css-1nu3sdc{background-color:hsla(0 0% 0% /0.5);}\n.css-98qi4x{background-color:rgb(0% 20% 70% / 50%);}\n.css-1f60zw7{background-color:rgb(0% 20% 70% / 0.5);}\n.css-1sopvf5{background-color:rgb(0 64 185 / 50%);}\n.css-1xjr5yh{background-color:rgb(0 64 185 / 0.5);}\n.css-ase6sp{background-color:hsl(0 0% 0% / 0.5);}\n.css-131nvgj{background-color:#000F;}\n.css-1xqbf4a{background-color:#000000FF;}\n.css-9ss56r{background-color:rebeccapurple;}\n.css-1k5i3r2{border-color:rgb(0% 20% 70%);}\n.css-17269e2{border-color:rgb(0 64 185);}\n.css-1kpl970{border-color:hsl(0 0% 0%);}\n.css-scxvdj{border-color:rgba(0% 20% 70% / 50%);}\n.css-2a1dto{border-color:rgba(0% 20% 70% / 0.5);}\n.css-tvijrw{border-color:rgba(0 64 185 / 50%);}\n.css-1fp9ko3{border-color:rgba(0 64 185 / 0.5);}\n.css-1qn5w0z{border-color:hsla(0 0% 0% /0.5);}\n.css-1hr8e0z{border-color:rgb(0% 20% 70% / 50%);}\n.css-3y6gcy{border-color:rgb(0% 20% 70% / 0.5);}\n.css-1ymoio{border-color:rgb(0 64 185 / 50%);}\n.css-1mjjpk9{border-color:rgb(0 64 185 / 0.5);}\n.css-8bj0kf{border-color:hsl(0 0% 0% / 0.5);}\n.css-n5b9dq{border-color:#000F;}\n.css-12wm3pc{border-color:#000000FF;}\n.css-1c73fhh{border-color:rebeccapurple;}\n.css-ln3bxw{text-decoration-color:rgb(0% 20% 70%);}\n.css-lkgw6s{text-decoration-color:rgb(0 64 185);}\n.css-14o54z6{text-decoration-color:hsl(0 0% 0%);}\n.css-80it8b{text-decoration-color:rgba(0% 20% 70% / 50%);}\n.css-c8v6ky{text-decoration-color:rgba(0% 20% 70% / 0.5);}\n.css-pvd63l{text-decoration-color:rgba(0 64 185 / 50%);}\n.css-14bmep{text-decoration-color:rgba(0 64 185 / 0.5);}\n.css-17xi8yb{text-decoration-color:hsla(0 0% 0% /0.5);}\n.css-kv6m7{text-decoration-color:rgb(0% 20% 70% / 50%);}\n.css-135snjr{text-decoration-color:rgb(0% 20% 70% / 0.5);}\n.css-tm0vqt{text-decoration-color:rgb(0 64 185 / 50%);}\n.css-1bkqk8j{text-decoration-color:rgb(0 64 185 / 0.5);}\n.css-68bkrk{text-decoration-color:hsl(0 0% 0% / 0.5);}\n.css-40xjkw{text-decoration-color:#000F;}\n.css-zlfh32{text-decoration-color:#000000FF;}\n.css-18j2zim{text-decoration-color:rebeccapurple;}\n.css-1oj6vui{column-rule-color:rgb(0% 20% 70%);}\n.css-4i3dyf{column-rule-color:rgb(0 64 185);}\n.css-1maqvl6{column-rule-color:hsl(0 0% 0%);}\n.css-1wm8yii{column-rule-color:rgba(0% 20% 70% / 50%);}\n.css-11jt9pq{column-rule-color:rgba(0% 20% 70% / 0.5);}\n.css-sjwwr9{column-rule-color:rgba(0 64 185 / 50%);}\n.css-1k0c8ch{column-rule-color:rgba(0 64 185 / 0.5);}\n.css-2guu68{column-rule-color:hsla(0 0% 0% /0.5);}\n.css-514t4f{column-rule-color:rgb(0% 20% 70% / 50%);}\n.css-6yxjvr{column-rule-color:rgb(0% 20% 70% / 0.5);}\n.css-gqmwf4{column-rule-color:rgb(0 64 185 / 50%);}\n.css-11xt3by{column-rule-color:rgb(0 64 185 / 0.5);}\n.css-1kkf3h2{column-rule-color:hsl(0 0% 0% / 0.5);}\n.css-19rpsoy{column-rule-color:#000F;}\n.css-g596r0{column-rule-color:#000000FF;}\n.css-107t3it{column-rule-color:rebeccapurple;}\n.css-xv7eia{color:color-mix(in srgb, teal 65%, olive);}\n.css-1q9agm7{color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}\n.css-rzb0m8{color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}\n.css-6hx6yd{color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}\n.css-1dr2vpr{color:color-mix(in lch, teal 65%, olive);}\n.css-i9v2e0{color:color-mix(in hsl, teal 65%, olive);}\n.css-13pap82{color:color-mix(in hwb, teal 65%, olive);}\n.css-s4rji0{color:color-mix(in xyz, teal 65%, olive);}\n.css-1imxr44{color:color-mix(in lab, teal 65%, olive);}\n.css-bvuxb0{color:color-mix(in lch longer hue, hsl(200deg 50% 80%), coral);}\n.css-vzawmn{background-color:color-mix(in srgb, teal 65%, olive);}\n.css-1bh658x{background-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}\n.css-xdjnak{background-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}\n.css-z2tmhh{background-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}\n.css-sr14q8{background-color:color-mix(in lch, teal 65%, olive);}\n.css-15xujv5{background-color:color-mix(in hsl, teal 65%, olive);}\n.css-5j5l1n{background-color:color-mix(in hwb, teal 65%, olive);}\n.css-1layqra{background-color:color-mix(in xyz, teal 65%, olive);}\n.css-iqo7xf{background-color:color-mix(in lab, teal 65%, olive);}\n.css-1dvgebh{border-color:color-mix(in srgb, teal 65%, olive);}\n.css-1cpjoz7{border-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}\n.css-qokah8{border-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}\n.css-tlegxc{border-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}\n.css-xd9u6g{border-color:color-mix(in lch, teal 65%, olive);}\n.css-19dtqog{border-color:color-mix(in hsl, teal 65%, olive);}\n.css-4czslf{border-color:color-mix(in hwb, teal 65%, olive);}\n.css-7we9z4{border-color:color-mix(in xyz, teal 65%, olive);}\n.css-15anzfj{border-color:color-mix(in lab, teal 65%, olive);}\n.css-1laj5fb{text-decoration-color:color-mix(in srgb, teal 65%, olive);}\n.css-2vgokw{text-decoration-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}\n.css-nnawx{text-decoration-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}\n.css-1w9gyza{text-decoration-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}\n.css-10gmjvl{text-decoration-color:color-mix(in lch, teal 65%, olive);}\n.css-5dhj6n{text-decoration-color:color-mix(in hsl, teal 65%, olive);}\n.css-13of0y0{text-decoration-color:color-mix(in hwb, teal 65%, olive);}\n.css-1qogihm{text-decoration-color:color-mix(in xyz, teal 65%, olive);}\n.css-1huznhc{text-decoration-color:color-mix(in lab, teal 65%, olive);}\n.css-1cbt29u{column-rule-color:color-mix(in srgb, teal 65%, olive);}\n.css-lh3exx{column-rule-color:color-mix(in srgb, rgb(255, 0, 0, 0.2) 65%, olive);}\n.css-tznjzz{column-rule-color:color-mix(in srgb, currentColor, rgba(0, 0, 0, 0.5) 65%);}\n.css-bomvwj{column-rule-color:color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, 0.5) 65%);}\n.css-10mgb0{column-rule-color:color-mix(in lch, teal 65%, olive);}\n.css-64iyg8{column-rule-color:color-mix(in hsl, teal 65%, olive);}\n.css-1dpa2h1{column-rule-color:color-mix(in hwb, teal 65%, olive);}\n.css-8f641x{column-rule-color:color-mix(in xyz, teal 65%, olive);}\n.css-r6gkgb{column-rule-color:color-mix(in lab, teal 65%, olive);}\n.css-161ii5p{color:rgba(0, 0, 0, calc(1));}\n.css-1ikqmml{color:rgba(0, 0, 0, calc(10 - 1));}\n"
  ];
  
  CSS.make("css-1klg0jz", []);
  CSS.make("css-19aau8k", []);
  CSS.make("css-show2y", []);
  CSS.make("css-12w3rs3", []);
  CSS.make("css-682uz0", []);
  CSS.make("css-1wq4akx", []);
  CSS.make("css-thzv76", []);
  CSS.make("css-1aguouh", []);
  CSS.make("css-1o97rsf", []);
  CSS.make("css-p9u22v", []);
  CSS.make("css-12vo0zw", []);
  CSS.make("css-8rxhyp", []);
  CSS.make("css-1rm7u2e", []);
  CSS.make("css-dltmcs", []);
  CSS.make("css-1xkgeh2", []);
  CSS.make("css-d8xfod", []);
  CSS.make("css-ngwiga", []);
  CSS.make("css-o1a70m", []);
  CSS.make("css-4aeh3t", []);
  CSS.make("css-roftna", []);
  CSS.make("css-1hs94su", []);
  CSS.make("css-o5763g", []);
  CSS.make("css-1sjelkb", []);
  CSS.make("css-hy9y29", []);
  CSS.make("css-1j28iw5", []);
  CSS.make("css-1m667jc", []);
  CSS.make("css-1ks6wvt", []);
  CSS.make("css-1spw3fg", []);
  CSS.make("css-1dqtlwt", []);
  CSS.make("css-ey6q4n", []);
  CSS.make("css-1pel08", []);
  CSS.make("css-jyf49a", []);
  CSS.make("css-1hgrow3", []);
  CSS.make("css-1vyru4n", []);
  CSS.make("css-l03e1", []);
  
  CSS.make("css-106elx5", []);
  CSS.make("css-169x4dj", []);
  CSS.make("css-itsf2n", []);
  CSS.make("css-10z9r5f", []);
  CSS.make("css-i8e91", []);
  CSS.make("css-k2ko2n", []);
  CSS.make("css-1jq4wb0", []);
  CSS.make("css-1deabkw", []);
  CSS.make("css-1chilpd", []);
  CSS.make("css-cm2qa9", []);
  CSS.make("css-tnjacv", []);
  CSS.make("css-1nl0tkw", []);
  CSS.make("css-ikl566", []);
  CSS.make("css-1wfylgf", []);
  CSS.make("css-1o5x0fw", []);
  CSS.make("css-1j7dx2f", []);
  
  CSS.make("css-1lzhslh", []);
  CSS.make("css-6ez43m", []);
  CSS.make("css-2v74s8", []);
  CSS.make("css-fqa3ju", []);
  CSS.make("css-1ulf2tb", []);
  CSS.make("css-99atwn", []);
  CSS.make("css-1mk7sx6", []);
  CSS.make("css-1nu3sdc", []);
  CSS.make("css-98qi4x", []);
  CSS.make("css-1f60zw7", []);
  CSS.make("css-1sopvf5", []);
  CSS.make("css-1xjr5yh", []);
  CSS.make("css-ase6sp", []);
  CSS.make("css-131nvgj", []);
  CSS.make("css-1xqbf4a", []);
  CSS.make("css-9ss56r", []);
  CSS.make("css-1k5i3r2", []);
  CSS.make("css-17269e2", []);
  CSS.make("css-1kpl970", []);
  CSS.make("css-scxvdj", []);
  CSS.make("css-2a1dto", []);
  CSS.make("css-tvijrw", []);
  CSS.make("css-1fp9ko3", []);
  CSS.make("css-1qn5w0z", []);
  CSS.make("css-1hr8e0z", []);
  CSS.make("css-3y6gcy", []);
  CSS.make("css-1ymoio", []);
  CSS.make("css-1mjjpk9", []);
  CSS.make("css-8bj0kf", []);
  CSS.make("css-n5b9dq", []);
  CSS.make("css-12wm3pc", []);
  CSS.make("css-1c73fhh", []);
  CSS.make("css-ln3bxw", []);
  CSS.make("css-lkgw6s", []);
  CSS.make("css-14o54z6", []);
  CSS.make("css-80it8b", []);
  CSS.make("css-c8v6ky", []);
  CSS.make("css-pvd63l", []);
  CSS.make("css-14bmep", []);
  CSS.make("css-17xi8yb", []);
  CSS.make("css-kv6m7", []);
  CSS.make("css-135snjr", []);
  CSS.make("css-tm0vqt", []);
  CSS.make("css-1bkqk8j", []);
  CSS.make("css-68bkrk", []);
  CSS.make("css-40xjkw", []);
  CSS.make("css-zlfh32", []);
  CSS.make("css-18j2zim", []);
  CSS.make("css-1oj6vui", []);
  CSS.make("css-4i3dyf", []);
  CSS.make("css-1maqvl6", []);
  CSS.make("css-1wm8yii", []);
  CSS.make("css-11jt9pq", []);
  CSS.make("css-sjwwr9", []);
  CSS.make("css-1k0c8ch", []);
  CSS.make("css-2guu68", []);
  CSS.make("css-514t4f", []);
  CSS.make("css-6yxjvr", []);
  CSS.make("css-gqmwf4", []);
  CSS.make("css-11xt3by", []);
  CSS.make("css-1kkf3h2", []);
  CSS.make("css-19rpsoy", []);
  CSS.make("css-g596r0", []);
  CSS.make("css-107t3it", []);
  
  CSS.make("css-xv7eia", []);
  CSS.make("css-1q9agm7", []);
  CSS.make("css-rzb0m8", []);
  CSS.make("css-6hx6yd", []);
  CSS.make("css-1dr2vpr", []);
  CSS.make("css-i9v2e0", []);
  CSS.make("css-13pap82", []);
  CSS.make("css-s4rji0", []);
  CSS.make("css-1imxr44", []);
  CSS.make("css-bvuxb0", []);
  
  CSS.make("css-vzawmn", []);
  CSS.make("css-1bh658x", []);
  CSS.make("css-xdjnak", []);
  CSS.make("css-z2tmhh", []);
  CSS.make("css-sr14q8", []);
  CSS.make("css-15xujv5", []);
  CSS.make("css-5j5l1n", []);
  CSS.make("css-1layqra", []);
  CSS.make("css-iqo7xf", []);
  
  CSS.make("css-1dvgebh", []);
  CSS.make("css-1cpjoz7", []);
  CSS.make("css-qokah8", []);
  CSS.make("css-tlegxc", []);
  CSS.make("css-xd9u6g", []);
  CSS.make("css-19dtqog", []);
  CSS.make("css-4czslf", []);
  CSS.make("css-7we9z4", []);
  CSS.make("css-15anzfj", []);
  
  CSS.make("css-1laj5fb", []);
  CSS.make("css-2vgokw", []);
  CSS.make("css-nnawx", []);
  CSS.make("css-1w9gyza", []);
  CSS.make("css-10gmjvl", []);
  CSS.make("css-5dhj6n", []);
  CSS.make("css-13of0y0", []);
  CSS.make("css-1qogihm", []);
  CSS.make("css-1huznhc", []);
  
  CSS.make("css-1cbt29u", []);
  CSS.make("css-lh3exx", []);
  CSS.make("css-tznjzz", []);
  CSS.make("css-bomvwj", []);
  CSS.make("css-10mgb0", []);
  CSS.make("css-64iyg8", []);
  CSS.make("css-1dpa2h1", []);
  CSS.make("css-8f641x", []);
  CSS.make("css-r6gkgb", []);
  
  CSS.make("css-161ii5p", []);
  CSS.make("css-1ikqmml", []);
