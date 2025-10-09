/* CSS Color Types
 * Color-related value types and functions
 */

open Standard;
open Modifier;
open Rule.Match;

module rec Color = [%value.rec
  "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | 'currentColor' | <deprecated-system-color> | <interpolation> | <var()> | <color-mix()>"
]

and Function_rgb = [%value.rec
  "
    rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
  | rgb( [ <number> ]{3} [ '/' <alpha-value> ]? )
  | rgb( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
  | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )
"
]

and Function_rgba = [%value.rec
  "
    rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? )
  | rgba( [ <number> ]{3} [ '/' <alpha-value> ]? )
  | rgba( [ <extended-percentage> ]#{3} [ ',' <alpha-value> ]? )
  | rgba( [ <number> ]#{3} [ ',' <alpha-value> ]? )
"
]

and Function_hsl = [%value.rec
  " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? )
  | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' <alpha-value> ]? )"
]

and Function_hsla = [%value.rec
  " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> ]? )
  | hsla( <hue> ',' <extended-percentage> ',' <extended-percentage> ',' [ <alpha-value> ]? )"
]

and Hue = [%value.rec
  "<number> | <extended-angle>"
]

and Named_color = [%value.rec
  "'transparent' | 'aliceblue' | 'antiquewhite' | 'aqua' | 'aquamarine' | 'azure' | 'beige' | 'bisque' | 'black' | 'blanchedalmond' | 'blue' | 'blueviolet' | 'brown' | 'burlywood' | 'cadetblue' | 'chartreuse' | 'chocolate' | 'coral' | 'cornflowerblue' | 'cornsilk' | 'crimson' | 'cyan' | 'darkblue' | 'darkcyan' | 'darkgoldenrod' | 'darkgray' | 'darkgreen' | 'darkgrey' | 'darkkhaki' | 'darkmagenta' | 'darkolivegreen' | 'darkorange' | 'darkorchid' | 'darkred' | 'darksalmon' | 'darkseagreen' | 'darkslateblue' | 'darkslategray' | 'darkslategrey' | 'darkturquoise' | 'darkviolet' | 'deeppink' | 'deepskyblue' | 'dimgray' | 'dimgrey' | 'dodgerblue' | 'firebrick' | 'floralwhite' | 'forestgreen' | 'fuchsia' | 'gainsboro' | 'ghostwhite' | 'gold' | 'goldenrod' | 'gray' | 'green' | 'greenyellow' | 'grey' | 'honeydew' | 'hotpink' | 'indianred' | 'indigo' | 'ivory' | 'khaki' | 'lavender' | 'lavenderblush' | 'lawngreen' | 'lemonchiffon' | 'lightblue' | 'lightcoral' | 'lightcyan' | 'lightgoldenrodyellow' | 'lightgray' | 'lightgreen' | 'lightgrey' | 'lightpink' | 'lightsalmon' | 'lightseagreen' | 'lightskyblue' | 'lightslategray' | 'lightslategrey' | 'lightsteelblue' | 'lightyellow' | 'lime' | 'limegreen' | 'linen' | 'magenta' | 'maroon' | 'mediumaquamarine' | 'mediumblue' | 'mediumorchid' | 'mediumpurple' | 'mediumseagreen' | 'mediumslateblue' | 'mediumspringgreen' | 'mediumturquoise' | 'mediumvioletred' | 'midnightblue' | 'mintcream' | 'mistyrose' | 'moccasin' | 'navajowhite' | 'navy' | 'oldlace' | 'olive' | 'olivedrab' | 'orange' | 'orangered' | 'orchid' | 'palegoldenrod' | 'palegreen' | 'paleturquoise' | 'palevioletred' | 'papayawhip' | 'peachpuff' | 'peru' | 'pink' | 'plum' | 'powderblue' | 'purple' | 'rebeccapurple' | 'red' | 'rosybrown' | 'royalblue' | 'saddlebrown' | 'salmon' | 'sandybrown' | 'seagreen' | 'seashell' | 'sienna' | 'silver' | 'skyblue' | 'slateblue' | 'slategray' | 'slategrey' | 'snow' | 'springgreen' | 'steelblue' | 'tan' | 'teal' | 'thistle' | 'tomato' | 'turquoise' | 'violet' | 'wheat' | 'white' | 'whitesmoke' | 'yellow' | 'yellowgreen' | <-non-standard-color>"
]

and Deprecated_system_color = [%value.rec
  "'ActiveBorder' | 'ActiveCaption' | 'AppWorkspace' | 'Background' | 'ButtonFace' | 'ButtonHighlight' | 'ButtonShadow' | 'ButtonText' | 'CaptionText' | 'GrayText' | 'Highlight' | 'HighlightText' | 'InactiveBorder' | 'InactiveCaption' | 'InactiveCaptionText' | 'InfoBackground' | 'InfoText' | 'Menu' | 'MenuText' | 'Scrollbar' | 'ThreeDDarkShadow' | 'ThreeDFace' | 'ThreeDHighlight' | 'ThreeDLightShadow' | 'ThreeDShadow' | 'Window' | 'WindowFrame' | 'WindowText'"
]

/* Color stops and gradients components */
and Color_stop_list = [%value.rec
  "[ [<color>? <length-percentage>] | [<color> <length-percentage>?] ]#"
]

and Color_stop = [%value.rec
  "<color-stop-length> | <color-stop-angle>"
]

and Color_stop_length = [%value.rec
  "<extended-length> | <extended-percentage>"
]

and Color_stop_angle = [%value.rec
  "[ <extended-angle> ]{1,2}"
]

and Linear_color_stop = [%value.rec
  "<color> <length-percentage>?"
]

and Linear_color_hint = [%value.rec
  "<extended-length> | <extended-percentage>"
]

and Angular_color_stop = [%value.rec
  "<color> && [ <color-stop-angle> ]?"
]

and Angular_color_hint = [%value.rec
  "<extended-angle> | <extended-percentage>"
]

and Angular_color_stop_list = [%value.rec
  "[ <angular-color-stop> [ ',' <angular-color-hint> ]? ]# ',' <angular-color-stop>"
]

/* Color interpolation */
and Hue_interpolation_method = [%value.rec
  " [ 'shorter' | 'longer' | 'increasing' | 'decreasing' ] && 'hue' "
]

and Polar_color_space = [%value.rec
  " 'hsl' | 'hwb' | 'lch' | 'oklch' "
]

and Rectangular_color_space = [%value.rec
  " 'srgb' | 'srgb-linear' | 'display-p3' | 'a98-rgb' | 'prophoto-rgb' | 'rec2020' | 'lab' | 'oklab' | 'xyz' | 'xyz-d50' | 'xyz-d65' "
]

and Color_interpolation_method = [%value.rec
  " 'in' && [<rectangular-color-space> | <polar-color-space> <hue-interpolation-method>?] "
]

and Function_color_mix = [%value.rec
  "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' [ <color> && <percentage>? ])"
]

/* Paint (SVG/color) */
and Paint = [%value.rec
  "'none' | <color> | <url> [ 'none' | <color> ]? | 'context-fill' | 'context-stroke' | <interpolation>"
]

/* Non-standard extensions */
and Non_standard_color = [%value.rec
  "'-moz-ButtonDefault' | '-moz-ButtonHoverFace' | '-moz-ButtonHoverText' | '-moz-CellHighlight' | '-moz-CellHighlightText' | '-moz-Combobox' | '-moz-ComboboxText' | '-moz-Dialog' | '-moz-DialogText' | '-moz-dragtargetzone' | '-moz-EvenTreeRow' | '-moz-Field' | '-moz-FieldText' | '-moz-html-CellHighlight' | '-moz-html-CellHighlightText' | '-moz-mac-accentdarkestshadow' | '-moz-mac-accentdarkshadow' | '-moz-mac-accentface' | '-moz-mac-accentlightesthighlight' | '-moz-mac-accentlightshadow' | '-moz-mac-accentregularhighlight' | '-moz-mac-accentregularshadow' | '-moz-mac-chrome-active' | '-moz-mac-chrome-inactive' | '-moz-mac-focusring' | '-moz-mac-menuselect' | '-moz-mac-menushadow' | '-moz-mac-menutextselect' | '-moz-MenuHover' | '-moz-MenuHoverText' | '-moz-MenuBarText' | '-moz-MenuBarHoverText' | '-moz-nativehyperlinktext' | '-moz-OddTreeRow' | '-moz-win-communicationstext' | '-moz-win-mediatext' | '-moz-activehyperlinktext' | '-moz-default-background-color' | '-moz-default-color' | '-moz-hyperlinktext' | '-moz-visitedhyperlinktext' | '-webkit-activelink' | '-webkit-focus-ring-color' | '-webkit-link' | '-webkit-text'"
];

