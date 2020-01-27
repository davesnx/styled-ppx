let styledComponentInline = [%styled
    {|
      color: red;
      background-color: white;
      margin: auto 0 10px 1em;
      border-bottom: thin dashed #eee;
      border-right-color: rgb(1, 0, 1);
      width: 70%;
      background: url(http://example.com/test.jpg)
    |}
  ]

let styledComponentMultiline = [%styled {|
  display: block;
|}]

(* Not supported yet

let styledComponentWithProps =
  [%styled
    (fun ~color -> {|
      display: block;
      color: $color;
    |})]
    
*)
