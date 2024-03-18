let width = "120px"
let orientation = "landscape"

module SelectorWithInterpolation = %styled.div(`
  @media only screen and (min-width: $(width)) {
    color: blue;
  }
  @media (min-width: 700px) and (orientation: $(orientation)) {
    display: none;
  }
`)
