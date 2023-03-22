module DynamicComponentWithArray = %styled.button(
  (~size, ~color) => [
    %css("width: $(size)"),
    %css("color: $(color)"),
    %css("display: block;"),
    %css("width: 100%;"),
  ]
)
