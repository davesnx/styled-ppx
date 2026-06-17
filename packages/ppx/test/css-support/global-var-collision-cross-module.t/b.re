let primary = CSS.hex("0000ff");
module Theme = [%styled.global {| body { color: $(primary); } |}];
