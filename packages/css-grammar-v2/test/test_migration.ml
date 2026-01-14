open Alcotest
open Css_grammar_v2

let parse spec input =
  match Spec.parse ~strict:true spec input with
  | Ok v -> Ok v
  | Error e -> Error e

(* === LINE-STYLE: keyword-only property === *)
type line_style =
  [ `None
  | `Hidden
  | `Dotted
  | `Dashed
  | `Solid
  | `Double
  | `Groove
  | `Ridge
  | `Inset
  | `Outset
  ]

let line_style : line_style Spec.t =
  [%spec
    "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | \
     'ridge' | 'inset' | 'outset'"]

(* === LINE-WIDTH: keywords + length === *)
type line_width =
  [ `Length of Standard.length
  | `Thin
  | `Medium
  | `Thick
  ]

let line_width : line_width Spec.t =
  [%spec "<length> | 'thin' | 'medium' | 'thick'"]

(* === BOX-SHADOW tests === *)
(* shadow = ['inset']? <length>{2,4} [<color>]? *)

(* Single keyword uses unit type - variants only make sense with xor *)
let shadow_inset : unit Spec.t = [%spec "'inset'"]

type shadow_lengths = Standard.length list

let shadow_lengths : shadow_lengths Spec.t = [%spec "<length>{2,4}"]

(* === COLOR - basic named colors for testing === *)
type named_color =
  [ `Red
  | `Green
  | `Blue
  | `Black
  | `White
  | `Transparent
  | `CurrentColor
  ]

let named_color : named_color Spec.t =
  [%spec
    "'red' | 'green' | 'blue' | 'black' | 'white' | 'transparent' | \
     'currentColor'"]

(* === TRANSFORM FUNCTIONS === *)
(* Testing function parsing with different argument patterns *)

type translate_x = Standard.length_percentage

let translate_x : translate_x Spec.t =
  [%spec "translateX( <length-percentage> )"]

type translate_y = Standard.length_percentage

let translate_y : translate_y Spec.t =
  [%spec "translateY( <length-percentage> )"]

type scale_value = Standard.number

let scale_x : scale_value Spec.t = [%spec "scaleX( <number> )"]
let scale_y : scale_value Spec.t = [%spec "scaleY( <number> )"]

type rotate_value = Standard.angle

let rotate : rotate_value Spec.t = [%spec "rotate( <angle> )"]

(* === TRANSITION-PROPERTY === *)
type transition_property_value =
  [ `None
  | `All
  | `Custom_ident of string
  ]

let transition_property_value : transition_property_value Spec.t =
  [%spec "'none' | 'all' | <custom-ident>"]

type transition_property = transition_property_value list

let transition_property : transition_property Spec.t =
  [%spec "[ 'none' | 'all' | <custom-ident> ]#"]

(* === TIMING-FUNCTION (partial) === *)
type timing_function_keyword =
  [ `Ease
  | `Linear
  | `Ease_in
  | `Ease_out
  | `Ease_in_out
  | `Step_start
  | `Step_end
  ]

let timing_function_keyword : timing_function_keyword Spec.t =
  [%spec
    "'ease' | 'linear' | 'ease-in' | 'ease-out' | 'ease-in-out' | 'step-start' \
     | 'step-end'"]

(* === Tests === *)

let test_line_style () =
  check bool "solid" true (parse line_style "solid" = Ok `Solid);
  check bool "dashed" true (parse line_style "dashed" = Ok `Dashed);
  check bool "SOLID (case insensitive)" true
    (parse line_style "SOLID" = Ok `Solid);
  check bool "dotted" true (parse line_style "dotted" = Ok `Dotted);
  check bool "none" true (parse line_style "none" = Ok `None);
  check bool "invalid" true (Result.is_error (parse line_style "invalid"))

