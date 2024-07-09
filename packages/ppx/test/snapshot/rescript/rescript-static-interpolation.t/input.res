module Theme = {
  let var = CSS.hex("333333")
  module Border = {
    let black = CSS.hex("222222")
  }
}
let black = CSS.hex("000")

module StringInterpolation = %styled.div(j`
  color: $(Theme.var);
  background-color: $(black);
  border-color: $(Theme.Border.black);
  display: block;
`)
