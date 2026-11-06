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

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@property --colorTextString-1giwa8d{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-scmw6u{syntax:\"*\";inherits:false;}"];
  [@css "@property --c-1y1b95i{syntax:\"*\";inherits:false;}"];
  [@css "@property --maskedImageUrl-1qhb1c{syntax:\"*\";inherits:false;}"];
  [@css "@property --text-pz8ifa{syntax:\"*\";inherits:false;}"];
  [@css "@property --lola-18prcej{syntax:\"*\";inherits:false;}"];
  [@css "@property --lola-z0qww9{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-d1k6jd{syntax:\"*\";inherits:false;}"];
  [@css "@property --value-kytc9g{syntax:\"*\";inherits:false;}"];
  [@css "@property --interpolation-ljz9bc{syntax:\"*\";inherits:false;}"];
  [@css "@property --interpolation-1qkz86l{syntax:\"*\";inherits:false;}"];
  [@css.atoms
    [
      (
        "_ai7ZlHGBa",
        ["._ai7ZlHGBa{scroll-behavior:auto;}"],
        1,
        0,
        1,
        [("value", "ZlHGBa", "val\\0i7\\0& | \\0scroll-behavior:auto")],
      ),
      (
        "_ai7KfM3by",
        ["._ai7KfM3by{scroll-behavior:smooth;}"],
        1,
        0,
        1,
        [("value", "KfM3by", "val\\0i7\\0& | \\0scroll-behavior:smooth")],
      ),
      (
        "_afirmbhQj",
        ["._afirmbhQj{overflow-anchor:none;}"],
        1,
        0,
        1,
        [("value", "rmbhQj", "val\\0fi\\0& | \\0overflow-anchor:none")],
      ),
      (
        "_afi4GjZD4",
        ["._afi4GjZD4{overflow-anchor:auto;}"],
        1,
        0,
        1,
        [("value", "4GjZD4", "val\\0fi\\0& | \\0overflow-anchor:auto")],
      ),
      (
        "_a00PquroU",
        ["._a00PquroU{-moz-appearance:textfield;}"],
        1,
        0,
        1,
        [("value", "PquroU", "val\\000\\0& | \\0-moz-appearance:textfield")],
      ),
      (
        "_a4acMUuSe",
        ["._a4acMUuSe{-webkit-appearance:none;}"],
        1,
        0,
        1,
        [("value", "cMUuSe", "val\\04a\\0& | \\0-webkit-appearance:none")],
      ),
      (
        "_a2f6YcADB",
        ["._a2f6YcADB{-webkit-box-orient:vertical;}"],
        1,
        0,
        1,
        [("value", "6YcADB", "val\\02f\\0& | \\0-webkit-box-orient:vertical")],
      ),
      (
        "_a2ku4i_xM",
        ["._a2ku4i_xM{-webkit-line-clamp:2;}"],
        1,
        0,
        1,
        [("value", "u4i_xM", "val\\02k\\0& | \\0-webkit-line-clamp:2")],
      ),
      (
        "_a2xFfZYpw",
        ["._a2xFfZYpw{-webkit-overflow-scrolling:touch;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FfZYpw",
            "val\\02x\\0& | \\0-webkit-overflow-scrolling:touch",
          ),
        ],
      ),
      (
        "_a320sKm4U",
        ["._a320sKm4U{-webkit-tap-highlight-color:transparent;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0sKm4U",
            "val\\032\\0& | \\0-webkit-tap-highlight-color:transparent",
          ),
        ],
      ),
      (
        "_a35i0CS0z",
        [
          "._a35i0CS0z{-webkit-text-fill-color:var(--colorTextString-1giwa8d);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "i0CS0z",
            "val\\035\\0& | \\0-webkit-text-fill-color:$(colorTextString)",
          ),
        ],
      ),
      (
        "_a3syU5j_z",
        ["._a3syU5j_z{-webkit-animation:none;animation:none;}"],
        1,
        0,
        11,
        [("value", "yU5j_z", "val\\03s\\0& | \\0animation:none")],
      ),
      (
        "_a4aYLqRod",
        [
          "._a4aYLqRod{-webkit-appearance:none;-moz-appearance:none;-ms-appearance:none;appearance:none;}",
        ],
        1,
        0,
        1,
        [("value", "YLqRod", "val\\04a\\0& | \\0appearance:none")],
      ),
      (
        "_a4c8FKL6B",
        ["._a4c8FKL6B{aspect-ratio:21 / 8;}"],
        1,
        0,
        1,
        [("value", "8FKL6B", "val\\04c\\0& | \\0aspect-ratio:21 / 8")],
      ),
      (
        "_a4lxALByi",
        ["._a4lxALByi{background-color:var(--c-scmw6u);}"],
        1,
        0,
        1,
        [("value", "xALByi", "val\\04l\\0& | \\0background-color:$(c)")],
      ),
      (
        "_a50c0XN8y",
        ["._a50c0XN8y{border:none;}"],
        1,
        0,
        17,
        [("value", "c0XN8y", "val\\050\\0& | \\0border:none")],
      ),
      (
        "_a50iSKg4P",
        ["._a50iSKg4P{border:1px;}"],
        1,
        0,
        17,
        [("value", "iSKg4P", "val\\050\\0& | \\0border:1px")],
      ),
      (
        "_a50mQ0J5l",
        ["._a50mQ0J5l{border:thin;}"],
        1,
        0,
        17,
        [("value", "mQ0J5l", "val\\050\\0& | \\0border:thin")],
      ),
      (
        "_a50xl-Gj4",
        ["._a50xl-Gj4{border:1px solid;}"],
        1,
        0,
        17,
        [("value", "xl-Gj4", "val\\050\\0& | \\0border:1px solid")],
      ),
      (
        "_a508hlzmo",
        ["._a508hlzmo{border:thin dashed;}"],
        1,
        0,
        17,
        [("value", "8hlzmo", "val\\050\\0& | \\0border:thin dashed")],
      ),
      (
        "_a50UaH0F4",
        ["._a50UaH0F4{border:1px solid black;}"],
        1,
        0,
        17,
        [("value", "UaH0F4", "val\\050\\0& | \\0border:1px solid black")],
      ),
      (
        "_a50iCE_gS",
        ["._a50iCE_gS{border:thin dashed red;}"],
        1,
        0,
        17,
        [("value", "iCE_gS", "val\\050\\0& | \\0border:thin dashed red")],
      ),
      (
        "_a50hkW-Vg",
        ["._a50hkW-Vg{border:2px dotted #333;}"],
        1,
        0,
        17,
        [("value", "hkW-Vg", "val\\050\\0& | \\0border:2px dotted #333")],
      ),
      (
        "_a50x2KILW",
        ["._a50x2KILW{border:medium double blue;}"],
        1,
        0,
        17,
        [("value", "x2KILW", "val\\050\\0& | \\0border:medium double blue")],
      ),
      (
        "_a6qGq5uAd",
        ["._a6qGq5uAd{bottom:unset;}"],
        1,
        0,
        1,
        [("value", "Gq5uAd", "val\\06q\\0& | \\0bottom:unset")],
      ),
      (
        "_a70rDIiHK",
        ["._a70rDIiHK{box-shadow:none;}"],
        1,
        0,
        1,
        [("value", "rDIiHK", "val\\070\\0& | \\0box-shadow:none")],
      ),
      (
        "_a74-MnpYt",
        ["._a74-MnpYt{break-inside:avoid;}"],
        1,
        0,
        1,
        [("value", "-MnpYt", "val\\074\\0& | \\0break-inside:avoid")],
      ),
      (
        "_a79c5mced",
        ["._a79c5mced{caret-color:#e15a46;}"],
        1,
        0,
        1,
        [("value", "c5mced", "val\\079\\0& | \\0caret-color:#e15a46")],
      ),
      (
        "_a7f5UFNY0",
        ["._a7f5UFNY0{color:inherit;}"],
        1,
        0,
        1,
        [("value", "5UFNY0", "val\\07f\\0& | \\0color:inherit")],
      ),
      (
        "_a7fU0bw7D",
        ["._a7fU0bw7D{color:var(--color-link);}"],
        1,
        0,
        1,
        [("value", "U0bw7D", "val\\07f\\0& | \\0color:var(--color-link)")],
      ),
      (
        "_a85AXey2l",
        ["._a85AXey2l{-webkit-column-width:125px;column-width:125px;}"],
        1,
        0,
        1,
        [("value", "AXey2l", "val\\085\\0& | \\0column-width:125px")],
      ),
      (
        "_a85gfZ3hH",
        ["._a85gfZ3hH{-webkit-column-width:auto;column-width:auto;}"],
        1,
        0,
        1,
        [("value", "gfZ3hH", "val\\085\\0& | \\0column-width:auto")],
      ),
      (
        "_a9170wKTv",
        ["._a9170wKTv{counter-increment:ol;}"],
        1,
        0,
        1,
        [("value", "70wKTv", "val\\091\\0& | \\0counter-increment:ol")],
      ),
      (
        "_a92W86mkN",
        ["._a92W86mkN{counter-reset:ol;}"],
        1,
        0,
        1,
        [("value", "W86mkN", "val\\092\\0& | \\0counter-reset:ol")],
      ),
      (
        "_a9fZ_UND3",
        ["._a9fZ_UND3{display:-webkit-box;}"],
        1,
        0,
        1,
        [("value", "Z_UND3", "val\\09f\\0& | \\0display:-webkit-box")],
      ),
      (
        "_a9fyPJ81p",
        ["._a9fyPJ81p{display:contents;}"],
        1,
        0,
        1,
        [("value", "yPJ81p", "val\\09f\\0& | \\0display:contents")],
      ),
      (
        "_a9f7N3a1a",
        ["._a9f7N3a1a{display:table;}"],
        1,
        0,
        1,
        [("value", "7N3a1a", "val\\09f\\0& | \\0display:table")],
      ),
      (
        "_a9ldl1JCU",
        ["._a9ldl1JCU{fill:var(--c-1y1b95i);}"],
        1,
        0,
        1,
        [("value", "dl1JCU", "val\\09l\\0& | \\0fill:$(c)")],
      ),
      (
        "_a9l-iu02h",
        ["._a9l-iu02h{fill:currentColor;}"],
        1,
        0,
        1,
        [("value", "-iu02h", "val\\09l\\0& | \\0fill:currentColor")],
      ),
      (
        "_aauGtRWTT",
        ["._aauGtRWTT{gap:4px;}"],
        1,
        0,
        2,
        [("value", "GtRWTT", "val\\0au\\0& | \\0gap:4px")],
      ),
      (
        "_ab3C-n9Ng",
        ["._ab3C-n9Ng{grid-column-end:span 2;}"],
        1,
        0,
        1,
        [("value", "C-n9Ng", "val\\0b3\\0& | \\0grid-column-end:span 2")],
      ),
      (
        "_ab27xniyw",
        ["._ab27xniyw{-ms-grid-column:unset;grid-column:unset;}"],
        1,
        0,
        2,
        [("value", "7xniyw", "val\\0b2\\0& | \\0grid-column:unset")],
      ),
      (
        "_ab5zCzk3l",
        ["._ab5zCzk3l{-ms-grid-row:unset;grid-row:unset;}"],
        1,
        0,
        2,
        [("value", "zCzk3l", "val\\0b5\\0& | \\0grid-row:unset")],
      ),
      (
        "_abaW19h8G",
        ["._abaW19h8G{grid-template-columns:max-content max-content;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "W19h8G",
            "val\\0ba\\0& | \\0grid-template-columns:max-content max-content",
          ),
        ],
      ),
      (
        "_abayb_L6t",
        [
          "._abayb_L6t{grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "yb_L6t",
            "val\\0ba\\0& | \\0grid-template-columns:minmax(10px, auto) fit-content(20px) fit-content(20px)",
          ),
        ],
      ),
      (
        "_abaVTD_1A",
        [
          "._abaVTD_1A{grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "VTD_1A",
            "val\\0ba\\0& | \\0grid-template-columns:minmax(51px, auto) fit-content(20px) fit-content(20px)",
          ),
        ],
      ),
      (
        "_aba4sv0H6",
        ["._aba4sv0H6{grid-template-columns:repeat(2, auto);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "4sv0H6",
            "val\\0ba\\0& | \\0grid-template-columns:repeat(2, auto)",
          ),
        ],
      ),
      (
        "_abaJ9g-wc",
        ["._abaJ9g-wc{grid-template-columns:repeat(3, auto);}"],
        1,
        0,
        1,
        [
          (
            "value",
            "J9g-wc",
            "val\\0ba\\0& | \\0grid-template-columns:repeat(3, auto)",
          ),
        ],
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
        "_ac8Gx8pWa",
        ["._ac8Gx8pWa{justify-items:start;}"],
        1,
        0,
        1,
        [("value", "Gx8pWa", "val\\0c8\\0& | \\0justify-items:start")],
      ),
      (
        "_ac95GtJLN",
        ["._ac95GtJLN{justify-self:unset;}"],
        1,
        0,
        1,
        [("value", "5GtJLN", "val\\0c9\\0& | \\0justify-self:unset")],
      ),
      (
        "_ach6ZEYAH",
        ["._ach6ZEYAH{left:unset;}"],
        1,
        0,
        1,
        [("value", "6ZEYAH", "val\\0ch\\0& | \\0left:unset")],
      ),
      (
        "_adkB8EOHF",
        [
          "._adkB8EOHF{-webkit-mask-image:var(--maskedImageUrl-1qhb1c);mask-image:var(--maskedImageUrl-1qhb1c);}",
        ],
        1,
        0,
        1,
        [
          ("value", "B8EOHF", "val\\0dk\\0& | \\0mask-image:$(maskedImageUrl)"),
        ],
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
        "_ado-IjxqD",
        ["._ado-IjxqD{-webkit-mask-repeat:no-repeat;mask-repeat:no-repeat;}"],
        1,
        0,
        1,
        [("value", "-IjxqD", "val\\0do\\0& | \\0mask-repeat:no-repeat")],
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
        "_afcb9MGYC",
        ["._afcb9MGYC{outline:none;}"],
        1,
        0,
        3,
        [("value", "b9MGYC", "val\\0fc\\0& | \\0outline:none")],
      ),
      (
        "_agmkVrkn9",
        ["._agmkVrkn9{position:unset;}"],
        1,
        0,
        1,
        [("value", "kVrkn9", "val\\0gm\\0& | \\0position:unset")],
      ),
      (
        "_ah1yzcR5r",
        ["._ah1yzcR5r{resize:none;}"],
        1,
        0,
        1,
        [("value", "yzcR5r", "val\\0h1\\0& | \\0resize:none")],
      ),
      (
        "_ah6FqVpd7",
        ["._ah6FqVpd7{right:calc(50% - 4px);}"],
        1,
        0,
        1,
        [("value", "FqVpd7", "val\\0h6\\0& | \\0right:calc(50% - 4px)")],
      ),
      (
        "_akdAxNag1",
        ["._akdAxNag1{stroke-opacity:0;}"],
        1,
        0,
        1,
        [("value", "AxNag1", "val\\0kd\\0& | \\0stroke-opacity:0")],
      ),
      (
        "_ak6KyWjqH",
        ["._ak6KyWjqH{stroke:var(--text-pz8ifa);}"],
        1,
        0,
        1,
        [("value", "KyWjqH", "val\\0k6\\0& | \\0stroke:$(Color.text)")],
      ),
      (
        "_am44eyLtM",
        ["._am44eyLtM{top:calc(50% - 1px);}"],
        1,
        0,
        1,
        [("value", "4eyLtM", "val\\0m4\\0& | \\0top:calc(50% - 1px)")],
      ),
      (
        "_am4AG4_sY",
        ["._am4AG4_sY{top:unset;}"],
        1,
        0,
        1,
        [("value", "AG4_sY", "val\\0m4\\0& | \\0top:unset")],
      ),
      (
        "_am5K3jON5",
        ["._am5K3jON5{touch-action:none;}"],
        1,
        0,
        1,
        [("value", "K3jON5", "val\\0m5\\0& | \\0touch-action:none")],
      ),
      (
        "_am5vWL2hF",
        ["._am5vWL2hF{touch-action:pan-x pan-y;}"],
        1,
        0,
        1,
        [("value", "vWL2hF", "val\\0m5\\0& | \\0touch-action:pan-x pan-y")],
      ),
      (
        "_am8sY1Dd2",
        ["._am8sY1Dd2{transform-origin:center bottom;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "sY1Dd2",
            "val\\0m8\\0& | \\0transform-origin:center bottom",
          ),
        ],
      ),
      (
        "_am8BXiMiu",
        ["._am8BXiMiu{transform-origin:center left;}"],
        1,
        0,
        1,
        [
          ("value", "BXiMiu", "val\\0m8\\0& | \\0transform-origin:center left"),
        ],
      ),
      (
        "_am8qxheic",
        ["._am8qxheic{transform-origin:center right;}"],
        1,
        0,
        1,
        [
          ("value", "qxheic", "val\\0m8\\0& | \\0transform-origin:center right"),
        ],
      ),
      (
        "_am8bw3lfM",
        ["._am8bw3lfM{transform-origin:2px;}"],
        1,
        0,
        1,
        [("value", "bw3lfM", "val\\0m8\\0& | \\0transform-origin:2px")],
      ),
      (
        "_am8eiq9q3",
        ["._am8eiq9q3{transform-origin:bottom;}"],
        1,
        0,
        1,
        [("value", "eiq9q3", "val\\0m8\\0& | \\0transform-origin:bottom")],
      ),
      (
        "_am8Fgh94A",
        ["._am8Fgh94A{transform-origin:3cm 2px;}"],
        1,
        0,
        1,
        [("value", "Fgh94A", "val\\0m8\\0& | \\0transform-origin:3cm 2px")],
      ),
      (
        "_am8HZ_oTe",
        ["._am8HZ_oTe{transform-origin:left 2px;}"],
        1,
        0,
        1,
        [("value", "HZ_oTe", "val\\0m8\\0& | \\0transform-origin:left 2px")],
      ),
      (
        "_am8q3CURE",
        ["._am8q3CURE{transform-origin:center top;}"],
        1,
        0,
        1,
        [("value", "q3CURE", "val\\0m8\\0& | \\0transform-origin:center top")],
      ),
      (
        "_am6HuTSFA",
        [
          "._am6HuTSFA{-webkit-transform:none;-moz-transform:none;-ms-transform:none;transform:none;}",
        ],
        1,
        0,
        1,
        [("value", "HuTSFA", "val\\0m6\\0& | \\0transform:none")],
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
        "_amcq6x_Za",
        ["._amcq6x_Za{transition-delay:240ms;}"],
        1,
        0,
        1,
        [("value", "q6x_Za", "val\\0mc\\0& | \\0transition-delay:240ms")],
      ),
      (
        "_a3yeuVeot",
        [
          "._a3yeuVeot{-webkit-animation-duration:150ms;animation-duration:150ms;}",
        ],
        1,
        0,
        1,
        [("value", "euVeot", "val\\03y\\0& | \\0animation-duration:150ms")],
      ),
      (
        "_a6pyVGi1B",
        ["._a6pyVGi1B{border-width:thin;}"],
        1,
        0,
        4,
        [("value", "yVGi1B", "val\\06p\\0& | \\0border-width:thin")],
      ),
      (
        "_afgEVpS-v",
        ["._afgEVpS-v{outline-width:medium;}"],
        1,
        0,
        1,
        [("value", "EVpS-v", "val\\0fg\\0& | \\0outline-width:medium")],
      ),
      (
        "_afcmSrGvr",
        ["._afcmSrGvr{outline:medium solid red;}"],
        1,
        0,
        3,
        [("value", "mSrGvr", "val\\0fc\\0& | \\0outline:medium solid red")],
      ),
      (
        "_afhlKgiaO",
        ["._afhlKgiaO{overflow:var(--lola-18prcej);}"],
        1,
        0,
        2,
        [("value", "lKgiaO", "val\\0fh\\0& | \\0overflow:$(lola)")],
      ),
      (
        "_afhAcA9Lt",
        ["._afhAcA9Lt{overflow:hidden;}"],
        1,
        0,
        2,
        [("value", "AcA9Lt", "val\\0fh\\0& | \\0overflow:hidden")],
      ),
      (
        "_afpzakJ8E",
        ["._afpzakJ8E{overflow-y:var(--lola-z0qww9);}"],
        1,
        0,
        1,
        [("value", "zakJ8E", "val\\0fp\\0& | \\0overflow-y:$(lola)")],
      ),
      (
        "_afoL3rz1S",
        ["._afoL3rz1S{overflow-x:hidden;}"],
        1,
        0,
        1,
        [("value", "L3rz1S", "val\\0fo\\0& | \\0overflow-x:hidden")],
      ),
      (
        "_afjwDCg5p",
        ["._afjwDCg5p{overflow-block:hidden;}"],
        1,
        0,
        1,
        [("value", "wDCg5p", "val\\0fj\\0& | \\0overflow-block:hidden")],
      ),
      (
        "_afjatKelS",
        ["._afjatKelS{overflow-block:var(--value-d1k6jd);}"],
        1,
        0,
        1,
        [("value", "atKelS", "val\\0fj\\0& | \\0overflow-block:$(value)")],
      ),
      (
        "_afmzV14sT",
        ["._afmzV14sT{overflow-inline:var(--value-kytc9g);}"],
        1,
        0,
        1,
        [("value", "zV14sT", "val\\0fm\\0& | \\0overflow-inline:$(value)")],
      ),
      (
        "_a4mbWDFMV",
        [
          "._a4mbWDFMV{background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%);}",
        ],
        1,
        0,
        1,
        [
          (
            "value",
            "bWDFMV",
            "val\\04m\\0& | \\0background-image:linear-gradient(84deg, #F80 0%, rgba(255, 255, 255, 0.8) 50%, #2A97FF 100%)",
          ),
        ],
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
        "_ah6Mim-rP",
        ["._ah6Mim-rP{right:var(--interpolation-ljz9bc);}"],
        1,
        0,
        1,
        [("value", "Mim-rP", "val\\0h6\\0& | \\0right:$(interpolation)")],
      ),
      (
        "_a6qAEI5Tv",
        ["._a6qAEI5Tv{bottom:var(--interpolation-1qkz86l);}"],
        1,
        0,
        1,
        [("value", "AEI5Tv", "val\\06q\\0& | \\0bottom:$(interpolation)")],
      ),
    ]
  ];
  
  CSS.make("_ai7ZlHGBa", []);
  CSS.make("_ai7KfM3by", []);
  
  CSS.make("_afirmbhQj", []);
  CSS.make("_afi4GjZD4", []);
  
  CSS.make("_a00PquroU", []);
  CSS.make("_a4acMUuSe", []);
  CSS.make("_a2f6YcADB", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let _backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make("_a2ku4i_xM", []);
  CSS.make("_a2xFfZYpw", []);
  CSS.make("_a320sKm4U", []);
  CSS.make(
    "_a35i0CS0z",
    [
      (
        "--colorTextString-1giwa8d",
        CSS.Types.WebkitTextFillColor.toString(colorTextString),
      ),
    ],
  );
  CSS.make("_a3syU5j_z", []);
  CSS.make("_a4aYLqRod", []);
  CSS.make("_a4c8FKL6B", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("_a4lxALByi", [("--c-scmw6u", CSS.Types.Color.toString(c))]);
  
  CSS.make("_a50c0XN8y", []);
  
  CSS.make("_a50iSKg4P", []);
  CSS.make("_a50mQ0J5l", []);
  
  CSS.make("_a50xl-Gj4", []);
  CSS.make("_a508hlzmo", []);
  
  CSS.make("_a50UaH0F4", []);
  CSS.make("_a50iCE_gS", []);
  CSS.make("_a50hkW-Vg", []);
  CSS.make("_a50x2KILW", []);
  CSS.make("_a6qGq5uAd", []);
  CSS.make("_a70rDIiHK", []);
  CSS.make("_a74-MnpYt", []);
  CSS.make("_a79c5mced", []);
  CSS.make("_a7f5UFNY0", []);
  CSS.make("_a7fU0bw7D", []);
  CSS.make("_a85AXey2l", []);
  CSS.make("_a85gfZ3hH", []);
  CSS.make("_a9170wKTv", []);
  CSS.make("_a92W86mkN", []);
  CSS.make("_a9fZ_UND3", []);
  CSS.make("_a9fyPJ81p", []);
  CSS.make("_a9f7N3a1a", []);
  CSS.make("_a9ldl1JCU", [("--c-1y1b95i", CSS.Types.Paint.toString(c))]);
  CSS.make("_a9l-iu02h", []);
  CSS.make("_aauGtRWTT", []);
  CSS.make("_ab3C-n9Ng", []);
  CSS.make("_ab27xniyw", []);
  CSS.make("_ab5zCzk3l", []);
  CSS.make("_abaW19h8G", []);
  CSS.make("_abayb_L6t", []);
  CSS.make("_abaVTD_1A", []);
  CSS.make("_aba4sv0H6", []);
  CSS.make("_abaJ9g-wc", []);
  CSS.make("_abdGMH-lc", []);
  CSS.make("_ac8Gx8pWa", []);
  CSS.make("_ac95GtJLN", []);
  CSS.make("_ach6ZEYAH", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "_adkB8EOHF",
    [
      ("--maskedImageUrl-1qhb1c", CSS.Types.MaskImage.toString(maskedImageUrl)),
    ],
  );
  CSS.make("_adnjtDGCC", []);
  CSS.make("_ado-IjxqD", []);
  CSS.make("_adznwfDVz", []);
  CSS.make("_afcb9MGYC", []);
  CSS.make("_afirmbhQj", []);
  CSS.make("_agmkVrkn9", []);
  CSS.make("_ah1yzcR5r", []);
  CSS.make("_ah6FqVpd7", []);
  CSS.make("_ai7KfM3by", []);
  CSS.make("_akdAxNag1", []);
  CSS.make(
    "_ak6KyWjqH",
    [("--text-pz8ifa", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("_am44eyLtM", []);
  CSS.make("_am4AG4_sY", []);
  CSS.make("_am5K3jON5", []);
  CSS.make("_am5vWL2hF", []);
  CSS.make("_am8sY1Dd2", []);
  CSS.make("_am8BXiMiu", []);
  CSS.make("_am8qxheic", []);
  CSS.make("_am8bw3lfM", []);
  CSS.make("_am8eiq9q3", []);
  CSS.make("_am8Fgh94A", []);
  CSS.make("_am8HZ_oTe", []);
  CSS.make("_am8q3CURE", []);
  CSS.make("_am6HuTSFA", []);
  
  CSS.make("_an8GbUK3p", []);
  CSS.make("_an8PyQzDr", []);
  
  CSS.make("_amcq6x_Za", []);
  CSS.make("_a3yeuVeot", []);
  
  CSS.make("_a6pyVGi1B", []);
  CSS.make("_afgEVpS-v", []);
  CSS.make("_afcmSrGvr", []);
  
  let lola = `hidden;
  CSS.make(
    "_afhlKgiaO",
    [("--lola-18prcej", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("_afhAcA9Lt", []);
  CSS.make(
    "_afpzakJ8E",
    [("--lola-z0qww9", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("_afoL3rz1S", []);
  
  let value = `clip;
  CSS.make("_afjwDCg5p", []);
  CSS.make(
    "_afjatKelS",
    [("--value-d1k6jd", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "_afmzV14sT",
    [("--value-kytc9g", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.make("_a4mbWDFMV", []);
  
  CSS.make("_a4c6pCvf8", []);
  
  CSS.make("_a7fU0bw7D", []);
  
  let interpolation = `px(10);
  CSS.make(
    "_ah6Mim-rP _a6qAEI5Tv",
    [
      ("--interpolation-ljz9bc", CSS.Types.Right.toString(interpolation)),
      ("--interpolation-1qkz86l", CSS.Types.Bottom.toString(interpolation)),
    ],
  );

  $ dune build
