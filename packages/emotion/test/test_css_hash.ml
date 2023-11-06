let quoted s = Printf.sprintf "\"%s\"" s

let check_equality (input, expected) =
  ( quoted input,
    `Quick,
    fun () ->
      (Alcotest.check Alcotest.string)
        ("hash " ^ quoted input ^ " should be")
        expected
        (Emotion_hash.Hash.default input) )

let data =
  [
    "", "0";
    "something ", "qcixcz";
    "something", "cm8er4";
    "padding: 0;", "v8dmfq";
    "paddinxg: 1;", "xmbgw";
    "padding: 0px;", "ixat1e";
    "padding: 2px;", "gj3q13";
    "color: #323337", "quolp2";
    "color: #323335", "b68ppv";
    "font-size: 32px;", "jstwi7";
    "font-size: 33px;", "a5x1gs";
    "display: block", "mv2c4f";
    "display: blocki", "1535om";
    "display: block;", "q4hpu6";
    "display: flex", "kk1mho";
    "display: flex;", "ys5gsh";
    "color: #333;", "6g3ove";
    "font-size: 22px;", "k3hg6s";
    "font-size: 40px;", "dg860v";
    "line-height: 22px;", "g91b7w";
    "display: flex; font-size: 33px", "z26z7a";
    "background-color: red", "lzpofl";
    "width: 100%", "dlqvhl";
    "height: 100%", "olwsdm";
    "min-width: auto", "bzacp2";
    "min-height: auto", "g9nxj8";
    "max-width: 100vw", "4ffvch";
    "max-height: 100vh", "t7233b";
    "margin: 3px", "iytphq";
    "border: 1px solid red", "7qpmok";
    "border: none", "ndyqz8";
    "border-color: grey", "e9xayw";
    "border-radius: 6px", "hwdvwe";
    "font-family: Inter", "gbi4cl";
    "font-style: italic", "gsa6l1";
    "font-weight: 400", "30lgje";
    "position: absolute", "780j5w";
    "position: relative", "4m5soz";
    "z-index: 9999999", "yi31fc";
    "z-index: 10", "a5gwpy";
  ]

let tests = "Hash", List.map check_equality data
