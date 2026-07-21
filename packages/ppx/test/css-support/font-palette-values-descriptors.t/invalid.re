/* base-palette only accepts 'light' | 'dark' | <integer>: any other
   keyword must be rejected at compile time. */

module Broken = [%styled.global
  {|
  @font-palette-values --cool {
    font-family: "Bixa";
    base-palette: warm;
  }
|}
];
