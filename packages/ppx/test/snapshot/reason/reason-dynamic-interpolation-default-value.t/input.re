module DynamicComponentWithDefaultValue = [%styled.div
  (~var=CssJs.hex("333")) => [|
    [%css "color: $(var);"],
    [%css "display: block;"],
  |]
];
