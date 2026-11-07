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
        "_a88FjKofu",
        ["._a88FjKofu{contain:none;}"],
        1,
        0,
        1,
        [("value", "FjKofu", "val\\088\\0& | \\0contain:none")],
      ),
      (
        "_a88pfUO9y",
        ["._a88pfUO9y{contain:strict;}"],
        1,
        0,
        1,
        [("value", "pfUO9y", "val\\088\\0& | \\0contain:strict")],
      ),
      (
        "_a88ufklw5",
        ["._a88ufklw5{contain:content;}"],
        1,
        0,
        1,
        [("value", "ufklw5", "val\\088\\0& | \\0contain:content")],
      ),
      (
        "_a887nNE6i",
        ["._a887nNE6i{contain:size;}"],
        1,
        0,
        1,
        [("value", "7nNE6i", "val\\088\\0& | \\0contain:size")],
      ),
      (
        "_a883PpJqy",
        ["._a883PpJqy{contain:layout;}"],
        1,
        0,
        1,
        [("value", "3PpJqy", "val\\088\\0& | \\0contain:layout")],
      ),
      (
        "_a88XA8wwV",
        ["._a88XA8wwV{contain:paint;}"],
        1,
        0,
        1,
        [("value", "XA8wwV", "val\\088\\0& | \\0contain:paint")],
      ),
      (
        "_a88HaJnGX",
        ["._a88HaJnGX{contain:size layout;}"],
        1,
        0,
        1,
        [("value", "HaJnGX", "val\\088\\0& | \\0contain:size layout")],
      ),
      (
        "_a88fFxNlT",
        ["._a88fFxNlT{contain:size paint;}"],
        1,
        0,
        1,
        [("value", "fFxNlT", "val\\088\\0& | \\0contain:size paint")],
      ),
      (
        "_a88B4Pjha",
        ["._a88B4Pjha{contain:size layout paint;}"],
        1,
        0,
        1,
        [("value", "B4Pjha", "val\\088\\0& | \\0contain:size layout paint")],
      ),
      (
        "_an8eAydt3",
        ["._an8eAydt3{width:5cqw;}"],
        1,
        0,
        1,
        [("value", "eAydt3", "val\\0n8\\0& | \\0width:5cqw")],
      ),
      (
        "_an8FrePpp",
        ["._an8FrePpp{width:5cqh;}"],
        1,
        0,
        1,
        [("value", "FrePpp", "val\\0n8\\0& | \\0width:5cqh")],
      ),
      (
        "_an8osYxvT",
        ["._an8osYxvT{width:5cqi;}"],
        1,
        0,
        1,
        [("value", "osYxvT", "val\\0n8\\0& | \\0width:5cqi")],
      ),
      (
        "_an8rwoLKP",
        ["._an8rwoLKP{width:5cqb;}"],
        1,
        0,
        1,
        [("value", "rwoLKP", "val\\0n8\\0& | \\0width:5cqb")],
      ),
      (
        "_an8q_DvOx",
        ["._an8q_DvOx{width:5cqmin;}"],
        1,
        0,
        1,
        [("value", "q_DvOx", "val\\0n8\\0& | \\0width:5cqmin")],
      ),
      (
        "_an8X6NOl8",
        ["._an8X6NOl8{width:5cqmax;}"],
        1,
        0,
        1,
        [("value", "X6NOl8", "val\\0n8\\0& | \\0width:5cqmax")],
      ),
      (
        "_a8hJZUnuH",
        ["._a8hJZUnuH{container-type:normal;}"],
        1,
        0,
        1,
        [("value", "JZUnuH", "val\\08h\\0& | \\0container-type:normal")],
      ),
      (
        "_a8hMPATp7",
        ["._a8hMPATp7{container-type:size;}"],
        1,
        0,
        1,
        [("value", "MPATp7", "val\\08h\\0& | \\0container-type:size")],
      ),
      (
        "_a8hicGmkO",
        ["._a8hicGmkO{container-type:inline-size;}"],
        1,
        0,
        1,
        [("value", "icGmkO", "val\\08h\\0& | \\0container-type:inline-size")],
      ),
      (
        "_a8fq-qsK3",
        ["._a8fq-qsK3{container-name:none;}"],
        1,
        0,
        1,
        [("value", "q-qsK3", "val\\08f\\0& | \\0container-name:none")],
      ),
      (
        "_a8f5MVdPu",
        ["._a8f5MVdPu{container-name:x;}"],
        1,
        0,
        1,
        [("value", "5MVdPu", "val\\08f\\0& | \\0container-name:x")],
      ),
      (
        "_a8f5dDvsm",
        ["._a8f5dDvsm{container-name:x y;}"],
        1,
        0,
        1,
        [("value", "5dDvsm", "val\\08f\\0& | \\0container-name:x y")],
      ),
      (
        "_a8e_MwVhz",
        ["._a8e_MwVhz{container:none;}"],
        1,
        0,
        2,
        [("value", "_MwVhz", "val\\08e\\0& | \\0container:none")],
      ),
      (
        "_a8eevjkxL",
        ["._a8eevjkxL{container:x / normal;}"],
        1,
        0,
        2,
        [("value", "evjkxL", "val\\08e\\0& | \\0container:x / normal")],
      ),
      (
        "_a8ep_tLRv",
        ["._a8ep_tLRv{container:x / size;}"],
        1,
        0,
        2,
        [("value", "p_tLRv", "val\\08e\\0& | \\0container:x / size")],
      ),
      (
        "_a8eNqL_bI",
        ["._a8eNqL_bI{container:x / inline-size;}"],
        1,
        0,
        2,
        [("value", "NqL_bI", "val\\08e\\0& | \\0container:x / inline-size")],
      ),
      (
        "_a8eVNSDGh",
        ["._a8eVNSDGh{container:x y / size;}"],
        1,
        0,
        2,
        [("value", "VNSDGh", "val\\08e\\0& | \\0container:x y / size")],
      ),
    ]
  ];
  
  CSS.make("_a88FjKofu", []);
  CSS.make("_a88pfUO9y", []);
  CSS.make("_a88ufklw5", []);
  CSS.make("_a887nNE6i", []);
  CSS.make("_a883PpJqy", []);
  CSS.make("_a88XA8wwV", []);
  CSS.make("_a88HaJnGX", []);
  CSS.make("_a88fFxNlT", []);
  CSS.make("_a88B4Pjha", []);
  
  CSS.make("_an8eAydt3", []);
  CSS.make("_an8FrePpp", []);
  CSS.make("_an8osYxvT", []);
  CSS.make("_an8rwoLKP", []);
  CSS.make("_an8q_DvOx", []);
  CSS.make("_an8X6NOl8", []);
  CSS.make("_a8hJZUnuH", []);
  CSS.make("_a8hMPATp7", []);
  CSS.make("_a8hicGmkO", []);
  CSS.make("_a8fq-qsK3", []);
  CSS.make("_a8f5MVdPu", []);
  CSS.make("_a8f5dDvsm", []);
  CSS.make("_a8e_MwVhz", []);
  CSS.make("_a8eevjkxL", []);
  CSS.make("_a8ep_tLRv", []);
  CSS.make("_a8eNqL_bI", []);
  CSS.make("_a8eVNSDGh", []);
