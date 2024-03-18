let sharedStylesBetweenDynamicComponents = color => %css("color: $(color)")

module DynamicCompnentWithLetIn = %styled.div(
  (~color) => {
    let styles = sharedStylesBetweenDynamicComponents(color)
    styles
  }
)
