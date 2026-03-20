/* CSS Frequency and Resolution Units */
/* These types exist in Parser.ml but are missing from Css_types.ml */

/* Resolution units - tested via image-set in background-image */
[%css {|image-rendering: auto|}];
[%css {|image-rendering: crisp-edges|}];
[%css {|image-rendering: pixelated|}];

/* Testing resolution in background-image context (image-set) */
[%css {|background-image: image-set("cat.png" 1x, "cat-2x.png" 2x)|}];
[%css {|background-image: image-set("cat.png" 1dppx, "cat-2x.png" 2dppx)|}];
[%css {|background-image: image-set("cat.png" 96dpi, "cat-2x.png" 192dpi)|}];
[%css {|background-image: image-set("cat.png" 37dpcm)|}];
