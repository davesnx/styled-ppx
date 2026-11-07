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
        "_alosNeqHG",
        ["._alosNeqHG{text-transform:full-width;}"],
        1,
        0,
        1,
        [("value", "sNeqHG", "val\\0lo\\0& | \\0text-transform:full-width")],
      ),
      (
        "_aloaCfWqQ",
        ["._aloaCfWqQ{text-transform:full-size-kana;}"],
        1,
        0,
        1,
        [
          ("value", "aCfWqQ", "val\\0lo\\0& | \\0text-transform:full-size-kana"),
        ],
      ),
      (
        "_akj_L8jBH",
        ["._akj_L8jBH{-moz-tab-size:4;-o-tab-size:4;tab-size:4;}"],
        1,
        0,
        1,
        [("value", "_L8jBH", "val\\0kj\\0& | \\0tab-size:4")],
      ),
      (
        "_akjAk0enB",
        ["._akjAk0enB{-moz-tab-size:1em;-o-tab-size:1em;tab-size:1em;}"],
        1,
        0,
        1,
        [("value", "Ak0enB", "val\\0kj\\0& | \\0tab-size:1em")],
      ),
      (
        "_ackIEZOLU",
        ["._ackIEZOLU{line-break:auto;}"],
        1,
        0,
        1,
        [("value", "IEZOLU", "val\\0ck\\0& | \\0line-break:auto")],
      ),
      (
        "_acksOSKlg",
        ["._acksOSKlg{line-break:loose;}"],
        1,
        0,
        1,
        [("value", "sOSKlg", "val\\0ck\\0& | \\0line-break:loose")],
      ),
      (
        "_ackRvd1Zk",
        ["._ackRvd1Zk{line-break:normal;}"],
        1,
        0,
        1,
        [("value", "Rvd1Zk", "val\\0ck\\0& | \\0line-break:normal")],
      ),
      (
        "_ackCgOXgQ",
        ["._ackCgOXgQ{line-break:strict;}"],
        1,
        0,
        1,
        [("value", "CgOXgQ", "val\\0ck\\0& | \\0line-break:strict")],
      ),
      (
        "_ackkl0Hst",
        ["._ackkl0Hst{line-break:anywhere;}"],
        1,
        0,
        1,
        [("value", "kl0Hst", "val\\0ck\\0& | \\0line-break:anywhere")],
      ),
      (
        "_anapJKoci",
        ["._anapJKoci{word-break:normal;}"],
        1,
        0,
        1,
        [("value", "pJKoci", "val\\0na\\0& | \\0word-break:normal")],
      ),
      (
        "_anaAqdjxG",
        ["._anaAqdjxG{word-break:keep-all;}"],
        1,
        0,
        1,
        [("value", "AqdjxG", "val\\0na\\0& | \\0word-break:keep-all")],
      ),
      (
        "_anaLZNWUV",
        ["._anaLZNWUV{word-break:break-all;}"],
        1,
        0,
        1,
        [("value", "LZNWUV", "val\\0na\\0& | \\0word-break:break-all")],
      ),
      (
        "_an5dX2dBN",
        ["._an5dX2dBN{white-space:break-spaces;}"],
        1,
        0,
        2,
        [("value", "dX2dBN", "val\\0n5\\0& | \\0white-space:break-spaces")],
      ),
      (
        "_abjStI8L2",
        [
          "._abjStI8L2{-webkit-hyphens:auto;-moz-hyphens:auto;-ms-hyphens:auto;hyphens:auto;}",
        ],
        1,
        0,
        1,
        [("value", "StI8L2", "val\\0bj\\0& | \\0hyphens:auto")],
      ),
      (
        "_abjGnOMpr",
        [
          "._abjGnOMpr{-webkit-hyphens:manual;-moz-hyphens:manual;-ms-hyphens:manual;hyphens:manual;}",
        ],
        1,
        0,
        1,
        [("value", "GnOMpr", "val\\0bj\\0& | \\0hyphens:manual")],
      ),
      (
        "_abjBtIUc3",
        [
          "._abjBtIUc3{-webkit-hyphens:none;-moz-hyphens:none;-ms-hyphens:none;hyphens:none;}",
        ],
        1,
        0,
        1,
        [("value", "BtIUc3", "val\\0bj\\0& | \\0hyphens:none")],
      ),
      (
        "_afnQf45Dj",
        ["._afnQf45Dj{overflow-wrap:normal;}"],
        1,
        0,
        1,
        [("value", "Qf45Dj", "val\\0fn\\0& | \\0overflow-wrap:normal")],
      ),
      (
        "_afnBD_3Zs",
        ["._afnBD_3Zs{overflow-wrap:break-word;}"],
        1,
        0,
        1,
        [("value", "BD_3Zs", "val\\0fn\\0& | \\0overflow-wrap:break-word")],
      ),
      (
        "_afn0UsS31",
        ["._afn0UsS31{overflow-wrap:anywhere;}"],
        1,
        0,
        1,
        [("value", "0UsS31", "val\\0fn\\0& | \\0overflow-wrap:anywhere")],
      ),
      (
        "_afncue6Al",
        ["._afncue6Al{word-wrap:normal;}"],
        1,
        0,
        1,
        [("value", "cue6Al", "val\\0fn\\0& | \\0word-wrap:normal")],
      ),
      (
        "_afnTeGr8u",
        ["._afnTeGr8u{word-wrap:break-word;}"],
        1,
        0,
        1,
        [("value", "TeGr8u", "val\\0fn\\0& | \\0word-wrap:break-word")],
      ),
      (
        "_afnI9IWNd",
        ["._afnI9IWNd{word-wrap:anywhere;}"],
        1,
        0,
        1,
        [("value", "I9IWNd", "val\\0fn\\0& | \\0word-wrap:anywhere")],
      ),
      (
        "_aklJ9YIHq",
        ["._aklJ9YIHq{text-align:start;}"],
        1,
        0,
        1,
        [("value", "J9YIHq", "val\\0kl\\0& | \\0text-align:start")],
      ),
      (
        "_akldeP5pA",
        ["._akldeP5pA{text-align:end;}"],
        1,
        0,
        1,
        [("value", "deP5pA", "val\\0kl\\0& | \\0text-align:end")],
      ),
      (
        "_aklSKcom8",
        ["._aklSKcom8{text-align:left;}"],
        1,
        0,
        1,
        [("value", "SKcom8", "val\\0kl\\0& | \\0text-align:left")],
      ),
      (
        "_aklynrkDG",
        ["._aklynrkDG{text-align:right;}"],
        1,
        0,
        1,
        [("value", "ynrkDG", "val\\0kl\\0& | \\0text-align:right")],
      ),
      (
        "_akla9X05c",
        ["._akla9X05c{text-align:center;}"],
        1,
        0,
        1,
        [("value", "a9X05c", "val\\0kl\\0& | \\0text-align:center")],
      ),
      (
        "_aklGNGSzN",
        ["._aklGNGSzN{text-align:justify;}"],
        1,
        0,
        1,
        [("value", "GNGSzN", "val\\0kl\\0& | \\0text-align:justify")],
      ),
      (
        "_aklCGjAXo",
        ["._aklCGjAXo{text-align:match-parent;}"],
        1,
        0,
        1,
        [("value", "CGjAXo", "val\\0kl\\0& | \\0text-align:match-parent")],
      ),
      (
        "_aklP-_MBw",
        ["._aklP-_MBw{text-align:justify-all;}"],
        1,
        0,
        1,
        [("value", "P-_MBw", "val\\0kl\\0& | \\0text-align:justify-all")],
      ),
      (
        "_akm0fzRWT",
        ["._akm0fzRWT{text-align-all:start;}"],
        1,
        0,
        1,
        [("value", "0fzRWT", "val\\0km\\0& | \\0text-align-all:start")],
      ),
      (
        "_akmcy-jIO",
        ["._akmcy-jIO{text-align-all:end;}"],
        1,
        0,
        1,
        [("value", "cy-jIO", "val\\0km\\0& | \\0text-align-all:end")],
      ),
      (
        "_akmCEFT_m",
        ["._akmCEFT_m{text-align-all:left;}"],
        1,
        0,
        1,
        [("value", "CEFT_m", "val\\0km\\0& | \\0text-align-all:left")],
      ),
      (
        "_akmotkJ2u",
        ["._akmotkJ2u{text-align-all:right;}"],
        1,
        0,
        1,
        [("value", "otkJ2u", "val\\0km\\0& | \\0text-align-all:right")],
      ),
      (
        "_akmUTN8sb",
        ["._akmUTN8sb{text-align-all:center;}"],
        1,
        0,
        1,
        [("value", "UTN8sb", "val\\0km\\0& | \\0text-align-all:center")],
      ),
      (
        "_akmCO33Lv",
        ["._akmCO33Lv{text-align-all:justify;}"],
        1,
        0,
        1,
        [("value", "CO33Lv", "val\\0km\\0& | \\0text-align-all:justify")],
      ),
      (
        "_akmYSevAj",
        ["._akmYSevAj{text-align-all:match-parent;}"],
        1,
        0,
        1,
        [("value", "YSevAj", "val\\0km\\0& | \\0text-align-all:match-parent")],
      ),
      (
        "_akn7ks8Bv",
        ["._akn7ks8Bv{text-align-last:auto;}"],
        1,
        0,
        1,
        [("value", "7ks8Bv", "val\\0kn\\0& | \\0text-align-last:auto")],
      ),
      (
        "_aknNUQ-L5",
        ["._aknNUQ-L5{text-align-last:start;}"],
        1,
        0,
        1,
        [("value", "NUQ-L5", "val\\0kn\\0& | \\0text-align-last:start")],
      ),
      (
        "_aknO5e7eF",
        ["._aknO5e7eF{text-align-last:end;}"],
        1,
        0,
        1,
        [("value", "O5e7eF", "val\\0kn\\0& | \\0text-align-last:end")],
      ),
      (
        "_aknlMFMP8",
        ["._aknlMFMP8{text-align-last:left;}"],
        1,
        0,
        1,
        [("value", "lMFMP8", "val\\0kn\\0& | \\0text-align-last:left")],
      ),
      (
        "_aknh9zbMb",
        ["._aknh9zbMb{text-align-last:right;}"],
        1,
        0,
        1,
        [("value", "h9zbMb", "val\\0kn\\0& | \\0text-align-last:right")],
      ),
      (
        "_aknS-ea-h",
        ["._aknS-ea-h{text-align-last:center;}"],
        1,
        0,
        1,
        [("value", "S-ea-h", "val\\0kn\\0& | \\0text-align-last:center")],
      ),
      (
        "_akn0JU1Ae",
        ["._akn0JU1Ae{text-align-last:justify;}"],
        1,
        0,
        1,
        [("value", "0JU1Ae", "val\\0kn\\0& | \\0text-align-last:justify")],
      ),
      (
        "_akn6GVsft",
        ["._akn6GVsft{text-align-last:match-parent;}"],
        1,
        0,
        1,
        [
          ("value", "6GVsft", "val\\0kn\\0& | \\0text-align-last:match-parent"),
        ],
      ),
      (
        "_aleEIpL3o",
        ["._aleEIpL3o{text-justify:auto;}"],
        1,
        0,
        1,
        [("value", "EIpL3o", "val\\0le\\0& | \\0text-justify:auto")],
      ),
      (
        "_aleVDiSUv",
        ["._aleVDiSUv{text-justify:none;}"],
        1,
        0,
        1,
        [("value", "VDiSUv", "val\\0le\\0& | \\0text-justify:none")],
      ),
      (
        "_alen3UCJC",
        ["._alen3UCJC{text-justify:inter-word;}"],
        1,
        0,
        1,
        [("value", "n3UCJC", "val\\0le\\0& | \\0text-justify:inter-word")],
      ),
      (
        "_aleCOsxOx",
        ["._aleCOsxOx{text-justify:inter-character;}"],
        1,
        0,
        1,
        [
          ("value", "COsxOx", "val\\0le\\0& | \\0text-justify:inter-character"),
        ],
      ),
      (
        "_anc0OtNo3",
        ["._anc0OtNo3{word-spacing:50%;}"],
        1,
        0,
        1,
        [("value", "0OtNo3", "val\\0nc\\0& | \\0word-spacing:50%")],
      ),
      (
        "_aldr8wJMA",
        ["._aldr8wJMA{text-indent:1em hanging;}"],
        1,
        0,
        1,
        [("value", "r8wJMA", "val\\0ld\\0& | \\0text-indent:1em hanging")],
      ),
      (
        "_aldaH9558",
        ["._aldaH9558{text-indent:1em each-line;}"],
        1,
        0,
        1,
        [("value", "aH9558", "val\\0ld\\0& | \\0text-indent:1em each-line")],
      ),
      (
        "_aldEg7LNB",
        ["._aldEg7LNB{text-indent:1em hanging each-line;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "Eg7LNB",
            "val\\0ld\\0& | \\0text-indent:1em hanging each-line",
          ),
        ],
      ),
      (
        "_abcLiYgFS",
        ["._abcLiYgFS{hanging-punctuation:none;}"],
        1,
        0,
        1,
        [("value", "LiYgFS", "val\\0bc\\0& | \\0hanging-punctuation:none")],
      ),
      (
        "_abc7WWZ54",
        ["._abc7WWZ54{hanging-punctuation:first;}"],
        1,
        0,
        1,
        [("value", "7WWZ54", "val\\0bc\\0& | \\0hanging-punctuation:first")],
      ),
      (
        "_abcciuOxx",
        ["._abcciuOxx{hanging-punctuation:last;}"],
        1,
        0,
        1,
        [("value", "ciuOxx", "val\\0bc\\0& | \\0hanging-punctuation:last")],
      ),
      (
        "_abch1q0FL",
        ["._abch1q0FL{hanging-punctuation:force-end;}"],
        1,
        0,
        1,
        [
          ("value", "h1q0FL", "val\\0bc\\0& | \\0hanging-punctuation:force-end"),
        ],
      ),
      (
        "_abcvl8kea",
        ["._abcvl8kea{hanging-punctuation:allow-end;}"],
        1,
        0,
        1,
        [
          ("value", "vl8kea", "val\\0bc\\0& | \\0hanging-punctuation:allow-end"),
        ],
      ),
      (
        "_abciWbmiI",
        ["._abciWbmiI{hanging-punctuation:first last;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "iWbmiI",
            "val\\0bc\\0& | \\0hanging-punctuation:first last",
          ),
        ],
      ),
      (
        "_abc6nQzv-",
        ["._abc6nQzv-{hanging-punctuation:first force-end;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "6nQzv-",
            "val\\0bc\\0& | \\0hanging-punctuation:first force-end",
          ),
        ],
      ),
      (
        "_abcFAABll",
        ["._abcFAABll{hanging-punctuation:first force-end last;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "FAABll",
            "val\\0bc\\0& | \\0hanging-punctuation:first force-end last",
          ),
        ],
      ),
      (
        "_abcMYZjHo",
        ["._abcMYZjHo{hanging-punctuation:first allow-end last;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "MYZjHo",
            "val\\0bc\\0& | \\0hanging-punctuation:first allow-end last",
          ),
        ],
      ),
      (
        "_alrjJb28B",
        ["._alrjJb28B{text-wrap:wrap;}"],
        1,
        0,
        2,
        [("value", "jJb28B", "val\\0lr\\0& | \\0text-wrap:wrap")],
      ),
      (
        "_alr-dGQfV",
        ["._alr-dGQfV{text-wrap:nowrap;}"],
        1,
        0,
        2,
        [("value", "-dGQfV", "val\\0lr\\0& | \\0text-wrap:nowrap")],
      ),
      (
        "_alrDki1iT",
        ["._alrDki1iT{text-wrap:balance;}"],
        1,
        0,
        2,
        [("value", "Dki1iT", "val\\0lr\\0& | \\0text-wrap:balance")],
      ),
      (
        "_alrYhCV9j",
        ["._alrYhCV9j{text-wrap:stable;}"],
        1,
        0,
        2,
        [("value", "YhCV9j", "val\\0lr\\0& | \\0text-wrap:stable")],
      ),
      (
        "_alrkaiIks",
        ["._alrkaiIks{text-wrap:pretty;}"],
        1,
        0,
        2,
        [("value", "kaiIks", "val\\0lr\\0& | \\0text-wrap:pretty")],
      ),
      (
        "_alsoMTb_-",
        ["._alsoMTb_-{text-wrap-mode:wrap;}"],
        1,
        0,
        1,
        [("value", "oMTb_-", "val\\0ls\\0& | \\0text-wrap-mode:wrap")],
      ),
      (
        "_als1b0NOX",
        ["._als1b0NOX{text-wrap-mode:nowrap;}"],
        1,
        0,
        1,
        [("value", "1b0NOX", "val\\0ls\\0& | \\0text-wrap-mode:nowrap")],
      ),
      (
        "_altdfRYTE",
        ["._altdfRYTE{text-wrap-style:auto;}"],
        1,
        0,
        1,
        [("value", "dfRYTE", "val\\0lt\\0& | \\0text-wrap-style:auto")],
      ),
      (
        "_altTSkWV3",
        ["._altTSkWV3{text-wrap-style:balance;}"],
        1,
        0,
        1,
        [("value", "TSkWV3", "val\\0lt\\0& | \\0text-wrap-style:balance")],
      ),
      (
        "_altQktEZv",
        ["._altQktEZv{text-wrap-style:stable;}"],
        1,
        0,
        1,
        [("value", "QktEZv", "val\\0lt\\0& | \\0text-wrap-style:stable")],
      ),
      (
        "_altd4XkL3",
        ["._altd4XkL3{text-wrap-style:pretty;}"],
        1,
        0,
        1,
        [("value", "d4XkL3", "val\\0lt\\0& | \\0text-wrap-style:pretty")],
      ),
      (
        "_abenKQXDD",
        ["._abenKQXDD{hyphenate-character:auto;}"],
        1,
        0,
        1,
        [("value", "nKQXDD", "val\\0be\\0& | \\0hyphenate-character:auto")],
      ),
      (
        "_abiHncVrL",
        ["._abiHncVrL{hyphenate-limit-zone:1%;}"],
        1,
        0,
        1,
        [("value", "HncVrL", "val\\0bi\\0& | \\0hyphenate-limit-zone:1%")],
      ),
      (
        "_abiECU60f",
        ["._abiECU60f{hyphenate-limit-zone:1em;}"],
        1,
        0,
        1,
        [("value", "ECU60f", "val\\0bi\\0& | \\0hyphenate-limit-zone:1em")],
      ),
      (
        "_abf1SrA4B",
        ["._abf1SrA4B{hyphenate-limit-chars:auto;}"],
        1,
        0,
        1,
        [("value", "1SrA4B", "val\\0bf\\0& | \\0hyphenate-limit-chars:auto")],
      ),
      (
        "_abfJs59QT",
        ["._abfJs59QT{hyphenate-limit-chars:5;}"],
        1,
        0,
        1,
        [("value", "Js59QT", "val\\0bf\\0& | \\0hyphenate-limit-chars:5")],
      ),
      (
        "_abh0wuj68",
        ["._abh0wuj68{hyphenate-limit-lines:no-limit;}"],
        1,
        0,
        1,
        [
          (
            "value",
            "0wuj68",
            "val\\0bh\\0& | \\0hyphenate-limit-lines:no-limit",
          ),
        ],
      ),
      (
        "_abhp10sXJ",
        ["._abhp10sXJ{hyphenate-limit-lines:2;}"],
        1,
        0,
        1,
        [("value", "p10sXJ", "val\\0bh\\0& | \\0hyphenate-limit-lines:2")],
      ),
    ]
  ];
  
  CSS.make("_alosNeqHG", []);
  CSS.make("_aloaCfWqQ", []);
  
  CSS.make("_akj_L8jBH", []);
  CSS.make("_akjAk0enB", []);
  CSS.make("_ackIEZOLU", []);
  CSS.make("_acksOSKlg", []);
  CSS.make("_ackRvd1Zk", []);
  CSS.make("_ackCgOXgQ", []);
  CSS.make("_ackkl0Hst", []);
  CSS.make("_anapJKoci", []);
  CSS.make("_anaAqdjxG", []);
  CSS.make("_anaLZNWUV", []);
  CSS.make("_an5dX2dBN", []);
  CSS.make("_abjStI8L2", []);
  CSS.make("_abjGnOMpr", []);
  CSS.make("_abjBtIUc3", []);
  CSS.make("_afnQf45Dj", []);
  CSS.make("_afnBD_3Zs", []);
  CSS.make("_afn0UsS31", []);
  CSS.make("_afncue6Al", []);
  CSS.make("_afnTeGr8u", []);
  CSS.make("_afnI9IWNd", []);
  CSS.make("_aklJ9YIHq", []);
  CSS.make("_akldeP5pA", []);
  CSS.make("_aklSKcom8", []);
  CSS.make("_aklynrkDG", []);
  CSS.make("_akla9X05c", []);
  CSS.make("_aklGNGSzN", []);
  CSS.make("_aklCGjAXo", []);
  CSS.make("_aklP-_MBw", []);
  CSS.make("_akm0fzRWT", []);
  CSS.make("_akmcy-jIO", []);
  CSS.make("_akmCEFT_m", []);
  CSS.make("_akmotkJ2u", []);
  CSS.make("_akmUTN8sb", []);
  CSS.make("_akmCO33Lv", []);
  CSS.make("_akmYSevAj", []);
  CSS.make("_akn7ks8Bv", []);
  CSS.make("_aknNUQ-L5", []);
  CSS.make("_aknO5e7eF", []);
  CSS.make("_aknlMFMP8", []);
  CSS.make("_aknh9zbMb", []);
  CSS.make("_aknS-ea-h", []);
  CSS.make("_akn0JU1Ae", []);
  CSS.make("_akn6GVsft", []);
  CSS.make("_aleEIpL3o", []);
  CSS.make("_aleVDiSUv", []);
  CSS.make("_alen3UCJC", []);
  CSS.make("_aleCOsxOx", []);
  CSS.make("_anc0OtNo3", []);
  CSS.make("_aldr8wJMA", []);
  CSS.make("_aldaH9558", []);
  CSS.make("_aldEg7LNB", []);
  CSS.make("_abcLiYgFS", []);
  CSS.make("_abc7WWZ54", []);
  CSS.make("_abcciuOxx", []);
  CSS.make("_abch1q0FL", []);
  CSS.make("_abcvl8kea", []);
  CSS.make("_abciWbmiI", []);
  CSS.make("_abc6nQzv-", []);
  CSS.make("_abcFAABll", []);
  CSS.make("_abcMYZjHo", []);
  
  CSS.make("_alrjJb28B", []);
  CSS.make("_alr-dGQfV", []);
  CSS.make("_alrDki1iT", []);
  CSS.make("_alrYhCV9j", []);
  CSS.make("_alrkaiIks", []);
  CSS.make("_alsoMTb_-", []);
  CSS.make("_als1b0NOX", []);
  CSS.make("_altdfRYTE", []);
  CSS.make("_altTSkWV3", []);
  CSS.make("_altQktEZv", []);
  CSS.make("_altd4XkL3", []);
  
  CSS.make("_abenKQXDD", []);
  CSS.make("_abiHncVrL", []);
  CSS.make("_abiECU60f", []);
  CSS.make("_abf1SrA4B", []);
  CSS.make("_abfJs59QT", []);
  
  CSS.make("_abh0wuj68", []);
  CSS.make("_abhp10sXJ", []);
