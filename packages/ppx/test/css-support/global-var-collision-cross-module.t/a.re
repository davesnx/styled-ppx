let primary = CSS.red;
module Theme = [%styled.global {| body { color: $(primary); } |}];
