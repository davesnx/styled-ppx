/**
 * CSS Colors Data Types
 * 
 * This module defines CSS color-related data types according to the CSS Color Module specifications.
 * 
 * References:
 * - CSS Color Module Level 4: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Colors
 * - <color> data type: https://developer.mozilla.org/en-US/docs/Web/CSS/color_value
 * - Named colors: https://developer.mozilla.org/en-US/docs/Web/CSS/named-color
 * - System colors: https://developer.mozilla.org/en-US/docs/Web/CSS/system-color
 */

/**
 * Alpha value for colors
 * 
 * Represents the transparency/opacity of a color, ranging from 0 (fully transparent) to 1 (fully opaque).
 * Can be specified as a number or percentage.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/alpha-value
 */
let rec alpha_value = [%value.rec "<number> | <extended-percentage>"];

/**
 * Main color data type
 * 
 * Represents a color value in CSS, supporting various color formats including:
 * - RGB/RGBA functions
 * - HSL/HSLA functions  
 * - Hex colors
 * - Named colors
 * - System colors
 * - currentColor keyword
 * - Color mixing functions
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value
 */
and color = [%value.rec
  "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | 'currentColor' | <deprecated-system-color> | <interpolation> | <var()> | <color-mix()>"
];

/**
 * Named colors
 * 
 * Predefined color keywords like 'red', 'blue', 'transparent', etc.
 * Includes all CSS named colors and the transparent keyword.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/named-color
 */
and named_color = [%value.rec
  "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | 'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | 'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | 'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | 'cyan' | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | 'darkgreen' | 'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' | 'darkorange' | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' | 'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | 'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | 'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | 'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | 'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' | 'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | 'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | 'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | 'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | 'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | 'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | 'mediumaquamarine' | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | 'mediumseagreen' | 'mediumslateblue' | 'mediumspringgreen' | 'mediumturquoise' | 'mediumvioletred' | 'midnightblue' | 'mintcream' | 'mistyrose' | 'moccasin' | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | 'olivedrab' | 'orange' | 'orangered' | 'orchid' | 'palegoldenrod' | 'palegreen' | 'paleturquoise' | 'palevioletred' | 'papayawhip' | 'peachpuff' | 'peru' | 'pink' | 'plum' | 'powderblue' | 'purple' | 'rebeccapurple' | 'red' | 'rosybrown' | 'royalblue' | 'saddlebrown' | 'salmon' | 'sandybrown' | 'seagreen' | 'seashell' | 'sienna' | 'silver' | 'skyblue' | 'slateblue' | 'slategray' | 'slategrey' | 'snow' | 'springgreen' | 'steelblue' | 'tan' | 'teal' | 'thistle' | 'tomato' | 'turquoise' | 'violet' | 'wheat' | 'white' | 'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>"
];

/**
 * Deprecated system colors
 * 
 * Legacy system color keywords that were used to reference OS-specific colors.
 * Now deprecated but still supported for backwards compatibility.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/system-color
 */
and deprecated_system_color = [%value.rec
  "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | 'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | 'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | 'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | 'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | 'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'"
];

/**
 * Color stop length
 * 
 * Used in gradients to specify where a color stop should be positioned.
 * Can be a length or percentage value.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/linear-gradient#color-stop-length
 */
and color_stop_length = [%value.rec
  "<extended-length> | <extended-percentage>"
];

/**
 * Color stop angle  
 * 
 * Used in conic gradients to specify the angular position of color stops.
 * Can accept one or two angle values.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/conic-gradient#color-stop-angle
 */
and color_stop_angle = [%value.rec "[ <extended-angle> ]{1,2}"];

/**
 * Color stop
 * 
 * A color stop used in gradients, specifying both position and how the stop is defined.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient#color-stops
 */
and color_stop = [%value.rec "<color-stop-length> | <color-stop-angle>"];

/**
 * Color stop list
 * 
 * A list of color stops used in linear and radial gradients.
 * Simplified version that allows easier code generation while maintaining compatibility.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient#color-stop-list
 */
and color_stop_list = [%value.rec
  "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#"
];

/**
 * Angular color stop
 * 
 * Color stop used specifically in conic gradients with angular positioning.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/conic-gradient
 */
and angular_color_stop = [%value.rec "<color> && [ <color-stop-angle> ]?"];

/**
 * Angular color hint
 * 
 * Used in conic gradients to control the transition between color stops.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/conic-gradient
 */
and angular_color_hint = [%value.rec
  "<extended-angle> | <extended-percentage>"
];

/**
 * Angular color stop list
 * 
 * List of color stops and hints used specifically in conic gradients.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/conic-gradient
 */
and angular_color_stop_list = [%value.rec
  "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' <angular-color-stop>"
];

/**
 * Linear color stop
 * 
 * Color stop used in linear gradients with optional length/percentage positioning.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/linear-gradient
 */
and linear_color_stop = [%value.rec "<color> <length-percentage>?"];

/**
 * Linear color hint
 * 
 * Used in linear gradients to control the transition midpoint between color stops.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/gradient/linear-gradient
 */
and linear_color_hint = [%value.rec
  "<extended-length> | <extended-percentage>"
];

/**
 * Hue interpolation method
 * 
 * Specifies how hue values should be interpolated in color spaces.
 * Used in color-mix() function and other color interpolation contexts.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix#interpolation-method
 */
and hue_interpolation_method = [%value.rec
  " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' "
];

/**
 * Polar color space
 * 
 * Color spaces that use polar coordinates (hue, saturation, lightness/brightness).
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix#interpolation-method
 */
and polar_color_space = [%value.rec " 'hsl' | 'hwb' | 'lch' | 'oklch' "];

/**
 * Rectangular color space
 * 
 * Color spaces that use rectangular/Cartesian coordinates.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix#interpolation-method
 */
and rectangular_color_space = [%value.rec
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | 'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' "
];

/**
 * Color interpolation method
 * 
 * Specifies how colors should be interpolated when mixing or transitioning.
 * Used in color-mix() function and CSS transitions.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix#interpolation-method
 */
and color_interpolation_method = [%value.rec
  " 'in' && [<rectangular-color-space> | <polar-color-space> <hue-interpolation-method>?] "
];

/**
 * color-mix() function
 * 
 * Function for mixing two colors in a specified color space with optional percentages.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/color_value/color-mix
 */
and function_color_mix = [%value.rec
  (* TODO: Use <extended-percentage> *)
  "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' [ <color> && <percentage>? ])"
];