/**
 * CSS Color Functions
 * 
 * This module defines CSS color functions for creating and manipulating colors.
 * 
 * References:
 * - CSS Color Module: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Colors
 * - rgb(): https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/rgb
 * - hsl(): https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/hsl
 * - color-mix(): https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix
 */

/**
 * rgb() function
 * 
 * Creates colors using the RGB (red, green, blue) color model.
 * Supports both comma-separated and space-separated syntax, with optional alpha.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/rgb
 */
let rec function_rgb = [%value.rec
  "rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? ) | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )"
];

/**
 * rgba() function
 * 
 * Creates colors using the RGB color model with alpha transparency.
 * Legacy function that's now identical to rgb() with alpha support.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/rgba
 */
and function_rgba = [%value.rec
  "rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ <number> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? ) | rgba( [ <number> ]#{3} [ ',' <alpha-value> ]? )"
];

/**
 * hsl() function
 * 
 * Creates colors using the HSL (hue, saturation, lightness) color model.
 * Supports both comma-separated and space-separated syntax, with optional alpha.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/hsl
 */
and function_hsl = [%value.rec
  " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? ) | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' <alpha-value> ]? )"
];

/**
 * hsla() function
 * 
 * Creates colors using the HSL color model with alpha transparency.
 * Legacy function that's now identical to hsl() with alpha support.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/hsla
 */
and function_hsla = [%value.rec
  " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? ) | hsla( <hue> ',' <extended-percentage> ',' <extended-percentage> ',' [ <alpha-value> ]? )"
];

/**
 * color-mix() function
 * 
 * Mixes two colors in a specified color space with optional percentages.
 * Allows for sophisticated color blending and interpolation.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix
 */
and function_color_mix = [%value.rec
  (* TODO: Use <extended-percentage> *)
  "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' [ <color> && <percentage>? ])"
];

/**
 * Hue value
 * 
 * Represents the hue component in HSL color functions.
 * Can be specified as a number (degrees) or angle value.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/hue
 */
and hue = [%value.rec "<number> | <extended-angle>"];