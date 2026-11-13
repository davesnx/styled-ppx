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
  [@css "@property --7qykh1-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --7qykh1-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --7qykh1-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --6iz2nt-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --6iz2nt-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --6iz2nt-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --1trhfce-0{syntax:\"*\";inherits:false;}"];
  [@css "@property --1trhfce-1{syntax:\"*\";inherits:false;}"];
  [@css "@property --1trhfce-2{syntax:\"*\";inherits:false;}"];
  [@css "@property --1trhfce-3{syntax:\"*\";inherits:false;}"];
  [@css "@property --1lkw9pk-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-103mvew{background-repeat:space;}"];
  [@css ".css-xq8w5y{background-repeat:round;}"];
  [@css ".css-a8csmt{background-repeat:repeat repeat;}"];
  [@css ".css-1ft3ceg{background-repeat:space repeat;}"];
  [@css ".css-13s9mza{background-repeat:round repeat;}"];
  [@css ".css-y1m0mj{background-repeat:no-repeat repeat;}"];
  [@css ".css-356iko{background-repeat:repeat space;}"];
  [@css ".css-1e6f2ns{background-repeat:space space;}"];
  [@css ".css-ykb3dw{background-repeat:round space;}"];
  [@css ".css-8dk25r{background-repeat:no-repeat space;}"];
  [@css ".css-1f33szp{background-repeat:repeat round;}"];
  [@css ".css-1m4h9fx{background-repeat:space round;}"];
  [@css ".css-1i6ivx1{background-repeat:round round;}"];
  [@css ".css-12xldm6{background-repeat:no-repeat round;}"];
  [@css ".css-1l8csu3{background-repeat:repeat no-repeat;}"];
  [@css ".css-inlcvs{background-repeat:space no-repeat;}"];
  [@css ".css-tacf43{background-repeat:round no-repeat;}"];
  [@css ".css-1q8jpyj{background-repeat:no-repeat no-repeat;}"];
  [@css ".css-1vmv5td{background-repeat:repeat-x, repeat-y;}"];
  [@css ".css-mk96da{background-attachment:local;}"];
  [@css
    ".css-w9t7qy{-webkit-background-clip:border-box;background-clip:border-box;}"
  ];
  [@css
    ".css-d4d5v4{-webkit-background-clip:padding-box;background-clip:padding-box;}"
  ];
  [@css
    ".css-319xak{-webkit-background-clip:content-box;background-clip:content-box;}"
  ];
  [@css ".css-18qd4rc{-webkit-background-clip:text;background-clip:text;}"];
  [@css
    ".css-lmswcu{-webkit-background-clip:border-area;background-clip:border-area;}"
  ];
  [@css
    ".css-iva9kw{-webkit-background-clip:text, border-area;background-clip:text, border-area;}"
  ];
  [@css ".css-1955q8t{background-origin:border-box;}"];
  [@css ".css-1735cty{background-origin:padding-box;}"];
  [@css ".css-gh1jfl{background-origin:content-box;}"];
  [@css ".css-2e7ho5{background-size:auto;}"];
  [@css ".css-1fziq7w{background-size:cover;}"];
  [@css ".css-5ys43f{background-size:contain;}"];
  [@css ".css-mtm3ik{background-size:10px;}"];
  [@css ".css-1oz6l0x{background-size:50%;}"];
  [@css ".css-njy7h0{background-size:10px auto;}"];
  [@css ".css-1xdvc9f{background-size:auto 10%;}"];
  [@css ".css-dqcrpw{background-size:50em 50%;}"];
  [@css ".css-1kxndhy{background-size:20px 20px;}"];
  [@css ".css-15eijwr{background:top left / 50% 60%;}"];
  [@css ".css-11sx168{background:border-box;}"];
  [@css ".css-v3oj3g{background:blue;}"];
  [@css ".css-1c0cimw{background:border-box red;}"];
  [@css ".css-fa4hwu{background:border-box padding-box;}"];
  [@css
    ".css-jbalz8{background:url(\"foo.png\") bottom right / cover padding-box content-box;}"
  ];
  [@css ".css-1g5dnum{border-top-left-radius:0;}"];
  [@css ".css-xu86rl{border-top-left-radius:50%;}"];
  [@css ".css-103r34l{border-top-left-radius:250px 100px;}"];
  [@css ".css-1qsff6w{border-top-right-radius:0;}"];
  [@css ".css-emwrvm{border-top-right-radius:50%;}"];
  [@css ".css-wbvsgh{border-top-right-radius:250px 100px;}"];
  [@css ".css-18z3qas{border-bottom-right-radius:0;}"];
  [@css ".css-og60n1{border-bottom-right-radius:50%;}"];
  [@css ".css-1i7csmg{border-bottom-right-radius:250px 100px;}"];
  [@css ".css-ywfkvp{border-bottom-left-radius:0;}"];
  [@css ".css-e4k9mp{border-bottom-left-radius:50%;}"];
  [@css ".css-8sv32j{border-bottom-left-radius:250px 100px;}"];
  [@css ".css-40qzjv{border-radius:10px;}"];
  [@css ".css-1n730d{border-radius:50%;}"];
  [@css ".css-gxx2v1{border-radius:2px 4px;}"];
  [@css ".css-ax8pa{border-radius:2px 4px 8px;}"];
  [@css ".css-1ylo8t6{border-radius:2px 4px 8px 16px;}"];
  [@css ".css-fzy6zr{border-radius:10px / 20px;}"];
  [@css ".css-10sjm2i{border-radius:2px 4px 8px 16px / 2px 4px 8px 16px;}"];
  [@css ".css-ftxfzm{border-image-source:none;}"];
  [@css ".css-scxyes{border-image-source:url(\"foo.png\");}"];
  [@css ".css-13emjar{border-image-slice:10;}"];
  [@css ".css-13tsz8b{border-image-slice:30%;}"];
  [@css ".css-17q9bou{border-image-slice:10 10;}"];
  [@css ".css-7g43ah{border-image-slice:30% 10;}"];
  [@css ".css-1jlmlqd{border-image-slice:10 30%;}"];
  [@css ".css-ourmh3{border-image-slice:30% 30%;}"];
  [@css ".css-11wghsw{border-image-slice:10 10 10;}"];
  [@css ".css-f7nplj{border-image-slice:30% 10 10;}"];
  [@css ".css-1frbr9{border-image-slice:10 30% 10;}"];
  [@css ".css-1ht1ecp{border-image-slice:30% 30% 10;}"];
  [@css ".css-ouz6pb{border-image-slice:10 10 30%;}"];
  [@css ".css-mlh688{border-image-slice:30% 10 30%;}"];
  [@css ".css-f4r3ac{border-image-slice:10 30% 30%;}"];
  [@css ".css-kdait5{border-image-slice:30% 30% 30%;}"];
  [@css ".css-qp9a49{border-image-slice:10 10 10 10;}"];
  [@css ".css-177ic64{border-image-slice:30% 10 10 10;}"];
  [@css ".css-t9fzva{border-image-slice:10 30% 10 10;}"];
  [@css ".css-1dqq7r{border-image-slice:30% 30% 10 10;}"];
  [@css ".css-5b0nke{border-image-slice:10 10 30% 10;}"];
  [@css ".css-y051fa{border-image-slice:30% 10 30% 10;}"];
  [@css ".css-1eemv5b{border-image-slice:10 30% 30% 10;}"];
  [@css ".css-p6olr5{border-image-slice:30% 30% 30% 10;}"];
  [@css ".css-17puc21{border-image-slice:10 10 10 30%;}"];
  [@css ".css-nwcrwu{border-image-slice:30% 10 10 30%;}"];
  [@css ".css-f7xold{border-image-slice:10 30% 10 30%;}"];
  [@css ".css-aj8wnx{border-image-slice:30% 30% 10 30%;}"];
  [@css ".css-9tgmqr{border-image-slice:10 10 30% 30%;}"];
  [@css ".css-1gr4grh{border-image-slice:30% 10 30% 30%;}"];
  [@css ".css-twuj83{border-image-slice:10 30% 30% 30%;}"];
  [@css ".css-1dvuten{border-image-slice:30% 30% 30% 30%;}"];
  [@css ".css-1oyqkh6{border-image-slice:fill 30%;}"];
  [@css ".css-mnydl{border-image-slice:fill 10;}"];
  [@css ".css-1lchk48{border-image-slice:fill 2 4 8% 16%;}"];
  [@css ".css-clwsl6{border-image-slice:30% fill;}"];
  [@css ".css-9r5a4q{border-image-slice:10 fill;}"];
  [@css ".css-p1bkg5{border-image-slice:2 4 8% 16% fill;}"];
  [@css ".css-1l8ypdn{border-image-width:10px;}"];
  [@css ".css-17bobs3{border-image-width:5%;}"];
  [@css ".css-acq0zc{border-image-width:28;}"];
  [@css ".css-h2hz84{border-image-width:auto;}"];
  [@css ".css-15de49o{border-image-width:10px 10px;}"];
  [@css ".css-1lilqof{border-image-width:5% 10px;}"];
  [@css ".css-1ltcfbh{border-image-width:28 10px;}"];
  [@css ".css-17tdo8v{border-image-width:auto 10px;}"];
  [@css ".css-7p39j4{border-image-width:10px 5%;}"];
  [@css ".css-1eilh45{border-image-width:5% 5%;}"];
  [@css ".css-1nxq0c1{border-image-width:28 5%;}"];
  [@css ".css-545uaa{border-image-width:auto 5%;}"];
  [@css ".css-phh0yl{border-image-width:10px 28;}"];
  [@css ".css-1po25tk{border-image-width:5% 28;}"];
  [@css ".css-1ph07m5{border-image-width:28 28;}"];
  [@css ".css-1xbk2my{border-image-width:auto 28;}"];
  [@css ".css-oc9lja{border-image-width:10px auto;}"];
  [@css ".css-r4ci8i{border-image-width:5% auto;}"];
  [@css ".css-dv34y9{border-image-width:28 auto;}"];
  [@css ".css-1ukoqje{border-image-width:auto auto;}"];
  [@css ".css-wimxrn{border-image-width:10px 10% 10;}"];
  [@css ".css-fz48md{border-image-width:5% 10px 20 auto;}"];
  [@css ".css-1sshf0p{border-image-outset:10px;}"];
  [@css ".css-10ch5sk{border-image-outset:20;}"];
  [@css ".css-1eff4d8{border-image-outset:10px 20;}"];
  [@css ".css-1ptw524{border-image-outset:10px 20px;}"];
  [@css ".css-1n7lioy{border-image-outset:20 30;}"];
  [@css ".css-bvl5g5{border-image-outset:2px 3px 4;}"];
  [@css ".css-1xlwx1t{border-image-outset:1 2px 3px 4;}"];
  [@css ".css-5mxerm{border-image-repeat:stretch;}"];
  [@css ".css-1ewgy3{border-image-repeat:repeat;}"];
  [@css ".css-ewiodi{border-image-repeat:round;}"];
  [@css ".css-3sig0u{border-image-repeat:space;}"];
  [@css ".css-7zhnny{border-image-repeat:stretch stretch;}"];
  [@css ".css-1cwpvkb{border-image-repeat:repeat stretch;}"];
  [@css ".css-uhd3vw{border-image-repeat:round stretch;}"];
  [@css ".css-1lbiewk{border-image-repeat:space stretch;}"];
  [@css ".css-1c3s2ov{border-image-repeat:stretch repeat;}"];
  [@css ".css-quauhi{border-image-repeat:repeat repeat;}"];
  [@css ".css-3uvk7i{border-image-repeat:round repeat;}"];
  [@css ".css-1gcqwuo{border-image-repeat:space repeat;}"];
  [@css ".css-debglq{border-image-repeat:stretch round;}"];
  [@css ".css-j73fcw{border-image-repeat:repeat round;}"];
  [@css ".css-o84mxx{border-image-repeat:round round;}"];
  [@css ".css-14dlwip{border-image-repeat:space round;}"];
  [@css ".css-u7gdi4{border-image-repeat:stretch space;}"];
  [@css ".css-q24mrn{border-image-repeat:repeat space;}"];
  [@css ".css-14ve9wq{border-image-repeat:round space;}"];
  [@css ".css-1qbk5e7{border-image-repeat:space space;}"];
  [@css ".css-btbydd{border-image:url(\"foo.png\") 10;}"];
  [@css ".css-10qvvi3{border-image:url(\"foo.png\") 10%;}"];
  [@css ".css-tsgxq8{border-image:url(\"foo.png\") 10% fill;}"];
  [@css ".css-1cfidqq{border-image:url(\"foo.png\") 10 round;}"];
  [@css ".css-8hpk1f{border-image:url(\"foo.png\") 10 stretch repeat;}"];
  [@css ".css-1npdm6x{border-image:url(\"foo.png\") 10 / 10px;}"];
  [@css ".css-1789fd4{border-image:url(\"foo.png\") 10 / 10% / 10px;}"];
  [@css ".css-1typqvp{border-image:url(\"foo.png\") fill 10 / 10% / 10px;}"];
  [@css
    ".css-4jyr4e{border-image:url(\"foo.png\") fill 10 / 10% / 10px space;}"
  ];
  [@css ".css-hlv71f{box-shadow:none;}"];
  [@css ".css-1rrnq58{box-shadow:1px 1px;}"];
  [@css ".css-y14zh2{box-shadow:0 0 black;}"];
  [@css ".css-1j044lg{box-shadow:1px 2px 3px;}"];
  [@css ".css-z40wto{box-shadow:1px 2px 3px black;}"];
  [@css ".css-1byhv8c{box-shadow:1px 2px 3px 4px;}"];
  [@css ".css-jsboxm{box-shadow:1px 2px 3px 4px black;}"];
  [@css ".css-jp6frm{box-shadow:inset 1px 1px;}"];
  [@css ".css-1dws61{box-shadow:inset 0 0 black;}"];
  [@css ".css-k4794k{box-shadow:inset 1px 2px 3px;}"];
  [@css ".css-4kiwvw{box-shadow:inset 1px 2px 3px black;}"];
  [@css ".css-38l82s{box-shadow:inset 1px 2px 3px 4px;}"];
  [@css ".css-h247gf{box-shadow:inset 1px 2px 3px 4px black;}"];
  [@css
    ".css-14g5y3c{box-shadow:inset 1px 2px 3px 4px black, 1px 2px 3px 4px black;}"
  ];
  [@css ".css-hb8rq5{box-shadow:1px 1px, inset 2px 2px red;}"];
  [@css ".css-2hpm2z{box-shadow:0 0 5px, inset 0 0 10px black;}"];
  [@css
    ".css-7qykh1{box-shadow:-1px 1px 0px 0px var(--7qykh1-0), 1px 1px 0px 0px var(--7qykh1-1), 0px -1px 0px 0px var(--7qykh1-2);}"
  ];
  [@css ".css-ov7g6w{background-position-x:right;}"];
  [@css ".css-12efer5{background-position-x:center;}"];
  [@css ".css-1fw0v0y{background-position-x:50%;}"];
  [@css ".css-1cr2uy5{background-position-x:left, left;}"];
  [@css ".css-1pwf16c{background-position-x:left, right;}"];
  [@css ".css-yvhrhp{background-position-x:right, left;}"];
  [@css ".css-1mdqd54{background-position-x:left, 0%;}"];
  [@css ".css-iskajy{background-position-x:10%, 20%, 40%;}"];
  [@css ".css-er08c7{background-position-x:0px;}"];
  [@css ".css-1ywetyb{background-position-x:30px;}"];
  [@css ".css-10x1y29{background-position-x:0%, 10%, 20%, 30%;}"];
  [@css ".css-6a7hma{background-position-x:left, left, left, left, left;}"];
  [@css ".css-66ffzk{background-position-x:calc(20px);}"];
  [@css ".css-1e8lt9w{background-position-x:calc(20px + 1em);}"];
  [@css ".css-az2km0{background-position-x:calc(20px / 2);}"];
  [@css ".css-qvfsxl{background-position-x:calc(20px + 50%);}"];
  [@css ".css-cpp5ws{background-position-x:calc(50% - 10px);}"];
  [@css ".css-5x9kb3{background-position-x:calc(-20px);}"];
  [@css ".css-1s267z1{background-position-x:calc(-50%);}"];
  [@css ".css-1m7uyso{background-position-x:calc(-20%);}"];
  [@css ".css-ehls39{background-position-x:right 20px;}"];
  [@css ".css-wn8mc6{background-position-x:left 20px;}"];
  [@css ".css-l3mlhe{background-position-x:right -50px;}"];
  [@css ".css-1wrzpq{background-position-x:left -50px;}"];
  [@css ".css-jhjivl{background-position-y:bottom;}"];
  [@css ".css-mrdnn4{background-position-y:center;}"];
  [@css ".css-mpnuqy{background-position-y:50%;}"];
  [@css ".css-1kmhgic{background-position-y:top, top;}"];
  [@css ".css-o7lusv{background-position-y:top, bottom;}"];
  [@css ".css-1ha1y0h{background-position-y:bottom, top;}"];
  [@css ".css-g9dh78{background-position-y:top, 0%;}"];
  [@css ".css-2xgdy5{background-position-y:10%, 20%, 40%;}"];
  [@css ".css-1nfogqu{background-position-y:0px;}"];
  [@css ".css-jqjxhl{background-position-y:30px;}"];
  [@css ".css-18ym6xi{background-position-y:0%, 10%, 20%, 30%;}"];
  [@css ".css-1w9lik3{background-position-y:top, top, top, top, top;}"];
  [@css ".css-1pkz6jk{background-position-y:calc(20px);}"];
  [@css ".css-1rtkyja{background-position-y:calc(20px + 1em);}"];
  [@css ".css-rbgg2w{background-position-y:calc(20px / 2);}"];
  [@css ".css-yxw0x2{background-position-y:calc(20px + 50%);}"];
  [@css ".css-pom5pn{background-position-y:calc(50% - 10px);}"];
  [@css ".css-3gelvz{background-position-y:calc(-20px);}"];
  [@css ".css-we2i90{background-position-y:calc(-50%);}"];
  [@css ".css-1xsx6lh{background-position-y:calc(-20%);}"];
  [@css ".css-1683xoj{background-position-y:bottom 20px;}"];
  [@css ".css-1raqrjk{background-position-y:top 20px;}"];
  [@css ".css-1f4dura{background-position-y:bottom -50px;}"];
  [@css ".css-1dvtt90{background-position-y:top -50px;}"];
  [@css ".css-1n8qvjg{background-image:linear-gradient(45deg, blue, red);}"];
  [@css
    ".css-1bom7la{background-image:linear-gradient(90deg, blue 10%, red 20%);}"
  ];
  [@css ".css-i4o14z{background-image:linear-gradient(90deg, blue 10%, red);}"];
  [@css ".css-d4iszc{background-image:linear-gradient(90deg, blue, 10%, red);}"];
  [@css ".css-1jr5xxu{background-image:linear-gradient(white, black);}"];
  [@css
    ".css-1u2z2py{background-image:linear-gradient(to right, white, black);}"
  ];
  [@css ".css-195a0ta{background-image:linear-gradient(45deg, white, black);}"];
  [@css ".css-1r2wspy{background-image:linear-gradient(white 50%, black);}"];
  [@css ".css-18vd8h6{background-image:linear-gradient(white, #f06, black);}"];
  [@css
    ".css-1ya0bn9{background-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css
    ".css-7y5q4c{background-image:linear-gradient(45deg, blue, red), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}"
  ];
  [@css
    ".css-6iz2nt{background-image:linear-gradient(45deg, var(--6iz2nt-0) 25%, transparent 0%, transparent 50%, var(--6iz2nt-1) 0%, var(--6iz2nt-2) 75%, transparent 0%, transparent 100% );}"
  ];
  [@css
    ".css-1trhfce{background-image:repeating-linear-gradient( 45deg, var(--1trhfce-0) 0px, var(--1trhfce-1) 4px, var(--1trhfce-2) 5px, var(--1trhfce-3) 9px );}"
  ];
  [@css
    ".css-1lkw9pk{background-image:linear-gradient(45deg, var(--1lkw9pk-0) 25%, transparent 25%), linear-gradient(red -50px, white calc(-25px + 50%), blue 100%), linear-gradient(45deg, blue, red);}"
  ];
  [@css ".css-73gakk{background-image:radial-gradient(white, black);}"];
  [@css ".css-8ictt3{background-image:radial-gradient(circle, white, black);}"];
  [@css ".css-2an1k6{background-image:radial-gradient(ellipse, white, black);}"];
  [@css
    ".css-nxdq7u{background-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    ".css-1h1zgbd{background-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    ".css-rxt7ui{background-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css ".css-62w798{background-image:radial-gradient(50%, white, black);}"];
  [@css
    ".css-1bktrkj{background-image:radial-gradient(60% 60%, white, black);}"
  ];
  [@css ".css-6b650i{list-style-image:linear-gradient(white, black);}"];
  [@css
    ".css-luj45f{list-style-image:linear-gradient(to right, white, black);}"
  ];
  [@css ".css-9p0ve0{list-style-image:linear-gradient(45deg, white, black);}"];
  [@css ".css-1xtg389{list-style-image:linear-gradient(white 50%, black);}"];
  [@css ".css-181601c{list-style-image:linear-gradient(white 5px, black);}"];
  [@css ".css-yhacw2{list-style-image:linear-gradient(white, #f06, black);}"];
  [@css ".css-3lvo23{list-style-image:linear-gradient(currentColor, black);}"];
  [@css
    ".css-1tpfite{list-style-image:linear-gradient(red -50px, white calc(-25px + 50%), blue 100%);}"
  ];
  [@css ".css-3spt5w{list-style-image:radial-gradient(white, black);}"];
  [@css ".css-abzv8q{list-style-image:radial-gradient(circle, white, black);}"];
  [@css ".css-9jl2h3{list-style-image:radial-gradient(ellipse, white, black);}"];
  [@css
    ".css-u600tu{list-style-image:radial-gradient(closest-corner, white, black);}"
  ];
  [@css
    ".css-1vdghw4{list-style-image:radial-gradient(circle closest-corner, white, black);}"
  ];
  [@css
    ".css-k1ozzc{list-style-image:radial-gradient(farthest-side, white, black);}"
  ];
  [@css
    ".css-1rnpikn{list-style-image:radial-gradient(circle farthest-side, white, black);}"
  ];
  [@css ".css-1llzwi2{list-style-image:radial-gradient(50%, white, black);}"];
  [@css ".css-mutdlg{list-style-image:radial-gradient(60% 60%, white, black);}"];
  [@css ".css-2juiz3{image-rendering:auto;}"];
  [@css ".css-17kqt38{image-rendering:smooth;}"];
  [@css ".css-tcno30{image-rendering:high-quality;}"];
  [@css ".css-9d9cum{image-rendering:pixelated;}"];
  [@css ".css-vm4kgw{image-rendering:crisp-edges;}"];
  [@css ".css-wxgo2n{background-position:bottom;}"];
  [@css ".css-1voku2s{background-position-y:0;}"];
  [@css ".css-1dfml4s{background-position:0 0;}"];
  [@css ".css-1whqeok{background-position:1rem 0;}"];
  [@css ".css-2bhiqt{background-position:bottom 10px right;}"];
  [@css ".css-1jdojpf{background-position:bottom 10px right 20px;}"];
  [@css ".css-cybe59{background-position:0 0, center;}"];
  [@css ".css-19r1zpj{object-position:top;}"];
  [@css ".css-6s5fa9{object-position:bottom;}"];
  [@css ".css-1xohkjt{object-position:left;}"];
  [@css ".css-4ap5n3{object-position:right;}"];
  [@css ".css-16dohx7{object-position:center;}"];
  [@css ".css-rha8lu{object-position:25% 75%;}"];
  [@css ".css-1tleykt{object-position:25%;}"];
  [@css ".css-tjsgzo{object-position:0 0;}"];
  [@css ".css-qhieok{object-position:1cm 2cm;}"];
  [@css ".css-bbrtwy{object-position:10ch 8em;}"];
  [@css ".css-gpw6ax{object-position:bottom 10px right 20px;}"];
  [@css ".css-1wjeq6w{object-position:right 3em bottom 10px;}"];
  [@css ".css-1nvj705{object-position:top 0 right 10px;}"];
  [@css ".css-16tumi3{object-position:inherit;}"];
  [@css ".css-r8k95c{object-position:initial;}"];
  [@css ".css-12z0g7d{object-position:revert;}"];
  [@css ".css-1b8ulid{object-position:revert-layer;}"];
  [@css ".css-1riw0oh{object-position:unset;}"];
  [@css
    "@keyframes keyframe-1b5h4ts{0%{background-position:0 0;}100%{background-position:1rem 0;}}"
  ];
  [@css.classes
    [
      ("css-103mvew", 11, "", "input.re", 11, 8, 11, 32),
      ("css-xq8w5y", 12, "", "input.re", 12, 8, 12, 32),
      ("css-a8csmt", 13, "", "input.re", 13, 8, 13, 40),
      ("css-1ft3ceg", 14, "", "input.re", 14, 8, 14, 39),
      ("css-13s9mza", 15, "", "input.re", 15, 8, 15, 39),
      ("css-y1m0mj", 16, "", "input.re", 16, 8, 16, 43),
      ("css-356iko", 17, "", "input.re", 17, 8, 17, 39),
      ("css-1e6f2ns", 18, "", "input.re", 18, 8, 18, 38),
      ("css-ykb3dw", 19, "", "input.re", 19, 8, 19, 38),
      ("css-8dk25r", 20, "", "input.re", 20, 8, 20, 42),
      ("css-1f33szp", 21, "", "input.re", 21, 8, 21, 39),
      ("css-1m4h9fx", 22, "", "input.re", 22, 8, 22, 38),
      ("css-1i6ivx1", 23, "", "input.re", 23, 8, 23, 38),
      ("css-12xldm6", 24, "", "input.re", 24, 8, 24, 42),
      ("css-1l8csu3", 25, "", "input.re", 25, 8, 25, 43),
      ("css-inlcvs", 26, "", "input.re", 26, 8, 26, 42),
      ("css-tacf43", 27, "", "input.re", 27, 8, 27, 42),
      ("css-1q8jpyj", 28, "", "input.re", 28, 8, 28, 46),
      ("css-1vmv5td", 29, "", "input.re", 29, 8, 29, 45),
      ("css-mk96da", 30, "", "input.re", 30, 8, 30, 36),
      ("css-w9t7qy", 31, "", "input.re", 31, 8, 31, 35),
      ("css-d4d5v4", 32, "", "input.re", 32, 8, 32, 36),
      ("css-319xak", 33, "", "input.re", 33, 8, 33, 36),
      ("css-18qd4rc", 34, "", "input.re", 34, 8, 34, 29),
      ("css-lmswcu", 35, "", "input.re", 35, 8, 35, 36),
      ("css-iva9kw", 36, "", "input.re", 36, 8, 36, 42),
      ("css-1955q8t", 37, "", "input.re", 37, 8, 37, 37),
      ("css-1735cty", 38, "", "input.re", 38, 8, 38, 38),
      ("css-gh1jfl", 39, "", "input.re", 39, 8, 39, 38),
      ("css-2e7ho5", 40, "", "input.re", 40, 8, 40, 29),
      ("css-1fziq7w", 41, "", "input.re", 41, 8, 41, 30),
      ("css-5ys43f", 42, "", "input.re", 42, 8, 42, 32),
      ("css-mtm3ik", 43, "", "input.re", 43, 8, 43, 29),
      ("css-1oz6l0x", 44, "", "input.re", 44, 8, 44, 28),
      ("css-njy7h0", 45, "", "input.re", 45, 8, 45, 34),
      ("css-1xdvc9f", 46, "", "input.re", 46, 8, 46, 33),
      ("css-dqcrpw", 47, "", "input.re", 47, 8, 47, 33),
      ("css-1kxndhy", 48, "", "input.re", 48, 8, 48, 34),
      ("css-15eijwr", 49, "", "input.re", 50, 8, 50, 38),
      ("css-11sx168", 50, "", "input.re", 51, 8, 51, 30),
      ("css-v3oj3g", 51, "", "input.re", 52, 8, 52, 24),
      ("css-1c0cimw", 52, "", "input.re", 53, 8, 53, 34),
      ("css-fa4hwu", 53, "", "input.re", 55, 8, 55, 42),
      ("css-jbalz8", 54, "", "input.re", 57, 4, 57, 73),
      ("css-1g5dnum", 55, "", "input.re", 59, 8, 59, 33),
      ("css-xu86rl", 56, "", "input.re", 60, 8, 60, 35),
      ("css-103r34l", 57, "", "input.re", 61, 8, 61, 43),
      ("css-1qsff6w", 58, "", "input.re", 62, 8, 62, 34),
      ("css-emwrvm", 59, "", "input.re", 63, 8, 63, 36),
      ("css-wbvsgh", 60, "", "input.re", 64, 8, 64, 44),
      ("css-18z3qas", 61, "", "input.re", 65, 8, 65, 37),
      ("css-og60n1", 62, "", "input.re", 66, 8, 66, 39),
      ("css-1i7csmg", 63, "", "input.re", 67, 8, 67, 47),
      ("css-ywfkvp", 64, "", "input.re", 68, 8, 68, 36),
      ("css-e4k9mp", 65, "", "input.re", 69, 8, 69, 38),
      ("css-8sv32j", 66, "", "input.re", 70, 8, 70, 46),
      ("css-40qzjv", 67, "", "input.re", 71, 8, 71, 27),
      ("css-1n730d", 68, "", "input.re", 72, 8, 72, 26),
      ("css-gxx2v1", 69, "", "input.re", 73, 8, 73, 30),
      ("css-ax8pa", 70, "", "input.re", 74, 8, 74, 34),
      ("css-1ylo8t6", 71, "", "input.re", 75, 8, 75, 39),
      ("css-fzy6zr", 72, "", "input.re", 76, 8, 76, 34),
      ("css-10sjm2i", 73, "", "input.re", 77, 8, 77, 58),
      ("css-ftxfzm", 74, "", "input.re", 78, 8, 78, 33),
      ("css-scxyes", 75, "", "input.re", 79, 8, 79, 41),
      ("css-13emjar", 76, "", "input.re", 80, 8, 80, 30),
      ("css-13tsz8b", 77, "", "input.re", 81, 8, 81, 31),
      ("css-17q9bou", 78, "", "input.re", 82, 8, 82, 33),
      ("css-7g43ah", 79, "", "input.re", 83, 8, 83, 34),
      ("css-1jlmlqd", 80, "", "input.re", 84, 8, 84, 34),
      ("css-ourmh3", 81, "", "input.re", 85, 8, 85, 35),
      ("css-11wghsw", 82, "", "input.re", 86, 8, 86, 36),
      ("css-f7nplj", 83, "", "input.re", 87, 8, 87, 37),
      ("css-1frbr9", 84, "", "input.re", 88, 8, 88, 37),
      ("css-1ht1ecp", 85, "", "input.re", 89, 8, 89, 38),
      ("css-ouz6pb", 86, "", "input.re", 90, 8, 90, 37),
      ("css-mlh688", 87, "", "input.re", 91, 8, 91, 38),
      ("css-f4r3ac", 88, "", "input.re", 92, 8, 92, 38),
      ("css-kdait5", 89, "", "input.re", 93, 8, 93, 39),
      ("css-qp9a49", 90, "", "input.re", 94, 8, 94, 39),
      ("css-177ic64", 91, "", "input.re", 95, 8, 95, 40),
      ("css-t9fzva", 92, "", "input.re", 96, 8, 96, 40),
      ("css-1dqq7r", 93, "", "input.re", 97, 8, 97, 41),
      ("css-5b0nke", 94, "", "input.re", 98, 8, 98, 40),
      ("css-y051fa", 95, "", "input.re", 99, 8, 99, 41),
      ("css-1eemv5b", 96, "", "input.re", 100, 8, 100, 41),
      ("css-p6olr5", 97, "", "input.re", 101, 8, 101, 42),
      ("css-17puc21", 98, "", "input.re", 102, 8, 102, 40),
      ("css-nwcrwu", 99, "", "input.re", 103, 8, 103, 41),
      ("css-f7xold", 100, "", "input.re", 104, 8, 104, 41),
      ("css-aj8wnx", 101, "", "input.re", 105, 8, 105, 42),
      ("css-9tgmqr", 102, "", "input.re", 106, 8, 106, 41),
      ("css-1gr4grh", 103, "", "input.re", 107, 8, 107, 42),
      ("css-twuj83", 104, "", "input.re", 108, 8, 108, 42),
      ("css-1dvuten", 105, "", "input.re", 109, 8, 109, 43),
      ("css-1oyqkh6", 106, "", "input.re", 110, 8, 110, 36),
      ("css-mnydl", 107, "", "input.re", 111, 8, 111, 35),
      ("css-1lchk48", 108, "", "input.re", 112, 8, 112, 43),
      ("css-clwsl6", 109, "", "input.re", 113, 8, 113, 36),
      ("css-9r5a4q", 110, "", "input.re", 114, 8, 114, 35),
      ("css-p1bkg5", 111, "", "input.re", 115, 8, 115, 43),
      ("css-1l8ypdn", 112, "", "input.re", 116, 8, 116, 32),
      ("css-17bobs3", 113, "", "input.re", 117, 8, 117, 30),
      ("css-acq0zc", 114, "", "input.re", 118, 8, 118, 30),
      ("css-h2hz84", 115, "", "input.re", 119, 8, 119, 32),
      ("css-15de49o", 116, "", "input.re", 120, 8, 120, 37),
      ("css-1lilqof", 117, "", "input.re", 121, 8, 121, 35),
      ("css-1ltcfbh", 118, "", "input.re", 122, 8, 122, 35),
      ("css-17tdo8v", 119, "", "input.re", 123, 8, 123, 37),
      ("css-7p39j4", 120, "", "input.re", 124, 8, 124, 35),
      ("css-1eilh45", 121, "", "input.re", 125, 8, 125, 33),
      ("css-1nxq0c1", 122, "", "input.re", 126, 8, 126, 33),
      ("css-545uaa", 123, "", "input.re", 127, 8, 127, 35),
      ("css-phh0yl", 124, "", "input.re", 128, 8, 128, 35),
      ("css-1po25tk", 125, "", "input.re", 129, 8, 129, 33),
      ("css-1ph07m5", 126, "", "input.re", 130, 8, 130, 33),
      ("css-1xbk2my", 127, "", "input.re", 131, 8, 131, 35),
      ("css-oc9lja", 128, "", "input.re", 132, 8, 132, 37),
      ("css-r4ci8i", 129, "", "input.re", 133, 8, 133, 35),
      ("css-dv34y9", 130, "", "input.re", 134, 8, 134, 35),
      ("css-1ukoqje", 131, "", "input.re", 135, 8, 135, 37),
      ("css-wimxrn", 132, "", "input.re", 136, 8, 136, 39),
      ("css-fz48md", 133, "", "input.re", 137, 8, 137, 43),
      ("css-1sshf0p", 134, "", "input.re", 138, 8, 138, 33),
      ("css-10ch5sk", 135, "", "input.re", 139, 8, 139, 31),
      ("css-1eff4d8", 136, "", "input.re", 140, 8, 140, 36),
      ("css-1ptw524", 137, "", "input.re", 141, 8, 141, 38),
      ("css-1n7lioy", 138, "", "input.re", 142, 8, 142, 34),
      ("css-bvl5g5", 139, "", "input.re", 143, 8, 143, 38),
      ("css-1xlwx1t", 140, "", "input.re", 144, 8, 144, 40),
      ("css-5mxerm", 141, "", "input.re", 145, 8, 145, 36),
      ("css-1ewgy3", 142, "", "input.re", 146, 8, 146, 35),
      ("css-ewiodi", 143, "", "input.re", 147, 8, 147, 34),
      ("css-3sig0u", 144, "", "input.re", 148, 8, 148, 34),
      ("css-7zhnny", 145, "", "input.re", 149, 8, 149, 44),
      ("css-1cwpvkb", 146, "", "input.re", 150, 8, 150, 43),
      ("css-uhd3vw", 147, "", "input.re", 151, 8, 151, 42),
      ("css-1lbiewk", 148, "", "input.re", 152, 8, 152, 42),
      ("css-1c3s2ov", 149, "", "input.re", 153, 8, 153, 43),
      ("css-quauhi", 150, "", "input.re", 154, 8, 154, 42),
      ("css-3uvk7i", 151, "", "input.re", 155, 8, 155, 41),
      ("css-1gcqwuo", 152, "", "input.re", 156, 8, 156, 41),
      ("css-debglq", 153, "", "input.re", 157, 8, 157, 42),
      ("css-j73fcw", 154, "", "input.re", 158, 8, 158, 41),
      ("css-o84mxx", 155, "", "input.re", 159, 8, 159, 40),
      ("css-14dlwip", 156, "", "input.re", 160, 8, 160, 40),
      ("css-u7gdi4", 157, "", "input.re", 161, 8, 161, 42),
      ("css-q24mrn", 158, "", "input.re", 162, 8, 162, 41),
      ("css-14ve9wq", 159, "", "input.re", 163, 8, 163, 40),
      ("css-1qbk5e7", 160, "", "input.re", 164, 8, 164, 40),
      ("css-btbydd", 161, "", "input.re", 165, 8, 165, 37),
      ("css-10qvvi3", 162, "", "input.re", 166, 8, 166, 38),
      ("css-tsgxq8", 163, "", "input.re", 167, 8, 167, 43),
      ("css-1cfidqq", 164, "", "input.re", 168, 8, 168, 43),
      ("css-8hpk1f", 165, "", "input.re", 169, 8, 169, 52),
      ("css-1npdm6x", 166, "", "input.re", 170, 8, 170, 44),
      ("css-1789fd4", 167, "", "input.re", 171, 8, 171, 50),
      ("css-1typqvp", 168, "", "input.re", 172, 8, 172, 55),
      ("css-4jyr4e", 169, "", "input.re", 173, 8, 173, 61),
      ("css-hlv71f", 170, "", "input.re", 176, 8, 176, 24),
      ("css-1rrnq58", 171, "", "input.re", 179, 8, 179, 27),
      ("css-y14zh2", 172, "", "input.re", 181, 8, 181, 29),
      ("css-1j044lg", 173, "", "input.re", 183, 8, 183, 31),
      ("css-z40wto", 174, "", "input.re", 185, 8, 185, 37),
      ("css-1byhv8c", 175, "", "input.re", 187, 8, 187, 35),
      ("css-jsboxm", 176, "", "input.re", 189, 8, 189, 41),
      ("css-jp6frm", 177, "", "input.re", 192, 8, 192, 33),
      ("css-1dws61", 178, "", "input.re", 194, 8, 194, 35),
      ("css-k4794k", 179, "", "input.re", 196, 8, 196, 37),
      ("css-4kiwvw", 180, "", "input.re", 198, 8, 198, 43),
      ("css-38l82s", 181, "", "input.re", 200, 8, 200, 41),
      ("css-h247gf", 182, "", "input.re", 202, 8, 202, 47),
      ("css-14g5y3c", 183, "", "input.re", 204, 8, 204, 70),
      ("css-hb8rq5", 184, "", "input.re", 205, 8, 205, 46),
      ("css-2hpm2z", 185, "", "input.re", 206, 8, 206, 49),
      ("css-7qykh1", 186, "", "input.re", 208, 4, 210, 56),
      ("css-ov7g6w", 187, "", "input.re", 214, 8, 214, 36),
      ("css-12efer5", 188, "", "input.re", 215, 8, 215, 37),
      ("css-1fw0v0y", 189, "", "input.re", 216, 8, 216, 34),
      ("css-1cr2uy5", 190, "", "input.re", 217, 8, 217, 41),
      ("css-1pwf16c", 191, "", "input.re", 218, 8, 218, 42),
      ("css-yvhrhp", 192, "", "input.re", 219, 8, 219, 42),
      ("css-1mdqd54", 193, "", "input.re", 220, 8, 220, 39),
      ("css-iskajy", 194, "", "input.re", 221, 8, 221, 44),
      ("css-er08c7", 195, "", "input.re", 222, 8, 222, 34),
      ("css-1ywetyb", 196, "", "input.re", 223, 8, 223, 35),
      ("css-10x1y29", 197, "", "input.re", 224, 8, 224, 48),
      ("css-6a7hma", 198, "", "input.re", 225, 8, 225, 59),
      ("css-66ffzk", 199, "", "input.re", 226, 8, 226, 41),
      ("css-1e8lt9w", 200, "", "input.re", 227, 8, 227, 47),
      ("css-az2km0", 201, "", "input.re", 228, 8, 228, 45),
      ("css-qvfsxl", 202, "", "input.re", 229, 8, 229, 47),
      ("css-cpp5ws", 203, "", "input.re", 230, 8, 230, 47),
      ("css-5x9kb3", 204, "", "input.re", 231, 8, 231, 42),
      ("css-1s267z1", 205, "", "input.re", 232, 8, 232, 41),
      ("css-1m7uyso", 206, "", "input.re", 233, 8, 233, 41),
      ("css-ehls39", 207, "", "input.re", 234, 8, 234, 41),
      ("css-wn8mc6", 208, "", "input.re", 235, 8, 235, 40),
      ("css-l3mlhe", 209, "", "input.re", 236, 8, 236, 42),
      ("css-1wrzpq", 210, "", "input.re", 237, 8, 237, 41),
      ("css-jhjivl", 211, "", "input.re", 239, 8, 239, 37),
      ("css-mrdnn4", 212, "", "input.re", 240, 8, 240, 37),
      ("css-mpnuqy", 213, "", "input.re", 241, 8, 241, 34),
      ("css-1kmhgic", 214, "", "input.re", 242, 8, 242, 39),
      ("css-o7lusv", 215, "", "input.re", 243, 8, 243, 42),
      ("css-1ha1y0h", 216, "", "input.re", 244, 8, 244, 42),
      ("css-g9dh78", 217, "", "input.re", 245, 8, 245, 38),
      ("css-2xgdy5", 218, "", "input.re", 246, 8, 246, 44),
      ("css-1nfogqu", 219, "", "input.re", 247, 8, 247, 34),
      ("css-jqjxhl", 220, "", "input.re", 248, 8, 248, 35),
      ("css-18ym6xi", 221, "", "input.re", 249, 8, 249, 48),
      ("css-1w9lik3", 222, "", "input.re", 250, 8, 250, 54),
      ("css-1pkz6jk", 223, "", "input.re", 251, 8, 251, 41),
      ("css-1rtkyja", 224, "", "input.re", 252, 8, 252, 47),
      ("css-rbgg2w", 225, "", "input.re", 253, 8, 253, 45),
      ("css-yxw0x2", 226, "", "input.re", 254, 8, 254, 47),
      ("css-pom5pn", 227, "", "input.re", 255, 8, 255, 47),
      ("css-3gelvz", 228, "", "input.re", 256, 8, 256, 42),
      ("css-we2i90", 229, "", "input.re", 257, 8, 257, 41),
      ("css-1xsx6lh", 230, "", "input.re", 258, 8, 258, 41),
      ("css-1683xoj", 231, "", "input.re", 259, 8, 259, 42),
      ("css-1raqrjk", 232, "", "input.re", 260, 8, 260, 39),
      ("css-1f4dura", 233, "", "input.re", 261, 8, 261, 43),
      ("css-1dvtt90", 234, "", "input.re", 262, 8, 262, 40),
      ("css-1n8qvjg", 235, "", "input.re", 266, 8, 266, 60),
      ("css-1bom7la", 236, "", "input.re", 267, 8, 267, 68),
      ("css-i4o14z", 237, "", "input.re", 268, 8, 268, 64),
      ("css-d4iszc", 238, "", "input.re", 269, 8, 269, 65),
      ("css-1jr5xxu", 239, "", "input.re", 270, 8, 270, 56),
      ("css-1u2z2py", 240, "", "input.re", 271, 8, 271, 66),
      ("css-195a0ta", 241, "", "input.re", 272, 8, 272, 63),
      ("css-1r2wspy", 242, "", "input.re", 273, 8, 273, 60),
      ("css-18vd8h6", 243, "", "input.re", 274, 8, 274, 62),
      ("css-1ya0bn9", 244, "", "input.re", 276, 4, 276, 85),
      ("css-7y5q4c", 245, "", "input.re", 280, 7, 284, 5),
      ("css-6iz2nt", 246, "", "input.re", 289, 7, 299, 5),
      ("css-1trhfce", 247, "", "input.re", 303, 4, 311, 4),
      ("css-1lkw9pk", 248, "", "input.re", 316, 7, 320, 5),
      ("css-73gakk", 249, "", "input.re", 326, 8, 326, 56),
      ("css-8ictt3", 250, "", "input.re", 327, 8, 327, 64),
      ("css-2an1k6", 251, "", "input.re", 328, 8, 328, 65),
      ("css-nxdq7u", 252, "", "input.re", 330, 4, 330, 75),
      ("css-1h1zgbd", 253, "", "input.re", 332, 8, 332, 71),
      ("css-rxt7ui", 254, "", "input.re", 334, 4, 334, 74),
      ("css-62w798", 255, "", "input.re", 336, 8, 336, 61),
      ("css-1bktrkj", 256, "", "input.re", 337, 8, 337, 65),
      ("css-6b650i", 257, "", "input.re", 340, 8, 340, 56),
      ("css-luj45f", 258, "", "input.re", 341, 8, 341, 66),
      ("css-9p0ve0", 259, "", "input.re", 342, 8, 342, 63),
      ("css-1xtg389", 260, "", "input.re", 343, 8, 343, 60),
      ("css-181601c", 261, "", "input.re", 344, 8, 344, 60),
      ("css-yhacw2", 262, "", "input.re", 345, 8, 345, 62),
      ("css-3lvo23", 263, "", "input.re", 346, 8, 346, 63),
      ("css-1tpfite", 264, "", "input.re", 348, 4, 348, 85),
      ("css-3spt5w", 265, "", "input.re", 350, 8, 350, 56),
      ("css-abzv8q", 266, "", "input.re", 351, 8, 351, 64),
      ("css-9jl2h3", 267, "", "input.re", 352, 8, 352, 65),
      ("css-u600tu", 268, "", "input.re", 353, 8, 353, 72),
      ("css-1vdghw4", 269, "", "input.re", 355, 4, 355, 75),
      ("css-k1ozzc", 270, "", "input.re", 357, 8, 357, 71),
      ("css-1rnpikn", 271, "", "input.re", 359, 4, 359, 74),
      ("css-1llzwi2", 272, "", "input.re", 361, 8, 361, 61),
      ("css-mutdlg", 273, "", "input.re", 362, 8, 362, 65),
      ("css-2juiz3", 274, "", "input.re", 384, 8, 384, 30),
      ("css-17kqt38", 275, "", "input.re", 385, 8, 385, 32),
      ("css-tcno30", 276, "", "input.re", 386, 8, 386, 38),
      ("css-9d9cum", 277, "", "input.re", 387, 8, 387, 35),
      ("css-vm4kgw", 278, "", "input.re", 388, 8, 388, 37),
      ("css-wxgo2n", 279, "", "input.re", 428, 8, 428, 36),
      ("css-1voku2s", 280, "", "input.re", 430, 8, 430, 33),
      ("css-1dfml4s", 281, "", "input.re", 431, 8, 431, 33),
      ("css-1whqeok", 282, "", "input.re", 432, 8, 432, 36),
      ("css-2bhiqt", 283, "", "input.re", 433, 8, 433, 46),
      ("css-1jdojpf", 284, "", "input.re", 434, 8, 434, 51),
      ("css-cybe59", 285, "", "input.re", 435, 8, 435, 40),
      ("css-19r1zpj", 286, "", "input.re", 438, 9, 438, 30),
      ("css-6s5fa9", 287, "", "input.re", 439, 9, 439, 33),
      ("css-1xohkjt", 288, "", "input.re", 440, 9, 440, 31),
      ("css-4ap5n3", 289, "", "input.re", 441, 9, 441, 32),
      ("css-16dohx7", 290, "", "input.re", 442, 9, 442, 33),
      ("css-rha8lu", 291, "", "input.re", 444, 9, 444, 34),
      ("css-1tleykt", 292, "", "input.re", 445, 9, 445, 30),
      ("css-tjsgzo", 293, "", "input.re", 447, 9, 447, 30),
      ("css-qhieok", 294, "", "input.re", 448, 9, 448, 34),
      ("css-bbrtwy", 295, "", "input.re", 449, 9, 449, 35),
      ("css-gpw6ax", 296, "", "input.re", 451, 9, 451, 49),
      ("css-1wjeq6w", 297, "", "input.re", 452, 9, 452, 48),
      ("css-1nvj705", 298, "", "input.re", 453, 9, 453, 43),
      ("css-16tumi3", 299, "", "input.re", 455, 9, 455, 34),
      ("css-r8k95c", 300, "", "input.re", 456, 9, 456, 34),
      ("css-12z0g7d", 301, "", "input.re", 457, 9, 457, 33),
      ("css-1b8ulid", 302, "", "input.re", 458, 9, 458, 39),
      ("css-1riw0oh", 303, "", "input.re", 459, 9, 459, 32),
    ]
  ];
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.make("css-103mvew", []);
  CSS.make("css-xq8w5y", []);
  CSS.make("css-a8csmt", []);
  CSS.make("css-1ft3ceg", []);
  CSS.make("css-13s9mza", []);
  CSS.make("css-y1m0mj", []);
  CSS.make("css-356iko", []);
  CSS.make("css-1e6f2ns", []);
  CSS.make("css-ykb3dw", []);
  CSS.make("css-8dk25r", []);
  CSS.make("css-1f33szp", []);
  CSS.make("css-1m4h9fx", []);
  CSS.make("css-1i6ivx1", []);
  CSS.make("css-12xldm6", []);
  CSS.make("css-1l8csu3", []);
  CSS.make("css-inlcvs", []);
  CSS.make("css-tacf43", []);
  CSS.make("css-1q8jpyj", []);
  CSS.make("css-1vmv5td", []);
  CSS.make("css-mk96da", []);
  CSS.make("css-w9t7qy", []);
  CSS.make("css-d4d5v4", []);
  CSS.make("css-319xak", []);
  CSS.make("css-18qd4rc", []);
  CSS.make("css-lmswcu", []);
  CSS.make("css-iva9kw", []);
  CSS.make("css-1955q8t", []);
  CSS.make("css-1735cty", []);
  CSS.make("css-gh1jfl", []);
  CSS.make("css-2e7ho5", []);
  CSS.make("css-1fziq7w", []);
  CSS.make("css-5ys43f", []);
  CSS.make("css-mtm3ik", []);
  CSS.make("css-1oz6l0x", []);
  CSS.make("css-njy7h0", []);
  CSS.make("css-1xdvc9f", []);
  CSS.make("css-dqcrpw", []);
  CSS.make("css-1kxndhy", []);
  
  CSS.make("css-15eijwr", []);
  CSS.make("css-11sx168", []);
  CSS.make("css-v3oj3g", []);
  CSS.make("css-1c0cimw", []);
  
  CSS.make("css-fa4hwu", []);
  CSS.make("css-jbalz8", []);
  CSS.make("css-1g5dnum", []);
  CSS.make("css-xu86rl", []);
  CSS.make("css-103r34l", []);
  CSS.make("css-1qsff6w", []);
  CSS.make("css-emwrvm", []);
  CSS.make("css-wbvsgh", []);
  CSS.make("css-18z3qas", []);
  CSS.make("css-og60n1", []);
  CSS.make("css-1i7csmg", []);
  CSS.make("css-ywfkvp", []);
  CSS.make("css-e4k9mp", []);
  CSS.make("css-8sv32j", []);
  CSS.make("css-40qzjv", []);
  CSS.make("css-1n730d", []);
  CSS.make("css-gxx2v1", []);
  CSS.make("css-ax8pa", []);
  CSS.make("css-1ylo8t6", []);
  CSS.make("css-fzy6zr", []);
  CSS.make("css-10sjm2i", []);
  CSS.make("css-ftxfzm", []);
  CSS.make("css-scxyes", []);
  CSS.make("css-13emjar", []);
  CSS.make("css-13tsz8b", []);
  CSS.make("css-17q9bou", []);
  CSS.make("css-7g43ah", []);
  CSS.make("css-1jlmlqd", []);
  CSS.make("css-ourmh3", []);
  CSS.make("css-11wghsw", []);
  CSS.make("css-f7nplj", []);
  CSS.make("css-1frbr9", []);
  CSS.make("css-1ht1ecp", []);
  CSS.make("css-ouz6pb", []);
  CSS.make("css-mlh688", []);
  CSS.make("css-f4r3ac", []);
  CSS.make("css-kdait5", []);
  CSS.make("css-qp9a49", []);
  CSS.make("css-177ic64", []);
  CSS.make("css-t9fzva", []);
  CSS.make("css-1dqq7r", []);
  CSS.make("css-5b0nke", []);
  CSS.make("css-y051fa", []);
  CSS.make("css-1eemv5b", []);
  CSS.make("css-p6olr5", []);
  CSS.make("css-17puc21", []);
  CSS.make("css-nwcrwu", []);
  CSS.make("css-f7xold", []);
  CSS.make("css-aj8wnx", []);
  CSS.make("css-9tgmqr", []);
  CSS.make("css-1gr4grh", []);
  CSS.make("css-twuj83", []);
  CSS.make("css-1dvuten", []);
  CSS.make("css-1oyqkh6", []);
  CSS.make("css-mnydl", []);
  CSS.make("css-1lchk48", []);
  CSS.make("css-clwsl6", []);
  CSS.make("css-9r5a4q", []);
  CSS.make("css-p1bkg5", []);
  CSS.make("css-1l8ypdn", []);
  CSS.make("css-17bobs3", []);
  CSS.make("css-acq0zc", []);
  CSS.make("css-h2hz84", []);
  CSS.make("css-15de49o", []);
  CSS.make("css-1lilqof", []);
  CSS.make("css-1ltcfbh", []);
  CSS.make("css-17tdo8v", []);
  CSS.make("css-7p39j4", []);
  CSS.make("css-1eilh45", []);
  CSS.make("css-1nxq0c1", []);
  CSS.make("css-545uaa", []);
  CSS.make("css-phh0yl", []);
  CSS.make("css-1po25tk", []);
  CSS.make("css-1ph07m5", []);
  CSS.make("css-1xbk2my", []);
  CSS.make("css-oc9lja", []);
  CSS.make("css-r4ci8i", []);
  CSS.make("css-dv34y9", []);
  CSS.make("css-1ukoqje", []);
  CSS.make("css-wimxrn", []);
  CSS.make("css-fz48md", []);
  CSS.make("css-1sshf0p", []);
  CSS.make("css-10ch5sk", []);
  CSS.make("css-1eff4d8", []);
  CSS.make("css-1ptw524", []);
  CSS.make("css-1n7lioy", []);
  CSS.make("css-bvl5g5", []);
  CSS.make("css-1xlwx1t", []);
  CSS.make("css-5mxerm", []);
  CSS.make("css-1ewgy3", []);
  CSS.make("css-ewiodi", []);
  CSS.make("css-3sig0u", []);
  CSS.make("css-7zhnny", []);
  CSS.make("css-1cwpvkb", []);
  CSS.make("css-uhd3vw", []);
  CSS.make("css-1lbiewk", []);
  CSS.make("css-1c3s2ov", []);
  CSS.make("css-quauhi", []);
  CSS.make("css-3uvk7i", []);
  CSS.make("css-1gcqwuo", []);
  CSS.make("css-debglq", []);
  CSS.make("css-j73fcw", []);
  CSS.make("css-o84mxx", []);
  CSS.make("css-14dlwip", []);
  CSS.make("css-u7gdi4", []);
  CSS.make("css-q24mrn", []);
  CSS.make("css-14ve9wq", []);
  CSS.make("css-1qbk5e7", []);
  CSS.make("css-btbydd", []);
  CSS.make("css-10qvvi3", []);
  CSS.make("css-tsgxq8", []);
  CSS.make("css-1cfidqq", []);
  CSS.make("css-8hpk1f", []);
  CSS.make("css-1npdm6x", []);
  CSS.make("css-1789fd4", []);
  CSS.make("css-1typqvp", []);
  CSS.make("css-4jyr4e", []);
  
  CSS.make("css-hlv71f", []);
  
  CSS.make("css-1rrnq58", []);
  
  CSS.make("css-y14zh2", []);
  
  CSS.make("css-1j044lg", []);
  
  CSS.make("css-z40wto", []);
  
  CSS.make("css-1byhv8c", []);
  
  CSS.make("css-jsboxm", []);
  
  CSS.make("css-jp6frm", []);
  
  CSS.make("css-1dws61", []);
  
  CSS.make("css-k4794k", []);
  
  CSS.make("css-4kiwvw", []);
  
  CSS.make("css-38l82s", []);
  
  CSS.make("css-h247gf", []);
  
  CSS.make("css-14g5y3c", []);
  CSS.make("css-hb8rq5", []);
  CSS.make("css-2hpm2z", []);
  CSS.make(
    "css-7qykh1",
    [
      ("--7qykh1-0", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      ("--7qykh1-1", CSS.Types.Color.toString(Color.Shadow.elevation1)),
      ("--7qykh1-2", CSS.Types.Color.toString(Color.Shadow.elevation1)),
    ],
  );
  
  CSS.make("css-ov7g6w", []);
  CSS.make("css-12efer5", []);
  CSS.make("css-1fw0v0y", []);
  CSS.make("css-1cr2uy5", []);
  CSS.make("css-1pwf16c", []);
  CSS.make("css-yvhrhp", []);
  CSS.make("css-1mdqd54", []);
  CSS.make("css-iskajy", []);
  CSS.make("css-er08c7", []);
  CSS.make("css-1ywetyb", []);
  CSS.make("css-10x1y29", []);
  CSS.make("css-6a7hma", []);
  CSS.make("css-66ffzk", []);
  CSS.make("css-1e8lt9w", []);
  CSS.make("css-az2km0", []);
  CSS.make("css-qvfsxl", []);
  CSS.make("css-cpp5ws", []);
  CSS.make("css-5x9kb3", []);
  CSS.make("css-1s267z1", []);
  CSS.make("css-1m7uyso", []);
  CSS.make("css-ehls39", []);
  CSS.make("css-wn8mc6", []);
  CSS.make("css-l3mlhe", []);
  CSS.make("css-1wrzpq", []);
  CSS.make("css-ehls39", []);
  CSS.make("css-jhjivl", []);
  CSS.make("css-mrdnn4", []);
  CSS.make("css-mpnuqy", []);
  CSS.make("css-1kmhgic", []);
  CSS.make("css-o7lusv", []);
  CSS.make("css-1ha1y0h", []);
  CSS.make("css-g9dh78", []);
  CSS.make("css-2xgdy5", []);
  CSS.make("css-1nfogqu", []);
  CSS.make("css-jqjxhl", []);
  CSS.make("css-18ym6xi", []);
  CSS.make("css-1w9lik3", []);
  CSS.make("css-1pkz6jk", []);
  CSS.make("css-1rtkyja", []);
  CSS.make("css-rbgg2w", []);
  CSS.make("css-yxw0x2", []);
  CSS.make("css-pom5pn", []);
  CSS.make("css-3gelvz", []);
  CSS.make("css-we2i90", []);
  CSS.make("css-1xsx6lh", []);
  CSS.make("css-1683xoj", []);
  CSS.make("css-1raqrjk", []);
  CSS.make("css-1f4dura", []);
  CSS.make("css-1dvtt90", []);
  CSS.make("css-1683xoj", []);
  
  CSS.make("css-1n8qvjg", []);
  CSS.make("css-1bom7la", []);
  CSS.make("css-i4o14z", []);
  CSS.make("css-d4iszc", []);
  CSS.make("css-1jr5xxu", []);
  CSS.make("css-1u2z2py", []);
  CSS.make("css-195a0ta", []);
  CSS.make("css-1r2wspy", []);
  CSS.make("css-18vd8h6", []);
  CSS.make("css-1ya0bn9", []);
  CSS.make("css-7y5q4c", []);
  let color = `hex("333");
  CSS.make(
    "css-6iz2nt",
    [
      ("--6iz2nt-0", CSS.Types.Color.toString(color)),
      ("--6iz2nt-1", CSS.Types.Color.toString(color)),
      ("--6iz2nt-2", CSS.Types.Color.toString(color)),
    ],
  );
  CSS.make(
    "css-1trhfce",
    [
      ("--1trhfce-0", CSS.Types.Color.toString(color)),
      ("--1trhfce-1", CSS.Types.Color.toString(color)),
      ("--1trhfce-2", CSS.Types.Color.toString(color)),
      ("--1trhfce-3", CSS.Types.Color.toString(color)),
    ],
  );
  
  CSS.make(
    "css-1lkw9pk",
    [("--1lkw9pk-0", CSS.Types.Color.toString(Color.Background.boxDark))],
  );
  
  CSS.make("css-73gakk", []);
  CSS.make("css-8ictt3", []);
  CSS.make("css-2an1k6", []);
  CSS.make("css-nxdq7u", []);
  CSS.make("css-1h1zgbd", []);
  CSS.make("css-rxt7ui", []);
  CSS.make("css-62w798", []);
  CSS.make("css-1bktrkj", []);
  
  CSS.make("css-6b650i", []);
  CSS.make("css-luj45f", []);
  CSS.make("css-9p0ve0", []);
  CSS.make("css-1xtg389", []);
  CSS.make("css-181601c", []);
  CSS.make("css-yhacw2", []);
  CSS.make("css-3lvo23", []);
  CSS.make("css-1tpfite", []);
  CSS.make("css-3spt5w", []);
  CSS.make("css-abzv8q", []);
  CSS.make("css-9jl2h3", []);
  CSS.make("css-u600tu", []);
  CSS.make("css-1vdghw4", []);
  CSS.make("css-k1ozzc", []);
  CSS.make("css-1rnpikn", []);
  CSS.make("css-1llzwi2", []);
  CSS.make("css-mutdlg", []);
  
  CSS.make("css-2juiz3", []);
  CSS.make("css-17kqt38", []);
  CSS.make("css-tcno30", []);
  CSS.make("css-9d9cum", []);
  CSS.make("css-vm4kgw", []);
  
  CSS.make("css-wxgo2n", []);
  CSS.make("css-1fw0v0y", []);
  CSS.make("css-1voku2s", []);
  CSS.make("css-1dfml4s", []);
  CSS.make("css-1whqeok", []);
  CSS.make("css-2bhiqt", []);
  CSS.make("css-1jdojpf", []);
  CSS.make("css-cybe59", []);
  
  CSS.make("css-19r1zpj", []);
  CSS.make("css-6s5fa9", []);
  CSS.make("css-1xohkjt", []);
  CSS.make("css-4ap5n3", []);
  CSS.make("css-16dohx7", []);
  
  CSS.make("css-rha8lu", []);
  CSS.make("css-1tleykt", []);
  
  CSS.make("css-tjsgzo", []);
  CSS.make("css-qhieok", []);
  CSS.make("css-bbrtwy", []);
  
  CSS.make("css-gpw6ax", []);
  CSS.make("css-1wjeq6w", []);
  CSS.make("css-1nvj705", []);
  
  CSS.make("css-16tumi3", []);
  CSS.make("css-r8k95c", []);
  CSS.make("css-12z0g7d", []);
  CSS.make("css-1b8ulid", []);
  CSS.make("css-1riw0oh", []);
  
  let _loadingKeyframes = CSS.Types.AnimationName.make("keyframe-1b5h4ts");
