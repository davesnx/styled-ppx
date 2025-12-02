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
    ".css-ql2niz { color: rgba(0,0,0,.5); }\n.css-utnfw3 { color: #F06; }\n.css-cdr4rr { color: #FF0066; }\n.css-1625616 { color: hsl(0,0%,0%); }\n.css-e652i7 { color: hsl(0,0%,0%,.5); }\n.css-5b16p9 { color: transparent; }\n.css-1t59ukk { color: currentColor; }\n.css-e4rbip { background-color: rgba(0,0,0,.5); }\n.css-1ngwsnx { background-color: #F06; }\n.css-1qp3978 { background-color: #FF0066; }\n.css-13v1x1v { background-color: hsl(0,0%,0%); }\n.css-127ic8u { background-color: hsl(0,0%,0%,.5); }\n.css-11vv77o { background-color: transparent; }\n.css-ez67n7 { background-color: currentColor; }\n.css-s0v1f3 { border-color: rgba(0,0,0,.5); }\n.css-16xu4mu { border-color: #F06; }\n.css-1gomodd { border-color: #FF0066; }\n.css-5fcwbb { border-color: hsl(0,0%,0%); }\n.css-9f15hz { border-color: hsl(0,0%,0%,.5); }\n.css-654qgu { border-color: transparent; }\n.css-b759ij { border-color: currentColor; }\n.css-eso1v5 { text-decoration-color: rgba(0,0,0,.5); }\n.css-s4ivm7 { text-decoration-color: #F06; }\n.css-1u4sqdq { text-decoration-color: #FF0066; }\n.css-kt4y8s { text-decoration-color: hsl(0,0%,0%); }\n.css-10t4cgt { text-decoration-color: hsl(0,0%,0%,.5); }\n.css-nkdopd { text-decoration-color: transparent; }\n.css-1paaitm { text-decoration-color: currentColor; }\n.css-1xrz5mm { column-rule-color: rgba(0,0,0,.5); }\n.css-bz9u07 { column-rule-color: #F06; }\n.css-1gbepq5 { column-rule-color: #FF0066; }\n.css-18jso63 { column-rule-color: hsl(0,0%,0%); }\n.css-1hea7mv { column-rule-color: hsl(0,0%,0%,.5); }\n.css-guw7qj { column-rule-color: transparent; }\n.css-r5eyr4 { column-rule-color: currentColor; }\n.css-1yllp8e { color: rgb(0% 20% 70%); }\n.css-1523x3b { color: rgb(0 64 185); }\n.css-lq7x1f { color: hsl(0 0% 0%); }\n.css-1aud4w0 { color: rgba(0% 20% 70% / 50%); }\n.css-1i0u3y4 { color: rgba(0% 20% 70% / .5); }\n.css-mzpcr9 { color: rgba(0 64 185 / 50%); }\n.css-1bdye09 { color: rgba(0 64 185 / .5); }\n.css-1evftag { color: hsla(0 0% 0% /.5); }\n.css-a1ic6v { color: rgb(0% 20% 70% / 50%); }\n.css-17pcpbz { color: rgb(0% 20% 70% / .5); }\n.css-62ufu8 { color: rgb(0 64 185 / 50%); }\n.css-1wbvqab { color: rgb(0 64 185 / .5); }\n.css-jj81fb { color: hsl(0 0% 0% / .5); }\n.css-1dfweq4 { color: #000F; }\n.css-1w23mct { color: #000000FF; }\n.css-l7wj9y { color: rebeccapurple; }\n.css-1k4ut6r { background-color: rgb(0% 20% 70%); }\n.css-1n219nk { background-color: rgb(0 64 185); }\n.css-1f4oe9r { background-color: hsl(0 0% 0%); }\n.css-jipirn { background-color: rgba(0% 20% 70% / 50%); }\n.css-8uej7o { background-color: rgba(0% 20% 70% / .5); }\n.css-wvwccg { background-color: rgba(0 64 185 / 50%); }\n.css-k2cn04 { background-color: rgba(0 64 185 / .5); }\n.css-1c4zsx { background-color: hsla(0 0% 0% /.5); }\n.css-1xhve2g { background-color: rgb(0% 20% 70% / 50%); }\n.css-olwe03 { background-color: rgb(0% 20% 70% / .5); }\n.css-a9452z { background-color: rgb(0 64 185 / 50%); }\n.css-19pn84c { background-color: rgb(0 64 185 / .5); }\n.css-ds7ppm { background-color: hsl(0 0% 0% / .5); }\n.css-5spd3j { background-color: #000F; }\n.css-cs0207 { background-color: #000000FF; }\n.css-6isffr { background-color: rebeccapurple; }\n.css-k3pfz2 { border-color: rgb(0% 20% 70%); }\n.css-1245yjz { border-color: rgb(0 64 185); }\n.css-lgmn07 { border-color: hsl(0 0% 0%); }\n.css-126c19m { border-color: rgba(0% 20% 70% / 50%); }\n.css-uwxb2v { border-color: rgba(0% 20% 70% / .5); }\n.css-1yr8elz { border-color: rgba(0 64 185 / 50%); }\n.css-1nvtl7m { border-color: rgba(0 64 185 / .5); }\n.css-ue19i { border-color: hsla(0 0% 0% /.5); }\n.css-7k2pr3 { border-color: rgb(0% 20% 70% / 50%); }\n.css-1h5co9q { border-color: rgb(0% 20% 70% / .5); }\n.css-dg91l3 { border-color: rgb(0 64 185 / 50%); }\n.css-uy06my { border-color: rgb(0 64 185 / .5); }\n.css-wx1hrx { border-color: hsl(0 0% 0% / .5); }\n.css-19gcb9v { border-color: #000F; }\n.css-1sul042 { border-color: #000000FF; }\n.css-1sif66 { border-color: rebeccapurple; }\n.css-28779c { text-decoration-color: rgb(0% 20% 70%); }\n.css-1it9vgy { text-decoration-color: rgb(0 64 185); }\n.css-1l24j16 { text-decoration-color: hsl(0 0% 0%); }\n.css-15y2e16 { text-decoration-color: rgba(0% 20% 70% / 50%); }\n.css-u7tzh9 { text-decoration-color: rgba(0% 20% 70% / .5); }\n.css-me0drx { text-decoration-color: rgba(0 64 185 / 50%); }\n.css-1psjio9 { text-decoration-color: rgba(0 64 185 / .5); }\n.css-1smwuej { text-decoration-color: hsla(0 0% 0% /.5); }\n.css-1oisd7h { text-decoration-color: rgb(0% 20% 70% / 50%); }\n.css-1qmhi8v { text-decoration-color: rgb(0% 20% 70% / .5); }\n.css-fg78i5 { text-decoration-color: rgb(0 64 185 / 50%); }\n.css-1dugwzp { text-decoration-color: rgb(0 64 185 / .5); }\n.css-1du5rng { text-decoration-color: hsl(0 0% 0% / .5); }\n.css-1ey7v7l { text-decoration-color: #000F; }\n.css-11g7iss { text-decoration-color: #000000FF; }\n.css-vsq0mg { text-decoration-color: rebeccapurple; }\n.css-10j23dq { column-rule-color: rgb(0% 20% 70%); }\n.css-156j5jj { column-rule-color: rgb(0 64 185); }\n.css-irl04j { column-rule-color: hsl(0 0% 0%); }\n.css-y3icls { column-rule-color: rgba(0% 20% 70% / 50%); }\n.css-etgjea { column-rule-color: rgba(0% 20% 70% / .5); }\n.css-5yd8e0 { column-rule-color: rgba(0 64 185 / 50%); }\n.css-ieoxcx { column-rule-color: rgba(0 64 185 / .5); }\n.css-poc40h { column-rule-color: hsla(0 0% 0% /.5); }\n.css-j0x582 { column-rule-color: rgb(0% 20% 70% / 50%); }\n.css-9xa6fm { column-rule-color: rgb(0% 20% 70% / .5); }\n.css-14pcnun { column-rule-color: rgb(0 64 185 / 50%); }\n.css-57nppq { column-rule-color: rgb(0 64 185 / .5); }\n.css-lz77po { column-rule-color: hsl(0 0% 0% / .5); }\n.css-1hqtiad { column-rule-color: #000F; }\n.css-1ybapkb { column-rule-color: #000000FF; }\n.css-uob8s6 { column-rule-color: rebeccapurple; }\n.css-29a6d0 { color: color-mix(in srgb, teal 65%, olive); }\n.css-1iv6j5o { color: color-mix(in srgb, rgb(255, 0, 0, .2) 65%, olive); }\n.css-58pop { color: color-mix(in srgb, currentColor, rgba(0, 0, 0, .5) 65%); }\n.css-lbd9kd { color: color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, .5) 65%); }\n.css-1jndwef { color: color-mix(in lch, teal 65%, olive); }\n.css-12oiwfd { color: color-mix(in hsl, teal 65%, olive); }\n.css-1h8kb81 { color: color-mix(in hwb, teal 65%, olive); }\n.css-hsyd2p { color: color-mix(in xyz, teal 65%, olive); }\n.css-301dw5 { color: color-mix(in lab, teal 65%, olive); }\n.css-3g68ko { color: color-mix(in lch longer hue, hsl(200deg 50% 80%), coral); }\n.css-gnyy57 { background-color: color-mix(in srgb, teal 65%, olive); }\n.css-1faafar { background-color: color-mix(in srgb, rgb(255, 0, 0, .2) 65%, olive); }\n.css-111m74t { background-color: color-mix(in srgb, currentColor, rgba(0, 0, 0, .5) 65%); }\n.css-1y7tp93 { background-color: color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, .5) 65%); }\n.css-d3s69x { background-color: color-mix(in lch, teal 65%, olive); }\n.css-16nt6nf { background-color: color-mix(in hsl, teal 65%, olive); }\n.css-rt1zg5 { background-color: color-mix(in hwb, teal 65%, olive); }\n.css-h8hkcd { background-color: color-mix(in xyz, teal 65%, olive); }\n.css-j95pc7 { background-color: color-mix(in lab, teal 65%, olive); }\n.css-qi82mi { border-color: color-mix(in srgb, teal 65%, olive); }\n.css-14xmozk { border-color: color-mix(in srgb, rgb(255, 0, 0, .2) 65%, olive); }\n.css-vfpkkz { border-color: color-mix(in srgb, currentColor, rgba(0, 0, 0, .5) 65%); }\n.css-1xt4dso { border-color: color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, .5) 65%); }\n.css-eyk11a { border-color: color-mix(in lch, teal 65%, olive); }\n.css-fw815v { border-color: color-mix(in hsl, teal 65%, olive); }\n.css-19sdk9i { border-color: color-mix(in hwb, teal 65%, olive); }\n.css-1n13433 { border-color: color-mix(in xyz, teal 65%, olive); }\n.css-4jp4kk { border-color: color-mix(in lab, teal 65%, olive); }\n.css-bx1piy { text-decoration-color: color-mix(in srgb, teal 65%, olive); }\n.css-z6jj2j { text-decoration-color: color-mix(in srgb, rgb(255, 0, 0, .2) 65%, olive); }\n.css-zafnqd { text-decoration-color: color-mix(in srgb, currentColor, rgba(0, 0, 0, .5) 65%); }\n.css-1j4hlq9 { text-decoration-color: color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, .5) 65%); }\n.css-a6m834 { text-decoration-color: color-mix(in lch, teal 65%, olive); }\n.css-ifjf1r { text-decoration-color: color-mix(in hsl, teal 65%, olive); }\n.css-6nva22 { text-decoration-color: color-mix(in hwb, teal 65%, olive); }\n.css-rssttz { text-decoration-color: color-mix(in xyz, teal 65%, olive); }\n.css-1qo34u0 { text-decoration-color: color-mix(in lab, teal 65%, olive); }\n.css-roomxe { column-rule-color: color-mix(in srgb, teal 65%, olive); }\n.css-159wd0r { column-rule-color: color-mix(in srgb, rgb(255, 0, 0, .2) 65%, olive); }\n.css-1f8yf2j { column-rule-color: color-mix(in srgb, currentColor, rgba(0, 0, 0, .5) 65%); }\n.css-1j75v9l { column-rule-color: color-mix(in srgb, currentColor 10%, rgba(0, 0, 0, .5) 65%); }\n.css-1swnb6g { column-rule-color: color-mix(in lch, teal 65%, olive); }\n.css-1f919q3 { column-rule-color: color-mix(in hsl, teal 65%, olive); }\n.css-yq4jpi { column-rule-color: color-mix(in hwb, teal 65%, olive); }\n.css-1j7l4il { column-rule-color: color-mix(in xyz, teal 65%, olive); }\n.css-1cm25f6 { column-rule-color: color-mix(in lab, teal 65%, olive); }\n.css-13hsm9f { color: rgba(0, 0, 0, calc(1)); }\n.css-8sa8u7 { color: rgba(0, 0, 0, calc(10 - 1)); }\n"
  ];
  CSS.make("css-ql2niz", []);
  CSS.make("css-utnfw3", []);
  CSS.make("css-cdr4rr", []);
  CSS.make("css-1625616", []);
  CSS.make("css-e652i7", []);
  CSS.make("css-5b16p9", []);
  CSS.make("css-1t59ukk", []);
  CSS.make("css-e4rbip", []);
  CSS.make("css-1ngwsnx", []);
  CSS.make("css-1qp3978", []);
  CSS.make("css-13v1x1v", []);
  CSS.make("css-127ic8u", []);
  CSS.make("css-11vv77o", []);
  CSS.make("css-ez67n7", []);
  CSS.make("css-s0v1f3", []);
  CSS.make("css-16xu4mu", []);
  CSS.make("css-1gomodd", []);
  CSS.make("css-5fcwbb", []);
  CSS.make("css-9f15hz", []);
  CSS.make("css-654qgu", []);
  CSS.make("css-b759ij", []);
  CSS.make("css-eso1v5", []);
  CSS.make("css-s4ivm7", []);
  CSS.make("css-1u4sqdq", []);
  CSS.make("css-kt4y8s", []);
  CSS.make("css-10t4cgt", []);
  CSS.make("css-nkdopd", []);
  CSS.make("css-1paaitm", []);
  CSS.make("css-1xrz5mm", []);
  CSS.make("css-bz9u07", []);
  CSS.make("css-1gbepq5", []);
  CSS.make("css-18jso63", []);
  CSS.make("css-1hea7mv", []);
  CSS.make("css-guw7qj", []);
  CSS.make("css-r5eyr4", []);
  
  CSS.make("css-1yllp8e", []);
  CSS.make("css-1523x3b", []);
  CSS.make("css-lq7x1f", []);
  CSS.make("css-1aud4w0", []);
  CSS.make("css-1i0u3y4", []);
  CSS.make("css-mzpcr9", []);
  CSS.make("css-1bdye09", []);
  CSS.make("css-1evftag", []);
  CSS.make("css-a1ic6v", []);
  CSS.make("css-17pcpbz", []);
  CSS.make("css-62ufu8", []);
  CSS.make("css-1wbvqab", []);
  CSS.make("css-jj81fb", []);
  CSS.make("css-1dfweq4", []);
  CSS.make("css-1w23mct", []);
  CSS.make("css-l7wj9y", []);
  
  CSS.make("css-1k4ut6r", []);
  CSS.make("css-1n219nk", []);
  CSS.make("css-1f4oe9r", []);
  CSS.make("css-jipirn", []);
  CSS.make("css-8uej7o", []);
  CSS.make("css-wvwccg", []);
  CSS.make("css-k2cn04", []);
  CSS.make("css-1c4zsx", []);
  CSS.make("css-1xhve2g", []);
  CSS.make("css-olwe03", []);
  CSS.make("css-a9452z", []);
  CSS.make("css-19pn84c", []);
  CSS.make("css-ds7ppm", []);
  CSS.make("css-5spd3j", []);
  CSS.make("css-cs0207", []);
  CSS.make("css-6isffr", []);
  CSS.make("css-k3pfz2", []);
  CSS.make("css-1245yjz", []);
  CSS.make("css-lgmn07", []);
  CSS.make("css-126c19m", []);
  CSS.make("css-uwxb2v", []);
  CSS.make("css-1yr8elz", []);
  CSS.make("css-1nvtl7m", []);
  CSS.make("css-ue19i", []);
  CSS.make("css-7k2pr3", []);
  CSS.make("css-1h5co9q", []);
  CSS.make("css-dg91l3", []);
  CSS.make("css-uy06my", []);
  CSS.make("css-wx1hrx", []);
  CSS.make("css-19gcb9v", []);
  CSS.make("css-1sul042", []);
  CSS.make("css-1sif66", []);
  CSS.make("css-28779c", []);
  CSS.make("css-1it9vgy", []);
  CSS.make("css-1l24j16", []);
  CSS.make("css-15y2e16", []);
  CSS.make("css-u7tzh9", []);
  CSS.make("css-me0drx", []);
  CSS.make("css-1psjio9", []);
  CSS.make("css-1smwuej", []);
  CSS.make("css-1oisd7h", []);
  CSS.make("css-1qmhi8v", []);
  CSS.make("css-fg78i5", []);
  CSS.make("css-1dugwzp", []);
  CSS.make("css-1du5rng", []);
  CSS.make("css-1ey7v7l", []);
  CSS.make("css-11g7iss", []);
  CSS.make("css-vsq0mg", []);
  CSS.make("css-10j23dq", []);
  CSS.make("css-156j5jj", []);
  CSS.make("css-irl04j", []);
  CSS.make("css-y3icls", []);
  CSS.make("css-etgjea", []);
  CSS.make("css-5yd8e0", []);
  CSS.make("css-ieoxcx", []);
  CSS.make("css-poc40h", []);
  CSS.make("css-j0x582", []);
  CSS.make("css-9xa6fm", []);
  CSS.make("css-14pcnun", []);
  CSS.make("css-57nppq", []);
  CSS.make("css-lz77po", []);
  CSS.make("css-1hqtiad", []);
  CSS.make("css-1ybapkb", []);
  CSS.make("css-uob8s6", []);
  
  CSS.make("css-29a6d0", []);
  CSS.make("css-1iv6j5o", []);
  CSS.make("css-58pop", []);
  CSS.make("css-lbd9kd", []);
  CSS.make("css-1jndwef", []);
  CSS.make("css-12oiwfd", []);
  CSS.make("css-1h8kb81", []);
  CSS.make("css-hsyd2p", []);
  CSS.make("css-301dw5", []);
  CSS.make("css-3g68ko", []);
  
  CSS.make("css-gnyy57", []);
  CSS.make("css-1faafar", []);
  CSS.make("css-111m74t", []);
  CSS.make("css-1y7tp93", []);
  CSS.make("css-d3s69x", []);
  CSS.make("css-16nt6nf", []);
  CSS.make("css-rt1zg5", []);
  CSS.make("css-h8hkcd", []);
  CSS.make("css-j95pc7", []);
  
  CSS.make("css-qi82mi", []);
  CSS.make("css-14xmozk", []);
  CSS.make("css-vfpkkz", []);
  CSS.make("css-1xt4dso", []);
  CSS.make("css-eyk11a", []);
  CSS.make("css-fw815v", []);
  CSS.make("css-19sdk9i", []);
  CSS.make("css-1n13433", []);
  CSS.make("css-4jp4kk", []);
  
  CSS.make("css-bx1piy", []);
  CSS.make("css-z6jj2j", []);
  CSS.make("css-zafnqd", []);
  CSS.make("css-1j4hlq9", []);
  CSS.make("css-a6m834", []);
  CSS.make("css-ifjf1r", []);
  CSS.make("css-6nva22", []);
  CSS.make("css-rssttz", []);
  CSS.make("css-1qo34u0", []);
  
  CSS.make("css-roomxe", []);
  CSS.make("css-159wd0r", []);
  CSS.make("css-1f8yf2j", []);
  CSS.make("css-1j75v9l", []);
  CSS.make("css-1swnb6g", []);
  CSS.make("css-1f919q3", []);
  CSS.make("css-yq4jpi", []);
  CSS.make("css-1j7l4il", []);
  CSS.make("css-1cm25f6", []);
  
  CSS.make("css-13hsm9f", []);
  CSS.make("css-8sa8u7", []);
