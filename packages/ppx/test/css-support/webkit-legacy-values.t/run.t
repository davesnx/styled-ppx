This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

Regression test for dash-prefixed webkit registry keys: <-webkit-gradient-type>
and <-webkit-mask-box-repeat> used to be referenced without the leading dash,
crashing the compiler with "Rule not found in registry: webkit-gradient-type"
and "Rule not found in registry: webkit-mask-box-repeat".

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
        "_a4hlwq_Fs",
        [
          "._a4hlwq_Fs{background:-webkit-gradient(linear, left top, left bottom, from(red), to(blue));}",
        ],
        1,
        0,
        9,
        [
          (
            "value",
            "lwq_Fs",
            "val\\04h\\0& | \\0background:-webkit-gradient(linear, left top, left bottom, from(red), to(blue))",
          ),
        ],
      ),
      (
        "_a4hOf6ivS",
        [
          "._a4hOf6ivS{background:-webkit-gradient(radial, center center, 0px, center center, 100px, from(blue), to(red));}",
        ],
        1,
        0,
        9,
        [
          (
            "value",
            "Of6ivS",
            "val\\04h\\0& | \\0background:-webkit-gradient(radial, center center, 0px, center center, 100px, from(blue), to(red))",
          ),
        ],
      ),
      (
        "_a2nuC6gRR",
        [
          "._a2nuC6gRR{-webkit-mask-box-image:url(\"mask.png\") 10px 10px 10px 10px stretch stretch;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "uC6gRR",
            "val\\02n\\0& | \\0-webkit-mask-box-image:url(\"mask.png\") 10px 10px 10px 10px stretch stretch",
          ),
        ],
      ),
      (
        "_a2nwJnqCe",
        [
          "._a2nwJnqCe{-webkit-mask-box-image:url(\"mask.png\") 5% 5% 5% 5% round repeat;}",
        ],
        1,
        0,
        5,
        [
          (
            "value",
            "wJnqCe",
            "val\\02n\\0& | \\0-webkit-mask-box-image:url(\"mask.png\") 5% 5% 5% 5% round repeat",
          ),
        ],
      ),
    ]
  ];
  
  CSS.make("_a4hlwq_Fs", []);
  CSS.make("_a4hOf6ivS", []);
  
  CSS.make("_a2nuC6gRR", []);
  CSS.make("_a2nwJnqCe", []);
