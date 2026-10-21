module Descriptors = [%styled.global {|
  @font-palette-values --cool {
    font-family: "Bixa";
    base-palette: 1;
    override-colors: 0 #7EB7E4, 1 rgb(20 20 20);
  }

  @view-transition {
    navigation: auto;
    types: slide forwards;
  }

  @counter-style thumbs {
    system: cyclic;
    symbols: "a";
    negative: "-" "!";
    prefix: "(";
    suffix: ") ";
    range: 1 infinite;
    pad: 2 "0";
    fallback: decimal;
  }

  @counter-style roman {
    system: additive;
    additive-symbols: 1000 "M", 900 "CM", 500 "D", 1 "I";
  }

  @counter-style hex {
    system: fixed 10;
    symbols: "a" "b" "c";
  }

  @counter-style child {
    system: extends decimal;
  }
|}];
