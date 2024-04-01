module DynamicComponent = [%styled.div
  (~var, ~id) => {js|
  color: $(var);
  display: flex;
  background-color: $(id);
|js}
];
