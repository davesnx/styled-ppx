module DynamicComponent = [%styled.div
  (~var) => {j|
    color: $(var);
    display: block;
  |j}
];
