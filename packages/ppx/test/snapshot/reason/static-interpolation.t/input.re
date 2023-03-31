module Theme = {
  let var = CssJs.hex("333333");
  module Border = {
    let black = CssJs.hex("222222");
  };
};
let black = CssJs.hex("000");

module StringInterpolation = [%styled.div
  {j|
  color: $(Theme.var);
  background-color: $(black);
  border-color: $(Theme.Border.black);
  display: block;
|j}
];
