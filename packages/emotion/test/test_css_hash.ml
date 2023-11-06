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
    "", "";
    "something ", "j3vvm2";
    (* "something", "vcob5v"; *)
    (* "padding: 0;", "6gat1f"; *)
    (* "paddinxg: 1;", "fzg3kw"; *)
    "padding: 0px;", "ylvxur";
    "padding: 2px;", "70mej";
    "color: #323337", "qhkljz";
    "color: #323335", "6m717h";
    (* "font-size: 32px;", "gyv1i7"; *)
    (* "font-size: 33px;", "80ebse"; *)
    "display: block", "qurtju";
    "display: blocki", "pewgr0";
    (* "display: block;", "350rwu"; *)
    (* "display: flex", "rfni09"; *)
    (* "display: flex;", "qpdvh3"; *)
    "color: #333;", "53ry7e";
    "font-size: 22px;", "rtdks8";
    "font-size: 40px;", "hrknh4";
    (* "line-height: 22px;", "r0jscr"; *)
    "display: flex; font-size: 33px", "pu0dnc";
    "background-color: red", "7ttg1g";
    "width: 100%", "rgyazj";
    "height: 100%", "e6oti9";
    "min-width: auto", "u3g7pv";
    (* "min-height: auto", "ua6m7"; *)
    "max-width: 100vw", "gl5lgb";
    (* "max-height: 100vh", "oihm23"; *)
    (* "margin: 3px", "rqx6bn"; *)
    (* "border: 1px solid red", "hoqo05"; *)
    "border: none", "ez5u86";
    "border-color: grey", "3hy7lk";
    "border-radius: 6px", "6o8xi9";
    "font-family: Inter", "6f4tzm";
    "font-style: italic", "v9mzl5";
    (* "font-weight: 400", "9ry02o"; *)
    "position: absolute", "we28sg";
    (* "position: relative", "8egqwf"; *)
    "z-index: 9999999", "kcc3zd";
    (* "z-index: 10", "xei54"; *)
  ]

let tests = "Hash", List.map check_equality data
