module DynamicComponentWithDefaultValue = [%styled.div
  (~var=CSS.hex("333")) => [|
    [%css "color: $(var);"],
    [%css "display: block;"],
  |]
];
