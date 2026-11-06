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

  $ dune describe pp ./input.re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      hidden_include_dirs: [],
      load_path: ([], []),
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      no_alias_deps: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  [@css "@keyframes keyframe-m6pt8e{0%{opacity:0;}100%{opacity:1;}}"];
  [@css
    "@keyframes keyframe-kuv9ix{0%{height:var(--previous-135wur0);}100%{height:var(--current-18ewl8i);}}"
  ];
  [@css.atoms
    [
      (
        "_a41Yktr65",
        ["._a41Yktr65{-webkit-animation-name:random;animation-name:random;}"],
        1,
        0,
        1,
        [("value", "Yktr65", "val\\041\\0& | \\0animation-name:random")],
      ),
      (
        "_a41EG7CHb",
        [
          "._a41EG7CHb{-webkit-animation-name:foo, bar;animation-name:foo, bar;}",
        ],
        1,
        0,
        1,
        [("value", "EG7CHb", "val\\041\\0& | \\0animation-name:foo, bar")],
      ),
      (
        "_a41pb_W39",
        [
          "._a41pb_W39{-webkit-animation-name:var(--foo-kzgs4v);animation-name:var(--foo-kzgs4v);}",
        ],
        1,
        0,
        1,
        [("value", "pb_W39", "val\\041\\0& | \\0animation-name:$(foo)")],
      ),
      (
        "_a413DNGbl",
        [
          "._a413DNGbl{-webkit-animation-name:var(--foo-aw7qiu), var(--bar-1ao4wdr);animation-name:var(--foo-aw7qiu), var(--bar-1ao4wdr);}",
        ],
        1,
        0,
        1,
        [
          ("value", "3DNGbl", "val\\041\\0& | \\0animation-name:$(foo), $(bar)"),
        ],
      ),
      (
        "_a3ycN5AXR",
        ["._a3ycN5AXR{-webkit-animation-duration:0s;animation-duration:0s;}"],
        1,
        0,
        1,
        [("value", "cN5AXR", "val\\03y\\0& | \\0animation-duration:0s")],
      ),
      (
        "_a3ynR1W4P",
        ["._a3ynR1W4P{-webkit-animation-duration:1s;animation-duration:1s;}"],
        1,
        0,
        1,
        [("value", "nR1W4P", "val\\03y\\0& | \\0animation-duration:1s")],
      ),
      (
        "_a3yZHQPTl",
        [
          "._a3yZHQPTl{-webkit-animation-duration:100ms;animation-duration:100ms;}",
        ],
        1,
        0,
        1,
        [("value", "ZHQPTl", "val\\03y\\0& | \\0animation-duration:100ms")],
      ),
      (
        "_a3yXqy7C8",
        [
          "._a3yXqy7C8{-webkit-animation-duration:1.64s, 15.22s;animation-duration:1.64s, 15.22s;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Xqy7C8",
            "val\\03y\\0& | \\0animation-duration:1.64s, 15.22s",
          ),
        ],
      ),
      (
        "_a3yMOxMmH",
        [
          "._a3yMOxMmH{-webkit-animation-duration:10s, 35s, 230ms;animation-duration:10s, 35s, 230ms;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "MOxMmH",
            "val\\03y\\0& | \\0animation-duration:10s, 35s, 230ms",
          ),
        ],
      ),
      (
        "_a473MgvcY",
        [
          "._a473MgvcY{-webkit-animation-timing-function:ease;animation-timing-function:ease;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "3MgvcY",
            "val\\047\\0& | \\0animation-timing-function:ease",
          ),
        ],
      ),
      (
        "_a47jzj-lc",
        [
          "._a47jzj-lc{-webkit-animation-timing-function:linear;animation-timing-function:linear;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "jzj-lc",
            "val\\047\\0& | \\0animation-timing-function:linear",
          ),
        ],
      ),
      (
        "_a47l5w5mr",
        [
          "._a47l5w5mr{-webkit-animation-timing-function:ease-in;animation-timing-function:ease-in;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "l5w5mr",
            "val\\047\\0& | \\0animation-timing-function:ease-in",
          ),
        ],
      ),
      (
        "_a47qMTKlm",
        [
          "._a47qMTKlm{-webkit-animation-timing-function:ease-out;animation-timing-function:ease-out;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "qMTKlm",
            "val\\047\\0& | \\0animation-timing-function:ease-out",
          ),
        ],
      ),
      (
        "_a47-aNHbU",
        [
          "._a47-aNHbU{-webkit-animation-timing-function:ease-in-out;animation-timing-function:ease-in-out;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "-aNHbU",
            "val\\047\\0& | \\0animation-timing-function:ease-in-out",
          ),
        ],
      ),
      (
        "_a47G-s3QQ",
        [
          "._a47G-s3QQ{-webkit-animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "G-s3QQ",
            "val\\047\\0& | \\0animation-timing-function:cubic-bezier(0.5, 0.5, 0.5, 0.5)",
          ),
        ],
      ),
      (
        "_a47XVlY2i",
        [
          "._a47XVlY2i{-webkit-animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "XVlY2i",
            "val\\047\\0& | \\0animation-timing-function:cubic-bezier(0.5, 1.5, 0.5, -2.5)",
          ),
        ],
      ),
      (
        "_a47tDwjVP",
        [
          "._a47tDwjVP{-webkit-animation-timing-function:step-start;animation-timing-function:step-start;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "tDwjVP",
            "val\\047\\0& | \\0animation-timing-function:step-start",
          ),
        ],
      ),
      (
        "_a47rOfa1t",
        [
          "._a47rOfa1t{-webkit-animation-timing-function:step-end;animation-timing-function:step-end;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "rOfa1t",
            "val\\047\\0& | \\0animation-timing-function:step-end",
          ),
        ],
      ),
      (
        "_a47ETEIWe",
        [
          "._a47ETEIWe{-webkit-animation-timing-function:steps(3, start);animation-timing-function:steps(3, start);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ETEIWe",
            "val\\047\\0& | \\0animation-timing-function:steps(3, start)",
          ),
        ],
      ),
      (
        "_a47jGjXeL",
        [
          "._a47jGjXeL{-webkit-animation-timing-function:steps(5, end);animation-timing-function:steps(5, end);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "jGjXeL",
            "val\\047\\0& | \\0animation-timing-function:steps(5, end)",
          ),
        ],
      ),
      (
        "_a47DZ82uT",
        [
          "._a47DZ82uT{-webkit-animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "DZ82uT",
            "val\\047\\0& | \\0animation-timing-function:ease, step-start, cubic-bezier(0.1, 0.7, 1, 0.1)",
          ),
        ],
      ),
      (
        "_a40zCX-K1",
        [
          "._a40zCX-K1{-webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "zCX-K1",
            "val\\040\\0& | \\0animation-iteration-count:infinite",
          ),
        ],
      ),
      (
        "_a40NE3EGq",
        [
          "._a40NE3EGq{-webkit-animation-iteration-count:8;animation-iteration-count:8;}",
        ],
        1,
        0,
        1,
        [("value", "NE3EGq", "val\\040\\0& | \\0animation-iteration-count:8")],
      ),
      (
        "_a404HLFde",
        [
          "._a404HLFde{-webkit-animation-iteration-count:4.35;animation-iteration-count:4.35;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "4HLFde",
            "val\\040\\0& | \\0animation-iteration-count:4.35",
          ),
        ],
      ),
      (
        "_a40RbIpnX",
        [
          "._a40RbIpnX{-webkit-animation-iteration-count:2, 0, infinite;animation-iteration-count:2, 0, infinite;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "RbIpnX",
            "val\\040\\0& | \\0animation-iteration-count:2, 0, infinite",
          ),
        ],
      ),
      (
        "_a3x_6x3_w",
        [
          "._a3x_6x3_w{-webkit-animation-direction:normal;animation-direction:normal;}",
        ],
        1,
        0,
        1,
        [("value", "_6x3_w", "val\\03x\\0& | \\0animation-direction:normal")],
      ),
      (
        "_a3x26HiC5",
        [
          "._a3x26HiC5{-webkit-animation-direction:alternate;animation-direction:alternate;}",
        ],
        1,
        0,
        1,
        [
          ("value", "26HiC5", "val\\03x\\0& | \\0animation-direction:alternate"),
        ],
      ),
      (
        "_a3xYrH_nK",
        [
          "._a3xYrH_nK{-webkit-animation-direction:reverse;animation-direction:reverse;}",
        ],
        1,
        0,
        1,
        [("value", "YrH_nK", "val\\03x\\0& | \\0animation-direction:reverse")],
      ),
      (
        "_a3xxlktH9",
        [
          "._a3xxlktH9{-webkit-animation-direction:alternate-reverse;animation-direction:alternate-reverse;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "xlktH9",
            "val\\03x\\0& | \\0animation-direction:alternate-reverse",
          ),
        ],
      ),
      (
        "_a3xMN1fxs",
        [
          "._a3xMN1fxs{-webkit-animation-direction:normal, reverse;animation-direction:normal, reverse;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "MN1fxs",
            "val\\03x\\0& | \\0animation-direction:normal, reverse",
          ),
        ],
      ),
      (
        "_a3xcOlTlw",
        [
          "._a3xcOlTlw{-webkit-animation-direction:alternate, reverse, normal;animation-direction:alternate, reverse, normal;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "cOlTlw",
            "val\\03x\\0& | \\0animation-direction:alternate, reverse, normal",
          ),
        ],
      ),
      (
        "_a42qHbpk9",
        [
          "._a42qHbpk9{-webkit-animation-play-state:running;animation-play-state:running;}",
        ],
        1,
        0,
        1,
        [
          ("value", "qHbpk9", "val\\042\\0& | \\0animation-play-state:running"),
        ],
      ),
      (
        "_a42ZDROVB",
        [
          "._a42ZDROVB{-webkit-animation-play-state:paused;animation-play-state:paused;}",
        ],
        1,
        0,
        1,
        [("value", "ZDROVB", "val\\042\\0& | \\0animation-play-state:paused")],
      ),
      (
        "_a42roEwHy",
        [
          "._a42roEwHy{-webkit-animation-play-state:paused, running, running;animation-play-state:paused, running, running;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "roEwHy",
            "val\\042\\0& | \\0animation-play-state:paused, running, running",
          ),
        ],
      ),
      (
        "_a3uvV6ZgB",
        ["._a3uvV6ZgB{-webkit-animation-delay:1s;animation-delay:1s;}"],
        1,
        0,
        1,
        [("value", "vV6ZgB", "val\\03u\\0& | \\0animation-delay:1s")],
      ),
      (
        "_a3udune7m",
        ["._a3udune7m{-webkit-animation-delay:-1s;animation-delay:-1s;}"],
        1,
        0,
        1,
        [("value", "dune7m", "val\\03u\\0& | \\0animation-delay:-1s")],
      ),
      (
        "_a3u4xYa-q",
        [
          "._a3u4xYa-q{-webkit-animation-delay:2.1s, 480ms;animation-delay:2.1s, 480ms;}",
        ],
        1,
        0,
        1,
        [("value", "4xYa-q", "val\\03u\\0& | \\0animation-delay:2.1s, 480ms")],
      ),
      (
        "_a3zk8OlDi",
        [
          "._a3zk8OlDi{-webkit-animation-fill-mode:none;animation-fill-mode:none;}",
        ],
        1,
        0,
        1,
        [("value", "k8OlDi", "val\\03z\\0& | \\0animation-fill-mode:none")],
      ),
      (
        "_a3zEpRKbp",
        [
          "._a3zEpRKbp{-webkit-animation-fill-mode:forwards;animation-fill-mode:forwards;}",
        ],
        1,
        0,
        1,
        [
          ("value", "EpRKbp", "val\\03z\\0& | \\0animation-fill-mode:forwards"),
        ],
      ),
      (
        "_a3zqMOkPk",
        [
          "._a3zqMOkPk{-webkit-animation-fill-mode:backwards;animation-fill-mode:backwards;}",
        ],
        1,
        0,
        1,
        [
          ("value", "qMOkPk", "val\\03z\\0& | \\0animation-fill-mode:backwards"),
        ],
      ),
      (
        "_a3zSQM1U0",
        [
          "._a3zSQM1U0{-webkit-animation-fill-mode:both;animation-fill-mode:both;}",
        ],
        1,
        0,
        1,
        [("value", "SQM1U0", "val\\03z\\0& | \\0animation-fill-mode:both")],
      ),
      (
        "_a3z4BQoO_",
        [
          "._a3z4BQoO_{-webkit-animation-fill-mode:both, forwards, none;animation-fill-mode:both, forwards, none;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "4BQoO_",
            "val\\03z\\0& | \\0animation-fill-mode:both, forwards, none",
          ),
        ],
      ),
      (
        "_a3sg7lz4l",
        [
          "._a3sg7lz4l{-webkit-animation:foo 1s 2s infinite linear alternate both;animation:foo 1s 2s infinite linear alternate both;}",
        ],
        1,
        0,
        11,
        [
          (
            "value",
            "g7lz4l",
            "val\\03s\\0& | \\0animation:foo 1s 2s infinite linear alternate both",
          ),
        ],
      ),
      (
        "_a3soDlqQ1",
        [
          "._a3soDlqQ1{-webkit-animation:4s ease-in 1s infinite reverse both paused;animation:4s ease-in 1s infinite reverse both paused;}",
        ],
        1,
        0,
        11,
        [
          (
            "value",
            "oDlqQ1",
            "val\\03s\\0& | \\0animation:4s ease-in 1s infinite reverse both paused",
          ),
        ],
      ),
      (
        "_a3sBO3gdd",
        [
          "._a3sBO3gdd{-webkit-animation:a 300ms linear 400ms infinite reverse forwards running;animation:a 300ms linear 400ms infinite reverse forwards running;}",
        ],
        1,
        0,
        11,
        [
          (
            "value",
            "BO3gdd",
            "val\\03s\\0& | \\0animation:a 300ms linear 400ms infinite reverse forwards running",
          ),
        ],
      ),
      (
        "_a41GqDIUS",
        [
          "._a41GqDIUS{-webkit-animation-name:var(--resize-pig2un);animation-name:var(--resize-pig2un);}",
        ],
        1,
        0,
        1,
        [("value", "GqDIUS", "val\\041\\0& | \\0animation-name:$(resize)")],
      ),
      (
        "_a3sMsXYHM",
        [
          "._a3sMsXYHM{-webkit-animation:var(--resize-ken5nx) 180ms ease-out 0s 1 normal both;animation:var(--resize-ken5nx) 180ms ease-out 0s 1 normal both;}",
        ],
        1,
        0,
        11,
        [
          (
            "value",
            "MsXYHM",
            "val\\03s\\0& | \\0animation:$(resize) 180ms ease-out 0s 1 normal both",
          ),
        ],
      ),
    ]
  ];
  let foo = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  let bar = CSS.Types.AnimationName.make("keyframe-m6pt8e");
  
  CSS.make("_a41Yktr65", []);
  CSS.make("_a41EG7CHb", []);
  CSS.make(
    "_a41pb_W39",
    CSS.Types.AnimationName.toStyleVars("--foo-kzgs4v", foo),
  );
  CSS.make(
    "_a413DNGbl",
    CSS.Types.AnimationName.toStyleVars("--foo-aw7qiu", foo)
    @ CSS.Types.AnimationName.toStyleVars("--bar-1ao4wdr", bar),
  );
  CSS.make("_a3ycN5AXR", []);
  CSS.make("_a3ynR1W4P", []);
  CSS.make("_a3yZHQPTl", []);
  CSS.make("_a3yXqy7C8", []);
  CSS.make("_a3yMOxMmH", []);
  CSS.make("_a473MgvcY", []);
  CSS.make("_a47jzj-lc", []);
  CSS.make("_a47l5w5mr", []);
  CSS.make("_a47qMTKlm", []);
  CSS.make("_a47-aNHbU", []);
  CSS.make("_a47G-s3QQ", []);
  CSS.make("_a47XVlY2i", []);
  CSS.make("_a47tDwjVP", []);
  CSS.make("_a47rOfa1t", []);
  CSS.make("_a47ETEIWe", []);
  CSS.make("_a47jGjXeL", []);
  CSS.make("_a47DZ82uT", []);
  CSS.make("_a40zCX-K1", []);
  CSS.make("_a40NE3EGq", []);
  CSS.make("_a404HLFde", []);
  CSS.make("_a40RbIpnX", []);
  CSS.make("_a3x_6x3_w", []);
  CSS.make("_a3x26HiC5", []);
  CSS.make("_a3xYrH_nK", []);
  CSS.make("_a3xxlktH9", []);
  CSS.make("_a3xMN1fxs", []);
  CSS.make("_a3xcOlTlw", []);
  CSS.make("_a42qHbpk9", []);
  CSS.make("_a42ZDROVB", []);
  CSS.make("_a42roEwHy", []);
  CSS.make("_a3uvV6ZgB", []);
  CSS.make("_a3udune7m", []);
  CSS.make("_a3u4xYa-q", []);
  CSS.make("_a3zk8OlDi", []);
  CSS.make("_a3zEpRKbp", []);
  CSS.make("_a3zqMOkPk", []);
  CSS.make("_a3zSQM1U0", []);
  CSS.make("_a3z4BQoO_", []);
  CSS.make("_a3sg7lz4l", []);
  CSS.make("_a3soDlqQ1", []);
  CSS.make("_a3sBO3gdd", []);
  
  let previousHeight = 20;
  let currentHeight = 80;
  let previous = `px(previousHeight);
  let current = `px(currentHeight);
  let resize =
    CSS.Types.AnimationName.make(
      ~vars=[
        ("--previous-135wur0", CSS.Types.Height.toString(previous)),
        ("--current-18ewl8i", CSS.Types.Height.toString(current)),
      ],
      "keyframe-kuv9ix",
    );
  
  CSS.make(
    "_a41GqDIUS",
    CSS.Types.AnimationName.toStyleVars("--resize-pig2un", resize),
  );
  CSS.make(
    "_a3sMsXYHM",
    CSS.Types.AnimationName.toStyleVars("--resize-ken5nx", resize),
  );
