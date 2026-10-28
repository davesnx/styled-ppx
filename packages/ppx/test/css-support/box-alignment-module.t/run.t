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
    (
      "._a_9j0001lqh0{align-self:auto;}",
      "_a_9j0001lqh0",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j00015str{align-self:normal;}",
      "_a_9j00015str",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001qoy4{align-self:stretch;}",
      "_a_9j0001qoy4",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001wum8{align-self:baseline;}",
      "_a_9j0001wum8",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j00012ze6{align-self:first baseline;}",
      "_a_9j00012ze6",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j00010zg2{align-self:last baseline;}",
      "_a_9j00010zg2",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001e9xz{align-self:center;}",
      "_a_9j0001e9xz",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001ehcy{align-self:start;}",
      "_a_9j0001ehcy",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001qp3k{align-self:end;}",
      "_a_9j0001qp3k",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001bvnc{align-self:self-start;}",
      "_a_9j0001bvnc",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001hf65{align-self:self-end;}",
      "_a_9j0001hf65",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001gsxr{align-self:unsafe start;}",
      "_a_9j0001gsxr",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0001q3l2{align-self:safe start;}",
      "_a_9j0001q3l2",
      "0,1,0 own",
      "343",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i00017rk4{align-items:normal;}",
      "_a_9i00017rk4",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i00011ack{align-items:stretch;}",
      "_a_9i00011ack",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001jl3a{align-items:baseline;}",
      "_a_9i0001jl3a",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i00013wj4{align-items:first baseline;}",
      "_a_9i00013wj4",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001r88q{align-items:last baseline;}",
      "_a_9i0001r88q",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001xndt{align-items:center;}",
      "_a_9i0001xndt",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001qn8b{align-items:start;}",
      "_a_9i0001qn8b",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i000112ai{align-items:end;}",
      "_a_9i000112ai",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001mgp6{align-items:self-start;}",
      "_a_9i0001mgp6",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001yf6q{align-items:self-end;}",
      "_a_9i0001yf6q",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i0001n9n2{align-items:unsafe start;}",
      "_a_9i0001n9n2",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9i00018fld{align-items:safe start;}",
      "_a_9i00018fld",
      "0,1,0 own",
      "342",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h000182qi{align-content:normal;}",
      "_a_9h000182qi",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001tf19{align-content:baseline;}",
      "_a_9h0001tf19",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001e56e{align-content:first baseline;}",
      "_a_9h0001e56e",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001bvxk{align-content:last baseline;}",
      "_a_9h0001bvxk",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001t6ef{align-content:space-between;}",
      "_a_9h0001t6ef",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001ulzr{align-content:space-around;}",
      "_a_9h0001ulzr",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001zzqp{align-content:space-evenly;}",
      "_a_9h0001zzqp",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001sg0i{align-content:stretch;}",
      "_a_9h0001sg0i",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001ho4p{align-content:center;}",
      "_a_9h0001ho4p",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h000162g1{align-content:start;}",
      "_a_9h000162g1",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001otui{align-content:end;}",
      "_a_9h0001otui",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001vgc7{align-content:flex-start;}",
      "_a_9h0001vgc7",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h0001x96o{align-content:flex-end;}",
      "_a_9h0001x96o",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h00016jw8{align-content:unsafe start;}",
      "_a_9h00016jw8",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9h00012jhg{align-content:safe start;}",
      "_a_9h00012jhg",
      "0,1,0 own",
      "341",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002nscv{justify-self:auto;}",
      "_a_9j0002nscv",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j00020v6u{justify-self:normal;}",
      "_a_9j00020v6u",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002yvex{justify-self:stretch;}",
      "_a_9j0002yvex",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j00023z27{justify-self:baseline;}",
      "_a_9j00023z27",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j00025zq0{justify-self:first baseline;}",
      "_a_9j00025zq0",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j00020186{justify-self:last baseline;}",
      "_a_9j00020186",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002dfjc{justify-self:center;}",
      "_a_9j0002dfjc",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002bxzs{justify-self:start;}",
      "_a_9j0002bxzs",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002pv54{justify-self:end;}",
      "_a_9j0002pv54",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002ab6k{justify-self:self-start;}",
      "_a_9j0002ab6k",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002zxgz{justify-self:self-end;}",
      "_a_9j0002zxgz",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002obw4{justify-self:unsafe start;}",
      "_a_9j0002obw4",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j00025sda{justify-self:safe start;}",
      "_a_9j00025sda",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j00024swf{justify-self:left;}",
      "_a_9j00024swf",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j00025rli{justify-self:right;}",
      "_a_9j00025rli",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9j0002akos{justify-self:safe right;}",
      "_a_9j0002akos",
      "0,1,0 own",
      "343",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002t02p{justify-items:normal;}",
      "_a_9i0002t02p",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002w19q{justify-items:stretch;}",
      "_a_9i0002w19q",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002sd3r{justify-items:baseline;}",
      "_a_9i0002sd3r",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002oxkb{justify-items:first baseline;}",
      "_a_9i0002oxkb",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002nqwq{justify-items:last baseline;}",
      "_a_9i0002nqwq",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002hncw{justify-items:center;}",
      "_a_9i0002hncw",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i00027xd1{justify-items:start;}",
      "_a_9i00027xd1",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002d6ik{justify-items:end;}",
      "_a_9i0002d6ik",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002ujby{justify-items:self-start;}",
      "_a_9i0002ujby",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002jls5{justify-items:self-end;}",
      "_a_9i0002jls5",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002kxpa{justify-items:unsafe start;}",
      "_a_9i0002kxpa",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002igov{justify-items:safe start;}",
      "_a_9i0002igov",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002hueq{justify-items:left;}",
      "_a_9i0002hueq",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002tw7a{justify-items:right;}",
      "_a_9i0002tw7a",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002zryg{justify-items:safe right;}",
      "_a_9i0002zryg",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i0002qp4r{justify-items:legacy;}",
      "_a_9i0002qp4r",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i00026jur{justify-items:legacy left;}",
      "_a_9i00026jur",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i00021n9p{justify-items:legacy right;}",
      "_a_9i00021n9p",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9i00028x1c{justify-items:legacy center;}",
      "_a_9i00028x1c",
      "0,1,0 own",
      "342",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002dm5u{justify-content:normal;}",
      "_a_9h0002dm5u",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002dmss{justify-content:space-between;}",
      "_a_9h0002dmss",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h00024oss{justify-content:space-around;}",
      "_a_9h00024oss",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002462w{justify-content:space-evenly;}",
      "_a_9h0002462w",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h000208ak{justify-content:stretch;}",
      "_a_9h000208ak",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002ndxa{justify-content:center;}",
      "_a_9h0002ndxa",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002xozo{justify-content:start;}",
      "_a_9h0002xozo",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002rfkc{justify-content:end;}",
      "_a_9h0002rfkc",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h00020841{justify-content:flex-start;}",
      "_a_9h00020841",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002getn{justify-content:flex-end;}",
      "_a_9h0002getn",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002ygzb{justify-content:unsafe start;}",
      "_a_9h0002ygzb",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002pp7h{justify-content:safe start;}",
      "_a_9h0002pp7h",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002dmac{justify-content:left;}",
      "_a_9h0002dmac",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h0002jo9q{justify-content:right;}",
      "_a_9h0002jo9q",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9h000289l6{justify-content:safe right;}",
      "_a_9h000289l6",
      "0,1,0 own",
      "341",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_9hqrgx{place-content:normal;}",
      "_a_9hqrgx",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hzktz{place-content:baseline;}",
      "_a_9hzktz",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h0k3s{place-content:first baseline;}",
      "_a_9h0k3s",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hlpj3{place-content:last baseline;}",
      "_a_9hlpj3",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hg07y{place-content:space-between;}",
      "_a_9hg07y",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hn9tt{place-content:space-around;}",
      "_a_9hn9tt",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h8p3p{place-content:space-evenly;}",
      "_a_9h8p3p",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hwium{place-content:stretch;}",
      "_a_9hwium",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hdqw8{place-content:center;}",
      "_a_9hdqw8",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h5dhv{place-content:start;}",
      "_a_9h5dhv",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hnyc7{place-content:end;}",
      "_a_9hnyc7",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hdrdu{place-content:flex-start;}",
      "_a_9hdrdu",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hnttj{place-content:flex-end;}",
      "_a_9hnttj",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h71ck{place-content:unsafe start;}",
      "_a_9h71ck",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hqxqj{place-content:safe start;}",
      "_a_9hqxqj",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h3qoo{place-content:normal normal;}",
      "_a_9h3qoo",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hnuac{place-content:baseline normal;}",
      "_a_9hnuac",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h0fds{place-content:first baseline normal;}",
      "_a_9h0fds",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hhpg7{place-content:space-between normal;}",
      "_a_9hhpg7",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hzrg5{place-content:center normal;}",
      "_a_9hzrg5",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hz0tb{place-content:unsafe start normal;}",
      "_a_9hz0tb",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hi3io{place-content:normal stretch;}",
      "_a_9hi3io",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hfbzg{place-content:baseline stretch;}",
      "_a_9hfbzg",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h8zlv{place-content:first baseline stretch;}",
      "_a_9h8zlv",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h4shn{place-content:center stretch;}",
      "_a_9h4shn",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hf3b8{place-content:unsafe start stretch;}",
      "_a_9hf3b8",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hb47q{place-content:normal safe right;}",
      "_a_9hb47q",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hwp5i{place-content:baseline safe right;}",
      "_a_9hwp5i",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hpafp{place-content:first baseline safe right;}",
      "_a_9hpafp",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9htr2b{place-content:space-between safe right;}",
      "_a_9htr2b",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9hhl56{place-content:center safe right;}",
      "_a_9hhl56",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9h288f{place-content:unsafe start safe right;}",
      "_a_9h288f",
      "0,1,0 own",
      "341",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iu5yn{place-items:normal;}",
      "_a_9iu5yn",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iwgtc{place-items:stretch;}",
      "_a_9iwgtc",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ip3r0{place-items:baseline;}",
      "_a_9ip3r0",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ijtjp{place-items:first baseline;}",
      "_a_9ijtjp",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9imap8{place-items:last baseline;}",
      "_a_9imap8",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iym04{place-items:center;}",
      "_a_9iym04",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9icea0{place-items:start;}",
      "_a_9icea0",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    ("._a_9iqbga{place-items:end;}", "_a_9iqbga", "0,1,0 own", "342", 3, false)
  ];
  [@css
    (
      "._a_9icfae{place-items:self-start;}",
      "_a_9icfae",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i4r6c{place-items:self-end;}",
      "_a_9i4r6c",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ik81w{place-items:unsafe start;}",
      "_a_9ik81w",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iboah{place-items:safe start;}",
      "_a_9iboah",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ioh71{place-items:normal normal;}",
      "_a_9ioh71",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ivk8n{place-items:stretch normal;}",
      "_a_9ivk8n",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9im489{place-items:baseline normal;}",
      "_a_9im489",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ibjab{place-items:first baseline normal;}",
      "_a_9ibjab",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iz5p3{place-items:self-start normal;}",
      "_a_9iz5p3",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i2at7{place-items:unsafe start normal;}",
      "_a_9i2at7",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i9qwi{place-items:normal stretch;}",
      "_a_9i9qwi",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ig7oz{place-items:stretch stretch;}",
      "_a_9ig7oz",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iecxz{place-items:baseline stretch;}",
      "_a_9iecxz",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9idtd3{place-items:first baseline stretch;}",
      "_a_9idtd3",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9itjgd{place-items:self-start stretch;}",
      "_a_9itjgd",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i24mg{place-items:unsafe start stretch;}",
      "_a_9i24mg",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9infmq{place-items:normal last baseline;}",
      "_a_9infmq",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i203s{place-items:stretch last baseline;}",
      "_a_9i203s",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iq0j0{place-items:baseline last baseline;}",
      "_a_9iq0j0",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9isgia{place-items:first baseline last baseline;}",
      "_a_9isgia",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i5oxa{place-items:self-start last baseline;}",
      "_a_9i5oxa",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9if3bh{place-items:unsafe start last baseline;}",
      "_a_9if3bh",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9io9xj{place-items:normal legacy left;}",
      "_a_9io9xj",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9iaufw{place-items:stretch legacy left;}",
      "_a_9iaufw",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i4fdy{place-items:baseline legacy left;}",
      "_a_9i4fdy",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9ilg27{place-items:first baseline legacy left;}",
      "_a_9ilg27",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9i6nyr{place-items:self-start legacy left;}",
      "_a_9i6nyr",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css
    (
      "._a_9isbzm{place-items:unsafe start legacy left;}",
      "_a_9isbzm",
      "0,1,0 own",
      "342",
      3,
      false,
    )
  ];
  [@css ("._a_6f9awh{gap:0 0;}", "_a_6f9awh", "0,1,0 own", "231", 3, false)];
  [@css ("._a_6f0ra0{gap:0 1em;}", "_a_6f0ra0", "0,1,0 own", "231", 3, false)];
  [@css ("._a_6f6cki{gap:1em;}", "_a_6f6cki", "0,1,0 own", "231", 3, false)];
  [@css
    ("._a_6fkubh{gap:1em 1em;}", "_a_6fkubh", "0,1,0 own", "231", 3, false)
  ];
  [@css
    (
      "._a_6f0001zqln{-webkit-column-gap:0;column-gap:0;}",
      "_a_6f0001zqln",
      "0,1,0 own",
      "231",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6f00012mee{-webkit-column-gap:1em;column-gap:1em;}",
      "_a_6f00012mee",
      "0,1,0 own",
      "231",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6f00015ixr{-webkit-column-gap:normal;column-gap:normal;}",
      "_a_6f00015ixr",
      "0,1,0 own",
      "231",
      1,
      false,
    )
  ];
  [@css
    (
      "._a_6f00022sqe{row-gap:0;}",
      "_a_6f00022sqe",
      "0,1,0 own",
      "231",
      2,
      false,
    )
  ];
  [@css
    (
      "._a_6f0002i0al{row-gap:1em;}",
      "_a_6f0002i0al",
      "0,1,0 own",
      "231",
      2,
      false,
    )
  ];
  [@css
    ("._a_7sx8z6{margin-trim:none;}", "_a_7sx8z6", "0,1,0 own", "280", 1, false)
  ];
  [@css
    (
      "._a_7s8oi1{margin-trim:in-flow;}",
      "_a_7s8oi1",
      "0,1,0 own",
      "280",
      1,
      false,
    )
  ];
  [@css
    ("._a_7sk011{margin-trim:all;}", "_a_7sk011", "0,1,0 own", "280", 1, false)
  ];
  [@css.blocks
    [
      (2, "", [0]),
      (3, "", [1]),
      (4, "", [2]),
      (5, "", [3]),
      (6, "", [4]),
      (7, "", [5]),
      (8, "", [6]),
      (9, "", [7]),
      (10, "", [8]),
      (11, "", [9]),
      (12, "", [10]),
      (13, "", [11]),
      (14, "", [12]),
      (15, "", [13]),
      (16, "", [14]),
      (17, "", [15]),
      (18, "", [16]),
      (19, "", [17]),
      (20, "", [18]),
      (21, "", [19]),
      (22, "", [20]),
      (23, "", [21]),
      (24, "", [22]),
      (25, "", [23]),
      (26, "", [24]),
      (27, "", [25]),
      (28, "", [26]),
      (29, "", [27]),
      (30, "", [28]),
      (31, "", [29]),
      (32, "", [30]),
      (33, "", [31]),
      (34, "", [32]),
      (35, "", [33]),
      (36, "", [34]),
      (37, "", [35]),
      (38, "", [36]),
      (39, "", [37]),
      (40, "", [38]),
      (41, "", [39]),
      (42, "", [40]),
      (43, "", [41]),
      (44, "", [42]),
      (45, "", [43]),
      (46, "", [44]),
      (47, "", [45]),
      (48, "", [46]),
      (49, "", [47]),
      (50, "", [48]),
      (51, "", [49]),
      (52, "", [50]),
      (53, "", [51]),
      (54, "", [52]),
      (55, "", [53]),
      (56, "", [54]),
      (57, "", [55]),
      (58, "", [56]),
      (59, "", [57]),
      (60, "", [58]),
      (61, "", [59]),
      (62, "", [60]),
      (63, "", [61]),
      (64, "", [62]),
      (65, "", [63]),
      (66, "", [64]),
      (67, "", [65]),
      (68, "", [66]),
      (69, "", [67]),
      (70, "", [68]),
      (71, "", [69]),
      (72, "", [70]),
      (73, "", [71]),
      (74, "", [72]),
      (75, "", [73]),
      (76, "", [74]),
      (77, "", [75]),
      (78, "", [76]),
      (79, "", [77]),
      (80, "", [78]),
      (81, "", [79]),
      (82, "", [80]),
      (83, "", [81]),
      (84, "", [82]),
      (85, "", [83]),
      (86, "", [84]),
      (87, "", [85]),
      (88, "", [86]),
      (89, "", [87]),
      (90, "", [88]),
      (91, "", [89]),
      (92, "", [90]),
      (93, "", [91]),
      (94, "", [92]),
      (95, "", [93]),
      (96, "", [94]),
      (97, "", [95]),
      (98, "", [96]),
      (99, "", [97]),
      (100, "", [98]),
      (101, "", [99]),
      (102, "", [100]),
      (103, "", [101]),
      (104, "", [102]),
      (105, "", [103]),
      (106, "", [104]),
      (107, "", [105]),
      (108, "", [106]),
      (109, "", [107]),
      (110, "", [108]),
      (111, "", [109]),
      (112, "", [110]),
      (113, "", [111]),
      (114, "", [112]),
      (115, "", [113]),
      (116, "", [114]),
      (117, "", [115]),
      (118, "", [116]),
      (119, "", [117]),
      (120, "", [118]),
      (121, "", [119]),
      (122, "", [120]),
      (123, "", [121]),
      (124, "", [122]),
      (125, "", [123]),
      (126, "", [124]),
      (127, "", [125]),
      (128, "", [126]),
      (129, "", [127]),
      (130, "", [128]),
      (131, "", [129]),
      (132, "", [130]),
      (133, "", [131]),
      (134, "", [132]),
      (135, "", [133]),
      (136, "", [134]),
      (137, "", [135]),
      (138, "", [136]),
      (139, "", [137]),
      (140, "", [138]),
      (141, "", [139]),
      (142, "", [140]),
      (143, "", [141]),
      (144, "", [142]),
      (145, "", [143]),
      (146, "", [144]),
      (147, "", [145]),
      (148, "", [146]),
      (149, "", [147]),
      (150, "", [148]),
      (151, "", [149]),
      (152, "", [150]),
      (153, "", [151]),
      (154, "", [152]),
      (155, "", [153]),
      (156, "", [154]),
      (157, "", [155]),
      (158, "", [156]),
      (159, "", [157]),
      (161, "", [158]),
      (162, "", [159]),
      (163, "", [160]),
      (164, "", [161]),
      (165, "", [162]),
      (166, "", [163]),
      (167, "", [164]),
      (168, "", [165]),
      (169, "", [166]),
      (172, "", [167]),
      (173, "", [168]),
      (174, "", [169]),
    ]
  ];
  
  CSS.make("_a_9j0001lqh0", []);
  CSS.make("_a_9j00015str", []);
  CSS.make("_a_9j0001qoy4", []);
  CSS.make("_a_9j0001wum8", []);
  CSS.make("_a_9j00012ze6", []);
  CSS.make("_a_9j00010zg2", []);
  CSS.make("_a_9j0001e9xz", []);
  CSS.make("_a_9j0001ehcy", []);
  CSS.make("_a_9j0001qp3k", []);
  CSS.make("_a_9j0001bvnc", []);
  CSS.make("_a_9j0001hf65", []);
  CSS.make("_a_9j0001gsxr", []);
  CSS.make("_a_9j0001q3l2", []);
  CSS.make("_a_9i00017rk4", []);
  CSS.make("_a_9i00011ack", []);
  CSS.make("_a_9i0001jl3a", []);
  CSS.make("_a_9i00013wj4", []);
  CSS.make("_a_9i0001r88q", []);
  CSS.make("_a_9i0001xndt", []);
  CSS.make("_a_9i0001qn8b", []);
  CSS.make("_a_9i000112ai", []);
  CSS.make("_a_9i0001mgp6", []);
  CSS.make("_a_9i0001yf6q", []);
  CSS.make("_a_9i0001n9n2", []);
  CSS.make("_a_9i00018fld", []);
  CSS.make("_a_9h000182qi", []);
  CSS.make("_a_9h0001tf19", []);
  CSS.make("_a_9h0001e56e", []);
  CSS.make("_a_9h0001bvxk", []);
  CSS.make("_a_9h0001t6ef", []);
  CSS.make("_a_9h0001ulzr", []);
  CSS.make("_a_9h0001zzqp", []);
  CSS.make("_a_9h0001sg0i", []);
  CSS.make("_a_9h0001ho4p", []);
  CSS.make("_a_9h000162g1", []);
  CSS.make("_a_9h0001otui", []);
  CSS.make("_a_9h0001vgc7", []);
  CSS.make("_a_9h0001x96o", []);
  CSS.make("_a_9h00016jw8", []);
  CSS.make("_a_9h00012jhg", []);
  CSS.make("_a_9j0002nscv", []);
  CSS.make("_a_9j00020v6u", []);
  CSS.make("_a_9j0002yvex", []);
  CSS.make("_a_9j00023z27", []);
  CSS.make("_a_9j00025zq0", []);
  CSS.make("_a_9j00020186", []);
  CSS.make("_a_9j0002dfjc", []);
  CSS.make("_a_9j0002bxzs", []);
  CSS.make("_a_9j0002pv54", []);
  CSS.make("_a_9j0002ab6k", []);
  CSS.make("_a_9j0002zxgz", []);
  CSS.make("_a_9j0002obw4", []);
  CSS.make("_a_9j00025sda", []);
  CSS.make("_a_9j00024swf", []);
  CSS.make("_a_9j00025rli", []);
  CSS.make("_a_9j0002akos", []);
  CSS.make("_a_9i0002t02p", []);
  CSS.make("_a_9i0002w19q", []);
  CSS.make("_a_9i0002sd3r", []);
  CSS.make("_a_9i0002oxkb", []);
  CSS.make("_a_9i0002nqwq", []);
  CSS.make("_a_9i0002hncw", []);
  CSS.make("_a_9i00027xd1", []);
  CSS.make("_a_9i0002d6ik", []);
  CSS.make("_a_9i0002ujby", []);
  CSS.make("_a_9i0002jls5", []);
  CSS.make("_a_9i0002kxpa", []);
  CSS.make("_a_9i0002igov", []);
  CSS.make("_a_9i0002hueq", []);
  CSS.make("_a_9i0002tw7a", []);
  CSS.make("_a_9i0002zryg", []);
  CSS.make("_a_9i0002qp4r", []);
  CSS.make("_a_9i00026jur", []);
  CSS.make("_a_9i00021n9p", []);
  CSS.make("_a_9i00028x1c", []);
  CSS.make("_a_9h0002dm5u", []);
  CSS.make("_a_9h0002dmss", []);
  CSS.make("_a_9h00024oss", []);
  CSS.make("_a_9h0002462w", []);
  CSS.make("_a_9h000208ak", []);
  CSS.make("_a_9h0002ndxa", []);
  CSS.make("_a_9h0002xozo", []);
  CSS.make("_a_9h0002rfkc", []);
  CSS.make("_a_9h00020841", []);
  CSS.make("_a_9h0002getn", []);
  CSS.make("_a_9h0002ygzb", []);
  CSS.make("_a_9h0002pp7h", []);
  CSS.make("_a_9h0002dmac", []);
  CSS.make("_a_9h0002jo9q", []);
  CSS.make("_a_9h000289l6", []);
  CSS.make("_a_9hqrgx", []);
  CSS.make("_a_9hzktz", []);
  CSS.make("_a_9h0k3s", []);
  CSS.make("_a_9hlpj3", []);
  CSS.make("_a_9hg07y", []);
  CSS.make("_a_9hn9tt", []);
  CSS.make("_a_9h8p3p", []);
  CSS.make("_a_9hwium", []);
  CSS.make("_a_9hdqw8", []);
  CSS.make("_a_9h5dhv", []);
  CSS.make("_a_9hnyc7", []);
  CSS.make("_a_9hdrdu", []);
  CSS.make("_a_9hnttj", []);
  CSS.make("_a_9h71ck", []);
  CSS.make("_a_9hqxqj", []);
  CSS.make("_a_9h3qoo", []);
  CSS.make("_a_9hnuac", []);
  CSS.make("_a_9h0fds", []);
  CSS.make("_a_9hhpg7", []);
  CSS.make("_a_9hzrg5", []);
  CSS.make("_a_9hz0tb", []);
  CSS.make("_a_9hi3io", []);
  CSS.make("_a_9hfbzg", []);
  CSS.make("_a_9h8zlv", []);
  CSS.make("_a_9h4shn", []);
  CSS.make("_a_9hf3b8", []);
  CSS.make("_a_9hb47q", []);
  CSS.make("_a_9hwp5i", []);
  CSS.make("_a_9hpafp", []);
  CSS.make("_a_9htr2b", []);
  CSS.make("_a_9hhl56", []);
  CSS.make("_a_9h288f", []);
  CSS.make("_a_9iu5yn", []);
  CSS.make("_a_9iwgtc", []);
  CSS.make("_a_9ip3r0", []);
  CSS.make("_a_9ijtjp", []);
  CSS.make("_a_9imap8", []);
  CSS.make("_a_9iym04", []);
  CSS.make("_a_9icea0", []);
  CSS.make("_a_9iqbga", []);
  CSS.make("_a_9icfae", []);
  CSS.make("_a_9i4r6c", []);
  CSS.make("_a_9ik81w", []);
  CSS.make("_a_9iboah", []);
  CSS.make("_a_9ioh71", []);
  CSS.make("_a_9ivk8n", []);
  CSS.make("_a_9im489", []);
  CSS.make("_a_9ibjab", []);
  CSS.make("_a_9iz5p3", []);
  CSS.make("_a_9i2at7", []);
  CSS.make("_a_9i9qwi", []);
  CSS.make("_a_9ig7oz", []);
  CSS.make("_a_9iecxz", []);
  CSS.make("_a_9idtd3", []);
  CSS.make("_a_9itjgd", []);
  CSS.make("_a_9i24mg", []);
  CSS.make("_a_9infmq", []);
  CSS.make("_a_9i203s", []);
  CSS.make("_a_9iq0j0", []);
  CSS.make("_a_9isgia", []);
  CSS.make("_a_9i5oxa", []);
  CSS.make("_a_9if3bh", []);
  CSS.make("_a_9io9xj", []);
  CSS.make("_a_9iaufw", []);
  CSS.make("_a_9i4fdy", []);
  CSS.make("_a_9ilg27", []);
  CSS.make("_a_9i6nyr", []);
  CSS.make("_a_9isbzm", []);
  
  CSS.make("_a_6f9awh", []);
  CSS.make("_a_6f0ra0", []);
  CSS.make("_a_6f6cki", []);
  CSS.make("_a_6fkubh", []);
  CSS.make("_a_6f0001zqln", []);
  CSS.make("_a_6f00012mee", []);
  CSS.make("_a_6f00015ixr", []);
  CSS.make("_a_6f00022sqe", []);
  CSS.make("_a_6f0002i0al", []);
  
  CSS.make("_a_7sx8z6", []);
  CSS.make("_a_7s8oi1", []);
  CSS.make("_a_7sk011", []);
