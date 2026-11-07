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
        "_an8PyQzDr",
        [
          "._an8PyQzDr{width:-webkit-max-content;width:-moz-max-content;width:max-content;}",
        ],
        1,
        0,
        1,
        [("value", "PyQzDr", "val\\0n8\\0& | \\0width:max-content")],
      ),
      (
        "_an8nSf-2W",
        [
          "._an8nSf-2W{width:-webkit-min-content;width:-moz-min-content;width:min-content;}",
        ],
        1,
        0,
        1,
        [("value", "nSf-2W", "val\\0n8\\0& | \\0width:min-content")],
      ),
      (
        "_an8dZeTM0",
        ["._an8dZeTM0{width:fit-content(10%);}"],
        1,
        0,
        1,
        [("value", "dZeTM0", "val\\0n8\\0& | \\0width:fit-content(10%)")],
      ),
      (
        "_aesVqQv3D",
        [
          "._aesVqQv3D{min-width:-webkit-max-content;min-width:-moz-max-content;min-width:max-content;}",
        ],
        1,
        0,
        1,
        [("value", "VqQv3D", "val\\0es\\0& | \\0min-width:max-content")],
      ),
      (
        "_aesJ3MEk2",
        [
          "._aesJ3MEk2{min-width:-webkit-min-content;min-width:-moz-min-content;min-width:min-content;}",
        ],
        1,
        0,
        1,
        [("value", "J3MEk2", "val\\0es\\0& | \\0min-width:min-content")],
      ),
      (
        "_aesIdbByQ",
        ["._aesIdbByQ{min-width:fit-content(10%);}"],
        1,
        0,
        1,
        [("value", "IdbByQ", "val\\0es\\0& | \\0min-width:fit-content(10%)")],
      ),
      (
        "_adznwfDVz",
        [
          "._adznwfDVz{max-width:-webkit-max-content;max-width:-moz-max-content;max-width:max-content;}",
        ],
        1,
        0,
        1,
        [("value", "nwfDVz", "val\\0dz\\0& | \\0max-width:max-content")],
      ),
      (
        "_adzjH_5eC",
        [
          "._adzjH_5eC{max-width:-webkit-min-content;max-width:-moz-min-content;max-width:min-content;}",
        ],
        1,
        0,
        1,
        [("value", "jH_5eC", "val\\0dz\\0& | \\0max-width:min-content")],
      ),
      (
        "_adzGpeY4i",
        ["._adzGpeY4i{max-width:fit-content(10%);}"],
        1,
        0,
        1,
        [("value", "GpeY4i", "val\\0dz\\0& | \\0max-width:fit-content(10%)")],
      ),
      (
        "_abdgX0xS1",
        [
          "._abdgX0xS1{height:-webkit-max-content;height:-moz-max-content;height:max-content;}",
        ],
        1,
        0,
        1,
        [("value", "gX0xS1", "val\\0bd\\0& | \\0height:max-content")],
      ),
      (
        "_abdiIpE7r",
        [
          "._abdiIpE7r{height:-webkit-min-content;height:-moz-min-content;height:min-content;}",
        ],
        1,
        0,
        1,
        [("value", "iIpE7r", "val\\0bd\\0& | \\0height:min-content")],
      ),
      (
        "_abdvy45Kh",
        ["._abdvy45Kh{height:fit-content(10%);}"],
        1,
        0,
        1,
        [("value", "vy45Kh", "val\\0bd\\0& | \\0height:fit-content(10%)")],
      ),
      (
        "_aeqSAou6B",
        [
          "._aeqSAou6B{min-height:-webkit-max-content;min-height:-moz-max-content;min-height:max-content;}",
        ],
        1,
        0,
        1,
        [("value", "SAou6B", "val\\0eq\\0& | \\0min-height:max-content")],
      ),
      (
        "_aeqXu-x0e",
        [
          "._aeqXu-x0e{min-height:-webkit-min-content;min-height:-moz-min-content;min-height:min-content;}",
        ],
        1,
        0,
        1,
        [("value", "Xu-x0e", "val\\0eq\\0& | \\0min-height:min-content")],
      ),
      (
        "_aeq5od4f3",
        ["._aeq5od4f3{min-height:fit-content(10%);}"],
        1,
        0,
        1,
        [("value", "5od4f3", "val\\0eq\\0& | \\0min-height:fit-content(10%)")],
      ),
      (
        "_adwJqKbpx",
        [
          "._adwJqKbpx{max-height:-webkit-max-content;max-height:-moz-max-content;max-height:max-content;}",
        ],
        1,
        0,
        1,
        [("value", "JqKbpx", "val\\0dw\\0& | \\0max-height:max-content")],
      ),
      (
        "_adwyC3Xe4",
        [
          "._adwyC3Xe4{max-height:-webkit-min-content;max-height:-moz-min-content;max-height:min-content;}",
        ],
        1,
        0,
        1,
        [("value", "yC3Xe4", "val\\0dw\\0& | \\0max-height:min-content")],
      ),
      (
        "_adwtQSpjS",
        ["._adwtQSpjS{max-height:fit-content(10%);}"],
        1,
        0,
        1,
        [("value", "tQSpjS", "val\\0dw\\0& | \\0max-height:fit-content(10%)")],
      ),
      (
        "_a4co4-uwh",
        ["._a4co4-uwh{aspect-ratio:auto;}"],
        1,
        0,
        1,
        [("value", "o4-uwh", "val\\04c\\0& | \\0aspect-ratio:auto")],
      ),
      (
        "_a4cBFpuvi",
        ["._a4cBFpuvi{aspect-ratio:2;}"],
        1,
        0,
        1,
        [("value", "BFpuvi", "val\\04c\\0& | \\0aspect-ratio:2")],
      ),
      (
        "_a4c6pCvf8",
        ["._a4c6pCvf8{aspect-ratio:16 / 9;}"],
        1,
        0,
        1,
        [("value", "6pCvf8", "val\\04c\\0& | \\0aspect-ratio:16 / 9")],
      ),
      (
        "_an8GbUK3p",
        [
          "._an8GbUK3p{width:-webkit-fit-content;width:-moz-fit-content;width:fit-content;}",
        ],
        1,
        0,
        1,
        [("value", "GbUK3p", "val\\0n8\\0& | \\0width:fit-content")],
      ),
      (
        "_aesLISmfG",
        [
          "._aesLISmfG{min-width:-webkit-fit-content;min-width:-moz-fit-content;min-width:fit-content;}",
        ],
        1,
        0,
        1,
        [("value", "LISmfG", "val\\0es\\0& | \\0min-width:fit-content")],
      ),
      (
        "_adzrE9B8E",
        [
          "._adzrE9B8E{max-width:-webkit-fit-content;max-width:-moz-fit-content;max-width:fit-content;}",
        ],
        1,
        0,
        1,
        [("value", "rE9B8E", "val\\0dz\\0& | \\0max-width:fit-content")],
      ),
      (
        "_abdGMH-lc",
        [
          "._abdGMH-lc{height:-webkit-fit-content;height:-moz-fit-content;height:fit-content;}",
        ],
        1,
        0,
        1,
        [("value", "GMH-lc", "val\\0bd\\0& | \\0height:fit-content")],
      ),
      (
        "_aeqGwmxhs",
        [
          "._aeqGwmxhs{min-height:-webkit-fit-content;min-height:-moz-fit-content;min-height:fit-content;}",
        ],
        1,
        0,
        1,
        [("value", "Gwmxhs", "val\\0eq\\0& | \\0min-height:fit-content")],
      ),
      (
        "_adw1Mmfr5",
        [
          "._adw1Mmfr5{max-height:-webkit-fit-content;max-height:-moz-fit-content;max-height:fit-content;}",
        ],
        1,
        0,
        1,
        [("value", "1Mmfr5", "val\\0dw\\0& | \\0max-height:fit-content")],
      ),
    ]
  ];
  
  CSS.make("_an8PyQzDr", []);
  CSS.make("_an8nSf-2W", []);
  CSS.make("_an8dZeTM0", []);
  CSS.make("_aesVqQv3D", []);
  CSS.make("_aesJ3MEk2", []);
  CSS.make("_aesIdbByQ", []);
  CSS.make("_adznwfDVz", []);
  CSS.make("_adzjH_5eC", []);
  CSS.make("_adzGpeY4i", []);
  CSS.make("_abdgX0xS1", []);
  CSS.make("_abdiIpE7r", []);
  CSS.make("_abdvy45Kh", []);
  CSS.make("_aeqSAou6B", []);
  CSS.make("_aeqXu-x0e", []);
  CSS.make("_aeq5od4f3", []);
  CSS.make("_adwJqKbpx", []);
  CSS.make("_adwyC3Xe4", []);
  CSS.make("_adwtQSpjS", []);
  
  CSS.make("_a4co4-uwh", []);
  CSS.make("_a4cBFpuvi", []);
  CSS.make("_a4c6pCvf8", []);
  
  CSS.make("_an8GbUK3p", []);
  
  CSS.make("_aesLISmfG", []);
  
  CSS.make("_adzrE9B8E", []);
  
  CSS.make("_abdGMH-lc", []);
  
  CSS.make("_aeqGwmxhs", []);
  
  CSS.make("_adw1Mmfr5", []);
