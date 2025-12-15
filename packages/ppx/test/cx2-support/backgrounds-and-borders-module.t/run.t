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
    ".css-1fk4zyw { background-repeat: space; }\n.css-1b5bs2w { background-repeat: round; }\n.css-10bc5xf { background-repeat: repeat repeat; }\n.css-1hj2nt2 { background-repeat: space repeat; }\n.css-1ymwewh { background-repeat: round repeat; }\n.css-q5ziyo { background-repeat: no-repeat repeat; }\n.css-12yljrm { background-repeat: repeat space; }\n.css-tmyoxk { background-repeat: space space; }\n.css-1b7df31 { background-repeat: round space; }\n.css-1u4wolb { background-repeat: no-repeat space; }\n.css-1xgro2y { background-repeat: repeat round; }\n.css-u4ceze { background-repeat: space round; }\n.css-or16mb { background-repeat: round round; }\n.css-fw89t4 { background-repeat: no-repeat round; }\n.css-1gi2lbt { background-repeat: repeat no-repeat; }\n.css-1lbdlha { background-repeat: space no-repeat; }\n.css-1utvway { background-repeat: round no-repeat; }\n.css-1rpyv7t { background-repeat: no-repeat no-repeat; }\n.css-6xthtc { background-repeat: repeat-x, repeat-y; }\n.css-17ts0al { background-attachment: local; }\n.css-142embh { background-clip: border-box; }\n.css-z8bxqs { background-clip: padding-box; }\n.css-9by3ij { background-clip: content-box; }\n.css-1x7ujam { background-clip: text; }\n.css-d7zqo6 { background-clip: border-area; }\n.css-15ytth8 { background-clip: text, border-area; }\n.css-1x5i1e9 { background-origin: border-box; }\n.css-1s64w3g { background-origin: padding-box; }\n.css-1r6s8xp { background-origin: content-box; }\n.css-1n1h8j5 { background-size: auto; }\n.css-14s2ljp { background-size: cover; }\n.css-a09f6u { background-size: contain; }\n.css-mamj9p { background-size: 10px; }\n.css-oxkcdr { background-size: 50%; }\n.css-tn48l0 { background-size: 10px auto; }\n.css-19wfbt8 { background-size: auto 10%; }\n.css-1uqpzom { background-size: 50em 50%; }\n.css-au7s1w { background-size: 20px 20px; }\n.css-56cen0 { background: top left / 50% 60%; }\n.css-1nau6m { background: border-box; }\n.css-gtzx6z { background: blue; }\n.css-b1irtn { background: border-box red; }\n.css-1u9ah2o { background: border-box padding-box; }\n.css-6m7hc3 { border-top-left-radius: 0; }\n.css-f0o6l1 { border-top-left-radius: 50%; }\n.css-1qeoett { border-top-left-radius: 250px 100px; }\n.css-10wkvpa { border-top-right-radius: 0; }\n.css-1i860i { border-top-right-radius: 50%; }\n.css-1oim8ix { border-top-right-radius: 250px 100px; }\n.css-qnz4gl { border-bottom-right-radius: 0; }\n.css-1vuxm78 { border-bottom-right-radius: 50%; }\n.css-1b6fhs4 { border-bottom-right-radius: 250px 100px; }\n.css-vhnyam { border-bottom-left-radius: 0; }\n.css-nfyd0w { border-bottom-left-radius: 50%; }\n.css-ky2v9 { border-bottom-left-radius: 250px 100px; }\n.css-umvizp { border-radius: 10px; }\n.css-1th4bik { border-radius: 50%; }\n.css-1dz7yyi { border-radius: 2px 4px; }\n.css-sqwgh9 { border-radius: 2px 4px 8px; }\n.css-12lyv6f { border-radius: 2px 4px 8px 16px; }\n.css-ob66cv { border-radius: 10px / 20px; }\n.css-akfwor { border-radius: 2px 4px 8px 16px / 2px 4px 8px 16px; }\n.css-1e5enqi { border-image-source: none; }\n.css-1axovv5 { border-image-source: url(\"foo.png\"); }\n.css-xr8hih { border-image-slice: 10; }\n.css-1qjwbrc { border-image-slice: 30%; }\n.css-ajdt4d { border-image-slice: 10 10; }\n.css-1bql356 { border-image-slice: 30% 10; }\n.css-1kg3y0 { border-image-slice: 10 30%; }\n.css-yod0wz { border-image-slice: 30% 30%; }\n.css-y0l98z { border-image-slice: 10 10 10; }\n.css-13cgh2p { border-image-slice: 30% 10 10; }\n.css-1brl1qh { border-image-slice: 10 30% 10; }\n.css-bzysd4 { border-image-slice: 30% 30% 10; }\n.css-1hfblwu { border-image-slice: 10 10 30%; }\n.css-ajn7uk { border-image-slice: 30% 10 30%; }\n.css-1h46fq9 { border-image-slice: 10 30% 30%; }\n.css-2dxidq { border-image-slice: 30% 30% 30%; }\n.css-5gem6r { border-image-slice: 10 10 10 10; }\n.css-1r194v9 { border-image-slice: 30% 10 10 10; }\n.css-14rsvnf { border-image-slice: 10 30% 10 10; }\n.css-1hcv9di { border-image-slice: 30% 30% 10 10; }\n.css-5fuvsr { border-image-slice: 10 10 30% 10; }\n.css-uh5q3x { border-image-slice: 30% 10 30% 10; }\n.css-5hk3bc { border-image-slice: 10 30% 30% 10; }\n.css-1tv21v2 { border-image-slice: 30% 30% 30% 10; }\n.css-1hcdlvy { border-image-slice: 10 10 10 30%; }\n.css-lgsfx5 { border-image-slice: 30% 10 10 30%; }\n.css-up4yap { border-image-slice: 10 30% 10 30%; }\n.css-6dxlse { border-image-slice: 30% 30% 10 30%; }\n.css-1isuxu8 { border-image-slice: 10 10 30% 30%; }\n.css-516x10 { border-image-slice: 30% 10 30% 30%; }\n.css-ouk36d { border-image-slice: 10 30% 30% 30%; }\n.css-6pofh7 { border-image-slice: 30% 30% 30% 30%; }\n.css-16dg2hb { border-image-slice: fill 30%; }\n.css-12h5e08 { border-image-slice: fill 10; }\n.css-1kd2llt { border-image-slice: fill 2 4 8% 16%; }\n.css-1lus7k { border-image-slice: 30% fill; }\n.css-6rmrpv { border-image-slice: 10 fill; }\n.css-1qf74bs { border-image-slice: 2 4 8% 16% fill; }\n.css-1gj7j3j { border-image-width: 10px; }\n.css-1ec91ha { border-image-width: 5%; }\n.css-z0gqw6 { border-image-width: 28; }\n.css-1ofnvgv { border-image-width: auto; }\n.css-gdz2u9 { border-image-width: 10px 10px; }\n.css-nvk2bm { border-image-width: 5% 10px; }\n.css-bfv341 { border-image-width: 28 10px; }\n.css-1lglxiv { border-image-width: auto 10px; }\n.css-u1173e { border-image-width: 10px 5%; }\n.css-1fyjqqb { border-image-width: 5% 5%; }\n.css-squu5c { border-image-width: 28 5%; }\n.css-l0o9ht { border-image-width: auto 5%; }\n.css-9c9p0u { border-image-width: 10px 28; }\n.css-o0322n { border-image-width: 5% 28; }\n.css-152q0ze { border-image-width: 28 28; }\n.css-1dk1af8 { border-image-width: auto 28; }\n.css-1rv3u38 { border-image-width: 10px auto; }\n.css-16xsevu { border-image-width: 5% auto; }\n.css-moeaz7 { border-image-width: 28 auto; }\n.css-1mdmz6m { border-image-width: auto auto; }\n.css-1yz9ba8 { border-image-width: 10px 10% 10; }\n.css-1fhkh6 { border-image-width: 5% 10px 20 auto; }\n.css-1dv1uyd { border-image-outset: 10px; }\n.css-io9tx7 { border-image-outset: 20; }\n.css-sfsda3 { border-image-outset: 10px 20; }\n.css-1gua88s { border-image-outset: 10px 20px; }\n.css-sygqri { border-image-outset: 20 30; }\n.css-hzg31h { border-image-outset: 2px 3px 4; }\n.css-p1zd5h { border-image-outset: 1 2px 3px 4; }\n.css-iukq73 { border-image-repeat: stretch; }\n.css-qlays4 { border-image-repeat: repeat; }\n.css-3gw8ap { border-image-repeat: round; }\n.css-2crgt2 { border-image-repeat: space; }\n.css-13hqytw { border-image-repeat: stretch stretch; }\n.css-tbjxzd { border-image-repeat: repeat stretch; }\n.css-1ffikn3 { border-image-repeat: round stretch; }\n.css-144n87h { border-image-repeat: space stretch; }\n.css-t5dbaz { border-image-repeat: stretch repeat; }\n.css-igc3ri { border-image-repeat: repeat repeat; }\n.css-1h0mig6 { border-image-repeat: round repeat; }\n.css-1sc0sq2 { border-image-repeat: space repeat; }\n.css-d7drvy { border-image-repeat: stretch round; }\n.css-7jja62 { border-image-repeat: repeat round; }\n.css-1u979rk { border-image-repeat: round round; }\n.css-hwt8k5 { border-image-repeat: space round; }\n.css-e7ord8 { border-image-repeat: stretch space; }\n.css-968a1q { border-image-repeat: repeat space; }\n.css-pqdvd9 { border-image-repeat: round space; }\n.css-mbbxbh { border-image-repeat: space space; }\n.css-1m9wd3d { border-image: url(\"foo.png\") 10; }\n.css-1fy06v9 { border-image: url(\"foo.png\") 10%; }\n.css-1h96vnp { border-image: url(\"foo.png\") 10% fill; }\n.css-oo9e7b { border-image: url(\"foo.png\") 10 round; }\n.css-1wnvre8 { border-image: url(\"foo.png\") 10 stretch repeat; }\n.css-rpty11 { border-image: url(\"foo.png\") 10 / 10px; }\n.css-192dl6s { border-image: url(\"foo.png\") 10 / 10% / 10px; }\n.css-17mojdd { border-image: url(\"foo.png\") fill 10 / 10% / 10px; }\n.css-1ndtvnz { border-image: url(\"foo.png\") fill 10 / 10% / 10px space; }\n.css-zic50l { box-shadow: none; }\n.css-165jfyp { box-shadow: 1px 1px; }\n.css-srtvoz { box-shadow: 0 0 black; }\n.css-1nj234s { box-shadow: 1px 2px 3px; }\n.css-157jdzb { box-shadow: 1px 2px 3px black; }\n.css-2l8cuc { box-shadow: 1px 2px 3px 4px; }\n.css-1okj66 { box-shadow: 1px 2px 3px 4px black; }\n.css-1pnao9g { box-shadow: inset 1px 1px; }\n.css-1y8e0hj { box-shadow: inset 0 0 black; }\n.css-dk77ol { box-shadow: inset 1px 2px 3px; }\n.css-p32tba { box-shadow: inset 1px 2px 3px black; }\n.css-1e68egt { box-shadow: inset 1px 2px 3px 4px; }\n.css-1g9li6 { box-shadow: inset 1px 2px 3px 4px black; }\n.css-u24s1c { box-shadow: inset 1px 2px 3px 4px black, 1px 2px 3px 4px black; }\n.css-6y530r { box-shadow: 1px 1px, inset 2px 2px red; }\n.css-1jgynz1 { box-shadow: 0 0 5px, inset 0 0 10px black; }\n.css-1glr9hp { background-position-x: right; }\n.css-1b2df6b { background-position-x: center; }\n.css-fx1dzd { background-position-x: 50%; }\n.css-1e2i7is { background-position-x: left, left; }\n.css-1397da6 { background-position-x: left, right; }\n.css-10odeic { background-position-x: right, left; }\n.css-1jsx82u { background-position-x: left, 0%; }\n.css-1yvnicx { background-position-x: 10%, 20%, 40%; }\n.css-fq9zh0 { background-position-x: 0px; }\n.css-ha1hq9 { background-position-x: 30px; }\n.css-1s564ce { background-position-x: 0%, 10%, 20%, 30%; }\n.css-1p2vlt9 { background-position-x: left, left, left, left, left; }\n.css-1fs6yvq { background-position-x: calc(20px); }\n.css-rggxn { background-position-x: calc(20px + 1em); }\n.css-m9jk6k { background-position-x: calc(20px / 2); }\n.css-2ihaxt { background-position-x: calc(20px + 50%); }\n.css-5bh2ud { background-position-x: calc(50% - 10px); }\n.css-1dtmz7k { background-position-x: calc(-20px); }\n.css-16mpia8 { background-position-x: calc(-50%); }\n.css-1jkek33 { background-position-x: calc(-20%); }\n.css-1ycn3ik { background-position-x: right 20px; }\n.css-4c6xru { background-position-x: left 20px; }\n.css-r4imm4 { background-position-x: right -50px; }\n.css-kv39m5 { background-position-x: left -50px; }\n.css-re8l95 { background-position-y: bottom; }\n.css-uz9guw { background-position-y: center; }\n.css-ch9rwi { background-position-y: 50%; }\n.css-1h1hbb9 { background-position-y: top, top; }\n.css-3cvgkt { background-position-y: top, bottom; }\n.css-aduod0 { background-position-y: bottom, top; }\n.css-1i85xi2 { background-position-y: top, 0%; }\n.css-1ky3xye { background-position-y: 10%, 20%, 40%; }\n.css-g0wssh { background-position-y: 0px; }\n.css-1s7pxxw { background-position-y: 30px; }\n.css-vy260l { background-position-y: 0%, 10%, 20%, 30%; }\n.css-4g4gs8 { background-position-y: top, top, top, top, top; }\n.css-2qw5h0 { background-position-y: calc(20px); }\n.css-r66qk4 { background-position-y: calc(20px + 1em); }\n.css-14b5nza { background-position-y: calc(20px / 2); }\n.css-bb0g65 { background-position-y: calc(20px + 50%); }\n.css-xbn4wn { background-position-y: calc(50% - 10px); }\n.css-s3zzuy { background-position-y: calc(-20px); }\n.css-1k2tsru { background-position-y: calc(-50%); }\n.css-1gfrv21 { background-position-y: calc(-20%); }\n.css-8m79ds { background-position-y: bottom 20px; }\n.css-1hzwtgz { background-position-y: top 20px; }\n.css-1xgan2o { background-position-y: bottom -50px; }\n.css-pqmnuo { background-position-y: top -50px; }\n.css-cgsa64 { background-image: linear-gradient(45deg, blue, red); }\n.css-lic5t9 { background-image: linear-gradient(90deg, blue 10%, red 20%); }\n.css-135ddyf { background-image: linear-gradient(90deg, blue 10%, red); }\n.css-1hwjj8y { background-image: linear-gradient(90deg, blue, 10%, red); }\n.css-fovh2j { background-image: linear-gradient(white, black); }\n.css-1ebjv96 { background-image: linear-gradient(to right, white, black); }\n.css-n3z8to { background-image: linear-gradient(45deg, white, black); }\n.css-ohwpft { background-image: linear-gradient(white 50%, black); }\n.css-1axzqa4 { background-image: linear-gradient(white, #f06, black); }\n.css-1gbz3ry { background-image: radial-gradient(white, black); }\n.css-wn52ef { background-image: radial-gradient(circle, white, black); }\n.css-zzuiae { background-image: radial-gradient(ellipse, white, black); }\n.css-1cyjcvl { background-image: radial-gradient(farthest-side, white, black); }\n.css-12wscu9 { background-image: radial-gradient(50%, white, black); }\n.css-1jji8qh { background-image: radial-gradient(60% 60%, white, black); }\n.css-13m5j5l { list-style-image: linear-gradient(white, black); }\n.css-easwvb { list-style-image: linear-gradient(to right, white, black); }\n.css-187ujbx { list-style-image: linear-gradient(45deg, white, black); }\n.css-k73a79 { list-style-image: linear-gradient(white 50%, black); }\n.css-1m79xq3 { list-style-image: linear-gradient(white 5px, black); }\n.css-aav5pv { list-style-image: linear-gradient(white, #f06, black); }\n.css-wmir1v { list-style-image: linear-gradient(currentColor, black); }\n.css-e02xib { list-style-image: radial-gradient(white, black); }\n.css-ivdvsa { list-style-image: radial-gradient(circle, white, black); }\n.css-op3ka0 { list-style-image: radial-gradient(ellipse, white, black); }\n.css-du5rb2 { list-style-image: radial-gradient(closest-corner, white, black); }\n.css-yfqm2s { list-style-image: radial-gradient(farthest-side, white, black); }\n.css-rb8sxk { list-style-image: radial-gradient(50%, white, black); }\n.css-zc0p5a { list-style-image: radial-gradient(60% 60%, white, black); }\n.css-1dj5d2p { image-rendering: auto; }\n.css-qh26ex { image-rendering: smooth; }\n.css-6crfs3 { image-rendering: high-quality; }\n.css-ygic6e { image-rendering: pixelated; }\n.css-ty2e5a { image-rendering: crisp-edges; }\n.css-mq469o { background-position: bottom; }\n.css-1734nwj { background-position-y: 0; }\n.css-z5tk8q { background-position: 0 0; }\n.css-yyi6jl { background-position: 1rem 0; }\n.css-8b4src { background-position: bottom 10px right; }\n.css-qgtn4r { background-position: bottom 10px right 20px; }\n.css-1mlmcbg { background-position: 0 0, center; }\n.css-1hmu3pq { object-position: top ; }\n.css-i0f9ks { object-position: bottom ; }\n.css-10a6umh { object-position: left ; }\n.css-1c9yfuu { object-position: right ; }\n.css-1syqq4t { object-position: center ; }\n.css-1wc27zn { object-position: 25% 75% ; }\n.css-rs3jiu { object-position: 25% ; }\n.css-jakd08 { object-position: 0 0 ; }\n.css-189za9c { object-position: 1cm 2cm ; }\n.css-1hbdrli { object-position: 10ch 8em ; }\n.css-yxg8fn { object-position: bottom 10px right 20px ; }\n.css-1yh03th { object-position: right 3em bottom 10px ; }\n.css-dnmtrq { object-position: top 0 right 10px ; }\n.css-74xj94 { object-position: inherit ; }\n.css-118tnzg { object-position: initial ; }\n.css-ibv8a8 { object-position: revert ; }\n.css-t0b38u { object-position: revert-layer ; }\n.css-1u70ao1 { object-position: unset ; }\n"
  ];
  module Color = {
    module Background = {
      let boxDark = `hex("000000");
    };
    module Shadow = {
      let elevation1 = `rgba((0, 0, 0, `num(0.03)));
    };
  };
  
  CSS.make("css-1fk4zyw", []);
  CSS.make("css-1b5bs2w", []);
  CSS.make("css-10bc5xf", []);
  CSS.make("css-1hj2nt2", []);
  CSS.make("css-1ymwewh", []);
  CSS.make("css-q5ziyo", []);
  CSS.make("css-12yljrm", []);
  CSS.make("css-tmyoxk", []);
  CSS.make("css-1b7df31", []);
  CSS.make("css-1u4wolb", []);
  CSS.make("css-1xgro2y", []);
  CSS.make("css-u4ceze", []);
  CSS.make("css-or16mb", []);
  CSS.make("css-fw89t4", []);
  CSS.make("css-1gi2lbt", []);
  CSS.make("css-1lbdlha", []);
  CSS.make("css-1utvway", []);
  CSS.make("css-1rpyv7t", []);
  CSS.make("css-6xthtc", []);
  CSS.make("css-17ts0al", []);
  CSS.make("css-142embh", []);
  CSS.make("css-z8bxqs", []);
  CSS.make("css-9by3ij", []);
  CSS.make("css-1x7ujam", []);
  CSS.make("css-d7zqo6", []);
  CSS.make("css-15ytth8", []);
  CSS.make("css-1x5i1e9", []);
  CSS.make("css-1s64w3g", []);
  CSS.make("css-1r6s8xp", []);
  CSS.make("css-1n1h8j5", []);
  CSS.make("css-14s2ljp", []);
  CSS.make("css-a09f6u", []);
  CSS.make("css-mamj9p", []);
  CSS.make("css-oxkcdr", []);
  CSS.make("css-tn48l0", []);
  CSS.make("css-19wfbt8", []);
  CSS.make("css-1uqpzom", []);
  CSS.make("css-au7s1w", []);
  
  CSS.make("css-56cen0", []);
  CSS.make("css-1nau6m", []);
  CSS.make("css-gtzx6z", []);
  CSS.make("css-b1irtn", []);
  
  CSS.make("css-1u9ah2o", []);
  CSS.backgroundImage(`url({js|foo.png|js}));
  CSS.make("css-6m7hc3", []);
  CSS.make("css-f0o6l1", []);
  CSS.make("css-1qeoett", []);
  CSS.make("css-10wkvpa", []);
  CSS.make("css-1i860i", []);
  CSS.make("css-1oim8ix", []);
  CSS.make("css-qnz4gl", []);
  CSS.make("css-1vuxm78", []);
  CSS.make("css-1b6fhs4", []);
  CSS.make("css-vhnyam", []);
  CSS.make("css-nfyd0w", []);
  CSS.make("css-ky2v9", []);
  CSS.make("css-umvizp", []);
  CSS.make("css-1th4bik", []);
  CSS.make("css-1dz7yyi", []);
  CSS.make("css-sqwgh9", []);
  CSS.make("css-12lyv6f", []);
  CSS.make("css-ob66cv", []);
  CSS.make("css-akfwor", []);
  CSS.make("css-1e5enqi", []);
  CSS.make("css-1axovv5", []);
  CSS.make("css-xr8hih", []);
  CSS.make("css-1qjwbrc", []);
  CSS.make("css-ajdt4d", []);
  CSS.make("css-1bql356", []);
  CSS.make("css-1kg3y0", []);
  CSS.make("css-yod0wz", []);
  CSS.make("css-y0l98z", []);
  CSS.make("css-13cgh2p", []);
  CSS.make("css-1brl1qh", []);
  CSS.make("css-bzysd4", []);
  CSS.make("css-1hfblwu", []);
  CSS.make("css-ajn7uk", []);
  CSS.make("css-1h46fq9", []);
  CSS.make("css-2dxidq", []);
  CSS.make("css-5gem6r", []);
  CSS.make("css-1r194v9", []);
  CSS.make("css-14rsvnf", []);
  CSS.make("css-1hcv9di", []);
  CSS.make("css-5fuvsr", []);
  CSS.make("css-uh5q3x", []);
  CSS.make("css-5hk3bc", []);
  CSS.make("css-1tv21v2", []);
  CSS.make("css-1hcdlvy", []);
  CSS.make("css-lgsfx5", []);
  CSS.make("css-up4yap", []);
  CSS.make("css-6dxlse", []);
  CSS.make("css-1isuxu8", []);
  CSS.make("css-516x10", []);
  CSS.make("css-ouk36d", []);
  CSS.make("css-6pofh7", []);
  CSS.make("css-16dg2hb", []);
  CSS.make("css-12h5e08", []);
  CSS.make("css-1kd2llt", []);
  CSS.make("css-1lus7k", []);
  CSS.make("css-6rmrpv", []);
  CSS.make("css-1qf74bs", []);
  CSS.make("css-1gj7j3j", []);
  CSS.make("css-1ec91ha", []);
  CSS.make("css-z0gqw6", []);
  CSS.make("css-1ofnvgv", []);
  CSS.make("css-gdz2u9", []);
  CSS.make("css-nvk2bm", []);
  CSS.make("css-bfv341", []);
  CSS.make("css-1lglxiv", []);
  CSS.make("css-u1173e", []);
  CSS.make("css-1fyjqqb", []);
  CSS.make("css-squu5c", []);
  CSS.make("css-l0o9ht", []);
  CSS.make("css-9c9p0u", []);
  CSS.make("css-o0322n", []);
  CSS.make("css-152q0ze", []);
  CSS.make("css-1dk1af8", []);
  CSS.make("css-1rv3u38", []);
  CSS.make("css-16xsevu", []);
  CSS.make("css-moeaz7", []);
  CSS.make("css-1mdmz6m", []);
  CSS.make("css-1yz9ba8", []);
  CSS.make("css-1fhkh6", []);
  CSS.make("css-1dv1uyd", []);
  CSS.make("css-io9tx7", []);
  CSS.make("css-sfsda3", []);
  CSS.make("css-1gua88s", []);
  CSS.make("css-sygqri", []);
  CSS.make("css-hzg31h", []);
  CSS.make("css-p1zd5h", []);
  CSS.make("css-iukq73", []);
  CSS.make("css-qlays4", []);
  CSS.make("css-3gw8ap", []);
  CSS.make("css-2crgt2", []);
  CSS.make("css-13hqytw", []);
  CSS.make("css-tbjxzd", []);
  CSS.make("css-1ffikn3", []);
  CSS.make("css-144n87h", []);
  CSS.make("css-t5dbaz", []);
  CSS.make("css-igc3ri", []);
  CSS.make("css-1h0mig6", []);
  CSS.make("css-1sc0sq2", []);
  CSS.make("css-d7drvy", []);
  CSS.make("css-7jja62", []);
  CSS.make("css-1u979rk", []);
  CSS.make("css-hwt8k5", []);
  CSS.make("css-e7ord8", []);
  CSS.make("css-968a1q", []);
  CSS.make("css-pqdvd9", []);
  CSS.make("css-mbbxbh", []);
  CSS.make("css-1m9wd3d", []);
  CSS.make("css-1fy06v9", []);
  CSS.make("css-1h96vnp", []);
  CSS.make("css-oo9e7b", []);
  CSS.make("css-1wnvre8", []);
  CSS.make("css-rpty11", []);
  CSS.make("css-192dl6s", []);
  CSS.make("css-17mojdd", []);
  CSS.make("css-1ndtvnz", []);
  
  CSS.make("css-zic50l", []);
  
  CSS.make("css-165jfyp", []);
  
  CSS.make("css-srtvoz", []);
  
  CSS.make("css-1nj234s", []);
  
  CSS.make("css-157jdzb", []);
  
  CSS.make("css-2l8cuc", []);
  
  CSS.make("css-1okj66", []);
  
  CSS.make("css-1pnao9g", []);
  
  CSS.make("css-1y8e0hj", []);
  
  CSS.make("css-dk77ol", []);
  
  CSS.make("css-p32tba", []);
  
  CSS.make("css-1e68egt", []);
  
  CSS.make("css-1g9li6", []);
  
  CSS.make("css-u24s1c", []);
  CSS.make("css-6y530r", []);
  CSS.make("css-1jgynz1", []);
  CSS.boxShadows([|
    CSS.BoxShadow.box(
      ~x=`pxFloat(-1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CSS.BoxShadow.box(
      ~x=`pxFloat(1.),
      ~y=`pxFloat(1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
    CSS.BoxShadow.box(
      ~x=`pxFloat(0.),
      ~y=`pxFloat(-1.),
      ~blur=`pxFloat(0.),
      ~spread=`pxFloat(0.),
      Color.Shadow.elevation1,
    ),
  |]);
  
  CSS.make("css-1glr9hp", []);
  CSS.make("css-1b2df6b", []);
  CSS.make("css-fx1dzd", []);
  CSS.make("css-1e2i7is", []);
  CSS.make("css-1397da6", []);
  CSS.make("css-10odeic", []);
  CSS.make("css-1jsx82u", []);
  CSS.make("css-1yvnicx", []);
  CSS.make("css-fq9zh0", []);
  CSS.make("css-ha1hq9", []);
  CSS.make("css-1s564ce", []);
  CSS.make("css-1p2vlt9", []);
  CSS.make("css-1fs6yvq", []);
  CSS.make("css-rggxn", []);
  CSS.make("css-m9jk6k", []);
  CSS.make("css-2ihaxt", []);
  CSS.make("css-5bh2ud", []);
  CSS.make("css-1dtmz7k", []);
  CSS.make("css-16mpia8", []);
  CSS.make("css-1jkek33", []);
  CSS.make("css-1ycn3ik", []);
  CSS.make("css-4c6xru", []);
  CSS.make("css-r4imm4", []);
  CSS.make("css-kv39m5", []);
  CSS.make("css-1ycn3ik", []);
  CSS.make("css-re8l95", []);
  CSS.make("css-uz9guw", []);
  CSS.make("css-ch9rwi", []);
  CSS.make("css-1h1hbb9", []);
  CSS.make("css-3cvgkt", []);
  CSS.make("css-aduod0", []);
  CSS.make("css-1i85xi2", []);
  CSS.make("css-1ky3xye", []);
  CSS.make("css-g0wssh", []);
  CSS.make("css-1s7pxxw", []);
  CSS.make("css-vy260l", []);
  CSS.make("css-4g4gs8", []);
  CSS.make("css-2qw5h0", []);
  CSS.make("css-r66qk4", []);
  CSS.make("css-14b5nza", []);
  CSS.make("css-bb0g65", []);
  CSS.make("css-xbn4wn", []);
  CSS.make("css-s3zzuy", []);
  CSS.make("css-1k2tsru", []);
  CSS.make("css-1gfrv21", []);
  CSS.make("css-8m79ds", []);
  CSS.make("css-1hzwtgz", []);
  CSS.make("css-1xgan2o", []);
  CSS.make("css-pqmnuo", []);
  CSS.make("css-8m79ds", []);
  
  CSS.make("css-cgsa64", []);
  CSS.make("css-lic5t9", []);
  CSS.make("css-135ddyf", []);
  CSS.make("css-1hwjj8y", []);
  CSS.make("css-fovh2j", []);
  CSS.make("css-1ebjv96", []);
  CSS.make("css-n3z8to", []);
  CSS.make("css-ohwpft", []);
  CSS.make("css-1axzqa4", []);
  CSS.backgroundImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (Some(CSS.white), Some(`calc(`add((`pxFloat(-25.), `percent(50.)))))),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (Some(CSS.white), Some(`calc(`add((`pxFloat(-25.), `percent(50.)))))),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  |]);
  let color = `hex("333");
  CSS.backgroundImage(
    `linearGradient((
      Some(`deg(45.)),
      [|
        (Some(color), Some(`percent(25.))),
        (Some(`transparent), Some(`percent(0.))),
        (Some(`transparent), Some(`percent(50.))),
        (Some(color), Some(`percent(0.))),
        (Some(color), Some(`percent(75.))),
        (Some(`transparent), Some(`percent(0.))),
        (Some(`transparent), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.backgroundImage(
    `repeatingLinearGradient((
      Some(`deg(45.)),
      [|
        (Some(color), Some(`pxFloat(0.))),
        (Some(color), Some(`pxFloat(4.))),
        (Some(color), Some(`pxFloat(5.))),
        (Some(color), Some(`pxFloat(9.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  
  CSS.backgroundImages([|
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(Color.Background.boxDark), Some(`percent(25.))), (Some(`transparent), Some(`percent(25.)))|]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (Some(CSS.white), Some(`calc(`add((`pxFloat(-25.), `percent(50.)))))),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
    `linearGradient((
      Some(`deg(45.)),
      [|(Some(CSS.blue), None), (Some(CSS.red), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  |]);
  
  CSS.make("css-1gbz3ry", []);
  CSS.make("css-wn52ef", []);
  CSS.make("css-zzuiae", []);
  CSS.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-1cyjcvl", []);
  CSS.backgroundImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-12wscu9", []);
  CSS.make("css-1jji8qh", []);
  
  CSS.make("css-13m5j5l", []);
  CSS.make("css-easwvb", []);
  CSS.make("css-187ujbx", []);
  CSS.make("css-k73a79", []);
  CSS.make("css-1m79xq3", []);
  CSS.make("css-aav5pv", []);
  CSS.make("css-wmir1v", []);
  CSS.listStyleImage(
    `linearGradient((
      None,
      [|
        (Some(CSS.red), Some(`pxFloat(-50.))),
        (Some(CSS.white), Some(`calc(`add((`pxFloat(-25.), `percent(50.)))))),
        (Some(CSS.blue), Some(`percent(100.))),
      |]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-e02xib", []);
  CSS.make("css-ivdvsa", []);
  CSS.make("css-op3ka0", []);
  CSS.make("css-du5rb2", []);
  CSS.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`closestCorner),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-yfqm2s", []);
  CSS.listStyleImage(
    `radialGradient((
      Some(`circle),
      Some(`farthestSide),
      None,
      [|(Some(CSS.white), None), (Some(CSS.black), None)|]: CSS.Types.Gradient.color_stop_list,
    )),
  );
  CSS.make("css-rb8sxk", []);
  CSS.make("css-zc0p5a", []);
  
  CSS.make("css-1dj5d2p", []);
  CSS.make("css-qh26ex", []);
  CSS.make("css-6crfs3", []);
  CSS.make("css-ygic6e", []);
  CSS.make("css-ty2e5a", []);
  
  CSS.make("css-mq469o", []);
  CSS.make("css-fx1dzd", []);
  CSS.make("css-1734nwj", []);
  CSS.make("css-z5tk8q", []);
  CSS.make("css-yyi6jl", []);
  CSS.make("css-8b4src", []);
  CSS.make("css-qgtn4r", []);
  CSS.make("css-1mlmcbg", []);
  
  CSS.make("css-1hmu3pq", []);
  CSS.make("css-i0f9ks", []);
  CSS.make("css-10a6umh", []);
  CSS.make("css-1c9yfuu", []);
  CSS.make("css-1syqq4t", []);
  
  CSS.make("css-1wc27zn", []);
  CSS.make("css-rs3jiu", []);
  
  CSS.make("css-jakd08", []);
  CSS.make("css-189za9c", []);
  CSS.make("css-1hbdrli", []);
  
  CSS.make("css-yxg8fn", []);
  CSS.make("css-1yh03th", []);
  CSS.make("css-dnmtrq", []);
  
  CSS.make("css-74xj94", []);
  CSS.make("css-118tnzg", []);
  CSS.make("css-ibv8a8", []);
  CSS.make("css-t0b38u", []);
  CSS.make("css-1u70ao1", []);
  
  let _loadingKeyframes =
    CSS.keyframes([|
      (0, [|CSS.backgroundPosition(`hv((`zero, `zero)))|]),
      (100, [|CSS.backgroundPosition(`hv((`rem(1.), `zero)))|]),
    |]);

