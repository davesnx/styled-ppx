module Component = [%styled ("display: block")]

module ComponentMultiline = [%styled
  {|
    color: #333;
    background-color: #333;
    margin: auto 0 10px 1em;
    border-bottom: thin dashed #eee;
    border-right-color: rgb(1, 0, 1);
    width: 70%;
    background: url(http://example.com/test.jpg);
  |}
]

module Link = [%styled.a ("color: #C0FFEE")]

(* Not supported yet
(* module EmptyComponent = [%styled.div ()]
module EmptyComponent2 = [%styled.div]
 *)

module StyledWithProps = [%styled (~color) => {| color: $color |}];

type size =
  | Small
  | Big
  | Full;

module StyledWithPatternMatcing = [%styled
  (~size) => switch (size) {
    | Small => "width: 33%"
    | Big => "width: 80%"
    | Full => "width: 100%"
  }
];

*)
