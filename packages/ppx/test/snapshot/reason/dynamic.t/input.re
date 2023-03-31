module DynamicComponent = [%styled.div
  (~var) => {js|
  color: $(var);
  display: flex;
|js}
];
