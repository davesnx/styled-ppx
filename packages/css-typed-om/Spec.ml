(** CSS is a library that provides bindings to the CSS Typed OM API
    https://www.w3.org/TR/css-typed-om-1/ *)

(** Base types *)
type css_style_value

type css_keyword_value
type css_numeric_value
type css_unit_value
type css_math_value

(** Math value subtypes *)
type css_math_sum

type css_math_product
type css_math_negate
type css_math_invert
type css_math_min
type css_math_max
type css_math_clamp

(** Transform types *)
type css_transform_value

type css_transform_component
type css_translate
type css_rotate
type css_scale
type css_skew
type css_skew_x
type css_skew_y
type css_perspective
type css_matrix_component

(** Color types *)
type css_color_value

type css_rgb
type css_hsl
type css_hwb
type css_lab
type css_lch
type css_oklab
type css_oklch
type css_color

(** Image types *)
type css_image_value

(** Array types *)
type css_numeric_array

(** Enums *)
type css_numeric_base_type =
  | Length [@mel.as "length"]
  | Angle [@mel.as "angle"]
  | Time [@mel.as "time"]
  | Frequency [@mel.as "frequency"]
  | Resolution [@mel.as "resolution"]
  | Flex [@mel.as "flex"]
  | Percent [@mel.as "percent"]

type css_math_operator =
  | Sum [@mel.as "sum"]
  | Product [@mel.as "product"]
  | Negate [@mel.as "negate"]
  | Invert [@mel.as "invert"]
  | Min [@mel.as "min"]
  | Max [@mel.as "max"]
  | Clamp [@mel.as "clamp"]

(** CSSKeywordValue *)
external createKeywordValue : string -> css_keyword_value = "CSSKeywordValue"
[@@mel.new]

external keywordValue_value : css_keyword_value -> string = "value" [@@mel.get]

external keywordValue_setValue : css_keyword_value -> string -> unit = "value"
[@@mel.set]

(** CSSStyleValue *)
external toString : 'a -> string = "toString" [@@mel.send]

(** CSSNumericValue - instance methods *)
external add : css_numeric_value -> css_numeric_value array -> css_numeric_value
  = "add"
[@@mel.send] [@@mel.variadic]

external sub : css_numeric_value -> css_numeric_value array -> css_numeric_value
  = "sub"
[@@mel.send] [@@mel.variadic]

external mul : css_numeric_value -> css_numeric_value array -> css_numeric_value
  = "mul"
[@@mel.send] [@@mel.variadic]

external div : css_numeric_value -> css_numeric_value array -> css_numeric_value
  = "div"
[@@mel.send] [@@mel.variadic]

external min : css_numeric_value -> css_numeric_value array -> css_numeric_value
  = "min"
[@@mel.send] [@@mel.variadic]

external max : css_numeric_value -> css_numeric_value array -> css_numeric_value
  = "max"
[@@mel.send] [@@mel.variadic]

external equals : css_numeric_value -> css_numeric_value array -> bool
  = "equals"
[@@mel.send] [@@mel.variadic]

external to_ : css_numeric_value -> string -> css_unit_value = "to" [@@mel.send]

external toSum : css_numeric_value -> string array -> css_math_sum = "toSum"
[@@mel.send] [@@mel.variadic]

(** CSSNumericValue - static methods *)
external parse : string -> css_numeric_value = "parse"
[@@mel.scope "CSSNumericValue"]

(** CSSUnitValue constructor *)
external createUnitValue : float -> string -> css_unit_value = "CSSUnitValue"
[@@mel.new]

external unitValue_value : css_unit_value -> float = "value" [@@mel.get]

external unitValue_setValue : css_unit_value -> float -> unit = "value"
[@@mel.set]

external unitValue_unit : css_unit_value -> string = "unit" [@@mel.get]

(** CSSMathValue *)
external mathValue_operator : css_math_value -> string = "operator"
[@@mel.get]

(** CSSMathSum *)
external createMathSum : css_numeric_value array -> css_math_sum = "CSSMathSum"
[@@mel.new] [@@mel.variadic]

external mathSum_values : css_math_sum -> css_numeric_array = "values"
[@@mel.get]

(** CSSMathProduct *)
external createMathProduct : css_numeric_value array -> css_math_product
  = "CSSMathProduct"
[@@mel.new] [@@mel.variadic]

external mathProduct_values : css_math_product -> css_numeric_array = "values"
[@@mel.get]

(** CSSMathNegate *)
external createMathNegate : css_numeric_value -> css_math_negate
  = "CSSMathNegate"
[@@mel.new]

external mathNegate_value : css_math_negate -> css_numeric_value = "value"
[@@mel.get]

(** CSSMathInvert *)
external createMathInvert : css_numeric_value -> css_math_invert
  = "CSSMathInvert"
[@@mel.new]

external mathInvert_value : css_math_invert -> css_numeric_value = "value"
[@@mel.get]

(** CSSMathMin *)
external createMathMin : css_numeric_value array -> css_math_min = "CSSMathMin"
[@@mel.new] [@@mel.variadic]

external mathMin_values : css_math_min -> css_numeric_array = "values"
[@@mel.get]

(** CSSMathMax *)
external createMathMax : css_numeric_value array -> css_math_max = "CSSMathMax"
[@@mel.new] [@@mel.variadic]

external mathMax_values : css_math_max -> css_numeric_array = "values"
[@@mel.get]

(** CSSMathClamp *)
external createMathClamp :
  css_numeric_value -> css_numeric_value -> css_numeric_value -> css_math_clamp
  = "CSSMathClamp"
[@@mel.new]

external mathClamp_lower : css_math_clamp -> css_numeric_value = "lower"
[@@mel.get]

external mathClamp_value : css_math_clamp -> css_numeric_value = "value"
[@@mel.get]

external mathClamp_upper : css_math_clamp -> css_numeric_value = "upper"
[@@mel.get]

(** CSSNumericArray *)
external numericArray_length : css_numeric_array -> int = "length"
[@@mel.get]

external numericArray_get : css_numeric_array -> int -> css_numeric_value = ""
[@@mel.get_index]

(** CSS namespace - unit value factories *)
external number : float -> css_unit_value = "number"
[@@mel.scope "CSS"]

external percent : float -> css_unit_value = "percent" [@@mel.scope "CSS"]

(** <length> *)
external cap : float -> css_unit_value = "cap"
[@@mel.scope "CSS"]

external ch : float -> css_unit_value = "ch" [@@mel.scope "CSS"]
external em : float -> css_unit_value = "em" [@@mel.scope "CSS"]
external ex : float -> css_unit_value = "ex" [@@mel.scope "CSS"]
external ic : float -> css_unit_value = "ic" [@@mel.scope "CSS"]
external lh : float -> css_unit_value = "lh" [@@mel.scope "CSS"]
external rcap : float -> css_unit_value = "rcap" [@@mel.scope "CSS"]
external rch : float -> css_unit_value = "rch" [@@mel.scope "CSS"]
external rem : float -> css_unit_value = "rem" [@@mel.scope "CSS"]
external rex : float -> css_unit_value = "rex" [@@mel.scope "CSS"]
external ric : float -> css_unit_value = "ric" [@@mel.scope "CSS"]
external rlh : float -> css_unit_value = "rlh" [@@mel.scope "CSS"]
external vw : float -> css_unit_value = "vw" [@@mel.scope "CSS"]
external vh : float -> css_unit_value = "vh" [@@mel.scope "CSS"]
external vi : float -> css_unit_value = "vi" [@@mel.scope "CSS"]
external vb : float -> css_unit_value = "vb" [@@mel.scope "CSS"]
external vmin : float -> css_unit_value = "vmin" [@@mel.scope "CSS"]
external vmax : float -> css_unit_value = "vmax" [@@mel.scope "CSS"]
external svw : float -> css_unit_value = "svw" [@@mel.scope "CSS"]
external svh : float -> css_unit_value = "svh" [@@mel.scope "CSS"]
external svi : float -> css_unit_value = "svi" [@@mel.scope "CSS"]
external svb : float -> css_unit_value = "svb" [@@mel.scope "CSS"]
external svmin : float -> css_unit_value = "svmin" [@@mel.scope "CSS"]
external svmax : float -> css_unit_value = "svmax" [@@mel.scope "CSS"]
external lvw : float -> css_unit_value = "lvw" [@@mel.scope "CSS"]
external lvh : float -> css_unit_value = "lvh" [@@mel.scope "CSS"]
external lvi : float -> css_unit_value = "lvi" [@@mel.scope "CSS"]
external lvb : float -> css_unit_value = "lvb" [@@mel.scope "CSS"]
external lvmin : float -> css_unit_value = "lvmin" [@@mel.scope "CSS"]
external lvmax : float -> css_unit_value = "lvmax" [@@mel.scope "CSS"]
external dvw : float -> css_unit_value = "dvw" [@@mel.scope "CSS"]
external dvh : float -> css_unit_value = "dvh" [@@mel.scope "CSS"]
external dvi : float -> css_unit_value = "dvi" [@@mel.scope "CSS"]
external dvb : float -> css_unit_value = "dvb" [@@mel.scope "CSS"]
external dvmin : float -> css_unit_value = "dvmin" [@@mel.scope "CSS"]
external dvmax : float -> css_unit_value = "dvmax" [@@mel.scope "CSS"]
external cqw : float -> css_unit_value = "cqw" [@@mel.scope "CSS"]
external cqh : float -> css_unit_value = "cqh" [@@mel.scope "CSS"]
external cqi : float -> css_unit_value = "cqi" [@@mel.scope "CSS"]
external cqb : float -> css_unit_value = "cqb" [@@mel.scope "CSS"]
external cqmin : float -> css_unit_value = "cqmin" [@@mel.scope "CSS"]
external cqmax : float -> css_unit_value = "cqmax" [@@mel.scope "CSS"]
external cm : float -> css_unit_value = "cm" [@@mel.scope "CSS"]
external mm : float -> css_unit_value = "mm" [@@mel.scope "CSS"]
external q : float -> css_unit_value = "Q" [@@mel.scope "CSS"]
external in_ : float -> css_unit_value = "in" [@@mel.scope "CSS"]
external pt : float -> css_unit_value = "pt" [@@mel.scope "CSS"]
external pc : float -> css_unit_value = "pc" [@@mel.scope "CSS"]
external px : float -> css_unit_value = "px" [@@mel.scope "CSS"]

(** <angle> *)
external deg : float -> css_unit_value = "deg" [@@mel.scope "CSS"]

external grad : float -> css_unit_value = "grad" [@@mel.scope "CSS"]
external rad : float -> css_unit_value = "rad" [@@mel.scope "CSS"]
external turn : float -> css_unit_value = "turn" [@@mel.scope "CSS"]

(** <time> *)
external s : float -> css_unit_value = "s" [@@mel.scope "CSS"]

external ms : float -> css_unit_value = "ms" [@@mel.scope "CSS"]

(** <frequency> *)
external hz : float -> css_unit_value = "Hz"
[@@mel.scope "CSS"]

external khz : float -> css_unit_value = "kHz" [@@mel.scope "CSS"]

(** <resolution> *)
external dpi : float -> css_unit_value = "dpi"
[@@mel.scope "CSS"]

external dpcm : float -> css_unit_value = "dpcm" [@@mel.scope "CSS"]
external dppx : float -> css_unit_value = "dppx" [@@mel.scope "CSS"]

(** <flex> *)
external fr : float -> css_unit_value = "fr" [@@mel.scope "CSS"]

(** CSSTransformValue *)
external createTransformValue :
  css_transform_component array -> css_transform_value = "CSSTransformValue"
[@@mel.new]

external transformValue_length : css_transform_value -> int = "length"
[@@mel.get]

external transformValue_get :
  css_transform_value -> int -> css_transform_component = ""
[@@mel.get_index]

external transformValue_set :
  css_transform_value -> int -> css_transform_component -> unit = ""
[@@mel.set_index]

external transformValue_is2D : css_transform_value -> bool = "is2D" [@@mel.get]

(** CSSTransformComponent *)
external transformComponent_is2D : css_transform_component -> bool = "is2D"
[@@mel.get]

external transformComponent_setIs2D : css_transform_component -> bool -> unit
  = "is2D"
[@@mel.set]

(** CSSTranslate *)
external createTranslate :
  css_numeric_value ->
  css_numeric_value ->
  css_numeric_value option ->
  css_translate = "CSSTranslate"
[@@mel.new]

external translate_x : css_translate -> css_numeric_value = "x" [@@mel.get]

external translate_setX : css_translate -> css_numeric_value -> unit = "x"
[@@mel.set]

external translate_y : css_translate -> css_numeric_value = "y" [@@mel.get]

external translate_setY : css_translate -> css_numeric_value -> unit = "y"
[@@mel.set]

external translate_z : css_translate -> css_numeric_value = "z" [@@mel.get]

external translate_setZ : css_translate -> css_numeric_value -> unit = "z"
[@@mel.set]

(** CSSRotate *)
external createRotate1 : css_numeric_value -> css_rotate = "CSSRotate"
[@@mel.new]

external createRotate4 :
  float -> float -> float -> css_numeric_value -> css_rotate = "CSSRotate"
[@@mel.new]

external rotate_x : css_rotate -> float = "x" [@@mel.get]
external rotate_setX : css_rotate -> float -> unit = "x" [@@mel.set]
external rotate_y : css_rotate -> float = "y" [@@mel.get]
external rotate_setY : css_rotate -> float -> unit = "y" [@@mel.set]
external rotate_z : css_rotate -> float = "z" [@@mel.get]
external rotate_setZ : css_rotate -> float -> unit = "z" [@@mel.set]
external rotate_angle : css_rotate -> css_numeric_value = "angle" [@@mel.get]

external rotate_setAngle : css_rotate -> css_numeric_value -> unit = "angle"
[@@mel.set]

(** CSSScale *)
external createScale : float -> float -> float option -> css_scale = "CSSScale"
[@@mel.new]

external scale_x : css_scale -> float = "x" [@@mel.get]
external scale_setX : css_scale -> float -> unit = "x" [@@mel.set]
external scale_y : css_scale -> float = "y" [@@mel.get]
external scale_setY : css_scale -> float -> unit = "y" [@@mel.set]
external scale_z : css_scale -> float = "z" [@@mel.get]
external scale_setZ : css_scale -> float -> unit = "z" [@@mel.set]

(** CSSSkew *)
external createSkew : css_numeric_value -> css_numeric_value -> css_skew
  = "CSSSkew"
[@@mel.new]

external skew_ax : css_skew -> css_numeric_value = "ax" [@@mel.get]
external skew_setAx : css_skew -> css_numeric_value -> unit = "ax" [@@mel.set]
external skew_ay : css_skew -> css_numeric_value = "ay" [@@mel.get]
external skew_setAy : css_skew -> css_numeric_value -> unit = "ay" [@@mel.set]

(** CSSSkewX *)
external createSkewX : css_numeric_value -> css_skew_x = "CSSSkewX"
[@@mel.new]

external skewX_ax : css_skew_x -> css_numeric_value = "ax" [@@mel.get]

external skewX_setAx : css_skew_x -> css_numeric_value -> unit = "ax"
[@@mel.set]

(** CSSSkewY *)
external createSkewY : css_numeric_value -> css_skew_y = "CSSSkewY"
[@@mel.new]

external skewY_ay : css_skew_y -> css_numeric_value = "ay" [@@mel.get]

external skewY_setAy : css_skew_y -> css_numeric_value -> unit = "ay"
[@@mel.set]

(** CSSPerspective - length can be css_numeric_value or css_keyword_value *)
external createPerspective : 'a -> css_perspective = "CSSPerspective"
[@@mel.new]

external perspective_length : css_perspective -> 'a = "length" [@@mel.get]

external perspective_setLength : css_perspective -> 'a -> unit = "length"
[@@mel.set]

(** CSSColorValue *)
external parseColor : string -> css_color_value = "parse"
[@@mel.scope "CSSColorValue"]

(** CSSRGB *)
external createRGB : 'a -> 'a -> 'a -> 'a option -> css_rgb = "CSSRGB"
[@@mel.new]

external rgb_r : css_rgb -> 'a = "r" [@@mel.get]
external rgb_setR : css_rgb -> 'a -> unit = "r" [@@mel.set]
external rgb_g : css_rgb -> 'a = "g" [@@mel.get]
external rgb_setG : css_rgb -> 'a -> unit = "g" [@@mel.set]
external rgb_b : css_rgb -> 'a = "b" [@@mel.get]
external rgb_setB : css_rgb -> 'a -> unit = "b" [@@mel.set]
external rgb_alpha : css_rgb -> 'a = "alpha" [@@mel.get]
external rgb_setAlpha : css_rgb -> 'a -> unit = "alpha" [@@mel.set]

(** CSSHSL *)
external createHSL : 'a -> 'a -> 'a -> 'a option -> css_hsl = "CSSHSL"
[@@mel.new]

external hsl_h : css_hsl -> 'a = "h" [@@mel.get]
external hsl_setH : css_hsl -> 'a -> unit = "h" [@@mel.set]
external hsl_s : css_hsl -> 'a = "s" [@@mel.get]
external hsl_setS : css_hsl -> 'a -> unit = "s" [@@mel.set]
external hsl_l : css_hsl -> 'a = "l" [@@mel.get]
external hsl_setL : css_hsl -> 'a -> unit = "l" [@@mel.set]
external hsl_alpha : css_hsl -> 'a = "alpha" [@@mel.get]
external hsl_setAlpha : css_hsl -> 'a -> unit = "alpha" [@@mel.set]

(** CSSHWB *)
external createHWB :
  css_numeric_value -> float -> float -> float option -> css_hwb = "CSSHWB"
[@@mel.new]

external hwb_h : css_hwb -> css_numeric_value = "h" [@@mel.get]
external hwb_setH : css_hwb -> css_numeric_value -> unit = "h" [@@mel.set]
external hwb_w : css_hwb -> float = "w" [@@mel.get]
external hwb_setW : css_hwb -> float -> unit = "w" [@@mel.set]
external hwb_b : css_hwb -> float = "b" [@@mel.get]
external hwb_setB : css_hwb -> float -> unit = "b" [@@mel.set]
external hwb_alpha : css_hwb -> float = "alpha" [@@mel.get]
external hwb_setAlpha : css_hwb -> float -> unit = "alpha" [@@mel.set]

(** CSSLab *)
external createLab : 'a -> 'a -> 'a -> 'a option -> css_lab = "CSSLab"
[@@mel.new]

external lab_l : css_lab -> 'a = "l" [@@mel.get]
external lab_setL : css_lab -> 'a -> unit = "l" [@@mel.set]
external lab_a : css_lab -> 'a = "a" [@@mel.get]
external lab_setA : css_lab -> 'a -> unit = "a" [@@mel.set]
external lab_b : css_lab -> 'a = "b" [@@mel.get]
external lab_setB : css_lab -> 'a -> unit = "b" [@@mel.set]
external lab_alpha : css_lab -> 'a = "alpha" [@@mel.get]
external lab_setAlpha : css_lab -> 'a -> unit = "alpha" [@@mel.set]

(** CSSLCH *)
external createLCH : 'a -> 'a -> 'a -> 'a option -> css_lch = "CSSLCH"
[@@mel.new]

external lch_l : css_lch -> 'a = "l" [@@mel.get]
external lch_setL : css_lch -> 'a -> unit = "l" [@@mel.set]
external lch_c : css_lch -> 'a = "c" [@@mel.get]
external lch_setC : css_lch -> 'a -> unit = "c" [@@mel.set]
external lch_h : css_lch -> 'a = "h" [@@mel.get]
external lch_setH : css_lch -> 'a -> unit = "h" [@@mel.set]
external lch_alpha : css_lch -> 'a = "alpha" [@@mel.get]
external lch_setAlpha : css_lch -> 'a -> unit = "alpha" [@@mel.set]

(** CSSOKLab *)
external createOKLab : 'a -> 'a -> 'a -> 'a option -> css_oklab = "CSSOKLab"
[@@mel.new]

external oklab_l : css_oklab -> 'a = "l" [@@mel.get]
external oklab_setL : css_oklab -> 'a -> unit = "l" [@@mel.set]
external oklab_a : css_oklab -> 'a = "a" [@@mel.get]
external oklab_setA : css_oklab -> 'a -> unit = "a" [@@mel.set]
external oklab_b : css_oklab -> 'a = "b" [@@mel.get]
external oklab_setB : css_oklab -> 'a -> unit = "b" [@@mel.set]
external oklab_alpha : css_oklab -> 'a = "alpha" [@@mel.get]
external oklab_setAlpha : css_oklab -> 'a -> unit = "alpha" [@@mel.set]

(** CSSOKLCH *)
external createOKLCH : 'a -> 'a -> 'a -> 'a option -> css_oklch = "CSSOKLCH"
[@@mel.new]

external oklch_l : css_oklch -> 'a = "l" [@@mel.get]
external oklch_setL : css_oklch -> 'a -> unit = "l" [@@mel.set]
external oklch_c : css_oklch -> 'a = "c" [@@mel.get]
external oklch_setC : css_oklch -> 'a -> unit = "c" [@@mel.set]
external oklch_h : css_oklch -> 'a = "h" [@@mel.get]
external oklch_setH : css_oklch -> 'a -> unit = "h" [@@mel.set]
external oklch_alpha : css_oklch -> 'a = "alpha" [@@mel.get]
external oklch_setAlpha : css_oklch -> 'a -> unit = "alpha" [@@mel.set]

(** CSSColor *)
external createColor : 'a -> 'a array -> float option -> css_color = "CSSColor"
[@@mel.new]

external color_colorSpace : css_color -> 'a = "colorSpace" [@@mel.get]

external color_setColorSpace : css_color -> 'a -> unit = "colorSpace"
[@@mel.set]

external color_channels : css_color -> 'a array = "channels" [@@mel.get]
external color_alpha : css_color -> float = "alpha" [@@mel.get]
external color_setAlpha : css_color -> float -> unit = "alpha" [@@mel.set]
