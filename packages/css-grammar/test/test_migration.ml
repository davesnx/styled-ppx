open Alcotest
open Css_grammar

module Line_style = [%spec_module "'none' | 'hidden' | 'dotted' | 'dashed' | 'solid' | 'double' | 'groove' | 'ridge' | 'inset' | 'outset'"]
module Line_width = [%spec_module "<length> | 'thin' | 'medium' | 'thick'"]
module Shadow_lengths = [%spec_module "<length>{2,4}"]
module Named_color = [%spec_module "'red' | 'green' | 'blue' | 'black' | 'white' | 'transparent' | 'currentColor'"]
module Translate_x = [%spec_module "translateX( <length-percentage> )"]
module Translate_y = [%spec_module "translateY( <length-percentage> )"]
module Scale_x = [%spec_module "scaleX( <number> )"]
module Rotate = [%spec_module "rotate( <angle> )"]
module Transition_property = [%spec_module "[ 'none' | 'all' | <custom-ident> ]#"]
module Timing_function_keyword = [%spec_module "'ease' | 'linear' | 'ease-in' | 'ease-out' | 'ease-in-out' | 'step-start' | 'step-end'"]
module Blur_fn = [%spec_module "blur( <length> )"]
module Single_shadow = [%spec_module "[ 'inset' ]? <length>{2,4}"]
module Skew_fn = [%spec_module "skew( <angle> [ ',' <angle> ]? )"]
module Perspective_fn = [%spec_module "perspective( <length> )"]

let test_line_style () =
  check bool "solid" true (Line_style.parse "solid" = Ok `Solid);
  check bool "dashed" true (Line_style.parse "dashed" = Ok `Dashed);
  check bool "SOLID (case insensitive)" true
    (Line_style.parse "SOLID" = Ok `Solid);
  check bool "dotted" true (Line_style.parse "dotted" = Ok `Dotted);
  check bool "none" true (Line_style.parse "none" = Ok `None);
  check bool "invalid" true (Result.is_error (Line_style.parse "invalid"))

let test_line_width () =
  check bool "2px" true
    (match Line_width.parse "2px" with
    | Ok (`Length (`Px 2.0)) -> true
    | _ -> false);
  check bool "thin" true (Line_width.parse "thin" = Ok `Thin);
  check bool "medium" true (Line_width.parse "medium" = Ok `Medium);
  check bool "thick" true (Line_width.parse "thick" = Ok `Thick);
  check bool "calc" true
    (match Line_width.parse "calc(1px + 2px)" with
    | Ok (`Length (`Calc _)) -> true
    | _ -> false);
  check bool "interpolation" true
    (match Line_width.parse "$(borderWidth)" with
    | Ok (`Length (`Interpolation [ "borderWidth" ])) -> true
    | _ -> false)

