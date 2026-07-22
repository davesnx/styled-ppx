/* css-fonts-4 @font-palette-values descriptors (issue #585):
   font-family, base-palette and override-colors validate at compile time
   inside [%styled.global]; the font-palette property accepts the
   dashed-ident naming the palette. */

module Palettes = [%styled.global
  {|
  @font-palette-values --cool {
    font-family: "Bixa";
    base-palette: 1;
    override-colors: 0 #7EB7E4, 1 rgb(20 20 20);
  }
|}
];

let cool = [%css "font-palette: --cool"];
let light = [%css "font-palette: light"];

let _ = (Palettes.make, cool, light);
