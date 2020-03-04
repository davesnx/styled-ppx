module Component = [%styled ("z-index: 100")]

(*

module ComponentMultiline = [%styled
  {|
    color: red;
    background-color: white;
    margin: auto 0 10px 1em;
    border-bottom: thin dashed #eee;
    border-right-color: rgb(1, 0, 1);
    width: 70%;
    background: url(http://example.com/test.jpg);
  |}
]

*)

(* Not supported yet

module StyledComponentWithProps = [%styled
  (~color) => {|
    color: $color;
  |}
];

*)
