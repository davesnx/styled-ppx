/* CSS Color Level 4 Functions - Missing color function support */

/* hwb() */
[%css {|color: hwb(0 0% 0%)|}];
[%css {|color: hwb(0 0% 0% / .5)|}];
[%css {|color: hwb(120 30% 50%)|}];
[%css {|color: hwb(120 30% 50% / 0.8)|}];

/* lab() */
[%css {|color: lab(0% 0 0)|}];
[%css {|color: lab(0% 0 0 / .5)|}];
[%css {|color: lab(50% 20 -30)|}];
[%css {|color: lab(50% 20 -30 / 0.8)|}];

/* lch() */
[%css {|color: lch(0% 0 0)|}];
[%css {|color: lch(0% 0 0 / .5)|}];
[%css {|color: lch(50% 30 120)|}];
[%css {|color: lch(50% 30 120 / 0.8)|}];

/* oklab() */
[%css {|color: oklab(0% 0 0)|}];
[%css {|color: oklab(0% 0 0 / .5)|}];
[%css {|color: oklab(50% 0.1 -0.1)|}];
[%css {|color: oklab(50% 0.1 -0.1 / 0.8)|}];

/* oklch() */
[%css {|color: oklch(0% 0 0)|}];
[%css {|color: oklch(0% 0 0 / .5)|}];
[%css {|color: oklch(50% 0.15 120)|}];
[%css {|color: oklch(50% 0.15 120 / 0.8)|}];

/* light-dark() */
[%css {|color: light-dark(white, black)|}];
[%css {|color: light-dark(#fff, #000)|}];
[%css {|color: light-dark(rgb(255, 255, 255), rgb(0, 0, 0))|}];
[%css {|background-color: light-dark(#f0f0f0, #1a1a1a)|}];

/* color() */
[%css {|color: color(srgb 1 0.5 0)|}];
[%css {|color: color(srgb 1 0.5 0 / 0.5)|}];
[%css {|color: color(display-p3 1 0.5 0)|}];
[%css {|color: color(display-p3 1 0.5 0 / 0.5)|}];

/* hwb/lab/lch in background-color */
[%css {|background-color: hwb(0 0% 0%)|}];
[%css {|background-color: lab(50% 20 -30)|}];
[%css {|background-color: lch(50% 30 120)|}];
[%css {|background-color: oklab(50% 0.1 -0.1)|}];
[%css {|background-color: oklch(50% 0.15 120)|}];
