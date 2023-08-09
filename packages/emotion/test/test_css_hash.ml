let quoted s = Printf.sprintf "\"%s\"" s

let check_equality (input, expected) =
  ( quoted input,
    `Quick,
    fun () ->
      (Alcotest.check Alcotest.string)
        (quoted input ^ " should hash")
        expected (Hash.make input) )

let data =
  [
    ("something ", "pcredg");
    ("something", "vcob5v");
    ("padding: 0;", "6gat1f");
    ("paddinxg: 1;", "fzg3kw");
    ("padding: 0px;", "1vbv0c");
    ("padding: 2px;", "qt3f5x");
    ("color: #323337", "xdhv30");
    ("color: #323335", "nltzyu");
    ("font-size: 32px;", "gyv1i7");
    ("font-size: 33px;", "80ebse");
    ("display: block", "8mvhhy");
    ("display: blocki", "dd7692");
    ("display: block;", "350rwu");
    ("display: flex", "rfni09");
    ("display: flex;", "qpdvh3");
    ("color: #333;", "lxmcf8");
    ("font-size: 22px;", "o8xlm6");
    ("font-size: 40px;", "ipwjhb");
    ("line-height: 22px;", "r0jscr");
    ("display: flex; font-size: 33px", "ezi7t6");
    ("background-color: red", "l1121p");
    ("width: 100%", "jwcljb");
    ("height: 100%", "ndyh71");
    ("min-width: auto", "ypc7co");
    ("min-height: auto", "ua6m7");
    ("max-width: 100vw", "6292a4");
    ("max-height: 100vh", "oihm23");
    ("margin: 3px", "rqx6bn");
    ("border: 1px solid red", "hoqo05");
    ("border: none", "1kvnc3");
    ("border-color: grey", "rij9tm");
    ("border-radius: 6px", "gm9ptx");
    ("font-family: Inter", "1ibdwf");
    ("font-style: italic", "3azxi");
    ("font-weight: 400", "9ry02o");
    ("position: absolute", "9pm8sf");
    ("position: relative", "8egqwf");
    ("z-index: 9999999", "1ncuwq");
    ("z-index: 10", "xei54");
  ]

let tests = ("Hash", List.map check_equality data)
