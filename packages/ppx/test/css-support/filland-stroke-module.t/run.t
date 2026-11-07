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
  [@css.atoms
    [
      (
        "_a9nCgL02t",
        ["._a9nCgL02t{fill-rule:nonzero;}"],
        1,
        0,
        1,
        [("value", "CgL02t", "val\\09n\\0& | \\0fill-rule:nonzero")],
      ),
      (
        "_a9nvzQ_zq",
        ["._a9nvzQ_zq{fill-rule:evenodd;}"],
        1,
        0,
        1,
        [("value", "vzQ_zq", "val\\09n\\0& | \\0fill-rule:evenodd")],
      ),
      (
        "_a9mW-vXJ7",
        ["._a9mW-vXJ7{fill-opacity:0.5;}"],
        1,
        0,
        1,
        [("value", "W-vXJ7", "val\\09m\\0& | \\0fill-opacity:0.5")],
      ),
      (
        "_a9m5bass3",
        ["._a9m5bass3{fill-opacity:45%;}"],
        1,
        0,
        1,
        [("value", "5bass3", "val\\09m\\0& | \\0fill-opacity:45%")],
      ),
      (
        "_akeHV_IBx",
        ["._akeHV_IBx{stroke-width:0;}"],
        1,
        0,
        1,
        [("value", "HV_IBx", "val\\0ke\\0& | \\0stroke-width:0")],
      ),
      (
        "_akel7tnSl",
        ["._akel7tnSl{stroke-width:1px;}"],
        1,
        0,
        1,
        [("value", "l7tnSl", "val\\0ke\\0& | \\0stroke-width:1px")],
      ),
      (
        "_akeM-Q8qz",
        ["._akeM-Q8qz{stroke-width:25%;}"],
        1,
        0,
        1,
        [("value", "M-Q8qz", "val\\0ke\\0& | \\0stroke-width:25%")],
      ),
      (
        "_aka59Sbw5",
        ["._aka59Sbw5{stroke-linecap:butt;}"],
        1,
        0,
        1,
        [("value", "59Sbw5", "val\\0ka\\0& | \\0stroke-linecap:butt")],
      ),
      (
        "_akaXjb-cC",
        ["._akaXjb-cC{stroke-linecap:round;}"],
        1,
        0,
        1,
        [("value", "Xjb-cC", "val\\0ka\\0& | \\0stroke-linecap:round")],
      ),
      (
        "_akac_aoHZ",
        ["._akac_aoHZ{stroke-linecap:square;}"],
        1,
        0,
        1,
        [("value", "c_aoHZ", "val\\0ka\\0& | \\0stroke-linecap:square")],
      ),
      (
        "_akbQm4xEP",
        ["._akbQm4xEP{stroke-linejoin:miter;}"],
        1,
        0,
        1,
        [("value", "Qm4xEP", "val\\0kb\\0& | \\0stroke-linejoin:miter")],
      ),
      (
        "_akbTnGHWM",
        ["._akbTnGHWM{stroke-linejoin:bevel;}"],
        1,
        0,
        1,
        [("value", "TnGHWM", "val\\0kb\\0& | \\0stroke-linejoin:bevel")],
      ),
      (
        "_akbnq-P5X",
        ["._akbnq-P5X{stroke-linejoin:round;}"],
        1,
        0,
        1,
        [("value", "nq-P5X", "val\\0kb\\0& | \\0stroke-linejoin:round")],
      ),
      (
        "_akcaYJzl4",
        ["._akcaYJzl4{stroke-miterlimit:4;}"],
        1,
        0,
        1,
        [("value", "aYJzl4", "val\\0kc\\0& | \\0stroke-miterlimit:4")],
      ),
    ]
  ];
  
  CSS.make("_a9nCgL02t", []);
  CSS.make("_a9nvzQ_zq", []);
  
  CSS.make("_a9mW-vXJ7", []);
  CSS.make("_a9m5bass3", []);
  
  CSS.make("_akeHV_IBx", []);
  CSS.make("_akel7tnSl", []);
  CSS.make("_akeM-Q8qz", []);
  
  CSS.make("_aka59Sbw5", []);
  CSS.make("_akaXjb-cC", []);
  CSS.make("_akac_aoHZ", []);
  
  CSS.make("_akbQm4xEP", []);
  CSS.make("_akbTnGHWM", []);
  CSS.make("_akbnq-P5X", []);
  
  CSS.make("_akcaYJzl4", []);