let test_line_width () =
  check bool "2px" true
    (match parse line_width "2px" with
    | Ok (`Length (`Px 2.0)) -> true
    | _ -> false);
  check bool "thin" true (parse line_width "thin" = Ok `Thin);
  check bool "medium" true (parse line_width "medium" = Ok `Medium);
  check bool "thick" true (parse line_width "thick" = Ok `Thick);
  check bool "calc" true
    (match parse line_width "calc(1px + 2px)" with
    | Ok (`Length (`Calc _)) -> true
    | _ -> false);
  check bool "interpolation" true
    (match parse line_width "$(borderWidth)" with
    | Ok (`Length (`Interpolation [ "borderWidth" ])) -> true
    | _ -> false)

let test_shadow_lengths () =
  check bool "2 values (x y)" true
    (match parse shadow_lengths "10px 20px" with
    | Ok [ `Px 10.0; `Px 20.0 ] -> true
    | _ -> false);
  check bool "3 values (x y blur)" true
    (match parse shadow_lengths "10px 20px 5px" with
    | Ok [ `Px 10.0; `Px 20.0; `Px 5.0 ] -> true
    | _ -> false);
  check bool "4 values (x y blur spread)" true
    (match parse shadow_lengths "10px 20px 5px 2px" with
    | Ok [ `Px 10.0; `Px 20.0; `Px 5.0; `Px 2.0 ] -> true
    | _ -> false);
  check bool "1 value fails" true
    (Result.is_error (parse shadow_lengths "10px"));
  check bool "5 values fails (strict)" true
    (Result.is_error (parse shadow_lengths "10px 20px 5px 2px 1px"))

let test_named_color () =
  check bool "red" true (parse named_color "red" = Ok `Red);
  check bool "transparent" true
    (parse named_color "transparent" = Ok `Transparent);
  check bool "currentColor" true
    (parse named_color "currentColor" = Ok `CurrentColor);
  check bool "CURRENTCOLOR (case)" true
    (parse named_color "CURRENTCOLOR" = Ok `CurrentColor)

let test_transform_functions () =
  check bool "translateX(10px)" true
    (match parse translate_x "translateX(10px)" with
    | Ok (`Length (`Px 10.0)) -> true
    | _ -> false);
  check bool "translateX(50%)" true
    (match parse translate_x "translateX(50%)" with
    | Ok (`Percentage (`Percentage 50.0)) -> true
    | _ -> false);
  check bool "translateY(-20px)" true
    (match parse translate_y "translateY(-20px)" with
    | Ok (`Length (`Px -20.0)) -> true
    | _ -> false);
  check bool "scaleX(1.5)" true
    (match parse scale_x "scaleX(1.5)" with
    | Ok (`Number 1.5) -> true
    | _ -> false);
  check bool "rotate(45deg)" true
    (match parse rotate "rotate(45deg)" with
    | Ok (`Deg 45.0) -> true
    | _ -> false);
  check bool "rotate(calc(45deg + 10deg))" true
    (match parse rotate "rotate(calc(45deg + 10deg))" with
    | Ok (`Calc _) -> true
    | _ -> false)

let test_transition_property () =
  check bool "none" true
    (match parse transition_property "none" with
    | Ok [ `None ] -> true
    | _ -> false);
  check bool "all" true
    (match parse transition_property "all" with
    | Ok [ `All ] -> true
    | _ -> false);
  check bool "opacity" true
    (match parse transition_property "opacity" with
    | Ok [ `Custom_ident "opacity" ] -> true
    | _ -> false);
  check bool "multiple" true
    (match parse transition_property "opacity, transform, color" with
    | Ok
        [
          `Custom_ident "opacity";
          `Custom_ident "transform";
          `Custom_ident "color";
        ] ->
      true
    | _ -> false)

let test_timing_function_keyword () =
  check bool "ease" true (parse timing_function_keyword "ease" = Ok `Ease);
  check bool "linear" true (parse timing_function_keyword "linear" = Ok `Linear);
  check bool "ease-in" true
    (parse timing_function_keyword "ease-in" = Ok `Ease_in);
  check bool "ease-out" true
    (parse timing_function_keyword "ease-out" = Ok `Ease_out);
  check bool "ease-in-out" true
    (parse timing_function_keyword "ease-in-out" = Ok `Ease_in_out)

(* === BORDER shorthand === *)
(* In CSS spec: <line-width> || <line-style> || <color>
   We treat || as positional for interpolation type inference.
   So we require: <line-width> <line-style> <color> *)

(* For interpolation extraction to work, we define border with direct types
   instead of referencing other Spec.t values *)
type border_direct =
  [ `Length of Standard.length | `Thin | `Medium | `Thick ]
  * line_style
  * named_color

let border_direct : border_direct Spec.t =
  [%spec
    "[ <length> | 'thin' | 'medium' | 'thick' ] || <line-style> || \
     <named-color>"]

let test_border_shorthand () =
  check bool "width style color" true
    (match parse border_direct "1px solid red" with
    | Ok (`Length (`Px 1.0), `Solid, `Red) -> true
    | _ -> false);
  check bool "thin dotted blue" true
    (match parse border_direct "thin dotted blue" with
    | Ok (`Thin, `Dotted, `Blue) -> true
    | _ -> false);
  check bool "calc dashed transparent" true
    (match parse border_direct "calc(1px + 2px) dashed transparent" with
    | Ok (`Length (`Calc _), `Dashed, `Transparent) -> true
    | _ -> false);
  check bool "interpolation style color" true
    (match parse border_direct "$(borderWidth) solid black" with
    | Ok (`Length (`Interpolation _), `Solid, `Black) -> true
    | _ -> false)

let test_border_interpolation_extraction () =
  check bool "extracts width interpolation" true
    (match Spec.parse border_direct "$(w) solid red" with
    | Ok value ->
      let paths = Spec.extract_interpolations border_direct value in
      List.exists
        (fun (name, path) -> name = "w" && path = "Css_types.Length")
        paths
    | _ -> false)

(* === LINEAR-GRADIENT === *)
(* Testing function parsing with arguments *)

(* For 'to <side>', we use a single keyword approach since the PPX parses
   'to <side>' as a Static combinator. Instead, let's define keywords directly. *)
type gradient_direction =
  [ `Angle of Standard.angle
  | `To_top
  | `To_right
  | `To_bottom
  | `To_left
  ]

let gradient_direction : gradient_direction Spec.t =
  [%spec "<angle> | 'to-top' | 'to-right' | 'to-bottom' | 'to-left'"]

(* Color stop: color optionally followed by position *)
type color_stop = named_color * Standard.length_percentage option

let color_stop : color_stop Spec.t =
  [%spec "<named-color> [ <length-percentage> ]?"]

(* Simplified gradient - direction + 2 color stops.
   The comma is part of the optional direction group:
   linear-gradient( [ <angle> , ]? <color> , <color> ) *)
type simple_gradient =
  (gradient_direction * unit) option * color_stop * unit * color_stop

let simple_gradient : simple_gradient Spec.t =
  [%spec
    "linear-gradient( [ <gradient-direction> ',' ]? <color-stop> ',' \
     <color-stop> )"]

let test_linear_gradient () =
  check bool "basic gradient" true
    (match parse simple_gradient "linear-gradient(red, blue)" with
    | Ok (None, (`Red, None), (), (`Blue, None)) -> true
    | _ -> false);
  check bool "with angle" true
    (match parse simple_gradient "linear-gradient(45deg, red, blue)" with
    | Ok (Some (`Angle (`Deg 45.0), ()), _, (), _) -> true
    | _ -> false);
  check bool "with direction" true
    (match parse simple_gradient "linear-gradient(to-right, red, blue)" with
    | Ok (Some (`To_right, ()), _, (), _) -> true
    | _ -> false);
  check bool "with color stops at positions" true
    (match parse simple_gradient "linear-gradient(red 0%, blue 100%)" with
    | Ok (None, (`Red, Some (`Percentage _)), (), (`Blue, Some (`Percentage _)))
      ->
      true
    | _ -> false)

(* === TIMING FUNCTION - cubic-bezier() and steps() === *)
(* cubic-bezier(<number>, <number>, <number>, <number>) *)
type cubic_bezier =
  Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.number

let cubic_bezier : cubic_bezier Spec.t =
  [%spec "cubic-bezier( <number> ',' <number> ',' <number> ',' <number> )"]

(* step-position for steps() *)
type step_position =
  [ `Jump_start
  | `Jump_end
  | `Jump_none
  | `Jump_both
  | `Start
  | `End
  ]

let step_position : step_position Spec.t =
  [%spec
    "'jump-start' | 'jump-end' | 'jump-none' | 'jump-both' | 'start' | 'end'"]

(* steps(<integer> [, <step-position>]?) *)
type steps_fn = Standard.integer * (unit * step_position) option

let steps_fn : steps_fn Spec.t =
  [%spec "steps( <integer> [ ',' <step-position> ]? )"]

(* Full timing function - variant names match what PPX generates from references *)
type timing_function =
  [ `Linear
  | `Ease
  | `Ease_in
  | `Ease_out
  | `Ease_in_out
  | `Cubic_bezier of cubic_bezier
  | `Steps_fn of steps_fn
  ]

let timing_function : timing_function Spec.t =
  [%spec
    "'linear' | 'ease' | 'ease-in' | 'ease-out' | 'ease-in-out' | \
     <cubic-bezier> | <steps-fn>"]

let test_timing_function () =
  check bool "linear" true (parse timing_function "linear" = Ok `Linear);
  check bool "ease" true (parse timing_function "ease" = Ok `Ease);
  check bool "ease-in-out" true
    (parse timing_function "ease-in-out" = Ok `Ease_in_out);
  check bool "cubic-bezier" true
    (match parse timing_function "cubic-bezier(0.25, 0.1, 0.25, 1.0)" with
    | Ok
        (`Cubic_bezier
           (`Number 0.25, (), `Number 0.1, (), `Number 0.25, (), `Number 1.0))
      ->
      true
    | _ -> false);
  check bool "steps with position" true
    (match parse timing_function "steps(4, jump-end)" with
    | Ok (`Steps_fn (`Integer 4, Some ((), `Jump_end))) -> true
    | _ -> false);
  check bool "steps without position" true
    (match parse timing_function "steps(3)" with
    | Ok (`Steps_fn (`Integer 3, None)) -> true
    | _ -> false)

(* === FILTER FUNCTIONS === *)
(* blur(<length>) *)
type blur_fn = Standard.length

let blur_fn : blur_fn Spec.t = [%spec "blur( <length> )"]

(* brightness(<number> | <percentage>) *)
type brightness_amount =
  [ `Number of Standard.number
  | `Percentage of Standard.percentage
  ]

let brightness_amount : brightness_amount Spec.t =
  [%spec "<number> | <percentage>"]

type brightness_fn = brightness_amount

let brightness_fn : brightness_fn Spec.t =
  [%spec "brightness( <brightness-amount> )"]

(* drop-shadow(<length>{2,3} <color>?) - simplified *)
type drop_shadow_fn = Standard.length list * named_color option

let drop_shadow_fn : drop_shadow_fn Spec.t =
  [%spec "drop-shadow( <length>{2,3} [ <named-color> ]? )"]

(* Filter function - variant names match PPX generated names *)
type filter_function =
  [ `Blur_fn of blur_fn
  | `Brightness_fn of brightness_fn
  | `Drop_shadow_fn of drop_shadow_fn
  ]

let filter_function : filter_function Spec.t =
  [%spec "<blur-fn> | <brightness-fn> | <drop-shadow-fn>"]

let test_filter_functions () =
  check bool "blur" true
    (match parse filter_function "blur(5px)" with
    | Ok (`Blur_fn (`Px 5.0)) -> true
    | _ -> false);
  check bool "blur with calc" true
    (match parse filter_function "blur(calc(2px + 3px))" with
    | Ok (`Blur_fn (`Calc _)) -> true
    | _ -> false);
  check bool "brightness number" true
    (match parse filter_function "brightness(1.5)" with
    | Ok (`Brightness_fn (`Number (`Number 1.5))) -> true
    | _ -> false);
  check bool "brightness percentage" true
    (match parse filter_function "brightness(150%)" with
    | Ok (`Brightness_fn (`Percentage (`Percentage 150.0))) -> true
    | _ -> false);
  check bool "drop-shadow 2 lengths" true
    (match parse filter_function "drop-shadow(10px 10px)" with
    | Ok (`Drop_shadow_fn ([ `Px 10.0; `Px 10.0 ], None)) -> true
    | _ -> false);
  check bool "drop-shadow with color" true
    (match parse filter_function "drop-shadow(10px 10px 5px red)" with
    | Ok (`Drop_shadow_fn ([ `Px 10.0; `Px 10.0; `Px 5.0 ], Some `Red)) -> true
    | _ -> false)

(* === BOX-SHADOW === *)
(* box-shadow: [inset]? <length>{2,4} <color>?
   CSS spec allows multiple shadows comma-separated, but let's test single first.
   Note: [ 'keyword' ]? returns unit option, not variant option *)
type single_shadow = unit option * Standard.length list * named_color option

let single_shadow : single_shadow Spec.t =
  [%spec "[ 'inset' ]? <length>{2,4} [ <named-color> ]?"]

let test_box_shadow () =
  check bool "simple shadow" true
    (match parse single_shadow "10px 10px" with
    | Ok (None, [ `Px 10.0; `Px 10.0 ], None) -> true
    | _ -> false);
  check bool "shadow with blur" true
    (match parse single_shadow "10px 10px 5px" with
    | Ok (None, [ `Px 10.0; `Px 10.0; `Px 5.0 ], None) -> true
    | _ -> false);
  check bool "shadow with spread and color" true
    (match parse single_shadow "10px 10px 5px 2px red" with
    | Ok (None, [ `Px 10.0; `Px 10.0; `Px 5.0; `Px 2.0 ], Some `Red) -> true
    | _ -> false);
  check bool "inset shadow" true
    (match parse single_shadow "inset 10px 10px black" with
    | Ok (Some (), [ `Px 10.0; `Px 10.0 ], Some `Black) -> true
    | _ -> false);
  check bool "shadow with interpolation" true
    (match parse single_shadow "$(x) $(y)" with
    | Ok (None, [ `Interpolation _; `Interpolation _ ], None) -> true
    | _ -> false)

(* === TRANSFORM FUNCTIONS === *)
(* Testing various transform functions with different signatures *)

type matrix_fn =
  Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.number

let matrix_fn : matrix_fn Spec.t =
  [%spec
    "matrix( <number> ',' <number> ',' <number> ',' <number> ',' <number> ',' \
     <number> )"]

type translate3d_fn =
  Standard.length_percentage
  * unit
  * Standard.length_percentage
  * unit
  * Standard.length

let translate3d_fn : translate3d_fn Spec.t =
  [%spec
    "translate3d( <length-percentage> ',' <length-percentage> ',' <length> )"]

type rotate3d_fn =
  Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.number
  * unit
  * Standard.angle

let rotate3d_fn : rotate3d_fn Spec.t =
  [%spec "rotate3d( <number> ',' <number> ',' <number> ',' <angle> )"]

type skew_fn = Standard.angle * (unit * Standard.angle) option

let skew_fn : skew_fn Spec.t = [%spec "skew( <angle> [ ',' <angle> ]? )"]

type perspective_fn = Standard.length

let perspective_fn : perspective_fn Spec.t = [%spec "perspective( <length> )"]

type transform_function =
  [ `Matrix_fn of matrix_fn
  | `Translate3d_fn of translate3d_fn
  | `Rotate3d_fn of rotate3d_fn
  | `Skew_fn of skew_fn
  | `Perspective_fn of perspective_fn
  | `Translate_x of translate_x
  | `Rotate of rotate_value
  ]

let transform_function : transform_function Spec.t =
  [%spec
    "<matrix-fn> | <translate3d-fn> | <rotate3d-fn> | <skew-fn> | \
     <perspective-fn> | <translate-x> | <rotate>"]

let test_transform_complex () =
  check bool "matrix" true
    (match parse transform_function "matrix(1, 0, 0, 1, 0, 0)" with
    | Ok (`Matrix_fn _) -> true
    | _ -> false);
  check bool "translate3d" true
    (match parse transform_function "translate3d(10px, 20%, 30px)" with
    | Ok
        (`Translate3d_fn
           (`Length (`Px 10.0), (), `Percentage (`Percentage 20.0), (), `Px 30.0))
      ->
      true
    | _ -> false);
  check bool "rotate3d" true
    (match parse transform_function "rotate3d(1, 0, 0, 45deg)" with
    | Ok (`Rotate3d_fn _) -> true
    | _ -> false);
  check bool "skew single" true
    (match parse transform_function "skew(30deg)" with
    | Ok (`Skew_fn (`Deg 30.0, None)) -> true
    | _ -> false);
  check bool "skew both" true
    (match parse transform_function "skew(30deg, 10deg)" with
    | Ok (`Skew_fn (`Deg 30.0, Some ((), `Deg 10.0))) -> true
    | _ -> false);
  check bool "perspective" true
    (match parse transform_function "perspective(500px)" with
    | Ok (`Perspective_fn (`Px 500.0)) -> true
    | _ -> false);
  check bool "transform with interpolation" true
    (match parse transform_function "translateX($(x))" with
    | Ok (`Translate_x (`Interpolation _)) -> true
    | _ -> false)

(* === Interpolation extraction tests === *)

let test_interpolation_extraction () =
  check bool "line_width interpolation path" true
    (match Spec.parse line_width "$(w)" with
    | Ok value ->
      let paths = Spec.extract_interpolations line_width value in
      List.exists (fun (_, path) -> path = "Css_types.Length") paths
    | _ -> false);
  check bool "translateX interpolation" true
    (match Spec.parse translate_x "translateX($(x))" with
    | Ok value ->
      let paths = Spec.extract_interpolations translate_x value in
      List.exists (fun (_, path) -> path = "Css_types.LengthPercentage") paths
    | _ -> false)

let tests =
  ( "migration",
    [
      test_case "line-style keywords" `Quick test_line_style;
      test_case "line-width values" `Quick test_line_width;
      test_case "shadow-lengths {2,4}" `Quick test_shadow_lengths;
      test_case "named-color keywords" `Quick test_named_color;
      test_case "transform functions" `Quick test_transform_functions;
      test_case "transition-property comma-sep" `Quick test_transition_property;
      test_case "timing-function keywords" `Quick test_timing_function_keyword;
      test_case "border shorthand (|| positional)" `Quick test_border_shorthand;
      test_case "border interpolation extraction" `Quick
        test_border_interpolation_extraction;
      test_case "linear-gradient" `Quick test_linear_gradient;
      test_case "timing-function full" `Quick test_timing_function;
      test_case "filter-function" `Quick test_filter_functions;
      test_case "box-shadow" `Quick test_box_shadow;
      test_case "transform complex" `Quick test_transform_complex;
      test_case "interpolation extraction" `Quick test_interpolation_extraction;
    ] )
