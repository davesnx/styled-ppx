let StyledComponentInline = [%styled "display: block;"]
let StyledComponentMultiline = [%styled {|
  display: block;
|}]
let StyledComponentWithProps =
  [%styled
    fun ~color -> {j|
      display: block;
      color: $color;
    |j}]
