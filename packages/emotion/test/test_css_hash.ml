let quoted s = Printf.sprintf "\"%s\"" s

let check_equality (input, expected) =
  ( quoted input,
    `Quick,
    fun () ->
      (Alcotest.check Alcotest.string)
        (quoted input ^ " should hash")
        expected
        (Emotion_hash.Hash.default input) )

let data =
  [
    "", "0";
    "something ", "5aqktu";
    "something", "crsxd7";
    "padding: 0;", "14em68c";
    "paddinxg: 1;", "103fxnp";
    "padding: 0px;", "1mqllfw";
    "padding: 2px;", "1kgw61x";
    "color: #323337", "v3ltn7";
    "color: #323335", "pru0h8";
    "font-size: 32px;", "1aeywr2";
    "font-size: 33px;", "xts11q";
    "display: block", "1ni8fbp";
    "display: blocki", "1rb2f34";
    "display: block;", "avwy6";
    "display: flex", "18hxz5k";
    "display: flex;", "17vxl0k";
    "color: #333;", "m97760";
    "font-size: 22px;", "1m7bgz5";
    "font-size: 40px;", "pm5q90";
    "line-height: 22px;", "lehwic";
    "display: flex; font-size: 33px", "c8y5k7";
    "background-color: red", "mhqmk0";
    "width: 100%", "71gbl7";
    "height: 100%", "t3ccau";
    "min-width: auto", "13s44nx";
    "min-height: auto", "8zn0wa";
    "max-width: 100vw", "qilhjh";
    "max-height: 100vh", "1tmr74f";
    "margin: 3px", "1dpky6u";
    "border: 1px solid red", "1j0fwx2";
    "border: none", "zn5chm";
    "border-color: grey", "7nfkvr";
    "border-radius: 6px", "wyudoy";
    "font-family: Inter", "1bfbb9d";
    "font-style: italic", "9i7il8";
    "font-weight: 400", "1q1joro";
    "position: absolute", "1vmrgk7";
    "position: relative", "1dcu5cj";
    "z-index: 9999999", "1w4us3o";
    "z-index: 10", "7au0g0";
  ]

let tests = "Hash", List.map check_equality data
