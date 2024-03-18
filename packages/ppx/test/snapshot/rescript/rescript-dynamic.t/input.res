module DynamicComponent = %styled.div(
  (~var) =>
    `
  color: $(var);
  display: flex;
`
)
