let primary = CSS.red;
module Styles = [%styled.global {| body { color: $(primary); } |}];
