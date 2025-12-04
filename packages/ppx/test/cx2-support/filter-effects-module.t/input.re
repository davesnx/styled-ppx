let color = CSS.hex("333");

/* Filter Effects Module Level 1 */
[%cx2 {|filter: none|}];
[%cx2 {|filter: url(#id)|}];
[%cx2 {|filter: url(image.svg#id)|}];
[%cx2 {|filter: blur(5px)|}];
[%cx2 {|filter: brightness(0.5)|}];
[%cx2 {|filter: contrast(150%)|}];
/* drop-shadow: <offset-x> <offset-y> <blur-radius>? <color>?
   Note: In styled-ppx, drop-shadow requires blur-radius (x y blur [color])
   x y alone or x y color don't work */
/* x y blur (no color - uses currentColor) */
[%cx2 {|filter: drop-shadow(5px 5px 10px)|}];
/* x y blur color (all parts) */
[%cx2 {|filter: drop-shadow(15px 15px 15px #123)|}];
[%cx2 {|filter: grayscale(50%)|}];
[%cx2 {|filter: hue-rotate(50deg)|}];
[%cx2 {|filter: invert(50%)|}];
[%cx2 {|filter: opacity(50%)|}];
[%cx2 {|filter: sepia(50%)|}];
[%cx2 {|filter: saturate(150%)|}];
[%cx2 {|filter: grayscale(100%) sepia(100%)|}];
[%cx2 {|filter:
   drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));|}];
[%css
  {|filter:
       drop-shadow(0 1px 0 $(color))
       drop-shadow(0 1px 0 $(color))
       drop-shadow(0 1px 0 $(color))
       drop-shadow(0 32px 48px rgba(0, 0, 0, 0.075))
       drop-shadow(0 8px 32px rgba(0, 0, 0, 0.03));|}
];

/* Filter Effects Module Level 2 */
[%cx2 {|backdrop-filter: none|}];
[%cx2 {|backdrop-filter: url(#id)|}];
[%cx2 {|backdrop-filter: url(image.svg#id)|}];
[%cx2 {|backdrop-filter: blur(5px)|}];
[%cx2 {|backdrop-filter: brightness(0.5)|}];
[%cx2 {|backdrop-filter: contrast(150%)|}];
[%cx2 {|backdrop-filter: drop-shadow(15px 15px 15px rgba(0, 0, 0, 1))|}];
[%cx2 {|backdrop-filter: grayscale(50%)|}];
[%cx2 {|backdrop-filter: hue-rotate(50deg)|}];
[%cx2 {|backdrop-filter: invert(50%)|}];
[%cx2 {|backdrop-filter: opacity(50%)|}];
[%cx2 {|backdrop-filter: sepia(50%)|}];
[%cx2 {|backdrop-filter: saturate(150%)|}];
[%cx2 {|backdrop-filter: grayscale(100%) sepia(100%)|}];
