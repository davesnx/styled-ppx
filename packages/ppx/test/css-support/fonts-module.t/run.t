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
  [@css "@property --fonts-dsbp3l{syntax:\"*\";inherits:false;}"];
  [@css "@property --fontStack-ejj69w{syntax:\"*\";inherits:false;}"];
  [@css "@property --font-14m54rr{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_aa2OTRNlu",
        ["._aa2OTRNlu{font-family:\"Inter Semi Bold\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "OTRNlu",
            "val\\0a2\\0& | \\0font-family:\"Inter Semi Bold\"",
          ),
        ],
      ),
      (
        "_aa2X_GaAL",
        ["._aa2X_GaAL{font-family:var(--fonts-dsbp3l);}"],
        1,
        0,
        1,
        [("value", "X_GaAL", "val\\0a2\\0& | \\0font-family:$(fonts)")],
      ),
      (
        "_aa2hXHfm-",
        ["._aa2hXHfm-{font-family:Inter;}"],
        1,
        0,
        1,
        [("value", "hXHfm-", "val\\0a2\\0& | \\0font-family:Inter")],
      ),
      (
        "_aa2DBESAs",
        ["._aa2DBESAs{font-family:var(--fontStack-ejj69w);}"],
        1,
        0,
        1,
        [("value", "DBESAs", "val\\0a2\\0& | \\0font-family:$(fontStack)")],
      ),
      (
        "_aa2ufw0ge",
        ["._aa2ufw0ge{font-family:Inter, Sans;}"],
        1,
        0,
        1,
        [("value", "ufw0ge", "val\\0a2\\0& | \\0font-family:Inter, Sans")],
      ),
      (
        "_aa27nZc4p",
        ["._aa27nZc4p{font-family:Inter, var(--font-14m54rr);}"],
        1,
        0,
        1,
        [("value", "7nZc4p", "val\\0a2\\0& | \\0font-family:Inter, $(font)")],
      ),
      (
        "_aa2BF5Mzn",
        ["._aa2BF5Mzn{font-family:\"Gill Sans Extrabold\", sans-serif;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "BF5Mzn",
            "val\\0a2\\0& | \\0font-family:\"Gill Sans Extrabold\", sans-serif",
          ),
        ],
      ),
      (
        "_aahO2VtI7",
        ["._aahO2VtI7{font-synthesis-weight:none;}"],
        1,
        0,
        1,
        [("value", "O2VtI7", "val\\0ah\\0& | \\0font-synthesis-weight:none")],
      ),
      (
        "_aagzrA9fs",
        ["._aagzrA9fs{font-synthesis-style:auto;}"],
        1,
        0,
        1,
        [("value", "zrA9fs", "val\\0ag\\0& | \\0font-synthesis-style:auto")],
      ),
      (
        "_aafGq52Ns",
        ["._aafGq52Ns{font-synthesis-small-caps:none;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Gq52Ns",
            "val\\0af\\0& | \\0font-synthesis-small-caps:none",
          ),
        ],
      ),
      (
        "_aaeEPQAKv",
        ["._aaeEPQAKv{font-synthesis-position:auto;}"],
        1,
        0,
        1,
        [
          ("value", "EPQAKv", "val\\0ae\\0& | \\0font-synthesis-position:auto"),
        ],
      ),
      (
        "_aa8T1Qq8B",
        ["._aa8T1Qq8B{font-size:xxx-large;}"],
        1,
        0,
        1,
        [("value", "T1Qq8B", "val\\0a8\\0& | \\0font-size:xxx-large")],
      ),
      (
        "_aaiRToVPB",
        ["._aaiRToVPB{font-variant:none;}"],
        1,
        0,
        7,
        [("value", "RToVPB", "val\\0ai\\0& | \\0font-variant:none")],
      ),
      (
        "_aaicIF77j",
        ["._aaicIF77j{font-variant:normal;}"],
        1,
        0,
        7,
        [("value", "cIF77j", "val\\0ai\\0& | \\0font-variant:normal")],
      ),
      (
        "_aaiUTtW3y",
        ["._aaiUTtW3y{font-variant:all-petite-caps;}"],
        1,
        0,
        7,
        [
          ("value", "UTtW3y", "val\\0ai\\0& | \\0font-variant:all-petite-caps"),
        ],
      ),
      (
        "_aaimwMn-E",
        ["._aaimwMn-E{font-variant:historical-forms;}"],
        1,
        0,
        7,
        [
          ("value", "mwMn-E", "val\\0ai\\0& | \\0font-variant:historical-forms"),
        ],
      ),
      (
        "_aaiDuna0_",
        ["._aaiDuna0_{font-variant:super;}"],
        1,
        0,
        7,
        [("value", "Duna0_", "val\\0ai\\0& | \\0font-variant:super")],
      ),
      (
        "_aai2dL3W9",
        ["._aai2dL3W9{font-variant:sub lining-nums contextual ruby;}"],
        1,
        0,
        7,
        [
          (
            "value",
            "2dL3W9",
            "val\\0ai\\0& | \\0font-variant:sub lining-nums contextual ruby",
          ),
        ],
      ),
      (
        "_aaiwJ_D2V",
        ["._aaiwJ_D2V{font-variant:annotation(circled);}"],
        1,
        0,
        7,
        [
          (
            "value",
            "wJ_D2V",
            "val\\0ai\\0& | \\0font-variant:annotation(circled)",
          ),
        ],
      ),
      (
        "_aaidaqbMh",
        [
          "._aaidaqbMh{font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U);}",
        ],
        1,
        0,
        7,
        [
          (
            "value",
            "daqbMh",
            "val\\0ai\\0& | \\0font-variant:discretionary-ligatures character-variant(leo-B, leo-M, leo-N, leo-T, leo-U)",
          ),
        ],
      ),
      (
        "_aajhfn8kR",
        ["._aajhfn8kR{font-variant-alternates:normal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "hfn8kR",
            "val\\0aj\\0& | \\0font-variant-alternates:normal",
          ),
        ],
      ),
      (
        "_aajD9OPiZ",
        ["._aajD9OPiZ{font-variant-alternates:historical-forms;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "D9OPiZ",
            "val\\0aj\\0& | \\0font-variant-alternates:historical-forms",
          ),
        ],
      ),
      (
        "_aajhrYuYZ",
        ["._aajhrYuYZ{font-variant-alternates:styleset(ss01);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "hrYuYZ",
            "val\\0aj\\0& | \\0font-variant-alternates:styleset(ss01)",
          ),
        ],
      ),
      (
        "_aajZzuXpl",
        [
          "._aajZzuXpl{font-variant-alternates:styleset(stacked-g, geometric-m);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "ZzuXpl",
            "val\\0aj\\0& | \\0font-variant-alternates:styleset(stacked-g, geometric-m)",
          ),
        ],
      ),
      (
        "_aajjMfNIv",
        ["._aajjMfNIv{font-variant-alternates:character-variant(cv02);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "jMfNIv",
            "val\\0aj\\0& | \\0font-variant-alternates:character-variant(cv02)",
          ),
        ],
      ),
      (
        "_aajSkvV_m",
        [
          "._aajSkvV_m{font-variant-alternates:character-variant(beta-3, gamma);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "SkvV_m",
            "val\\0aj\\0& | \\0font-variant-alternates:character-variant(beta-3, gamma)",
          ),
        ],
      ),
      (
        "_aajew3hNg",
        ["._aajew3hNg{font-variant-alternates:swash(flowing);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ew3hNg",
            "val\\0aj\\0& | \\0font-variant-alternates:swash(flowing)",
          ),
        ],
      ),
      (
        "_aajoKI7ik",
        ["._aajoKI7ik{font-variant-alternates:ornaments(leaves);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "oKI7ik",
            "val\\0aj\\0& | \\0font-variant-alternates:ornaments(leaves)",
          ),
        ],
      ),
      (
        "_aajffUfXX",
        ["._aajffUfXX{font-variant-alternates:annotation(blocky);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ffUfXX",
            "val\\0aj\\0& | \\0font-variant-alternates:annotation(blocky)",
          ),
        ],
      ),
      (
        "_aa3F4k8u3",
        ["._aa3F4k8u3{font-feature-settings:normal;}"],
        1,
        0,
        1,
        [
          ("value", "F4k8u3", "val\\0a3\\0& | \\0font-feature-settings:normal"),
        ],
      ),
      (
        "_aa3Si0Gsx",
        ["._aa3Si0Gsx{font-feature-settings:\"swsh\" 2;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Si0Gsx",
            "val\\0a3\\0& | \\0font-feature-settings:\"swsh\" 2",
          ),
        ],
      ),
      (
        "_aa5Vm_2Dk",
        ["._aa5Vm_2Dk{font-language-override:normal;}"],
        1,
        0,
        1,
        [
          ("value", "Vm_2Dk", "val\\0a5\\0& | \\0font-language-override:normal"),
        ],
      ),
      (
        "_aa5bhI2MV",
        ["._aa5bhI2MV{font-language-override:\"SRB\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bhI2MV",
            "val\\0a5\\0& | \\0font-language-override:\"SRB\"",
          ),
        ],
      ),
      (
        "_aarXbaTWW",
        ["._aarXbaTWW{font-weight:1;}"],
        1,
        0,
        1,
        [("value", "XbaTWW", "val\\0ar\\0& | \\0font-weight:1")],
      ),
      (
        "_aarVc6_NL",
        ["._aarVc6_NL{font-weight:90;}"],
        1,
        0,
        1,
        [("value", "Vc6_NL", "val\\0ar\\0& | \\0font-weight:90")],
      ),
      (
        "_aar2O3VSk",
        ["._aar2O3VSk{font-weight:750;}"],
        1,
        0,
        1,
        [("value", "2O3VSk", "val\\0ar\\0& | \\0font-weight:750")],
      ),
      (
        "_aartLJqhX",
        ["._aartLJqhX{font-weight:1000;}"],
        1,
        0,
        1,
        [("value", "tLJqhX", "val\\0ar\\0& | \\0font-weight:1000")],
      ),
      (
        "_aacRDZRLz",
        ["._aacRDZRLz{font-style:oblique 15deg;}"],
        1,
        0,
        1,
        [("value", "RDZRLz", "val\\0ac\\0& | \\0font-style:oblique 15deg")],
      ),
      (
        "_aact_-OvO",
        ["._aact_-OvO{font-style:oblique -15deg;}"],
        1,
        0,
        1,
        [("value", "t_-OvO", "val\\0ac\\0& | \\0font-style:oblique -15deg")],
      ),
      (
        "_aacAJ5KnW",
        ["._aacAJ5KnW{font-style:oblique 0deg;}"],
        1,
        0,
        1,
        [("value", "AJ5KnW", "val\\0ac\\0& | \\0font-style:oblique 0deg")],
      ),
      (
        "_aa6IbnS79",
        ["._aa6IbnS79{font-optical-sizing:none;}"],
        1,
        0,
        1,
        [("value", "IbnS79", "val\\0a6\\0& | \\0font-optical-sizing:none")],
      ),
      (
        "_aa63F2x54",
        ["._aa63F2x54{font-optical-sizing:auto;}"],
        1,
        0,
        1,
        [("value", "3F2x54", "val\\0a6\\0& | \\0font-optical-sizing:auto")],
      ),
      (
        "_aa79IOUMf",
        ["._aa79IOUMf{font-palette:normal;}"],
        1,
        0,
        1,
        [("value", "9IOUMf", "val\\0a7\\0& | \\0font-palette:normal")],
      ),
      (
        "_aa751VCnU",
        ["._aa751VCnU{font-palette:light;}"],
        1,
        0,
        1,
        [("value", "51VCnU", "val\\0a7\\0& | \\0font-palette:light")],
      ),
      (
        "_aa7qWsLED",
        ["._aa7qWsLED{font-palette:dark;}"],
        1,
        0,
        1,
        [("value", "qWsLED", "val\\0a7\\0& | \\0font-palette:dark")],
      ),
      (
        "_aam0nfM-9",
        ["._aam0nfM-9{font-variant-emoji:normal;}"],
        1,
        0,
        1,
        [("value", "0nfM-9", "val\\0am\\0& | \\0font-variant-emoji:normal")],
      ),
      (
        "_aamMuEfUA",
        ["._aamMuEfUA{font-variant-emoji:text;}"],
        1,
        0,
        1,
        [("value", "MuEfUA", "val\\0am\\0& | \\0font-variant-emoji:text")],
      ),
      (
        "_aamnF9oKS",
        ["._aamnF9oKS{font-variant-emoji:emoji;}"],
        1,
        0,
        1,
        [("value", "nF9oKS", "val\\0am\\0& | \\0font-variant-emoji:emoji")],
      ),
      (
        "_aamJfALCx",
        ["._aamJfALCx{font-variant-emoji:unicode;}"],
        1,
        0,
        1,
        [("value", "JfALCx", "val\\0am\\0& | \\0font-variant-emoji:unicode")],
      ),
      (
        "_aabnS71Fu",
        ["._aabnS71Fu{font-stretch:normal;}"],
        1,
        0,
        1,
        [("value", "nS71Fu", "val\\0ab\\0& | \\0font-stretch:normal")],
      ),
      (
        "_aabWtM9y6",
        ["._aabWtM9y6{font-stretch:ultra-condensed;}"],
        1,
        0,
        1,
        [
          ("value", "WtM9y6", "val\\0ab\\0& | \\0font-stretch:ultra-condensed"),
        ],
      ),
      (
        "_aabKNBupd",
        ["._aabKNBupd{font-stretch:extra-condensed;}"],
        1,
        0,
        1,
        [
          ("value", "KNBupd", "val\\0ab\\0& | \\0font-stretch:extra-condensed"),
        ],
      ),
      (
        "_aabBZ6caK",
        ["._aabBZ6caK{font-stretch:condensed;}"],
        1,
        0,
        1,
        [("value", "BZ6caK", "val\\0ab\\0& | \\0font-stretch:condensed")],
      ),
      (
        "_aab8Ox2lh",
        ["._aab8Ox2lh{font-stretch:semi-condensed;}"],
        1,
        0,
        1,
        [("value", "8Ox2lh", "val\\0ab\\0& | \\0font-stretch:semi-condensed")],
      ),
      (
        "_aabL2F5jy",
        ["._aabL2F5jy{font-stretch:semi-expanded;}"],
        1,
        0,
        1,
        [("value", "L2F5jy", "val\\0ab\\0& | \\0font-stretch:semi-expanded")],
      ),
      (
        "_aab2Z-CT2",
        ["._aab2Z-CT2{font-stretch:expanded;}"],
        1,
        0,
        1,
        [("value", "2Z-CT2", "val\\0ab\\0& | \\0font-stretch:expanded")],
      ),
      (
        "_aabmYSr_b",
        ["._aabmYSr_b{font-stretch:extra-expanded;}"],
        1,
        0,
        1,
        [("value", "mYSr_b", "val\\0ab\\0& | \\0font-stretch:extra-expanded")],
      ),
      (
        "_aabvUiKOy",
        ["._aabvUiKOy{font-stretch:ultra-expanded;}"],
        1,
        0,
        1,
        [("value", "vUiKOy", "val\\0ab\\0& | \\0font-stretch:ultra-expanded")],
      ),
      (
        "_aa9LvicXd",
        ["._aa9LvicXd{font-size-adjust:none;}"],
        1,
        0,
        1,
        [("value", "LvicXd", "val\\0a9\\0& | \\0font-size-adjust:none")],
      ),
      (
        "_aa9DpTa8u",
        ["._aa9DpTa8u{font-size-adjust:0.5;}"],
        1,
        0,
        1,
        [("value", "DpTa8u", "val\\0a9\\0& | \\0font-size-adjust:0.5")],
      ),
      (
        "_aadQVXVzR",
        ["._aadQVXVzR{font-synthesis:none;}"],
        1,
        0,
        3,
        [("value", "QVXVzR", "val\\0ad\\0& | \\0font-synthesis:none")],
      ),
      (
        "_aadHr9fsL",
        ["._aadHr9fsL{font-synthesis:weight;}"],
        1,
        0,
        3,
        [("value", "Hr9fsL", "val\\0ad\\0& | \\0font-synthesis:weight")],
      ),
      (
        "_aadFtscUe",
        ["._aadFtscUe{font-synthesis:style;}"],
        1,
        0,
        3,
        [("value", "FtscUe", "val\\0ad\\0& | \\0font-synthesis:style")],
      ),
      (
        "_aadXHfMVH",
        ["._aadXHfMVH{font-synthesis:weight style;}"],
        1,
        0,
        3,
        [("value", "XHfMVH", "val\\0ad\\0& | \\0font-synthesis:weight style")],
      ),
      (
        "_aadGrGcF_",
        ["._aadGrGcF_{font-synthesis:style weight;}"],
        1,
        0,
        3,
        [("value", "GrGcF_", "val\\0ad\\0& | \\0font-synthesis:style weight")],
      ),
      (
        "_aa4OV4wvM",
        ["._aa4OV4wvM{font-kerning:auto;}"],
        1,
        0,
        1,
        [("value", "OV4wvM", "val\\0a4\\0& | \\0font-kerning:auto")],
      ),
      (
        "_aa4eB0_Yd",
        ["._aa4eB0_Yd{font-kerning:normal;}"],
        1,
        0,
        1,
        [("value", "eB0_Yd", "val\\0a4\\0& | \\0font-kerning:normal")],
      ),
      (
        "_aa4sqbSnE",
        ["._aa4sqbSnE{font-kerning:none;}"],
        1,
        0,
        1,
        [("value", "sqbSnE", "val\\0a4\\0& | \\0font-kerning:none")],
      ),
      (
        "_aapQsOxGC",
        ["._aapQsOxGC{font-variant-position:normal;}"],
        1,
        0,
        1,
        [
          ("value", "QsOxGC", "val\\0ap\\0& | \\0font-variant-position:normal"),
        ],
      ),
      (
        "_aapRvcTwB",
        ["._aapRvcTwB{font-variant-position:sub;}"],
        1,
        0,
        1,
        [("value", "RvcTwB", "val\\0ap\\0& | \\0font-variant-position:sub")],
      ),
      (
        "_aap_Rw3t7",
        ["._aap_Rw3t7{font-variant-position:super;}"],
        1,
        0,
        1,
        [("value", "_Rw3t7", "val\\0ap\\0& | \\0font-variant-position:super")],
      ),
      (
        "_aan_NmZ90",
        ["._aan_NmZ90{font-variant-ligatures:normal;}"],
        1,
        0,
        1,
        [
          ("value", "_NmZ90", "val\\0an\\0& | \\0font-variant-ligatures:normal"),
        ],
      ),
      (
        "_aanOx7fzt",
        ["._aanOx7fzt{font-variant-ligatures:none;}"],
        1,
        0,
        1,
        [("value", "Ox7fzt", "val\\0an\\0& | \\0font-variant-ligatures:none")],
      ),
      (
        "_aan6Mc_Ux",
        ["._aan6Mc_Ux{font-variant-ligatures:common-ligatures;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6Mc_Ux",
            "val\\0an\\0& | \\0font-variant-ligatures:common-ligatures",
          ),
        ],
      ),
      (
        "_aanh933EN",
        ["._aanh933EN{font-variant-ligatures:no-common-ligatures;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "h933EN",
            "val\\0an\\0& | \\0font-variant-ligatures:no-common-ligatures",
          ),
        ],
      ),
      (
        "_aanyyRayC",
        ["._aanyyRayC{font-variant-ligatures:discretionary-ligatures;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "yyRayC",
            "val\\0an\\0& | \\0font-variant-ligatures:discretionary-ligatures",
          ),
        ],
      ),
      (
        "_aan6BcyrC",
        ["._aan6BcyrC{font-variant-ligatures:no-discretionary-ligatures;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6BcyrC",
            "val\\0an\\0& | \\0font-variant-ligatures:no-discretionary-ligatures",
          ),
        ],
      ),
      (
        "_aanbBwjRo",
        ["._aanbBwjRo{font-variant-ligatures:historical-ligatures;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "bBwjRo",
            "val\\0an\\0& | \\0font-variant-ligatures:historical-ligatures",
          ),
        ],
      ),
      (
        "_aan3e4g1H",
        ["._aan3e4g1H{font-variant-ligatures:no-historical-ligatures;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "3e4g1H",
            "val\\0an\\0& | \\0font-variant-ligatures:no-historical-ligatures",
          ),
        ],
      ),
      (
        "_aanBI8iHS",
        ["._aanBI8iHS{font-variant-ligatures:contextual;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "BI8iHS",
            "val\\0an\\0& | \\0font-variant-ligatures:contextual",
          ),
        ],
      ),
      (
        "_aanEgs2SC",
        ["._aanEgs2SC{font-variant-ligatures:no-contextual;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Egs2SC",
            "val\\0an\\0& | \\0font-variant-ligatures:no-contextual",
          ),
        ],
      ),
      (
        "_aanT-_ljb",
        [
          "._aanT-_ljb{font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "T-_ljb",
            "val\\0an\\0& | \\0font-variant-ligatures:common-ligatures discretionary-ligatures historical-ligatures contextual",
          ),
        ],
      ),
      (
        "_aaktC2d_P",
        ["._aaktC2d_P{font-variant-caps:normal;}"],
        1,
        0,
        1,
        [("value", "tC2d_P", "val\\0ak\\0& | \\0font-variant-caps:normal")],
      ),
      (
        "_aakobx2po",
        ["._aakobx2po{font-variant-caps:small-caps;}"],
        1,
        0,
        1,
        [
          ("value", "obx2po", "val\\0ak\\0& | \\0font-variant-caps:small-caps"),
        ],
      ),
      (
        "_aakJNgwFr",
        ["._aakJNgwFr{font-variant-caps:all-small-caps;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "JNgwFr",
            "val\\0ak\\0& | \\0font-variant-caps:all-small-caps",
          ),
        ],
      ),
      (
        "_aak0jIO2q",
        ["._aak0jIO2q{font-variant-caps:petite-caps;}"],
        1,
        0,
        1,
        [
          ("value", "0jIO2q", "val\\0ak\\0& | \\0font-variant-caps:petite-caps"),
        ],
      ),
      (
        "_aak09Crtv",
        ["._aak09Crtv{font-variant-caps:all-petite-caps;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "09Crtv",
            "val\\0ak\\0& | \\0font-variant-caps:all-petite-caps",
          ),
        ],
      ),
      (
        "_aak5mx2CP",
        ["._aak5mx2CP{font-variant-caps:titling-caps;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "5mx2CP",
            "val\\0ak\\0& | \\0font-variant-caps:titling-caps",
          ),
        ],
      ),
      (
        "_aakS2l7Gl",
        ["._aakS2l7Gl{font-variant-caps:unicase;}"],
        1,
        0,
        1,
        [("value", "S2l7Gl", "val\\0ak\\0& | \\0font-variant-caps:unicase")],
      ),
      (
        "_aaoSdp0Ed",
        ["._aaoSdp0Ed{font-variant-numeric:normal;}"],
        1,
        0,
        1,
        [("value", "Sdp0Ed", "val\\0ao\\0& | \\0font-variant-numeric:normal")],
      ),
      (
        "_aaoajOLM_",
        ["._aaoajOLM_{font-variant-numeric:lining-nums;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ajOLM_",
            "val\\0ao\\0& | \\0font-variant-numeric:lining-nums",
          ),
        ],
      ),
      (
        "_aaop7tZ93",
        ["._aaop7tZ93{font-variant-numeric:oldstyle-nums;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "p7tZ93",
            "val\\0ao\\0& | \\0font-variant-numeric:oldstyle-nums",
          ),
        ],
      ),
      (
        "_aao4fCK2S",
        ["._aao4fCK2S{font-variant-numeric:proportional-nums;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "4fCK2S",
            "val\\0ao\\0& | \\0font-variant-numeric:proportional-nums",
          ),
        ],
      ),
      (
        "_aao0MatCo",
        ["._aao0MatCo{font-variant-numeric:tabular-nums;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0MatCo",
            "val\\0ao\\0& | \\0font-variant-numeric:tabular-nums",
          ),
        ],
      ),
      (
        "_aaoItnrIB",
        ["._aaoItnrIB{font-variant-numeric:diagonal-fractions;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "ItnrIB",
            "val\\0ao\\0& | \\0font-variant-numeric:diagonal-fractions",
          ),
        ],
      ),
      (
        "_aaoOofq_k",
        ["._aaoOofq_k{font-variant-numeric:stacked-fractions;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Oofq_k",
            "val\\0ao\\0& | \\0font-variant-numeric:stacked-fractions",
          ),
        ],
      ),
      (
        "_aao1Ez-Y3",
        ["._aao1Ez-Y3{font-variant-numeric:ordinal;}"],
        1,
        0,
        1,
        [
          ("value", "1Ez-Y3", "val\\0ao\\0& | \\0font-variant-numeric:ordinal"),
        ],
      ),
      (
        "_aaoy1FJFI",
        ["._aaoy1FJFI{font-variant-numeric:slashed-zero;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "y1FJFI",
            "val\\0ao\\0& | \\0font-variant-numeric:slashed-zero",
          ),
        ],
      ),
      (
        "_aaoqwgl7i",
        [
          "._aaoqwgl7i{font-variant-numeric:lining-nums proportional-nums diagonal-fractions;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "qwgl7i",
            "val\\0ao\\0& | \\0font-variant-numeric:lining-nums proportional-nums diagonal-fractions",
          ),
        ],
      ),
      (
        "_aaoxdkRMG",
        [
          "._aaoxdkRMG{font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "xdkRMG",
            "val\\0ao\\0& | \\0font-variant-numeric:oldstyle-nums tabular-nums stacked-fractions ordinal slashed-zero",
          ),
        ],
      ),
      (
        "_aaogG4utz",
        [
          "._aaogG4utz{font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums;}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "gG4utz",
            "val\\0ao\\0& | \\0font-variant-numeric:slashed-zero ordinal tabular-nums stacked-fractions oldstyle-nums",
          ),
        ],
      ),
      (
        "_aalkJnx-F",
        ["._aalkJnx-F{font-variant-east-asian:normal;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "kJnx-F",
            "val\\0al\\0& | \\0font-variant-east-asian:normal",
          ),
        ],
      ),
      (
        "_aalVZg1-v",
        ["._aalVZg1-v{font-variant-east-asian:jis78;}"],
        1,
        0,
        1,
        [
          ("value", "VZg1-v", "val\\0al\\0& | \\0font-variant-east-asian:jis78"),
        ],
      ),
      (
        "_aalho9Xt9",
        ["._aalho9Xt9{font-variant-east-asian:jis83;}"],
        1,
        0,
        1,
        [
          ("value", "ho9Xt9", "val\\0al\\0& | \\0font-variant-east-asian:jis83"),
        ],
      ),
      (
        "_aalDxWqw9",
        ["._aalDxWqw9{font-variant-east-asian:jis90;}"],
        1,
        0,
        1,
        [
          ("value", "DxWqw9", "val\\0al\\0& | \\0font-variant-east-asian:jis90"),
        ],
      ),
      (
        "_aalU88aRy",
        ["._aalU88aRy{font-variant-east-asian:jis04;}"],
        1,
        0,
        1,
        [
          ("value", "U88aRy", "val\\0al\\0& | \\0font-variant-east-asian:jis04"),
        ],
      ),
      (
        "_aalvU3XiG",
        ["._aalvU3XiG{font-variant-east-asian:simplified;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "vU3XiG",
            "val\\0al\\0& | \\0font-variant-east-asian:simplified",
          ),
        ],
      ),
      (
        "_aal9Ojusu",
        ["._aal9Ojusu{font-variant-east-asian:traditional;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "9Ojusu",
            "val\\0al\\0& | \\0font-variant-east-asian:traditional",
          ),
        ],
      ),
      (
        "_aalFSrs6n",
        ["._aalFSrs6n{font-variant-east-asian:full-width;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FSrs6n",
            "val\\0al\\0& | \\0font-variant-east-asian:full-width",
          ),
        ],
      ),
      (
        "_aalc0I_L8",
        ["._aalc0I_L8{font-variant-east-asian:proportional-width;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "c0I_L8",
            "val\\0al\\0& | \\0font-variant-east-asian:proportional-width",
          ),
        ],
      ),
      (
        "_aalrhQ7lb",
        ["._aalrhQ7lb{font-variant-east-asian:ruby;}"],
        1,
        0,
        1,
        [
          ("value", "rhQ7lb", "val\\0al\\0& | \\0font-variant-east-asian:ruby"),
        ],
      ),
      (
        "_aalinUYkm",
        ["._aalinUYkm{font-variant-east-asian:simplified full-width ruby;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "inUYkm",
            "val\\0al\\0& | \\0font-variant-east-asian:simplified full-width ruby",
          ),
        ],
      ),
      (
        "_aa3cTvj_U",
        ["._aa3cTvj_U{font-feature-settings:\"c2sc\";}"],
        1,
        0,
        1,
        [
          (
            "value",
            "cTvj_U",
            "val\\0a3\\0& | \\0font-feature-settings:\"c2sc\"",
          ),
        ],
      ),
      (
        "_aa35tt5Lt",
        ["._aa35tt5Lt{font-feature-settings:\"smcp\" on;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "5tt5Lt",
            "val\\0a3\\0& | \\0font-feature-settings:\"smcp\" on",
          ),
        ],
      ),
      (
        "_aa3MO7a2T",
        ["._aa3MO7a2T{font-feature-settings:\"liga\" off;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "MO7a2T",
            "val\\0a3\\0& | \\0font-feature-settings:\"liga\" off",
          ),
        ],
      ),
      (
        "_aa3E9aNY3",
        ["._aa3E9aNY3{font-feature-settings:\"smcp\", \"swsh\" 2;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "E9aNY3",
            "val\\0a3\\0& | \\0font-feature-settings:\"smcp\", \"swsh\" 2",
          ),
        ],
      ),
    ]
  ];
  
  let fonts: array(CSS.Types.FontFamilyName.t) = [|
    `quoted("Inter"),
    `quoted("Sans"),
  |];
  let fontStack: array(CSS.Types.FontFamilyName.t) = [|`quoted("Inter")|];
  let font: CSS.Types.FontFamily.t = `quoted("Inter");
  
  CSS.make("_aa2OTRNlu", []);
  CSS.make(
    "_aa2X_GaAL",
    [("--fonts-dsbp3l", CSS.Types.FontFamilies.toString(fonts))],
  );
  CSS.make("_aa2hXHfm-", []);
  CSS.make(
    "_aa2DBESAs",
    [("--fontStack-ejj69w", CSS.Types.FontFamilies.toString(fontStack))],
  );
  CSS.make("_aa2ufw0ge", []);
  CSS.make(
    "_aa27nZc4p",
    [("--font-14m54rr", CSS.Types.FontFamily.toString(font))],
  );
  CSS.make("_aa2BF5Mzn", []);
  
  CSS.make("_aahO2VtI7", []);
  CSS.make("_aagzrA9fs", []);
  CSS.make("_aafGq52Ns", []);
  CSS.make("_aaeEPQAKv", []);
  CSS.make("_aa8T1Qq8B", []);
  CSS.make("_aaiRToVPB", []);
  CSS.make("_aaicIF77j", []);
  CSS.make("_aaiUTtW3y", []);
  CSS.make("_aaimwMn-E", []);
  CSS.make("_aaiDuna0_", []);
  CSS.make("_aai2dL3W9", []);
  CSS.make("_aaiwJ_D2V", []);
  CSS.make("_aaidaqbMh", []);
  CSS.make("_aajhfn8kR", []);
  CSS.make("_aajD9OPiZ", []);
  CSS.make("_aajhrYuYZ", []);
  CSS.make("_aajZzuXpl", []);
  CSS.make("_aajjMfNIv", []);
  CSS.make("_aajSkvV_m", []);
  CSS.make("_aajew3hNg", []);
  CSS.make("_aajoKI7ik", []);
  CSS.make("_aajffUfXX", []);
  CSS.make("_aa3F4k8u3", []);
  CSS.make("_aa3Si0Gsx", []);
  CSS.make("_aa5Vm_2Dk", []);
  CSS.make("_aa5bhI2MV", []);
  CSS.make("_aarXbaTWW", []);
  CSS.make("_aarVc6_NL", []);
  CSS.make("_aar2O3VSk", []);
  CSS.make("_aartLJqhX", []);
  CSS.make("_aacRDZRLz", []);
  CSS.make("_aact_-OvO", []);
  CSS.make("_aacAJ5KnW", []);
  CSS.make("_aa6IbnS79", []);
  CSS.make("_aa63F2x54", []);
  CSS.make("_aa79IOUMf", []);
  CSS.make("_aa751VCnU", []);
  CSS.make("_aa7qWsLED", []);
  CSS.make("_aam0nfM-9", []);
  CSS.make("_aamMuEfUA", []);
  CSS.make("_aamnF9oKS", []);
  CSS.make("_aamJfALCx", []);
  
  CSS.make("_aabnS71Fu", []);
  CSS.make("_aabWtM9y6", []);
  CSS.make("_aabKNBupd", []);
  CSS.make("_aabBZ6caK", []);
  CSS.make("_aab8Ox2lh", []);
  CSS.make("_aabL2F5jy", []);
  CSS.make("_aab2Z-CT2", []);
  CSS.make("_aabmYSr_b", []);
  CSS.make("_aabvUiKOy", []);
  CSS.make("_aa9LvicXd", []);
  CSS.make("_aa9DpTa8u", []);
  CSS.make("_aadQVXVzR", []);
  CSS.make("_aadHr9fsL", []);
  CSS.make("_aadFtscUe", []);
  CSS.make("_aadXHfMVH", []);
  CSS.make("_aadGrGcF_", []);
  CSS.make("_aa4OV4wvM", []);
  CSS.make("_aa4eB0_Yd", []);
  CSS.make("_aa4sqbSnE", []);
  CSS.make("_aapQsOxGC", []);
  CSS.make("_aapRvcTwB", []);
  CSS.make("_aap_Rw3t7", []);
  CSS.make("_aan_NmZ90", []);
  CSS.make("_aanOx7fzt", []);
  CSS.make("_aan6Mc_Ux", []);
  CSS.make("_aanh933EN", []);
  CSS.make("_aanyyRayC", []);
  CSS.make("_aan6BcyrC", []);
  CSS.make("_aanbBwjRo", []);
  CSS.make("_aan3e4g1H", []);
  CSS.make("_aanBI8iHS", []);
  CSS.make("_aanEgs2SC", []);
  CSS.make("_aanT-_ljb", []);
  CSS.make("_aaktC2d_P", []);
  CSS.make("_aakobx2po", []);
  CSS.make("_aakJNgwFr", []);
  CSS.make("_aak0jIO2q", []);
  CSS.make("_aak09Crtv", []);
  CSS.make("_aak5mx2CP", []);
  CSS.make("_aakS2l7Gl", []);
  CSS.make("_aaoSdp0Ed", []);
  CSS.make("_aaoajOLM_", []);
  CSS.make("_aaop7tZ93", []);
  CSS.make("_aao4fCK2S", []);
  CSS.make("_aao0MatCo", []);
  CSS.make("_aaoItnrIB", []);
  CSS.make("_aaoOofq_k", []);
  CSS.make("_aao1Ez-Y3", []);
  CSS.make("_aaoy1FJFI", []);
  CSS.make("_aaoqwgl7i", []);
  CSS.make("_aaoxdkRMG", []);
  CSS.make("_aaogG4utz", []);
  CSS.make("_aalkJnx-F", []);
  CSS.make("_aalVZg1-v", []);
  CSS.make("_aalho9Xt9", []);
  CSS.make("_aalDxWqw9", []);
  CSS.make("_aalU88aRy", []);
  CSS.make("_aalvU3XiG", []);
  CSS.make("_aal9Ojusu", []);
  CSS.make("_aalFSrs6n", []);
  CSS.make("_aalc0I_L8", []);
  CSS.make("_aalrhQ7lb", []);
  CSS.make("_aalinUYkm", []);
  CSS.make("_aa3F4k8u3", []);
  CSS.make("_aa3cTvj_U", []);
  CSS.make("_aa35tt5Lt", []);
  CSS.make("_aa3MO7a2T", []);
  CSS.make("_aa3E9aNY3", []);
