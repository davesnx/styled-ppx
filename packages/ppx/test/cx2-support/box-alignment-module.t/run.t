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
    ".css-28lqh0{align-self:auto;}\n.css-1oa5str{align-self:normal;}\n.css-fzqoy4{align-self:stretch;}\n.css-chwum8{align-self:baseline;}\n.css-1lz2ze6{align-self:first baseline;}\n.css-ko0zg2{align-self:last baseline;}\n.css-hoe9xz{align-self:center;}\n.css-1hcehcy{align-self:start;}\n.css-1fuqp3k{align-self:end;}\n.css-sobvnc{align-self:self-start;}\n.css-6bhf65{align-self:self-end;}\n.css-lsgsxr{align-self:unsafe start;}\n.css-n6q3l2{align-self:safe start;}\n.css-1l47rk4{align-items:normal;}\n.css-k51ack{align-items:stretch;}\n.css-1y3jl3a{align-items:baseline;}\n.css-1v63wj4{align-items:first baseline;}\n.css-1par88q{align-items:last baseline;}\n.css-zcxndt{align-items:center;}\n.css-thqn8b{align-items:start;}\n.css-h812ai{align-items:end;}\n.css-1iymgp6{align-items:self-start;}\n.css-piyf6q{align-items:self-end;}\n.css-1con9n2{align-items:unsafe start;}\n.css-9x8fld{align-items:safe start;}\n.css-1ph82qi{align-content:normal;}\n.css-m6tf19{align-content:baseline;}\n.css-129e56e{align-content:first baseline;}\n.css-197bvxk{align-content:last baseline;}\n.css-1c5t6ef{align-content:space-between;}\n.css-1okulzr{align-content:space-around;}\n.css-oazzqp{align-content:space-evenly;}\n.css-zssg0i{align-content:stretch;}\n.css-1a5ho4p{align-content:center;}\n.css-zf62g1{align-content:start;}\n.css-1u0otui{align-content:end;}\n.css-1crvgc7{align-content:flex-start;}\n.css-4zx96o{align-content:flex-end;}\n.css-gr6jw8{align-content:unsafe start;}\n.css-5j2jhg{align-content:safe start;}\n.css-mxnscv{justify-self:auto;}\n.css-9a0v6u{justify-self:normal;}\n.css-1j4yvex{justify-self:stretch;}\n.css-ow3z27{justify-self:baseline;}\n.css-1hf5zq0{justify-self:first baseline;}\n.css-18k0186{justify-self:last baseline;}\n.css-tddfjc{justify-self:center;}\n.css-85bxzs{justify-self:start;}\n.css-v1pv54{justify-self:end;}\n.css-rkab6k{justify-self:self-start;}\n.css-e4zxgz{justify-self:self-end;}\n.css-2nobw4{justify-self:unsafe start;}\n.css-le5sda{justify-self:safe start;}\n.css-vv4swf{justify-self:left;}\n.css-9b5rli{justify-self:right;}\n.css-1uhakos{justify-self:safe right;}\n.css-1s3t02p{justify-items:normal;}\n.css-osw19q{justify-items:stretch;}\n.css-178sd3r{justify-items:baseline;}\n.css-g3oxkb{justify-items:first baseline;}\n.css-1d1nqwq{justify-items:last baseline;}\n.css-hghncw{justify-items:center;}\n.css-g27xd1{justify-items:start;}\n.css-c4d6ik{justify-items:end;}\n.css-1rxujby{justify-items:self-start;}\n.css-1npjls5{justify-items:self-end;}\n.css-1lfkxpa{justify-items:unsafe start;}\n.css-u1igov{justify-items:safe start;}\n.css-5whueq{justify-items:left;}\n.css-butw7a{justify-items:right;}\n.css-1uhzryg{justify-items:safe right;}\n.css-1phqp4r{justify-items:legacy;}\n.css-6d6jur{justify-items:legacy left;}\n.css-av1n9p{justify-items:legacy right;}\n.css-b18x1c{justify-items:legacy center;}\n.css-18dm5u{justify-content:normal;}\n.css-x4dmss{justify-content:space-between;}\n.css-kp4oss{justify-content:space-around;}\n.css-1ku462w{justify-content:space-evenly;}\n.css-x208ak{justify-content:stretch;}\n.css-1tyndxa{justify-content:center;}\n.css-k1xozo{justify-content:start;}\n.css-1b1rfkc{justify-content:end;}\n.css-1fn0841{justify-content:flex-start;}\n.css-1a9getn{justify-content:flex-end;}\n.css-t0ygzb{justify-content:unsafe start;}\n.css-1d6pp7h{justify-content:safe start;}\n.css-d5dmac{justify-content:left;}\n.css-dajo9q{justify-content:right;}\n.css-vp89l6{justify-content:safe right;}\n.css-6lqrgx{place-content:normal;}\n.css-1k2zktz{place-content:baseline;}\n.css-kd0k3s{place-content:first baseline;}\n.css-123lpj3{place-content:last baseline;}\n.css-1jag07y{place-content:space-between;}\n.css-fhn9tt{place-content:space-around;}\n.css-1lz8p3p{place-content:space-evenly;}\n.css-auwium{place-content:stretch;}\n.css-gdqw8{place-content:center;}\n.css-16c5dhv{place-content:start;}\n.css-16pnyc7{place-content:end;}\n.css-tdrdu{place-content:flex-start;}\n.css-1v2nttj{place-content:flex-end;}\n.css-bj71ck{place-content:unsafe start;}\n.css-1u7qxqj{place-content:safe start;}\n.css-yo3qoo{place-content:normal normal;}\n.css-ednuac{place-content:baseline normal;}\n.css-1ly0fds{place-content:first baseline normal;}\n.css-1lnhpg7{place-content:space-between normal;}\n.css-6kzrg5{place-content:center normal;}\n.css-ccz0tb{place-content:unsafe start normal;}\n.css-pgi3io{place-content:normal stretch;}\n.css-e1fbzg{place-content:baseline stretch;}\n.css-hf8zlv{place-content:first baseline stretch;}\n.css-1tb4shn{place-content:center stretch;}\n.css-1ogf3b8{place-content:unsafe start stretch;}\n.css-11cb47q{place-content:normal safe right;}\n.css-1e2wp5i{place-content:baseline safe right;}\n.css-1s7pafp{place-content:first baseline safe right;}\n.css-1phtr2b{place-content:space-between safe right;}\n.css-m6hl56{place-content:center safe right;}\n.css-ys288f{place-content:unsafe start safe right;}\n.css-o9u5yn{place-items:normal;}\n.css-dnwgtc{place-items:stretch;}\n.css-yzp3r0{place-items:baseline;}\n.css-u3jtjp{place-items:first baseline;}\n.css-nbmap8{place-items:last baseline;}\n.css-yoym04{place-items:center;}\n.css-racea0{place-items:start;}\n.css-16qqbga{place-items:end;}\n.css-1v9cfae{place-items:self-start;}\n.css-ji4r6c{place-items:self-end;}\n.css-11xk81w{place-items:unsafe start;}\n.css-uhboah{place-items:safe start;}\n.css-117oh71{place-items:normal normal;}\n.css-1mvk8n{place-items:stretch normal;}\n.css-162m489{place-items:baseline normal;}\n.css-11lbjab{place-items:first baseline normal;}\n.css-bdz5p3{place-items:self-start normal;}\n.css-pd2at7{place-items:unsafe start normal;}\n.css-1rt9qwi{place-items:normal stretch;}\n.css-qg7oz{place-items:stretch stretch;}\n.css-asecxz{place-items:baseline stretch;}\n.css-gndtd3{place-items:first baseline stretch;}\n.css-12jtjgd{place-items:self-start stretch;}\n.css-b824mg{place-items:unsafe start stretch;}\n.css-11znfmq{place-items:normal last baseline;}\n.css-u7203s{place-items:stretch last baseline;}\n.css-tbq0j0{place-items:baseline last baseline;}\n.css-1xqsgia{place-items:first baseline last baseline;}\n.css-x25oxa{place-items:self-start last baseline;}\n.css-8rf3bh{place-items:unsafe start last baseline;}\n.css-x3o9xj{place-items:normal legacy left;}\n.css-yuaufw{place-items:stretch legacy left;}\n.css-19o4fdy{place-items:baseline legacy left;}\n.css-1allg27{place-items:first baseline legacy left;}\n.css-1um6nyr{place-items:self-start legacy left;}\n.css-1ogsbzm{place-items:unsafe start legacy left;}\n.css-z39awh{gap:0 0;}\n.css-1m20ra0{gap:0 1em;}\n.css-bd6cki{gap:1em;}\n.css-f0kubh{gap:1em 1em;}\n.css-zqzqln{column-gap:0;}\n.css-602mee{column-gap:1em;}\n.css-mz5ixr{column-gap:normal;}\n.css-1j42sqe{row-gap:0;}\n.css-28i0al{row-gap:1em;}\n.css-xyx8z6{margin-trim:none;}\n.css-s28oi1{margin-trim:in-flow;}\n.css-1fk011{margin-trim:all;}\n"
  ];
  
  CSS.make("css-28lqh0", []);
  CSS.make("css-1oa5str", []);
  CSS.make("css-fzqoy4", []);
  CSS.make("css-chwum8", []);
  CSS.make("css-1lz2ze6", []);
  CSS.make("css-ko0zg2", []);
  CSS.make("css-hoe9xz", []);
  CSS.make("css-1hcehcy", []);
  CSS.make("css-1fuqp3k", []);
  CSS.make("css-sobvnc", []);
  CSS.make("css-6bhf65", []);
  CSS.make("css-lsgsxr", []);
  CSS.make("css-n6q3l2", []);
  CSS.make("css-1l47rk4", []);
  CSS.make("css-k51ack", []);
  CSS.make("css-1y3jl3a", []);
  CSS.make("css-1v63wj4", []);
  CSS.make("css-1par88q", []);
  CSS.make("css-zcxndt", []);
  CSS.make("css-thqn8b", []);
  CSS.make("css-h812ai", []);
  CSS.make("css-1iymgp6", []);
  CSS.make("css-piyf6q", []);
  CSS.make("css-1con9n2", []);
  CSS.make("css-9x8fld", []);
  CSS.make("css-1ph82qi", []);
  CSS.make("css-m6tf19", []);
  CSS.make("css-129e56e", []);
  CSS.make("css-197bvxk", []);
  CSS.make("css-1c5t6ef", []);
  CSS.make("css-1okulzr", []);
  CSS.make("css-oazzqp", []);
  CSS.make("css-zssg0i", []);
  CSS.make("css-1a5ho4p", []);
  CSS.make("css-zf62g1", []);
  CSS.make("css-1u0otui", []);
  CSS.make("css-1crvgc7", []);
  CSS.make("css-4zx96o", []);
  CSS.make("css-gr6jw8", []);
  CSS.make("css-5j2jhg", []);
  CSS.make("css-mxnscv", []);
  CSS.make("css-9a0v6u", []);
  CSS.make("css-1j4yvex", []);
  CSS.make("css-ow3z27", []);
  CSS.make("css-1hf5zq0", []);
  CSS.make("css-18k0186", []);
  CSS.make("css-tddfjc", []);
  CSS.make("css-85bxzs", []);
  CSS.make("css-v1pv54", []);
  CSS.make("css-rkab6k", []);
  CSS.make("css-e4zxgz", []);
  CSS.make("css-2nobw4", []);
  CSS.make("css-le5sda", []);
  CSS.make("css-vv4swf", []);
  CSS.make("css-9b5rli", []);
  CSS.make("css-1uhakos", []);
  CSS.make("css-1s3t02p", []);
  CSS.make("css-osw19q", []);
  CSS.make("css-178sd3r", []);
  CSS.make("css-g3oxkb", []);
  CSS.make("css-1d1nqwq", []);
  CSS.make("css-hghncw", []);
  CSS.make("css-g27xd1", []);
  CSS.make("css-c4d6ik", []);
  CSS.make("css-1rxujby", []);
  CSS.make("css-1npjls5", []);
  CSS.make("css-1lfkxpa", []);
  CSS.make("css-u1igov", []);
  CSS.make("css-5whueq", []);
  CSS.make("css-butw7a", []);
  CSS.make("css-1uhzryg", []);
  CSS.make("css-1phqp4r", []);
  CSS.make("css-6d6jur", []);
  CSS.make("css-av1n9p", []);
  CSS.make("css-b18x1c", []);
  CSS.make("css-18dm5u", []);
  CSS.make("css-x4dmss", []);
  CSS.make("css-kp4oss", []);
  CSS.make("css-1ku462w", []);
  CSS.make("css-x208ak", []);
  CSS.make("css-1tyndxa", []);
  CSS.make("css-k1xozo", []);
  CSS.make("css-1b1rfkc", []);
  CSS.make("css-1fn0841", []);
  CSS.make("css-1a9getn", []);
  CSS.make("css-t0ygzb", []);
  CSS.make("css-1d6pp7h", []);
  CSS.make("css-d5dmac", []);
  CSS.make("css-dajo9q", []);
  CSS.make("css-vp89l6", []);
  CSS.make("css-6lqrgx", []);
  CSS.make("css-1k2zktz", []);
  CSS.make("css-kd0k3s", []);
  CSS.make("css-123lpj3", []);
  CSS.make("css-1jag07y", []);
  CSS.make("css-fhn9tt", []);
  CSS.make("css-1lz8p3p", []);
  CSS.make("css-auwium", []);
  CSS.make("css-gdqw8", []);
  CSS.make("css-16c5dhv", []);
  CSS.make("css-16pnyc7", []);
  CSS.make("css-tdrdu", []);
  CSS.make("css-1v2nttj", []);
  CSS.make("css-bj71ck", []);
  CSS.make("css-1u7qxqj", []);
  CSS.make("css-yo3qoo", []);
  CSS.make("css-ednuac", []);
  CSS.make("css-1ly0fds", []);
  CSS.make("css-1lnhpg7", []);
  CSS.make("css-6kzrg5", []);
  CSS.make("css-ccz0tb", []);
  CSS.make("css-pgi3io", []);
  CSS.make("css-e1fbzg", []);
  CSS.make("css-hf8zlv", []);
  CSS.make("css-1tb4shn", []);
  CSS.make("css-1ogf3b8", []);
  CSS.make("css-11cb47q", []);
  CSS.make("css-1e2wp5i", []);
  CSS.make("css-1s7pafp", []);
  CSS.make("css-1phtr2b", []);
  CSS.make("css-m6hl56", []);
  CSS.make("css-ys288f", []);
  CSS.make("css-o9u5yn", []);
  CSS.make("css-dnwgtc", []);
  CSS.make("css-yzp3r0", []);
  CSS.make("css-u3jtjp", []);
  CSS.make("css-nbmap8", []);
  CSS.make("css-yoym04", []);
  CSS.make("css-racea0", []);
  CSS.make("css-16qqbga", []);
  CSS.make("css-1v9cfae", []);
  CSS.make("css-ji4r6c", []);
  CSS.make("css-11xk81w", []);
  CSS.make("css-uhboah", []);
  CSS.make("css-117oh71", []);
  CSS.make("css-1mvk8n", []);
  CSS.make("css-162m489", []);
  CSS.make("css-11lbjab", []);
  CSS.make("css-bdz5p3", []);
  CSS.make("css-pd2at7", []);
  CSS.make("css-1rt9qwi", []);
  CSS.make("css-qg7oz", []);
  CSS.make("css-asecxz", []);
  CSS.make("css-gndtd3", []);
  CSS.make("css-12jtjgd", []);
  CSS.make("css-b824mg", []);
  CSS.make("css-11znfmq", []);
  CSS.make("css-u7203s", []);
  CSS.make("css-tbq0j0", []);
  CSS.make("css-1xqsgia", []);
  CSS.make("css-x25oxa", []);
  CSS.make("css-8rf3bh", []);
  CSS.make("css-x3o9xj", []);
  CSS.make("css-yuaufw", []);
  CSS.make("css-19o4fdy", []);
  CSS.make("css-1allg27", []);
  CSS.make("css-1um6nyr", []);
  CSS.make("css-1ogsbzm", []);
  
  CSS.make("css-z39awh", []);
  CSS.make("css-1m20ra0", []);
  CSS.make("css-bd6cki", []);
  CSS.make("css-f0kubh", []);
  CSS.make("css-zqzqln", []);
  CSS.make("css-602mee", []);
  CSS.make("css-mz5ixr", []);
  CSS.make("css-1j42sqe", []);
  CSS.make("css-28i0al", []);
  
  CSS.make("css-xyx8z6", []);
  CSS.make("css-s28oi1", []);
  CSS.make("css-1fk011", []);
