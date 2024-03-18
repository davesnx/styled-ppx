module SequenceDynamicComponent = %styled.div(
  (~size) => {
    Js.log("Logging when render")
    [%css("width: $(size)"), %css("display: block;")]
  }
)

module DynamicComponentWithSequence = %styled.button(
  (~variant) => {
    let color = Theme.button(variant)
    [%css("display: inline-flex"), %css("color: $(color)"), %css("width: 100%;")]
  }
)