let test_shadow_lengths () =
  check bool "2 values (x y)" true
    (match Shadow_lengths.parse "10px 20px" with
    | Ok [ `Px 10.0; `Px 20.0 ] -> true
    | _ -> false);
  check bool "3 values (x y blur)" true
    (match Shadow_lengths.parse "10px 20px 5px" with
    | Ok [ `Px 10.0; `Px 20.0; `Px 5.0 ] -> true
    | _ -> false);
  check bool "4 values (x y blur spread)" true
    (match Shadow_lengths.parse "10px 20px 5px 2px" with
    | Ok [ `Px 10.0; `Px 20.0; `Px 5.0; `Px 2.0 ] -> true
    | _ -> false);
  check bool "1 value fails" true
    (Result.is_error (Shadow_lengths.parse "10px"))

let test_named_color () =
  check bool "red" true (Named_color.parse "red" = Ok `Red);
  check bool "transparent" true
    (Named_color.parse "transparent" = Ok `Transparent);
  check bool "currentColor" true
    (Named_color.parse "currentColor" = Ok `CurrentColor);
  check bool "CURRENTCOLOR (case)" true
    (Named_color.parse "CURRENTCOLOR" = Ok `CurrentColor)

let test_transform_functions () =
  check bool "translateX(10px)" true
    (match Translate_x.parse "translateX(10px)" with
    | Ok (`Length (`Px 10.0)) -> true
    | _ -> false);
  check bool "translateX(50%)" true
    (match Translate_x.parse "translateX(50%)" with
    | Ok (`Percentage (`Percentage 50.0)) -> true
    | _ -> false);
  check bool "translateY(-20px)" true
    (match Translate_y.parse "translateY(-20px)" with
    | Ok (`Length (`Px -20.0)) -> true
    | _ -> false);
  check bool "scaleX(1.5)" true
    (match Scale_x.parse "scaleX(1.5)" with
    | Ok (`Number 1.5) -> true
    | _ -> false);
  check bool "rotate(45deg)" true
    (match Rotate.parse "rotate(45deg)" with
    | Ok (`Deg 45.0) -> true
    | _ -> false);
  check bool "rotate(calc(45deg + 10deg))" true
    (match Rotate.parse "rotate(calc(45deg + 10deg))" with
    | Ok (`Calc _) -> true
    | _ -> false)

let test_transition_property () =
  check bool "none" true
    (match Transition_property.parse "none" with
    | Ok [ `None ] -> true
    | _ -> false);
  check bool "all" true
    (match Transition_property.parse "all" with
    | Ok [ `All ] -> true
    | _ -> false);
  check bool "opacity" true
    (match Transition_property.parse "opacity" with
    | Ok [ `Custom_ident "opacity" ] -> true
    | _ -> false);
  check bool "multiple" true
    (match Transition_property.parse "opacity, transform, color" with
    | Ok
        [
          `Custom_ident "opacity";
          `Custom_ident "transform";
          `Custom_ident "color";
        ] ->
      true
    | _ -> false)

let test_timing_function_keyword () =
  check bool "ease" true (Timing_function_keyword.parse "ease" = Ok `Ease);
  check bool "linear" true (Timing_function_keyword.parse "linear" = Ok `Linear);
  check bool "ease-in" true
    (Timing_function_keyword.parse "ease-in" = Ok `Ease_in);
  check bool "ease-out" true
    (Timing_function_keyword.parse "ease-out" = Ok `Ease_out);
  check bool "ease-in-out" true
    (Timing_function_keyword.parse "ease-in-out" = Ok `Ease_in_out)

let test_blur_fn () =
  check bool "blur" true
    (match Blur_fn.parse "blur(5px)" with
    | Ok (`Px 5.0) -> true
    | _ -> false);
  check bool "blur with calc" true
    (match Blur_fn.parse "blur(calc(2px + 3px))" with
    | Ok (`Calc _) -> true
    | _ -> false)

let test_box_shadow () =
  check bool "simple shadow" true
    (match Single_shadow.parse "10px 10px" with
    | Ok (None, [ `Px 10.0; `Px 10.0 ]) -> true
    | _ -> false);
  check bool "shadow with blur" true
    (match Single_shadow.parse "10px 10px 5px" with
    | Ok (None, [ `Px 10.0; `Px 10.0; `Px 5.0 ]) -> true
    | _ -> false);
  check bool "inset shadow" true
    (match Single_shadow.parse "inset 10px 10px" with
    | Ok (Some (), [ `Px 10.0; `Px 10.0 ]) -> true
    | _ -> false);
  check bool "shadow with interpolation" true
    (match Single_shadow.parse "$(x) $(y)" with
    | Ok (None, [ `Interpolation _; `Interpolation _ ]) -> true
    | _ -> false)

let test_skew () =
  check bool "skew single" true
    (match Skew_fn.parse "skew(30deg)" with
    | Ok (`Deg 30.0, None) -> true
    | _ -> false);
  check bool "skew both" true
    (match Skew_fn.parse "skew(30deg, 10deg)" with
    | Ok (`Deg 30.0, Some ((), `Deg 10.0)) -> true
    | _ -> false)

let test_perspective () =
  check bool "perspective" true
    (match Perspective_fn.parse "perspective(500px)" with
    | Ok (`Px 500.0) -> true
    | _ -> false)

let test_interpolation_extraction () =
  check bool "line_width interpolation path" true
    (match Line_width.parse "$(w)" with
    | Ok value ->
      let paths = Line_width.extract_interpolations value in
      List.exists (fun (_, path) -> path = "Css_types.Length") paths
    | _ -> false);
  check bool "translateX interpolation" true
    (match Translate_x.parse "translateX($(x))" with
    | Ok value ->
      let paths = Translate_x.extract_interpolations value in
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
      test_case "blur function" `Quick test_blur_fn;
      test_case "box-shadow" `Quick test_box_shadow;
      test_case "skew function" `Quick test_skew;
      test_case "perspective function" `Quick test_perspective;
      test_case "interpolation extraction" `Quick test_interpolation_extraction;
    ] )
