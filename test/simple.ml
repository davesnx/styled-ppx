let StyledComponentInline = [%re_styled_ppx "display: block;"]
let StyledComponentMultiline = [%re_styled_ppx {|
  display: block;
|}]
let StyledComponentWithProps =
  [%re_styled_ppx
    fun ~color -> {j|
      display: block;
      color: $color;
    |j}]
