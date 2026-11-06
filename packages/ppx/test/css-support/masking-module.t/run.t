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
  [@css.atoms
    [
      (
        "_a7dFhXCJE",
        [
          "._a7dFhXCJE{-webkit-clip-path:url(\"#clip\");clip-path:url(\"#clip\");}",
        ],
        1,
        0,
        1,
        [("value", "FhXCJE", "val\\07d\\0& | \\0clip-path:url(\"#clip\")")],
      ),
      (
        "_a7d9VZcs4",
        ["._a7d9VZcs4{-webkit-clip-path:inset(50%);clip-path:inset(50%);}"],
        1,
        0,
        1,
        [("value", "9VZcs4", "val\\07d\\0& | \\0clip-path:inset(50%)")],
      ),
      (
        "_a7dEBpLxD",
        [
          "._a7dEBpLxD{-webkit-clip-path:path(\"M 20 20 H 80 V 30\");clip-path:path(\"M 20 20 H 80 V 30\");}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "EBpLxD",
            "val\\07d\\0& | \\0clip-path:path(\"M 20 20 H 80 V 30\")",
          ),
        ],
      ),
      (
        "_a7dM47cwg",
        [
          "._a7dM47cwg{-webkit-clip-path:polygon(50% 100%, 0 0, 100% 0);clip-path:polygon(50% 100%, 0 0, 100% 0);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "M47cwg",
            "val\\07d\\0& | \\0clip-path:polygon(50% 100%, 0 0, 100% 0)",
          ),
        ],
      ),
      (
        "_a7dWqL3Rv",
        [
          "._a7dWqL3Rv{-webkit-clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "WqL3Rv",
            "val\\07d\\0& | \\0clip-path:polygon(evenodd, 0% 0%, 50% 50%, 0% 100%)",
          ),
        ],
      ),
      (
        "_a7dZJnWK8",
        [
          "._a7dZJnWK8{-webkit-clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ZJnWK8",
            "val\\07d\\0& | \\0clip-path:polygon(nonzero, 0% 0%, 50% 50%, 0% 100%)",
          ),
        ],
      ),
      (
        "_a7dSPditK",
        ["._a7dSPditK{-webkit-clip-path:border-box;clip-path:border-box;}"],
        1,
        0,
        1,
        [("value", "SPditK", "val\\07d\\0& | \\0clip-path:border-box")],
      ),
      (
        "_a7d7OKpHs",
        ["._a7d7OKpHs{-webkit-clip-path:padding-box;clip-path:padding-box;}"],
        1,
        0,
        1,
        [("value", "7OKpHs", "val\\07d\\0& | \\0clip-path:padding-box")],
      ),
      (
        "_a7dN0M8ek",
        ["._a7dN0M8ek{-webkit-clip-path:content-box;clip-path:content-box;}"],
        1,
        0,
        1,
        [("value", "N0M8ek", "val\\07d\\0& | \\0clip-path:content-box")],
      ),
      (
        "_a7dO39Qtl",
        ["._a7dO39Qtl{-webkit-clip-path:margin-box;clip-path:margin-box;}"],
        1,
        0,
        1,
        [("value", "O39Qtl", "val\\07d\\0& | \\0clip-path:margin-box")],
      ),
      (
        "_a7dTmCUPQ",
        ["._a7dTmCUPQ{-webkit-clip-path:fill-box;clip-path:fill-box;}"],
        1,
        0,
        1,
        [("value", "TmCUPQ", "val\\07d\\0& | \\0clip-path:fill-box")],
      ),
      (
        "_a7d6e-Z5G",
        ["._a7d6e-Z5G{-webkit-clip-path:stroke-box;clip-path:stroke-box;}"],
        1,
        0,
        1,
        [("value", "6e-Z5G", "val\\07d\\0& | \\0clip-path:stroke-box")],
      ),
      (
        "_a7d3Sa0c3",
        ["._a7d3Sa0c3{-webkit-clip-path:view-box;clip-path:view-box;}"],
        1,
        0,
        1,
        [("value", "3Sa0c3", "val\\07d\\0& | \\0clip-path:view-box")],
      ),
      (
        "_a7dI4YNS7",
        ["._a7dI4YNS7{-webkit-clip-path:none;clip-path:none;}"],
        1,
        0,
        1,
        [("value", "I4YNS7", "val\\07d\\0& | \\0clip-path:none")],
      ),
      (
        "_a7eT75exS",
        ["._a7eT75exS{clip-rule:nonzero;}"],
        1,
        0,
        1,
        [("value", "T75exS", "val\\07e\\0& | \\0clip-rule:nonzero")],
      ),
      (
        "_a7eoqqafC",
        ["._a7eoqqafC{clip-rule:evenodd;}"],
        1,
        0,
        1,
        [("value", "oqqafC", "val\\07e\\0& | \\0clip-rule:evenodd")],
      ),
      (
        "_adkZbg-Wr",
        ["._adkZbg-Wr{-webkit-mask-image:none;mask-image:none;}"],
        1,
        0,
        1,
        [("value", "Zbg-Wr", "val\\0dk\\0& | \\0mask-image:none")],
      ),
      (
        "_adkxlUIbZ",
        [
          "._adkxlUIbZ{-webkit-mask-image:linear-gradient(45deg, #333, #000);mask-image:linear-gradient(45deg, #333, #000);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "xlUIbZ",
            "val\\0dk\\0& | \\0mask-image:linear-gradient(45deg, #333, #000)",
          ),
        ],
      ),
      (
        "_adk1VGtMg",
        [
          "._adk1VGtMg{-webkit-mask-image:url(\"image.png\");mask-image:url(\"image.png\");}",
        ],
        1,
        0,
        1,
        [
          ("value", "1VGtMg", "val\\0dk\\0& | \\0mask-image:url(\"image.png\")"),
        ],
      ),
      (
        "_adlPNb_ul",
        ["._adlPNb_ul{-webkit-mask-mode:alpha;mask-mode:alpha;}"],
        1,
        0,
        1,
        [("value", "PNb_ul", "val\\0dl\\0& | \\0mask-mode:alpha")],
      ),
      (
        "_adlghIP07",
        ["._adlghIP07{-webkit-mask-mode:luminance;mask-mode:luminance;}"],
        1,
        0,
        1,
        [("value", "ghIP07", "val\\0dl\\0& | \\0mask-mode:luminance")],
      ),
      (
        "_adlCDZjKy",
        ["._adlCDZjKy{-webkit-mask-mode:match-source;mask-mode:match-source;}"],
        1,
        0,
        1,
        [("value", "CDZjKy", "val\\0dl\\0& | \\0mask-mode:match-source")],
      ),
      (
        "_adoBx3NaR",
        ["._adoBx3NaR{-webkit-mask-repeat:repeat-x;mask-repeat:repeat-x;}"],
        1,
        0,
        1,
        [("value", "Bx3NaR", "val\\0do\\0& | \\0mask-repeat:repeat-x")],
      ),
      (
        "_adopO_HU9",
        ["._adopO_HU9{-webkit-mask-repeat:repeat-y;mask-repeat:repeat-y;}"],
        1,
        0,
        1,
        [("value", "pO_HU9", "val\\0do\\0& | \\0mask-repeat:repeat-y")],
      ),
      (
        "_ado9oKnIE",
        ["._ado9oKnIE{-webkit-mask-repeat:repeat;mask-repeat:repeat;}"],
        1,
        0,
        1,
        [("value", "9oKnIE", "val\\0do\\0& | \\0mask-repeat:repeat")],
      ),
      (
        "_ado-jQ_ZB",
        ["._ado-jQ_ZB{-webkit-mask-repeat:space;mask-repeat:space;}"],
        1,
        0,
        1,
        [("value", "-jQ_ZB", "val\\0do\\0& | \\0mask-repeat:space")],
      ),
      (
        "_adoADv6aL",
        ["._adoADv6aL{-webkit-mask-repeat:round;mask-repeat:round;}"],
        1,
        0,
        1,
        [("value", "ADv6aL", "val\\0do\\0& | \\0mask-repeat:round")],
      ),
      (
        "_ado-IjxqD",
        ["._ado-IjxqD{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"],
        1,
        0,
        1,
        [("value", "-IjxqD", "val\\0do\\0& | \\0mask-repeat:no-repeat")],
      ),
      (
        "_adoadKkH-",
        [
          "._adoadKkH-{-webkit-mask-repeat:repeat repeat;mask-repeat:repeat repeat;}",
        ],
        1,
        0,
        1,
        [("value", "adKkH-", "val\\0do\\0& | \\0mask-repeat:repeat repeat")],
      ),
      (
        "_ado_ZwhB5",
        [
          "._ado_ZwhB5{-webkit-mask-repeat:space repeat;mask-repeat:space repeat;}",
        ],
        1,
        0,
        1,
        [("value", "_ZwhB5", "val\\0do\\0& | \\0mask-repeat:space repeat")],
      ),
      (
        "_adoiUr_Re",
        [
          "._adoiUr_Re{-webkit-mask-repeat:round repeat;mask-repeat:round repeat;}",
        ],
        1,
        0,
        1,
        [("value", "iUr_Re", "val\\0do\\0& | \\0mask-repeat:round repeat")],
      ),
      (
        "_ado07H_eb",
        [
          "._ado07H_eb{-webkit-mask-repeat:no-repeat repeat;mask-repeat:no-repeat repeat;}",
        ],
        1,
        0,
        1,
        [
          ("value", "07H_eb", "val\\0do\\0& | \\0mask-repeat:no-repeat repeat"),
        ],
      ),
      (
        "_adoxBdVLN",
        [
          "._adoxBdVLN{-webkit-mask-repeat:repeat space;mask-repeat:repeat space;}",
        ],
        1,
        0,
        1,
        [("value", "xBdVLN", "val\\0do\\0& | \\0mask-repeat:repeat space")],
      ),
      (
        "_adoShMg-E",
        [
          "._adoShMg-E{-webkit-mask-repeat:space space;mask-repeat:space space;}",
        ],
        1,
        0,
        1,
        [("value", "ShMg-E", "val\\0do\\0& | \\0mask-repeat:space space")],
      ),
      (
        "_adoH0FfxZ",
        [
          "._adoH0FfxZ{-webkit-mask-repeat:round space;mask-repeat:round space;}",
        ],
        1,
        0,
        1,
        [("value", "H0FfxZ", "val\\0do\\0& | \\0mask-repeat:round space")],
      ),
      (
        "_adolEb-Zt",
        [
          "._adolEb-Zt{-webkit-mask-repeat:no-repeat space;mask-repeat:no-repeat space;}",
        ],
        1,
        0,
        1,
        [("value", "lEb-Zt", "val\\0do\\0& | \\0mask-repeat:no-repeat space")],
      ),
      (
        "_adokiR1zN",
        [
          "._adokiR1zN{-webkit-mask-repeat:repeat round;mask-repeat:repeat round;}",
        ],
        1,
        0,
        1,
        [("value", "kiR1zN", "val\\0do\\0& | \\0mask-repeat:repeat round")],
      ),
      (
        "_ado7M0gdD",
        [
          "._ado7M0gdD{-webkit-mask-repeat:space round;mask-repeat:space round;}",
        ],
        1,
        0,
        1,
        [("value", "7M0gdD", "val\\0do\\0& | \\0mask-repeat:space round")],
      ),
      (
        "_adon1eTlo",
        [
          "._adon1eTlo{-webkit-mask-repeat:round round;mask-repeat:round round;}",
        ],
        1,
        0,
        1,
        [("value", "n1eTlo", "val\\0do\\0& | \\0mask-repeat:round round")],
      ),
      (
        "_adoMF1GZF",
        [
          "._adoMF1GZF{-webkit-mask-repeat:no-repeat round;mask-repeat:no-repeat round;}",
        ],
        1,
        0,
        1,
        [("value", "MF1GZF", "val\\0do\\0& | \\0mask-repeat:no-repeat round")],
      ),
      (
        "_adogZjfkh",
        [
          "._adogZjfkh{-webkit-mask-repeat:repeat no-repeat;mask-repeat:repeat no-repeat;}",
        ],
        1,
        0,
        1,
        [
          ("value", "gZjfkh", "val\\0do\\0& | \\0mask-repeat:repeat no-repeat"),
        ],
      ),
      (
        "_adoo5bvfa",
        [
          "._adoo5bvfa{-webkit-mask-repeat:space no-repeat;mask-repeat:space no-repeat;}",
        ],
        1,
        0,
        1,
        [("value", "o5bvfa", "val\\0do\\0& | \\0mask-repeat:space no-repeat")],
      ),
      (
        "_adoWjoW_Z",
        [
          "._adoWjoW_Z{-webkit-mask-repeat:round no-repeat;mask-repeat:round no-repeat;}",
        ],
        1,
        0,
        1,
        [("value", "WjoW_Z", "val\\0do\\0& | \\0mask-repeat:round no-repeat")],
      ),
      (
        "_adoYq-gmb",
        [
          "._adoYq-gmb{-webkit-mask-repeat:no-repeat no-repeat;mask-repeat:no-repeat no-repeat;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "Yq-gmb",
            "val\\0do\\0& | \\0mask-repeat:no-repeat no-repeat",
          ),
        ],
      ),
      (
        "_adneqlwtn",
        ["._adneqlwtn{-webkit-mask-position:center;mask-position:center;}"],
        1,
        0,
        2,
        [("value", "eqlwtn", "val\\0dn\\0& | \\0mask-position:center")],
      ),
      (
        "_adnjtDGCC",
        [
          "._adnjtDGCC{-webkit-mask-position:center center;mask-position:center center;}",
        ],
        1,
        0,
        2,
        [("value", "jtDGCC", "val\\0dn\\0& | \\0mask-position:center center")],
      ),
      (
        "_adnoLFIaf",
        ["._adnoLFIaf{-webkit-mask-position:left 50%;mask-position:left 50%;}"],
        1,
        0,
        2,
        [("value", "oLFIaf", "val\\0dn\\0& | \\0mask-position:left 50%")],
      ),
      (
        "_adnMFeRk9",
        [
          "._adnMFeRk9{-webkit-mask-position:bottom 10px right 20px;mask-position:bottom 10px right 20px;}",
        ],
        1,
        0,
        2,
        [
          (
            "value",
            "MFeRk9",
            "val\\0dn\\0& | \\0mask-position:bottom 10px right 20px",
          ),
        ],
      ),
      (
        "_adn_wvHjN",
        [
          "._adn_wvHjN{-webkit-mask-position:1rem 1rem, center;mask-position:1rem 1rem, center;}",
        ],
        1,
        0,
        2,
        [
          (
            "value",
            "_wvHjN",
            "val\\0dn\\0& | \\0mask-position:1rem 1rem, center",
          ),
        ],
      ),
      (
        "_adiSzlTWL",
        ["._adiSzlTWL{-webkit-mask-clip:border-box;mask-clip:border-box;}"],
        1,
        0,
        1,
        [("value", "SzlTWL", "val\\0di\\0& | \\0mask-clip:border-box")],
      ),
      (
        "_adiRBAlHJ",
        ["._adiRBAlHJ{-webkit-mask-clip:padding-box;mask-clip:padding-box;}"],
        1,
        0,
        1,
        [("value", "RBAlHJ", "val\\0di\\0& | \\0mask-clip:padding-box")],
      ),
      (
        "_adivgXv9O",
        ["._adivgXv9O{-webkit-mask-clip:content-box;mask-clip:content-box;}"],
        1,
        0,
        1,
        [("value", "vgXv9O", "val\\0di\\0& | \\0mask-clip:content-box")],
      ),
      (
        "_adi1gMToh",
        ["._adi1gMToh{-webkit-mask-clip:margin-box;mask-clip:margin-box;}"],
        1,
        0,
        1,
        [("value", "1gMToh", "val\\0di\\0& | \\0mask-clip:margin-box")],
      ),
      (
        "_adigAo2vz",
        ["._adigAo2vz{-webkit-mask-clip:fill-box;mask-clip:fill-box;}"],
        1,
        0,
        1,
        [("value", "gAo2vz", "val\\0di\\0& | \\0mask-clip:fill-box")],
      ),
      (
        "_adiQB-j-u",
        ["._adiQB-j-u{-webkit-mask-clip:stroke-box;mask-clip:stroke-box;}"],
        1,
        0,
        1,
        [("value", "QB-j-u", "val\\0di\\0& | \\0mask-clip:stroke-box")],
      ),
      (
        "_adiVB9BVX",
        ["._adiVB9BVX{-webkit-mask-clip:view-box;mask-clip:view-box;}"],
        1,
        0,
        1,
        [("value", "VB9BVX", "val\\0di\\0& | \\0mask-clip:view-box")],
      ),
      (
        "_adiHcSE21",
        ["._adiHcSE21{-webkit-mask-clip:no-clip;mask-clip:no-clip;}"],
        1,
        0,
        1,
        [("value", "HcSE21", "val\\0di\\0& | \\0mask-clip:no-clip")],
      ),
      (
        "_admJ0xoMH",
        ["._admJ0xoMH{-webkit-mask-origin:border-box;mask-origin:border-box;}"],
        1,
        0,
        1,
        [("value", "J0xoMH", "val\\0dm\\0& | \\0mask-origin:border-box")],
      ),
      (
        "_admV6lH1u",
        [
          "._admV6lH1u{-webkit-mask-origin:padding-box;mask-origin:padding-box;}",
        ],
        1,
        0,
        1,
        [("value", "V6lH1u", "val\\0dm\\0& | \\0mask-origin:padding-box")],
      ),
      (
        "_admpMQCPF",
        [
          "._admpMQCPF{-webkit-mask-origin:content-box;mask-origin:content-box;}",
        ],
        1,
        0,
        1,
        [("value", "pMQCPF", "val\\0dm\\0& | \\0mask-origin:content-box")],
      ),
      (
        "_admvUPlK1",
        ["._admvUPlK1{-webkit-mask-origin:margin-box;mask-origin:margin-box;}"],
        1,
        0,
        1,
        [("value", "vUPlK1", "val\\0dm\\0& | \\0mask-origin:margin-box")],
      ),
      (
        "_admupMJ8P",
        ["._admupMJ8P{-webkit-mask-origin:fill-box;mask-origin:fill-box;}"],
        1,
        0,
        1,
        [("value", "upMJ8P", "val\\0dm\\0& | \\0mask-origin:fill-box")],
      ),
      (
        "_adm6wj7jX",
        ["._adm6wj7jX{-webkit-mask-origin:stroke-box;mask-origin:stroke-box;}"],
        1,
        0,
        1,
        [("value", "6wj7jX", "val\\0dm\\0& | \\0mask-origin:stroke-box")],
      ),
      (
        "_admL_hpMn",
        ["._admL_hpMn{-webkit-mask-origin:view-box;mask-origin:view-box;}"],
        1,
        0,
        1,
        [("value", "L_hpMn", "val\\0dm\\0& | \\0mask-origin:view-box")],
      ),
      (
        "_adpyW1FZH",
        ["._adpyW1FZH{-webkit-mask-size:auto;mask-size:auto;}"],
        1,
        0,
        1,
        [("value", "yW1FZH", "val\\0dp\\0& | \\0mask-size:auto")],
      ),
      (
        "_adpiwnNlK",
        ["._adpiwnNlK{-webkit-mask-size:10px;mask-size:10px;}"],
        1,
        0,
        1,
        [("value", "iwnNlK", "val\\0dp\\0& | \\0mask-size:10px")],
      ),
      (
        "_adpwKEVJg",
        ["._adpwKEVJg{-webkit-mask-size:cover;mask-size:cover;}"],
        1,
        0,
        1,
        [("value", "wKEVJg", "val\\0dp\\0& | \\0mask-size:cover")],
      ),
      (
        "_adpd5tihx",
        ["._adpd5tihx{-webkit-mask-size:contain;mask-size:contain;}"],
        1,
        0,
        1,
        [("value", "d5tihx", "val\\0dp\\0& | \\0mask-size:contain")],
      ),
      (
        "_adpxx7P-d",
        ["._adpxx7P-d{-webkit-mask-size:50%;mask-size:50%;}"],
        1,
        0,
        1,
        [("value", "xx7P-d", "val\\0dp\\0& | \\0mask-size:50%")],
      ),
      (
        "_adpPBrbEM",
        ["._adpPBrbEM{-webkit-mask-size:10px auto;mask-size:10px auto;}"],
        1,
        0,
        1,
        [("value", "PBrbEM", "val\\0dp\\0& | \\0mask-size:10px auto")],
      ),
      (
        "_adpd7EGGE",
        ["._adpd7EGGE{-webkit-mask-size:auto 10%;mask-size:auto 10%;}"],
        1,
        0,
        1,
        [("value", "d7EGGE", "val\\0dp\\0& | \\0mask-size:auto 10%")],
      ),
      (
        "_adp2XVPB5",
        ["._adp2XVPB5{-webkit-mask-size:50em 50%;mask-size:50em 50%;}"],
        1,
        0,
        1,
        [("value", "2XVPB5", "val\\0dp\\0& | \\0mask-size:50em 50%")],
      ),
      (
        "_adjKJVqh0",
        ["._adjKJVqh0{-webkit-mask-composite:add;mask-composite:add;}"],
        1,
        0,
        1,
        [("value", "KJVqh0", "val\\0dj\\0& | \\0mask-composite:add")],
      ),
      (
        "_adjh_VGe0",
        [
          "._adjh_VGe0{-webkit-mask-composite:subtract;mask-composite:subtract;}",
        ],
        1,
        0,
        1,
        [("value", "h_VGe0", "val\\0dj\\0& | \\0mask-composite:subtract")],
      ),
      (
        "_adjErSUfG",
        [
          "._adjErSUfG{-webkit-mask-composite:intersect;mask-composite:intersect;}",
        ],
        1,
        0,
        1,
        [("value", "ErSUfG", "val\\0dj\\0& | \\0mask-composite:intersect")],
      ),
      (
        "_adjT8d9-M",
        ["._adjT8d9-M{-webkit-mask-composite:exclude;mask-composite:exclude;}"],
        1,
        0,
        1,
        [("value", "T8d9-M", "val\\0dj\\0& | \\0mask-composite:exclude")],
      ),
      (
        "_adaDHqaCJ",
        ["._adaDHqaCJ{-webkit-mask:top;mask:top;}"],
        1,
        0,
        9,
        [("value", "DHqaCJ", "val\\0da\\0& | \\0mask:top")],
      ),
      (
        "_adabpMG4j",
        ["._adabpMG4j{-webkit-mask:space;mask:space;}"],
        1,
        0,
        9,
        [("value", "bpMG4j", "val\\0da\\0& | \\0mask:space")],
      ),
      (
        "_adaLlWzjk",
        [
          "._adaLlWzjk{-webkit-mask:url(\"image.png\");mask:url(\"image.png\");}",
        ],
        1,
        0,
        9,
        [("value", "LlWzjk", "val\\0da\\0& | \\0mask:url(\"image.png\")")],
      ),
      (
        "_ada9B7U6A",
        [
          "._ada9B7U6A{-webkit-mask:url(\"image.png\") luminance;mask:url(\"image.png\") luminance;}",
        ],
        1,
        0,
        9,
        [
          (
            "value",
            "9B7U6A",
            "val\\0da\\0& | \\0mask:url(\"image.png\") luminance",
          ),
        ],
      ),
      (
        "_ada2Db9_h",
        [
          "._ada2Db9_h{-webkit-mask:url(\"image.png\") luminance top space;mask:url(\"image.png\") luminance top space;}",
        ],
        1,
        0,
        9,
        [
          (
            "value",
            "2Db9_h",
            "val\\0da\\0& | \\0mask:url(\"image.png\") luminance top space",
          ),
        ],
      ),
      (
        "_adgOisGks",
        ["._adgOisGks{mask-border-source:none;}"],
        1,
        0,
        1,
        [("value", "OisGks", "val\\0dg\\0& | \\0mask-border-source:none")],
      ),
      (
        "_adggbXjpU",
        ["._adggbXjpU{mask-border-source:url(\"image.png\");}"],
        1,
        0,
        1,
        [
          (
            "value",
            "gbXjpU",
            "val\\0dg\\0& | \\0mask-border-source:url(\"image.png\")",
          ),
        ],
      ),
      (
        "_adf_eYd1o",
        ["._adf_eYd1o{mask-border-slice:0 fill;}"],
        1,
        0,
        1,
        [("value", "_eYd1o", "val\\0df\\0& | \\0mask-border-slice:0 fill")],
      ),
      (
        "_adf3yxTrt",
        ["._adf3yxTrt{mask-border-slice:50% fill;}"],
        1,
        0,
        1,
        [("value", "3yxTrt", "val\\0df\\0& | \\0mask-border-slice:50% fill")],
      ),
      (
        "_adfkn-qls",
        ["._adfkn-qls{mask-border-slice:1.1 fill;}"],
        1,
        0,
        1,
        [("value", "kn-qls", "val\\0df\\0& | \\0mask-border-slice:1.1 fill")],
      ),
      (
        "_adfsHFgTq",
        ["._adfsHFgTq{mask-border-slice:0 1 fill;}"],
        1,
        0,
        1,
        [("value", "sHFgTq", "val\\0df\\0& | \\0mask-border-slice:0 1 fill")],
      ),
      (
        "_adft8fsn8",
        ["._adft8fsn8{mask-border-slice:0 1 2 fill;}"],
        1,
        0,
        1,
        [
          ("value", "t8fsn8", "val\\0df\\0& | \\0mask-border-slice:0 1 2 fill"),
        ],
      ),
      (
        "_adfm1JVs1",
        ["._adfm1JVs1{mask-border-slice:0 1 2 3 fill;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "m1JVs1",
            "val\\0df\\0& | \\0mask-border-slice:0 1 2 3 fill",
          ),
        ],
      ),
      (
        "_adhxJilcs",
        ["._adhxJilcs{mask-border-width:auto;}"],
        1,
        0,
        1,
        [("value", "xJilcs", "val\\0dh\\0& | \\0mask-border-width:auto")],
      ),
      (
        "_adhq9W68h",
        ["._adhq9W68h{mask-border-width:10px;}"],
        1,
        0,
        1,
        [("value", "q9W68h", "val\\0dh\\0& | \\0mask-border-width:10px")],
      ),
      (
        "_adhOzG4hK",
        ["._adhOzG4hK{mask-border-width:50%;}"],
        1,
        0,
        1,
        [("value", "OzG4hK", "val\\0dh\\0& | \\0mask-border-width:50%")],
      ),
      (
        "_adhukkwY7",
        ["._adhukkwY7{mask-border-width:1;}"],
        1,
        0,
        1,
        [("value", "ukkwY7", "val\\0dh\\0& | \\0mask-border-width:1")],
      ),
      (
        "_adhMnogi3",
        ["._adhMnogi3{mask-border-width:auto 1;}"],
        1,
        0,
        1,
        [("value", "Mnogi3", "val\\0dh\\0& | \\0mask-border-width:auto 1")],
      ),
      (
        "_adhBywwYP",
        ["._adhBywwYP{mask-border-width:auto 1 50%;}"],
        1,
        0,
        1,
        [
          ("value", "BywwYP", "val\\0dh\\0& | \\0mask-border-width:auto 1 50%"),
        ],
      ),
      (
        "_adhTiwQ2w",
        ["._adhTiwQ2w{mask-border-width:auto 1 50% 1.1;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "TiwQ2w",
            "val\\0dh\\0& | \\0mask-border-width:auto 1 50% 1.1",
          ),
        ],
      ),
      (
        "_addK6U1FC",
        ["._addK6U1FC{mask-border-outset:0;}"],
        1,
        0,
        1,
        [("value", "K6U1FC", "val\\0dd\\0& | \\0mask-border-outset:0")],
      ),
      (
        "_addREdYAa",
        ["._addREdYAa{mask-border-outset:1.1;}"],
        1,
        0,
        1,
        [("value", "REdYAa", "val\\0dd\\0& | \\0mask-border-outset:1.1")],
      ),
      (
        "_addjkd4Bv",
        ["._addjkd4Bv{mask-border-outset:0 1;}"],
        1,
        0,
        1,
        [("value", "jkd4Bv", "val\\0dd\\0& | \\0mask-border-outset:0 1")],
      ),
      (
        "_addEbQtek",
        ["._addEbQtek{mask-border-outset:0 1 2;}"],
        1,
        0,
        1,
        [("value", "EbQtek", "val\\0dd\\0& | \\0mask-border-outset:0 1 2")],
      ),
      (
        "_addIuz_DK",
        ["._addIuz_DK{mask-border-outset:0 1 2 3;}"],
        1,
        0,
        1,
        [("value", "Iuz_DK", "val\\0dd\\0& | \\0mask-border-outset:0 1 2 3")],
      ),
      (
        "_adeiaZ90v",
        ["._adeiaZ90v{mask-border-repeat:stretch;}"],
        1,
        0,
        1,
        [("value", "iaZ90v", "val\\0de\\0& | \\0mask-border-repeat:stretch")],
      ),
      (
        "_adew-mSEb",
        ["._adew-mSEb{mask-border-repeat:repeat;}"],
        1,
        0,
        1,
        [("value", "w-mSEb", "val\\0de\\0& | \\0mask-border-repeat:repeat")],
      ),
      (
        "_adeV4y4pT",
        ["._adeV4y4pT{mask-border-repeat:round;}"],
        1,
        0,
        1,
        [("value", "V4y4pT", "val\\0de\\0& | \\0mask-border-repeat:round")],
      ),
      (
        "_ade4Kyeeb",
        ["._ade4Kyeeb{mask-border-repeat:space;}"],
        1,
        0,
        1,
        [("value", "4Kyeeb", "val\\0de\\0& | \\0mask-border-repeat:space")],
      ),
      (
        "_adeZpZA57",
        ["._adeZpZA57{mask-border-repeat:stretch stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ZpZA57",
            "val\\0de\\0& | \\0mask-border-repeat:stretch stretch",
          ),
        ],
      ),
      (
        "_adeN8MSKl",
        ["._adeN8MSKl{mask-border-repeat:repeat stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "N8MSKl",
            "val\\0de\\0& | \\0mask-border-repeat:repeat stretch",
          ),
        ],
      ),
      (
        "_ade-yVGjm",
        ["._ade-yVGjm{mask-border-repeat:round stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "-yVGjm",
            "val\\0de\\0& | \\0mask-border-repeat:round stretch",
          ),
        ],
      ),
      (
        "_adeUTNCJ5",
        ["._adeUTNCJ5{mask-border-repeat:space stretch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "UTNCJ5",
            "val\\0de\\0& | \\0mask-border-repeat:space stretch",
          ),
        ],
      ),
      (
        "_adeJNJXQe",
        ["._adeJNJXQe{mask-border-repeat:stretch repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "JNJXQe",
            "val\\0de\\0& | \\0mask-border-repeat:stretch repeat",
          ),
        ],
      ),
      (
        "_adeYgGOWh",
        ["._adeYgGOWh{mask-border-repeat:repeat repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "YgGOWh",
            "val\\0de\\0& | \\0mask-border-repeat:repeat repeat",
          ),
        ],
      ),
      (
        "_adeuk6dQc",
        ["._adeuk6dQc{mask-border-repeat:round repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "uk6dQc",
            "val\\0de\\0& | \\0mask-border-repeat:round repeat",
          ),
        ],
      ),
      (
        "_adesGZGm9",
        ["._adesGZGm9{mask-border-repeat:space repeat;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sGZGm9",
            "val\\0de\\0& | \\0mask-border-repeat:space repeat",
          ),
        ],
      ),
      (
        "_adeRF12Vi",
        ["._adeRF12Vi{mask-border-repeat:stretch round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "RF12Vi",
            "val\\0de\\0& | \\0mask-border-repeat:stretch round",
          ),
        ],
      ),
      (
        "_adeyeS1Dr",
        ["._adeyeS1Dr{mask-border-repeat:repeat round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "yeS1Dr",
            "val\\0de\\0& | \\0mask-border-repeat:repeat round",
          ),
        ],
      ),
      (
        "_adelurj0S",
        ["._adelurj0S{mask-border-repeat:round round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "lurj0S",
            "val\\0de\\0& | \\0mask-border-repeat:round round",
          ),
        ],
      ),
      (
        "_adeb-WJ7b",
        ["._adeb-WJ7b{mask-border-repeat:space round;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "b-WJ7b",
            "val\\0de\\0& | \\0mask-border-repeat:space round",
          ),
        ],
      ),
      (
        "_ade1mMZ8Q",
        ["._ade1mMZ8Q{mask-border-repeat:stretch space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "1mMZ8Q",
            "val\\0de\\0& | \\0mask-border-repeat:stretch space",
          ),
        ],
      ),
      (
        "_adeDn2D9u",
        ["._adeDn2D9u{mask-border-repeat:repeat space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Dn2D9u",
            "val\\0de\\0& | \\0mask-border-repeat:repeat space",
          ),
        ],
      ),
      (
        "_adegTSLso",
        ["._adegTSLso{mask-border-repeat:round space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "gTSLso",
            "val\\0de\\0& | \\0mask-border-repeat:round space",
          ),
        ],
      ),
      (
        "_adeHn_fqE",
        ["._adeHn_fqE{mask-border-repeat:space space;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Hn_fqE",
            "val\\0de\\0& | \\0mask-border-repeat:space space",
          ),
        ],
      ),
      (
        "_adbCheuxG",
        ["._adbCheuxG{mask-border:url(\"image.png\");}"],
        1,
        0,
        1,
        [
          (
            "value",
            "CheuxG",
            "val\\0db\\0& | \\0mask-border:url(\"image.png\")",
          ),
        ],
      ),
      (
        "_adqVOuDA2",
        ["._adqVOuDA2{mask-type:luminance;}"],
        1,
        0,
        1,
        [("value", "VOuDA2", "val\\0dq\\0& | \\0mask-type:luminance")],
      ),
      (
        "_adqvDW-JR",
        ["._adqvDW-JR{mask-type:alpha;}"],
        1,
        0,
        1,
        [("value", "vDW-JR", "val\\0dq\\0& | \\0mask-type:alpha")],
      ),
    ]
  ];
  CSS.make("_a7dFhXCJE", []);
  CSS.make("_a7d9VZcs4", []);
  CSS.make("_a7dEBpLxD", []);
  CSS.make("_a7dM47cwg", []);
  CSS.make("_a7dWqL3Rv", []);
  CSS.make("_a7dZJnWK8", []);
  CSS.make("_a7dSPditK", []);
  CSS.make("_a7d7OKpHs", []);
  CSS.make("_a7dN0M8ek", []);
  CSS.make("_a7dO39Qtl", []);
  CSS.make("_a7dTmCUPQ", []);
  CSS.make("_a7d6e-Z5G", []);
  CSS.make("_a7d3Sa0c3", []);
  CSS.make("_a7dI4YNS7", []);
  CSS.make("_a7eT75exS", []);
  CSS.make("_a7eoqqafC", []);
  CSS.make("_adkZbg-Wr", []);
  CSS.make("_adkxlUIbZ", []);
  CSS.make("_adk1VGtMg", []);
  CSS.make("_adlPNb_ul", []);
  CSS.make("_adlghIP07", []);
  CSS.make("_adlCDZjKy", []);
  CSS.make("_adoBx3NaR", []);
  CSS.make("_adopO_HU9", []);
  CSS.make("_ado9oKnIE", []);
  CSS.make("_ado-jQ_ZB", []);
  CSS.make("_adoADv6aL", []);
  CSS.make("_ado-IjxqD", []);
  CSS.make("_adoadKkH-", []);
  CSS.make("_ado_ZwhB5", []);
  CSS.make("_adoiUr_Re", []);
  CSS.make("_ado07H_eb", []);
  CSS.make("_adoxBdVLN", []);
  CSS.make("_adoShMg-E", []);
  CSS.make("_adoH0FfxZ", []);
  CSS.make("_adolEb-Zt", []);
  CSS.make("_adokiR1zN", []);
  CSS.make("_ado7M0gdD", []);
  CSS.make("_adon1eTlo", []);
  CSS.make("_adoMF1GZF", []);
  CSS.make("_adogZjfkh", []);
  CSS.make("_adoo5bvfa", []);
  CSS.make("_adoWjoW_Z", []);
  CSS.make("_adoYq-gmb", []);
  CSS.make("_adneqlwtn", []);
  CSS.make("_adnjtDGCC", []);
  CSS.make("_adnoLFIaf", []);
  CSS.make("_adnMFeRk9", []);
  CSS.make("_adn_wvHjN", []);
  CSS.make("_adiSzlTWL", []);
  CSS.make("_adiRBAlHJ", []);
  CSS.make("_adivgXv9O", []);
  CSS.make("_adi1gMToh", []);
  CSS.make("_adigAo2vz", []);
  CSS.make("_adiQB-j-u", []);
  CSS.make("_adiVB9BVX", []);
  CSS.make("_adiHcSE21", []);
  CSS.make("_admJ0xoMH", []);
  CSS.make("_admV6lH1u", []);
  CSS.make("_admpMQCPF", []);
  CSS.make("_admvUPlK1", []);
  CSS.make("_admupMJ8P", []);
  CSS.make("_adm6wj7jX", []);
  CSS.make("_admL_hpMn", []);
  CSS.make("_adpyW1FZH", []);
  CSS.make("_adpiwnNlK", []);
  CSS.make("_adpwKEVJg", []);
  CSS.make("_adpd5tihx", []);
  CSS.make("_adpiwnNlK", []);
  CSS.make("_adpxx7P-d", []);
  CSS.make("_adpPBrbEM", []);
  CSS.make("_adpd7EGGE", []);
  CSS.make("_adp2XVPB5", []);
  CSS.make("_adjKJVqh0", []);
  CSS.make("_adjh_VGe0", []);
  CSS.make("_adjErSUfG", []);
  CSS.make("_adjT8d9-M", []);
  CSS.make("_adaDHqaCJ", []);
  CSS.make("_adabpMG4j", []);
  CSS.make("_adaLlWzjk", []);
  CSS.make("_ada9B7U6A", []);
  CSS.make("_ada2Db9_h", []);
  CSS.make("_adgOisGks", []);
  CSS.make("_adggbXjpU", []);
  CSS.make("_adf_eYd1o", []);
  CSS.make("_adf3yxTrt", []);
  CSS.make("_adfkn-qls", []);
  CSS.make("_adfsHFgTq", []);
  CSS.make("_adft8fsn8", []);
  CSS.make("_adfm1JVs1", []);
  CSS.make("_adhxJilcs", []);
  CSS.make("_adhq9W68h", []);
  CSS.make("_adhOzG4hK", []);
  CSS.make("_adhukkwY7", []);
  CSS.make("_adhukkwY7", []);
  CSS.make("_adhMnogi3", []);
  CSS.make("_adhBywwYP", []);
  CSS.make("_adhTiwQ2w", []);
  CSS.make("_addK6U1FC", []);
  CSS.make("_addREdYAa", []);
  CSS.make("_addjkd4Bv", []);
  CSS.make("_addEbQtek", []);
  CSS.make("_addIuz_DK", []);
  CSS.make("_adeiaZ90v", []);
  CSS.make("_adew-mSEb", []);
  CSS.make("_adeV4y4pT", []);
  CSS.make("_ade4Kyeeb", []);
  CSS.make("_adeZpZA57", []);
  CSS.make("_adeN8MSKl", []);
  CSS.make("_ade-yVGjm", []);
  CSS.make("_adeUTNCJ5", []);
  CSS.make("_adeJNJXQe", []);
  CSS.make("_adeYgGOWh", []);
  CSS.make("_adeuk6dQc", []);
  CSS.make("_adesGZGm9", []);
  CSS.make("_adeRF12Vi", []);
  CSS.make("_adeyeS1Dr", []);
  CSS.make("_adelurj0S", []);
  CSS.make("_adeb-WJ7b", []);
  CSS.make("_ade1mMZ8Q", []);
  CSS.make("_adeDn2D9u", []);
  CSS.make("_adegTSLso", []);
  CSS.make("_adeHn_fqE", []);
  CSS.make("_adbCheuxG", []);
  CSS.make("_adqVOuDA2", []);
  CSS.make("_adqvDW-JR", []);
