(** CSS is a library that provides bindings to the CSS Typed OM API
    https://www.w3.org/TR/css-typed-om-1/ *)

type css_unit_value

(* CSSUnitValue.prototype.toString *)
external toString : css_unit_value -> string = "toString" [@@mel.send]

(* *)
external number : float -> css_unit_value = "number" [@@mel.scope "CSS"]
external percent : float -> css_unit_value = "percent" [@@mel.scope "CSS"]

(* <length> *)
external cap : float -> css_unit_value = "cap" [@@mel.scope "CSS"]
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
external rex : float -> css_unit_value = "rex" [@@mel.scope "CSS"]
external vw : float -> css_unit_value = "vw" [@@mel.scope "CSS"]
external vh : float -> css_unit_value = "vh" [@@mel.scope "CSS"]
external vi : float -> css_unit_value = "vi" [@@mel.scope "CSS"]
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
external q : float -> css_unit_value = "Q" [@@mel.scope "CSS"] (* Q *)
external in_ : float -> css_unit_value = "in" [@@mel.scope "CSS"] (* in *)
external pt : float -> css_unit_value = "pt" [@@mel.scope "CSS"]
external pc : float -> css_unit_value = "pc" [@@mel.scope "CSS"]
external px : float -> css_unit_value = "px" [@@mel.scope "CSS"]

(* <angle> *)
external deg : float -> css_unit_value = "deg" [@@mel.scope "CSS"]
external grad : float -> css_unit_value = "grad" [@@mel.scope "CSS"]
external rad : float -> css_unit_value = "rad" [@@mel.scope "CSS"]
external turn : float -> css_unit_value = "turn" [@@mel.scope "CSS"]

(* <time> *)
external s : float -> css_unit_value = "s" [@@mel.scope "CSS"]
external ms : float -> css_unit_value = "ms" [@@mel.scope "CSS"]

(* <frequency> *)
external hz : float -> css_unit_value = "Hz" [@@mel.scope "CSS"] (* Hz *)
external k : float -> css_unit_value = "k" [@@mel.scope "CSS"]

(* <resolution> *)
external dpi : float -> css_unit_value = "dpi" [@@mel.scope "CSS"]
external dpcm : float -> css_unit_value = "dpcm" [@@mel.scope "CSS"]
external dppx : float -> css_unit_value = "dppx" [@@mel.scope "CSS"]

(* <flex> *)
external fr : float -> css_unit_value = "fr" [@@mel.scope "CSS"]

module MathValue = struct
  type css_math_sum
  type css_math_product
  type css_math_negate
  type css_math_invert
  type css_math_min
  type css_math_max

  (* All math operations inherit from CSSNumericValue, which has toString *)
  type css_numeric_value

  external add : css_unit_value -> css_unit_value -> css_math_sum = "add"
  [@@mel.send]

  external sub : css_unit_value -> css_unit_value -> css_math_sum = "sub"
  [@@mel.send]

  external mul : css_unit_value -> float -> css_math_product = "mul"
  [@@mel.send]

  external div : css_unit_value -> float -> css_math_product = "div"
  [@@mel.send]

  (* Static methods *)
  external min : css_numeric_value array -> css_math_min = "min"
  [@@mel.scope "CSS"]

  external max : css_numeric_value array -> css_math_max = "max"
  [@@mel.scope "CSS"]
end
