let StyledComponent = [%re_styled_ppx
  {|
    display: block;
    color: red;
  |}
];

let StyledComponentWithProps = [%re_styled_ppx
  (~color) => {
    {|
    display: block;
    color: $color;
  |};
  }
];

Js.log(StyledComponent);
Js.log(StyledComponentWithProps);
