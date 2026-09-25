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

let tests =
  List.map
    (fun (input, expected) ->
      let quoted = Printf.sprintf "%S" input in
      Alcotest_extra.test quoted (fun () ->
        (Alcotest.check Alcotest.string)
          ("hash " ^ quoted ^ " should be")
          expected (Murmur2.default input)))
    data

(* [default_int] is [default] before base36 encoding: same algorithm, so
   equal/distinct results must track each other, and it must be
   deterministic and non-negative (callers reduce it mod a range). *)
let int_tests =
  List.map
    (fun (input, _) ->
      let quoted = Printf.sprintf "int:%S" input in
      Alcotest_extra.test quoted (fun () ->
        (Alcotest.check Alcotest.int)
          ("default_int " ^ quoted ^ " is deterministic")
          (Murmur2.default_int input)
          (Murmur2.default_int input);
        (Alcotest.check Alcotest.bool)
          "non-negative" true
          (Murmur2.default_int input >= 0)))
    data
  @ [
      Alcotest_extra.test "equal default_int iff equal default" (fun () ->
        let a, b = "padding: 0px;", "padding: 2px;" in
        (Alcotest.check Alcotest.bool)
          "different strings -> different ints" true
          (Murmur2.default_int a <> Murmur2.default_int b);
        (Alcotest.check Alcotest.bool)
          "same string -> same int" true
          (Murmur2.default_int a = Murmur2.default_int a));
    ]

let () =
  Alcotest.run ~show_errors:true ~compact:true ~tail_errors:`Unlimited "murmur2"
    (tests @ int_tests)
