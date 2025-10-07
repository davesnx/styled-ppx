  $ as_standalone --impl input.ml | ocamlformat - --impl --enable-outside-detected-project
  open Standard
  open Modifier
  open Rule.Match
  
  module rec Color : sig
    type nonrec t =
      [ `Function_rgb of Function_rgb.t
      | `Function_rgba of Function_rgba.t
      | `Function_hsl of Function_hsl.t
      | `Function_hsla of Function_hsla.t
      | `Hex_color of Hex_color.t
      | `Named_color of Named_color.t
      | `CurrentColor
      | `Deprecated_system_color of Deprecated_system_color.t
      | `Interpolation of Interpolation.t
      | `Function_var of Function_var.t
      | `Function_color_mix of Function_color_mix.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Function_rgb of Function_rgb.t
      | `Function_rgba of Function_rgba.t
      | `Function_hsl of Function_hsl.t
      | `Function_hsla of Function_hsla.t
      | `Hex_color of Hex_color.t
      | `Named_color of Named_color.t
      | `CurrentColor
      | `Deprecated_system_color of Deprecated_system_color.t
      | `Interpolation of Interpolation.t
      | `Function_var of Function_var.t
      | `Function_color_mix of Function_color_mix.t ]
  
    let parser =
      Combinators.xor
        [
          map Function_rgb.parser (fun v -> `Function_rgb v);
          map Function_rgba.parser (fun v -> `Function_rgba v);
          map Function_hsl.parser (fun v -> `Function_hsl v);
          map Function_hsla.parser (fun v -> `Function_hsla v);
          map Hex_color.parser (fun v -> `Hex_color v);
          map Named_color.parser (fun v -> `Named_color v);
          map (keyword "currentColor") (fun _v -> `CurrentColor);
          map Deprecated_system_color.parser (fun v -> `Deprecated_system_color v);
          map Interpolation.parser (fun v -> `Interpolation v);
          map Function_var.parser (fun v -> `Function_var v);
          map Function_color_mix.parser (fun v -> `Function_color_mix v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Function_rgb v -> Function_rgb.toString v
      | `Function_rgba v -> Function_rgba.toString v
      | `Function_hsl v -> Function_hsl.toString v
      | `Function_hsla v -> Function_hsla.toString v
      | `Hex_color v -> Hex_color.toString v
      | `Named_color v -> Named_color.toString v
      | `CurrentColor -> "currentColor"
      | `Deprecated_system_color v -> Deprecated_system_color.toString v
      | `Interpolation v -> Interpolation.toString v
      | `Function_var v -> Function_var.toString v
      | `Function_color_mix v -> Function_color_mix.toString v
  end
  
  and Function_rgb : sig
    type nonrec t =
      [ `Rgb_0 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgb_1 of Number.t list * (unit * Alpha_value.t) option
      | `Rgb_2 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgb_3 of Number.t list * (unit * Alpha_value.t) option ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Rgb_0 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgb_1 of Number.t list * (unit * Alpha_value.t) option
      | `Rgb_2 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgb_3 of Number.t list * (unit * Alpha_value.t) option ]
  
    let parser =
      Combinators.xor
        [
          map
            (function_call "rgb"
               (map
                  (Combinators.static
                     [
                       map
                         (repeat (3, Some 3) Extended_percentage.parser)
                         (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map (delim "/") (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgb_0 v);
          map
            (function_call "rgb"
               (map
                  (Combinators.static
                     [
                       map (repeat (3, Some 3) Number.parser) (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map (delim "/") (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgb_1 v);
          map
            (function_call "rgb"
               (map
                  (Combinators.static
                     [
                       map
                         (repeat_by_comma (3, Some 3) Extended_percentage.parser)
                         (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map comma (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgb_2 v);
          map
            (function_call "rgb"
               (map
                  (Combinators.static
                     [
                       map
                         (repeat_by_comma (3, Some 3) Number.parser)
                         (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map comma (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgb_3 v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Rgb_0 v ->
          (("rgb" ^ "(")
          ^
          let v0, v1 = v in
          ((v0
           |> List.map (fun x -> Extended_percentage.toString x)
           |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("/" ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Rgb_1 v ->
          (("rgb" ^ "(")
          ^
          let v0, v1 = v in
          ((v0 |> List.map (fun x -> Number.toString x) |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("/" ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Rgb_2 v ->
          (("rgb" ^ "(")
          ^
          let v0, v1 = v in
          ((v0
           |> List.map (fun x -> Extended_percentage.toString x)
           |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("," ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Rgb_3 v ->
          (("rgb" ^ "(")
          ^
          let v0, v1 = v in
          ((v0 |> List.map (fun x -> Number.toString x) |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("," ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
  end
  
  and Function_rgba : sig
    type nonrec t =
      [ `Rgba_0 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgba_1 of Number.t list * (unit * Alpha_value.t) option
      | `Rgba_2 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgba_3 of Number.t list * (unit * Alpha_value.t) option ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Rgba_0 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgba_1 of Number.t list * (unit * Alpha_value.t) option
      | `Rgba_2 of Extended_percentage.t list * (unit * Alpha_value.t) option
      | `Rgba_3 of Number.t list * (unit * Alpha_value.t) option ]
  
    let parser =
      Combinators.xor
        [
          map
            (function_call "rgba"
               (map
                  (Combinators.static
                     [
                       map
                         (repeat (3, Some 3) Extended_percentage.parser)
                         (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map (delim "/") (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgba_0 v);
          map
            (function_call "rgba"
               (map
                  (Combinators.static
                     [
                       map (repeat (3, Some 3) Number.parser) (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map (delim "/") (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgba_1 v);
          map
            (function_call "rgba"
               (map
                  (Combinators.static
                     [
                       map
                         (repeat_by_comma (3, Some 3) Extended_percentage.parser)
                         (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map comma (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgba_2 v);
          map
            (function_call "rgba"
               (map
                  (Combinators.static
                     [
                       map
                         (repeat_by_comma (3, Some 3) Number.parser)
                         (fun v -> `V0 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map comma (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))))
            (fun v -> `Rgba_3 v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Rgba_0 v ->
          (("rgba" ^ "(")
          ^
          let v0, v1 = v in
          ((v0
           |> List.map (fun x -> Extended_percentage.toString x)
           |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("/" ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Rgba_1 v ->
          (("rgba" ^ "(")
          ^
          let v0, v1 = v in
          ((v0 |> List.map (fun x -> Number.toString x) |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("/" ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Rgba_2 v ->
          (("rgba" ^ "(")
          ^
          let v0, v1 = v in
          ((v0
           |> List.map (fun x -> Extended_percentage.toString x)
           |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("," ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Rgba_3 v ->
          (("rgba" ^ "(")
          ^
          let v0, v1 = v in
          ((v0 |> List.map (fun x -> Number.toString x) |> String.concat " ")
          ^ " ")
          ^
          match v1 with
          | Some x ->
              let v0, v1 = x in
              ("," ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
  end
  
  and Function_hsl : sig
    type nonrec t =
      [ `Hsl_0 of
        Hue.t
        * Extended_percentage.t
        * Extended_percentage.t
        * (unit * Alpha_value.t) option
      | `Hsl_1 of
        Hue.t
        * unit
        * Extended_percentage.t
        * unit
        * Extended_percentage.t
        * (unit * Alpha_value.t) option ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Hsl_0 of
        Hue.t
        * Extended_percentage.t
        * Extended_percentage.t
        * (unit * Alpha_value.t) option
      | `Hsl_1 of
        Hue.t
        * unit
        * Extended_percentage.t
        * unit
        * Extended_percentage.t
        * (unit * Alpha_value.t) option ]
  
    let parser =
      Combinators.xor
        [
          map
            (function_call "hsl"
               (map
                  (Combinators.static
                     [
                       map Hue.parser (fun v -> `V0 v);
                       map Extended_percentage.parser (fun v -> `V1 v);
                       map Extended_percentage.parser (fun v -> `V2 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map (delim "/") (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V3 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [
                                                     `V0 v0;
                                                     `V1 v1;
                                                     `V2 v2;
                                                     `V3 v3;
                                                   ]
                                                 -> (v0, v1, v2, v3))))
            (fun v -> `Hsl_0 v);
          map
            (function_call "hsl"
               (map
                  (Combinators.static
                     [
                       map Hue.parser (fun v -> `V0 v);
                       map comma (fun v -> `V1 v);
                       map Extended_percentage.parser (fun v -> `V2 v);
                       map comma (fun v -> `V3 v);
                       map Extended_percentage.parser (fun v -> `V4 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map comma (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V5 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [
                                                     `V0 v0;
                                                     `V1 v1;
                                                     `V2 v2;
                                                     `V3 v3;
                                                     `V4 v4;
                                                     `V5 v5;
                                                   ]
                                                 -> (v0, v1, v2, v3, v4, v5))))
            (fun v -> `Hsl_1 v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Hsl_0 v ->
          (("hsl" ^ "(")
          ^
          let v0, v1, v2, v3 = v in
          (((((Hue.toString v0 ^ " ") ^ Extended_percentage.toString v1) ^ " ")
           ^ Extended_percentage.toString v2)
          ^ " ")
          ^
          match v3 with
          | Some x ->
              let v0, v1 = x in
              ("/" ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Hsl_1 v ->
          (("hsl" ^ "(")
          ^
          let v0, v1, v2, v3, v4, v5 = v in
          (((((((((Hue.toString v0 ^ " ") ^ ",") ^ " ")
               ^ Extended_percentage.toString v2)
              ^ " ")
             ^ ",")
            ^ " ")
           ^ Extended_percentage.toString v4)
          ^ " ")
          ^
          match v5 with
          | Some x ->
              let v0, v1 = x in
              ("," ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
  end
  
  and Function_hsla : sig
    type nonrec t =
      [ `Hsla_0 of
        Hue.t
        * Extended_percentage.t
        * Extended_percentage.t
        * (unit * Alpha_value.t) option
      | `Hsla_1 of
        Hue.t
        * unit
        * Extended_percentage.t
        * unit
        * Extended_percentage.t
        * unit
        * Alpha_value.t option
      | `Hsla_2 of
        Hue.t
        * unit
        * Extended_percentage.t
        * unit
        * Extended_percentage.t
        * unit
        * Alpha_value.t option ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Hsla_0 of
        Hue.t
        * Extended_percentage.t
        * Extended_percentage.t
        * (unit * Alpha_value.t) option
      | `Hsla_1 of
        Hue.t
        * unit
        * Extended_percentage.t
        * unit
        * Extended_percentage.t
        * unit
        * Alpha_value.t option
      | `Hsla_2 of
        Hue.t
        * unit
        * Extended_percentage.t
        * unit
        * Extended_percentage.t
        * unit
        * Alpha_value.t option ]
  
    let parser =
      Combinators.xor
        [
          map
            (function_call "hsla"
               (map
                  (Combinators.static
                     [
                       map Hue.parser (fun v -> `V0 v);
                       map Extended_percentage.parser (fun v -> `V1 v);
                       map Extended_percentage.parser (fun v -> `V2 v);
                       map
                         (optional
                            (map
                               (Combinators.static
                                  [
                                    map (delim "/") (fun v -> `V0 v);
                                    map Alpha_value.parser (fun v -> `V1 v);
                                  ])
                               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ]
                                                              -> (v0, v1))))
                         (fun v -> `V3 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [
                                                     `V0 v0;
                                                     `V1 v1;
                                                     `V2 v2;
                                                     `V3 v3;
                                                   ]
                                                 -> (v0, v1, v2, v3))))
            (fun v -> `Hsla_0 v);
          map
            (function_call "hsla"
               (map
                  (Combinators.static
                     [
                       map Hue.parser (fun v -> `V0 v);
                       map comma (fun v -> `V1 v);
                       map Extended_percentage.parser (fun v -> `V2 v);
                       map comma (fun v -> `V3 v);
                       map Extended_percentage.parser (fun v -> `V4 v);
                       map comma (fun v -> `V5 v);
                       map (optional Alpha_value.parser) (fun v -> `V6 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [
                                                     `V0 v0;
                                                     `V1 v1;
                                                     `V2 v2;
                                                     `V3 v3;
                                                     `V4 v4;
                                                     `V5 v5;
                                                     `V6 v6;
                                                   ]
                                                 -> (v0, v1, v2, v3, v4, v5, v6))))
            (fun v -> `Hsla_1 v);
          map
            (function_call "hsla"
               (map
                  (Combinators.static
                     [
                       map Hue.parser (fun v -> `V0 v);
                       map comma (fun v -> `V1 v);
                       map Extended_percentage.parser (fun v -> `V2 v);
                       map comma (fun v -> `V3 v);
                       map Extended_percentage.parser (fun v -> `V4 v);
                       map comma (fun v -> `V5 v);
                       map (optional Alpha_value.parser) (fun v -> `V6 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [
                                                     `V0 v0;
                                                     `V1 v1;
                                                     `V2 v2;
                                                     `V3 v3;
                                                     `V4 v4;
                                                     `V5 v5;
                                                     `V6 v6;
                                                   ]
                                                 -> (v0, v1, v2, v3, v4, v5, v6))))
            (fun v -> `Hsla_2 v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Hsla_0 v ->
          (("hsla" ^ "(")
          ^
          let v0, v1, v2, v3 = v in
          (((((Hue.toString v0 ^ " ") ^ Extended_percentage.toString v1) ^ " ")
           ^ Extended_percentage.toString v2)
          ^ " ")
          ^
          match v3 with
          | Some x ->
              let v0, v1 = x in
              ("/" ^ " ") ^ Alpha_value.toString v1
          | None -> "")
          ^ ")"
      | `Hsla_1 v ->
          (("hsla" ^ "(")
          ^
          let v0, v1, v2, v3, v4, v5, v6 = v in
          (((((((((((Hue.toString v0 ^ " ") ^ ",") ^ " ")
                 ^ Extended_percentage.toString v2)
                ^ " ")
               ^ ",")
              ^ " ")
             ^ Extended_percentage.toString v4)
            ^ " ")
           ^ ",")
          ^ " ")
          ^ match v6 with Some x -> Alpha_value.toString x | None -> "")
          ^ ")"
      | `Hsla_2 v ->
          (("hsla" ^ "(")
          ^
          let v0, v1, v2, v3, v4, v5, v6 = v in
          (((((((((((Hue.toString v0 ^ " ") ^ ",") ^ " ")
                 ^ Extended_percentage.toString v2)
                ^ " ")
               ^ ",")
              ^ " ")
             ^ Extended_percentage.toString v4)
            ^ " ")
           ^ ",")
          ^ " ")
          ^ match v6 with Some x -> Alpha_value.toString x | None -> "")
          ^ ")"
  end
  
  and Hue : sig
    type nonrec t = [ `Number of Number.t | `Extended_angle of Extended_angle.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t = [ `Number of Number.t | `Extended_angle of Extended_angle.t ]
  
    let parser =
      Combinators.xor
        [
          map Number.parser (fun v -> `Number v);
          map Extended_angle.parser (fun v -> `Extended_angle v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Number v -> Number.toString v
      | `Extended_angle v -> Extended_angle.toString v
  end
  
  and Named_color : sig
    type nonrec t =
      [ `Transparent
      | `Aliceblue
      | `Antiquewhite
      | `Aqua
      | `Aquamarine
      | `Azure
      | `Beige
      | `Bisque
      | `Black
      | `Blanchedalmond
      | `Blue
      | `Blueviolet
      | `Brown
      | `Burlywood
      | `Cadetblue
      | `Chartreuse
      | `Chocolate
      | `Coral
      | `Cornflowerblue
      | `Cornsilk
      | `Crimson
      | `Cyan
      | `Darkblue
      | `Darkcyan
      | `Darkgoldenrod
      | `Darkgray
      | `Darkgreen
      | `Darkgrey
      | `Darkkhaki
      | `Darkmagenta
      | `Darkolivegreen
      | `Darkorange
      | `Darkorchid
      | `Darkred
      | `Darksalmon
      | `Darkseagreen
      | `Darkslateblue
      | `Darkslategray
      | `Darkslategrey
      | `Darkturquoise
      | `Darkviolet
      | `Deeppink
      | `Deepskyblue
      | `Dimgray
      | `Dimgrey
      | `Dodgerblue
      | `Firebrick
      | `Floralwhite
      | `Forestgreen
      | `Fuchsia
      | `Gainsboro
      | `Ghostwhite
      | `Gold
      | `Goldenrod
      | `Gray
      | `Green
      | `Greenyellow
      | `Grey
      | `Honeydew
      | `Hotpink
      | `Indianred
      | `Indigo
      | `Ivory
      | `Khaki
      | `Lavender
      | `Lavenderblush
      | `Lawngreen
      | `Lemonchiffon
      | `Lightblue
      | `Lightcoral
      | `Lightcyan
      | `Lightgoldenrodyellow
      | `Lightgray
      | `Lightgreen
      | `Lightgrey
      | `Lightpink
      | `Lightsalmon
      | `Lightseagreen
      | `Lightskyblue
      | `Lightslategray
      | `Lightslategrey
      | `Lightsteelblue
      | `Lightyellow
      | `Lime
      | `Limegreen
      | `Linen
      | `Magenta
      | `Maroon
      | `Mediumaquamarine
      | `Mediumblue
      | `Mediumorchid
      | `Mediumpurple
      | `Mediumseagreen
      | `Mediumslateblue
      | `Mediumspringgreen
      | `Mediumturquoise
      | `Mediumvioletred
      | `Midnightblue
      | `Mintcream
      | `Mistyrose
      | `Moccasin
      | `Navajowhite
      | `Navy
      | `Oldlace
      | `Olive
      | `Olivedrab
      | `Orange
      | `Orangered
      | `Orchid
      | `Palegoldenrod
      | `Palegreen
      | `Paleturquoise
      | `Palevioletred
      | `Papayawhip
      | `Peachpuff
      | `Peru
      | `Pink
      | `Plum
      | `Powderblue
      | `Purple
      | `Rebeccapurple
      | `Red
      | `Rosybrown
      | `Royalblue
      | `Saddlebrown
      | `Salmon
      | `Sandybrown
      | `Seagreen
      | `Seashell
      | `Sienna
      | `Silver
      | `Skyblue
      | `Slateblue
      | `Slategray
      | `Slategrey
      | `Snow
      | `Springgreen
      | `Steelblue
      | `Tan
      | `Teal
      | `Thistle
      | `Tomato
      | `Turquoise
      | `Violet
      | `Wheat
      | `White
      | `Whitesmoke
      | `Yellow
      | `Yellowgreen
      | `_non_standard_color of Non_standard_color.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Transparent
      | `Aliceblue
      | `Antiquewhite
      | `Aqua
      | `Aquamarine
      | `Azure
      | `Beige
      | `Bisque
      | `Black
      | `Blanchedalmond
      | `Blue
      | `Blueviolet
      | `Brown
      | `Burlywood
      | `Cadetblue
      | `Chartreuse
      | `Chocolate
      | `Coral
      | `Cornflowerblue
      | `Cornsilk
      | `Crimson
      | `Cyan
      | `Darkblue
      | `Darkcyan
      | `Darkgoldenrod
      | `Darkgray
      | `Darkgreen
      | `Darkgrey
      | `Darkkhaki
      | `Darkmagenta
      | `Darkolivegreen
      | `Darkorange
      | `Darkorchid
      | `Darkred
      | `Darksalmon
      | `Darkseagreen
      | `Darkslateblue
      | `Darkslategray
      | `Darkslategrey
      | `Darkturquoise
      | `Darkviolet
      | `Deeppink
      | `Deepskyblue
      | `Dimgray
      | `Dimgrey
      | `Dodgerblue
      | `Firebrick
      | `Floralwhite
      | `Forestgreen
      | `Fuchsia
      | `Gainsboro
      | `Ghostwhite
      | `Gold
      | `Goldenrod
      | `Gray
      | `Green
      | `Greenyellow
      | `Grey
      | `Honeydew
      | `Hotpink
      | `Indianred
      | `Indigo
      | `Ivory
      | `Khaki
      | `Lavender
      | `Lavenderblush
      | `Lawngreen
      | `Lemonchiffon
      | `Lightblue
      | `Lightcoral
      | `Lightcyan
      | `Lightgoldenrodyellow
      | `Lightgray
      | `Lightgreen
      | `Lightgrey
      | `Lightpink
      | `Lightsalmon
      | `Lightseagreen
      | `Lightskyblue
      | `Lightslategray
      | `Lightslategrey
      | `Lightsteelblue
      | `Lightyellow
      | `Lime
      | `Limegreen
      | `Linen
      | `Magenta
      | `Maroon
      | `Mediumaquamarine
      | `Mediumblue
      | `Mediumorchid
      | `Mediumpurple
      | `Mediumseagreen
      | `Mediumslateblue
      | `Mediumspringgreen
      | `Mediumturquoise
      | `Mediumvioletred
      | `Midnightblue
      | `Mintcream
      | `Mistyrose
      | `Moccasin
      | `Navajowhite
      | `Navy
      | `Oldlace
      | `Olive
      | `Olivedrab
      | `Orange
      | `Orangered
      | `Orchid
      | `Palegoldenrod
      | `Palegreen
      | `Paleturquoise
      | `Palevioletred
      | `Papayawhip
      | `Peachpuff
      | `Peru
      | `Pink
      | `Plum
      | `Powderblue
      | `Purple
      | `Rebeccapurple
      | `Red
      | `Rosybrown
      | `Royalblue
      | `Saddlebrown
      | `Salmon
      | `Sandybrown
      | `Seagreen
      | `Seashell
      | `Sienna
      | `Silver
      | `Skyblue
      | `Slateblue
      | `Slategray
      | `Slategrey
      | `Snow
      | `Springgreen
      | `Steelblue
      | `Tan
      | `Teal
      | `Thistle
      | `Tomato
      | `Turquoise
      | `Violet
      | `Wheat
      | `White
      | `Whitesmoke
      | `Yellow
      | `Yellowgreen
      | `_non_standard_color of Non_standard_color.t ]
  
    let parser =
      Combinators.xor
        [
          map (keyword "transparent") (fun _v -> `Transparent);
          map (keyword "aliceblue") (fun _v -> `Aliceblue);
          map (keyword "antiquewhite") (fun _v -> `Antiquewhite);
          map (keyword "aqua") (fun _v -> `Aqua);
          map (keyword "aquamarine") (fun _v -> `Aquamarine);
          map (keyword "azure") (fun _v -> `Azure);
          map (keyword "beige") (fun _v -> `Beige);
          map (keyword "bisque") (fun _v -> `Bisque);
          map (keyword "black") (fun _v -> `Black);
          map (keyword "blanchedalmond") (fun _v -> `Blanchedalmond);
          map (keyword "blue") (fun _v -> `Blue);
          map (keyword "blueviolet") (fun _v -> `Blueviolet);
          map (keyword "brown") (fun _v -> `Brown);
          map (keyword "burlywood") (fun _v -> `Burlywood);
          map (keyword "cadetblue") (fun _v -> `Cadetblue);
          map (keyword "chartreuse") (fun _v -> `Chartreuse);
          map (keyword "chocolate") (fun _v -> `Chocolate);
          map (keyword "coral") (fun _v -> `Coral);
          map (keyword "cornflowerblue") (fun _v -> `Cornflowerblue);
          map (keyword "cornsilk") (fun _v -> `Cornsilk);
          map (keyword "crimson") (fun _v -> `Crimson);
          map (keyword "cyan") (fun _v -> `Cyan);
          map (keyword "darkblue") (fun _v -> `Darkblue);
          map (keyword "darkcyan") (fun _v -> `Darkcyan);
          map (keyword "darkgoldenrod") (fun _v -> `Darkgoldenrod);
          map (keyword "darkgray") (fun _v -> `Darkgray);
          map (keyword "darkgreen") (fun _v -> `Darkgreen);
          map (keyword "darkgrey") (fun _v -> `Darkgrey);
          map (keyword "darkkhaki") (fun _v -> `Darkkhaki);
          map (keyword "darkmagenta") (fun _v -> `Darkmagenta);
          map (keyword "darkolivegreen") (fun _v -> `Darkolivegreen);
          map (keyword "darkorange") (fun _v -> `Darkorange);
          map (keyword "darkorchid") (fun _v -> `Darkorchid);
          map (keyword "darkred") (fun _v -> `Darkred);
          map (keyword "darksalmon") (fun _v -> `Darksalmon);
          map (keyword "darkseagreen") (fun _v -> `Darkseagreen);
          map (keyword "darkslateblue") (fun _v -> `Darkslateblue);
          map (keyword "darkslategray") (fun _v -> `Darkslategray);
          map (keyword "darkslategrey") (fun _v -> `Darkslategrey);
          map (keyword "darkturquoise") (fun _v -> `Darkturquoise);
          map (keyword "darkviolet") (fun _v -> `Darkviolet);
          map (keyword "deeppink") (fun _v -> `Deeppink);
          map (keyword "deepskyblue") (fun _v -> `Deepskyblue);
          map (keyword "dimgray") (fun _v -> `Dimgray);
          map (keyword "dimgrey") (fun _v -> `Dimgrey);
          map (keyword "dodgerblue") (fun _v -> `Dodgerblue);
          map (keyword "firebrick") (fun _v -> `Firebrick);
          map (keyword "floralwhite") (fun _v -> `Floralwhite);
          map (keyword "forestgreen") (fun _v -> `Forestgreen);
          map (keyword "fuchsia") (fun _v -> `Fuchsia);
          map (keyword "gainsboro") (fun _v -> `Gainsboro);
          map (keyword "ghostwhite") (fun _v -> `Ghostwhite);
          map (keyword "gold") (fun _v -> `Gold);
          map (keyword "goldenrod") (fun _v -> `Goldenrod);
          map (keyword "gray") (fun _v -> `Gray);
          map (keyword "green") (fun _v -> `Green);
          map (keyword "greenyellow") (fun _v -> `Greenyellow);
          map (keyword "grey") (fun _v -> `Grey);
          map (keyword "honeydew") (fun _v -> `Honeydew);
          map (keyword "hotpink") (fun _v -> `Hotpink);
          map (keyword "indianred") (fun _v -> `Indianred);
          map (keyword "indigo") (fun _v -> `Indigo);
          map (keyword "ivory") (fun _v -> `Ivory);
          map (keyword "khaki") (fun _v -> `Khaki);
          map (keyword "lavender") (fun _v -> `Lavender);
          map (keyword "lavenderblush") (fun _v -> `Lavenderblush);
          map (keyword "lawngreen") (fun _v -> `Lawngreen);
          map (keyword "lemonchiffon") (fun _v -> `Lemonchiffon);
          map (keyword "lightblue") (fun _v -> `Lightblue);
          map (keyword "lightcoral") (fun _v -> `Lightcoral);
          map (keyword "lightcyan") (fun _v -> `Lightcyan);
          map (keyword "lightgoldenrodyellow") (fun _v -> `Lightgoldenrodyellow);
          map (keyword "lightgray") (fun _v -> `Lightgray);
          map (keyword "lightgreen") (fun _v -> `Lightgreen);
          map (keyword "lightgrey") (fun _v -> `Lightgrey);
          map (keyword "lightpink") (fun _v -> `Lightpink);
          map (keyword "lightsalmon") (fun _v -> `Lightsalmon);
          map (keyword "lightseagreen") (fun _v -> `Lightseagreen);
          map (keyword "lightskyblue") (fun _v -> `Lightskyblue);
          map (keyword "lightslategray") (fun _v -> `Lightslategray);
          map (keyword "lightslategrey") (fun _v -> `Lightslategrey);
          map (keyword "lightsteelblue") (fun _v -> `Lightsteelblue);
          map (keyword "lightyellow") (fun _v -> `Lightyellow);
          map (keyword "lime") (fun _v -> `Lime);
          map (keyword "limegreen") (fun _v -> `Limegreen);
          map (keyword "linen") (fun _v -> `Linen);
          map (keyword "magenta") (fun _v -> `Magenta);
          map (keyword "maroon") (fun _v -> `Maroon);
          map (keyword "mediumaquamarine") (fun _v -> `Mediumaquamarine);
          map (keyword "mediumblue") (fun _v -> `Mediumblue);
          map (keyword "mediumorchid") (fun _v -> `Mediumorchid);
          map (keyword "mediumpurple") (fun _v -> `Mediumpurple);
          map (keyword "mediumseagreen") (fun _v -> `Mediumseagreen);
          map (keyword "mediumslateblue") (fun _v -> `Mediumslateblue);
          map (keyword "mediumspringgreen") (fun _v -> `Mediumspringgreen);
          map (keyword "mediumturquoise") (fun _v -> `Mediumturquoise);
          map (keyword "mediumvioletred") (fun _v -> `Mediumvioletred);
          map (keyword "midnightblue") (fun _v -> `Midnightblue);
          map (keyword "mintcream") (fun _v -> `Mintcream);
          map (keyword "mistyrose") (fun _v -> `Mistyrose);
          map (keyword "moccasin") (fun _v -> `Moccasin);
          map (keyword "navajowhite") (fun _v -> `Navajowhite);
          map (keyword "navy") (fun _v -> `Navy);
          map (keyword "oldlace") (fun _v -> `Oldlace);
          map (keyword "olive") (fun _v -> `Olive);
          map (keyword "olivedrab") (fun _v -> `Olivedrab);
          map (keyword "orange") (fun _v -> `Orange);
          map (keyword "orangered") (fun _v -> `Orangered);
          map (keyword "orchid") (fun _v -> `Orchid);
          map (keyword "palegoldenrod") (fun _v -> `Palegoldenrod);
          map (keyword "palegreen") (fun _v -> `Palegreen);
          map (keyword "paleturquoise") (fun _v -> `Paleturquoise);
          map (keyword "palevioletred") (fun _v -> `Palevioletred);
          map (keyword "papayawhip") (fun _v -> `Papayawhip);
          map (keyword "peachpuff") (fun _v -> `Peachpuff);
          map (keyword "peru") (fun _v -> `Peru);
          map (keyword "pink") (fun _v -> `Pink);
          map (keyword "plum") (fun _v -> `Plum);
          map (keyword "powderblue") (fun _v -> `Powderblue);
          map (keyword "purple") (fun _v -> `Purple);
          map (keyword "rebeccapurple") (fun _v -> `Rebeccapurple);
          map (keyword "red") (fun _v -> `Red);
          map (keyword "rosybrown") (fun _v -> `Rosybrown);
          map (keyword "royalblue") (fun _v -> `Royalblue);
          map (keyword "saddlebrown") (fun _v -> `Saddlebrown);
          map (keyword "salmon") (fun _v -> `Salmon);
          map (keyword "sandybrown") (fun _v -> `Sandybrown);
          map (keyword "seagreen") (fun _v -> `Seagreen);
          map (keyword "seashell") (fun _v -> `Seashell);
          map (keyword "sienna") (fun _v -> `Sienna);
          map (keyword "silver") (fun _v -> `Silver);
          map (keyword "skyblue") (fun _v -> `Skyblue);
          map (keyword "slateblue") (fun _v -> `Slateblue);
          map (keyword "slategray") (fun _v -> `Slategray);
          map (keyword "slategrey") (fun _v -> `Slategrey);
          map (keyword "snow") (fun _v -> `Snow);
          map (keyword "springgreen") (fun _v -> `Springgreen);
          map (keyword "steelblue") (fun _v -> `Steelblue);
          map (keyword "tan") (fun _v -> `Tan);
          map (keyword "teal") (fun _v -> `Teal);
          map (keyword "thistle") (fun _v -> `Thistle);
          map (keyword "tomato") (fun _v -> `Tomato);
          map (keyword "turquoise") (fun _v -> `Turquoise);
          map (keyword "violet") (fun _v -> `Violet);
          map (keyword "wheat") (fun _v -> `Wheat);
          map (keyword "white") (fun _v -> `White);
          map (keyword "whitesmoke") (fun _v -> `Whitesmoke);
          map (keyword "yellow") (fun _v -> `Yellow);
          map (keyword "yellowgreen") (fun _v -> `Yellowgreen);
          map Non_standard_color.parser (fun v -> `_non_standard_color v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Transparent -> "transparent"
      | `Aliceblue -> "aliceblue"
      | `Antiquewhite -> "antiquewhite"
      | `Aqua -> "aqua"
      | `Aquamarine -> "aquamarine"
      | `Azure -> "azure"
      | `Beige -> "beige"
      | `Bisque -> "bisque"
      | `Black -> "black"
      | `Blanchedalmond -> "blanchedalmond"
      | `Blue -> "blue"
      | `Blueviolet -> "blueviolet"
      | `Brown -> "brown"
      | `Burlywood -> "burlywood"
      | `Cadetblue -> "cadetblue"
      | `Chartreuse -> "chartreuse"
      | `Chocolate -> "chocolate"
      | `Coral -> "coral"
      | `Cornflowerblue -> "cornflowerblue"
      | `Cornsilk -> "cornsilk"
      | `Crimson -> "crimson"
      | `Cyan -> "cyan"
      | `Darkblue -> "darkblue"
      | `Darkcyan -> "darkcyan"
      | `Darkgoldenrod -> "darkgoldenrod"
      | `Darkgray -> "darkgray"
      | `Darkgreen -> "darkgreen"
      | `Darkgrey -> "darkgrey"
      | `Darkkhaki -> "darkkhaki"
      | `Darkmagenta -> "darkmagenta"
      | `Darkolivegreen -> "darkolivegreen"
      | `Darkorange -> "darkorange"
      | `Darkorchid -> "darkorchid"
      | `Darkred -> "darkred"
      | `Darksalmon -> "darksalmon"
      | `Darkseagreen -> "darkseagreen"
      | `Darkslateblue -> "darkslateblue"
      | `Darkslategray -> "darkslategray"
      | `Darkslategrey -> "darkslategrey"
      | `Darkturquoise -> "darkturquoise"
      | `Darkviolet -> "darkviolet"
      | `Deeppink -> "deeppink"
      | `Deepskyblue -> "deepskyblue"
      | `Dimgray -> "dimgray"
      | `Dimgrey -> "dimgrey"
      | `Dodgerblue -> "dodgerblue"
      | `Firebrick -> "firebrick"
      | `Floralwhite -> "floralwhite"
      | `Forestgreen -> "forestgreen"
      | `Fuchsia -> "fuchsia"
      | `Gainsboro -> "gainsboro"
      | `Ghostwhite -> "ghostwhite"
      | `Gold -> "gold"
      | `Goldenrod -> "goldenrod"
      | `Gray -> "gray"
      | `Green -> "green"
      | `Greenyellow -> "greenyellow"
      | `Grey -> "grey"
      | `Honeydew -> "honeydew"
      | `Hotpink -> "hotpink"
      | `Indianred -> "indianred"
      | `Indigo -> "indigo"
      | `Ivory -> "ivory"
      | `Khaki -> "khaki"
      | `Lavender -> "lavender"
      | `Lavenderblush -> "lavenderblush"
      | `Lawngreen -> "lawngreen"
      | `Lemonchiffon -> "lemonchiffon"
      | `Lightblue -> "lightblue"
      | `Lightcoral -> "lightcoral"
      | `Lightcyan -> "lightcyan"
      | `Lightgoldenrodyellow -> "lightgoldenrodyellow"
      | `Lightgray -> "lightgray"
      | `Lightgreen -> "lightgreen"
      | `Lightgrey -> "lightgrey"
      | `Lightpink -> "lightpink"
      | `Lightsalmon -> "lightsalmon"
      | `Lightseagreen -> "lightseagreen"
      | `Lightskyblue -> "lightskyblue"
      | `Lightslategray -> "lightslategray"
      | `Lightslategrey -> "lightslategrey"
      | `Lightsteelblue -> "lightsteelblue"
      | `Lightyellow -> "lightyellow"
      | `Lime -> "lime"
      | `Limegreen -> "limegreen"
      | `Linen -> "linen"
      | `Magenta -> "magenta"
      | `Maroon -> "maroon"
      | `Mediumaquamarine -> "mediumaquamarine"
      | `Mediumblue -> "mediumblue"
      | `Mediumorchid -> "mediumorchid"
      | `Mediumpurple -> "mediumpurple"
      | `Mediumseagreen -> "mediumseagreen"
      | `Mediumslateblue -> "mediumslateblue"
      | `Mediumspringgreen -> "mediumspringgreen"
      | `Mediumturquoise -> "mediumturquoise"
      | `Mediumvioletred -> "mediumvioletred"
      | `Midnightblue -> "midnightblue"
      | `Mintcream -> "mintcream"
      | `Mistyrose -> "mistyrose"
      | `Moccasin -> "moccasin"
      | `Navajowhite -> "navajowhite"
      | `Navy -> "navy"
      | `Oldlace -> "oldlace"
      | `Olive -> "olive"
      | `Olivedrab -> "olivedrab"
      | `Orange -> "orange"
      | `Orangered -> "orangered"
      | `Orchid -> "orchid"
      | `Palegoldenrod -> "palegoldenrod"
      | `Palegreen -> "palegreen"
      | `Paleturquoise -> "paleturquoise"
      | `Palevioletred -> "palevioletred"
      | `Papayawhip -> "papayawhip"
      | `Peachpuff -> "peachpuff"
      | `Peru -> "peru"
      | `Pink -> "pink"
      | `Plum -> "plum"
      | `Powderblue -> "powderblue"
      | `Purple -> "purple"
      | `Rebeccapurple -> "rebeccapurple"
      | `Red -> "red"
      | `Rosybrown -> "rosybrown"
      | `Royalblue -> "royalblue"
      | `Saddlebrown -> "saddlebrown"
      | `Salmon -> "salmon"
      | `Sandybrown -> "sandybrown"
      | `Seagreen -> "seagreen"
      | `Seashell -> "seashell"
      | `Sienna -> "sienna"
      | `Silver -> "silver"
      | `Skyblue -> "skyblue"
      | `Slateblue -> "slateblue"
      | `Slategray -> "slategray"
      | `Slategrey -> "slategrey"
      | `Snow -> "snow"
      | `Springgreen -> "springgreen"
      | `Steelblue -> "steelblue"
      | `Tan -> "tan"
      | `Teal -> "teal"
      | `Thistle -> "thistle"
      | `Tomato -> "tomato"
      | `Turquoise -> "turquoise"
      | `Violet -> "violet"
      | `Wheat -> "wheat"
      | `White -> "white"
      | `Whitesmoke -> "whitesmoke"
      | `Yellow -> "yellow"
      | `Yellowgreen -> "yellowgreen"
      | `_non_standard_color v -> Non_standard_color.toString v
  end
  
  and Deprecated_system_color : sig
    type nonrec t =
      [ `ActiveBorder
      | `ActiveCaption
      | `AppWorkspace
      | `Background
      | `ButtonFace
      | `ButtonHighlight
      | `ButtonShadow
      | `ButtonText
      | `CaptionText
      | `GrayText
      | `Highlight
      | `HighlightText
      | `InactiveBorder
      | `InactiveCaption
      | `InactiveCaptionText
      | `InfoBackground
      | `InfoText
      | `Menu
      | `MenuText
      | `Scrollbar
      | `ThreeDDarkShadow
      | `ThreeDFace
      | `ThreeDHighlight
      | `ThreeDLightShadow
      | `ThreeDShadow
      | `Window
      | `WindowFrame
      | `WindowText ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `ActiveBorder
      | `ActiveCaption
      | `AppWorkspace
      | `Background
      | `ButtonFace
      | `ButtonHighlight
      | `ButtonShadow
      | `ButtonText
      | `CaptionText
      | `GrayText
      | `Highlight
      | `HighlightText
      | `InactiveBorder
      | `InactiveCaption
      | `InactiveCaptionText
      | `InfoBackground
      | `InfoText
      | `Menu
      | `MenuText
      | `Scrollbar
      | `ThreeDDarkShadow
      | `ThreeDFace
      | `ThreeDHighlight
      | `ThreeDLightShadow
      | `ThreeDShadow
      | `Window
      | `WindowFrame
      | `WindowText ]
  
    let parser =
      Combinators.xor
        [
          map (keyword "ActiveBorder") (fun _v -> `ActiveBorder);
          map (keyword "ActiveCaption") (fun _v -> `ActiveCaption);
          map (keyword "AppWorkspace") (fun _v -> `AppWorkspace);
          map (keyword "Background") (fun _v -> `Background);
          map (keyword "ButtonFace") (fun _v -> `ButtonFace);
          map (keyword "ButtonHighlight") (fun _v -> `ButtonHighlight);
          map (keyword "ButtonShadow") (fun _v -> `ButtonShadow);
          map (keyword "ButtonText") (fun _v -> `ButtonText);
          map (keyword "CaptionText") (fun _v -> `CaptionText);
          map (keyword "GrayText") (fun _v -> `GrayText);
          map (keyword "Highlight") (fun _v -> `Highlight);
          map (keyword "HighlightText") (fun _v -> `HighlightText);
          map (keyword "InactiveBorder") (fun _v -> `InactiveBorder);
          map (keyword "InactiveCaption") (fun _v -> `InactiveCaption);
          map (keyword "InactiveCaptionText") (fun _v -> `InactiveCaptionText);
          map (keyword "InfoBackground") (fun _v -> `InfoBackground);
          map (keyword "InfoText") (fun _v -> `InfoText);
          map (keyword "Menu") (fun _v -> `Menu);
          map (keyword "MenuText") (fun _v -> `MenuText);
          map (keyword "Scrollbar") (fun _v -> `Scrollbar);
          map (keyword "ThreeDDarkShadow") (fun _v -> `ThreeDDarkShadow);
          map (keyword "ThreeDFace") (fun _v -> `ThreeDFace);
          map (keyword "ThreeDHighlight") (fun _v -> `ThreeDHighlight);
          map (keyword "ThreeDLightShadow") (fun _v -> `ThreeDLightShadow);
          map (keyword "ThreeDShadow") (fun _v -> `ThreeDShadow);
          map (keyword "Window") (fun _v -> `Window);
          map (keyword "WindowFrame") (fun _v -> `WindowFrame);
          map (keyword "WindowText") (fun _v -> `WindowText);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `ActiveBorder -> "ActiveBorder"
      | `ActiveCaption -> "ActiveCaption"
      | `AppWorkspace -> "AppWorkspace"
      | `Background -> "Background"
      | `ButtonFace -> "ButtonFace"
      | `ButtonHighlight -> "ButtonHighlight"
      | `ButtonShadow -> "ButtonShadow"
      | `ButtonText -> "ButtonText"
      | `CaptionText -> "CaptionText"
      | `GrayText -> "GrayText"
      | `Highlight -> "Highlight"
      | `HighlightText -> "HighlightText"
      | `InactiveBorder -> "InactiveBorder"
      | `InactiveCaption -> "InactiveCaption"
      | `InactiveCaptionText -> "InactiveCaptionText"
      | `InfoBackground -> "InfoBackground"
      | `InfoText -> "InfoText"
      | `Menu -> "Menu"
      | `MenuText -> "MenuText"
      | `Scrollbar -> "Scrollbar"
      | `ThreeDDarkShadow -> "ThreeDDarkShadow"
      | `ThreeDFace -> "ThreeDFace"
      | `ThreeDHighlight -> "ThreeDHighlight"
      | `ThreeDLightShadow -> "ThreeDLightShadow"
      | `ThreeDShadow -> "ThreeDShadow"
      | `Window -> "Window"
      | `WindowFrame -> "WindowFrame"
      | `WindowText -> "WindowText"
  end
  
  and Color_stop_list : sig
    type nonrec t =
      [ `Static_0 of Color.t option * Length_percentage.t
      | `Static_1 of Color.t * Length_percentage.t option ]
      list
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Static_0 of Color.t option * Length_percentage.t
      | `Static_1 of Color.t * Length_percentage.t option ]
      list
  
    let parser =
      repeat_by_comma (1, None)
        (Combinators.xor
           [
             map
               (map
                  (Combinators.static
                     [
                       map (optional Color.parser) (fun v -> `V0 v);
                       map Length_percentage.parser (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1)))
               (fun v -> `Static_0 v);
             map
               (map
                  (Combinators.static
                     [
                       map Color.parser (fun v -> `V0 v);
                       map (optional Length_percentage.parser) (fun v -> `V1 v);
                     ])
                  (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1)))
               (fun v -> `Static_1 v);
           ])
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      value
      |> List.map (fun x ->
             match x with
             | `Static_0 v ->
                 let v0, v1 = v in
                 ((match v0 with Some x -> Color.toString x | None -> "") ^ " ")
                 ^ Length_percentage.toString v1
             | `Static_1 v -> (
                 let v0, v1 = v in
                 (Color.toString v0 ^ " ")
                 ^
                 match v1 with
                 | Some x -> Length_percentage.toString x
                 | None -> ""))
      |> String.concat " "
  end
  
  and Color_stop : sig
    type nonrec t =
      [ `Color_stop_length of Color_stop_length.t
      | `Color_stop_angle of Color_stop_angle.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Color_stop_length of Color_stop_length.t
      | `Color_stop_angle of Color_stop_angle.t ]
  
    let parser =
      Combinators.xor
        [
          map Color_stop_length.parser (fun v -> `Color_stop_length v);
          map Color_stop_angle.parser (fun v -> `Color_stop_angle v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Color_stop_length v -> Color_stop_length.toString v
      | `Color_stop_angle v -> Color_stop_angle.toString v
  end
  
  and Color_stop_length : sig
    type nonrec t =
      [ `Extended_length of Extended_length.t
      | `Extended_percentage of Extended_percentage.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Extended_length of Extended_length.t
      | `Extended_percentage of Extended_percentage.t ]
  
    let parser =
      Combinators.xor
        [
          map Extended_length.parser (fun v -> `Extended_length v);
          map Extended_percentage.parser (fun v -> `Extended_percentage v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Extended_length v -> Extended_length.toString v
      | `Extended_percentage v -> Extended_percentage.toString v
  end
  
  and Color_stop_angle : sig
    type nonrec t = Extended_angle.t list
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t = Extended_angle.t list
  
    let parser = repeat (1, Some 2) Extended_angle.parser
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      value |> List.map (fun x -> Extended_angle.toString x) |> String.concat " "
  end
  
  and Linear_color_stop : sig
    type nonrec t = Color.t * Length_percentage.t option
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t = Color.t * Length_percentage.t option
  
    let parser =
      map
        (Combinators.static
           [
             map Color.parser (fun v -> `V0 v);
             map (optional Length_percentage.parser) (fun v -> `V1 v);
           ])
        (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      let v0, v1 = value in
      (Color.toString v0 ^ " ")
      ^ match v1 with Some x -> Length_percentage.toString x | None -> ""
  end
  
  and Linear_color_hint : sig
    type nonrec t =
      [ `Extended_length of Extended_length.t
      | `Extended_percentage of Extended_percentage.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Extended_length of Extended_length.t
      | `Extended_percentage of Extended_percentage.t ]
  
    let parser =
      Combinators.xor
        [
          map Extended_length.parser (fun v -> `Extended_length v);
          map Extended_percentage.parser (fun v -> `Extended_percentage v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Extended_length v -> Extended_length.toString v
      | `Extended_percentage v -> Extended_percentage.toString v
  end
  
  and Angular_color_stop : sig
    type nonrec t = Color.t * Color_stop_angle.t option
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t = Color.t * Color_stop_angle.t option
  
    let parser =
      map
        (Combinators.and_
           [
             map Color.parser (fun v -> `V0 v);
             map (optional Color_stop_angle.parser) (fun v -> `V1 v);
           ])
        (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      let v0, v1 = value in
      (Color.toString v0 ^ " ")
      ^ match v1 with Some x -> Color_stop_angle.toString x | None -> ""
  end
  
  and Angular_color_hint : sig
    type nonrec t =
      [ `Extended_angle of Extended_angle.t
      | `Extended_percentage of Extended_percentage.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Extended_angle of Extended_angle.t
      | `Extended_percentage of Extended_percentage.t ]
  
    let parser =
      Combinators.xor
        [
          map Extended_angle.parser (fun v -> `Extended_angle v);
          map Extended_percentage.parser (fun v -> `Extended_percentage v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Extended_angle v -> Extended_angle.toString v
      | `Extended_percentage v -> Extended_percentage.toString v
  end
  
  and Angular_color_stop_list : sig
    type nonrec t =
      (Angular_color_stop.t * (unit * Angular_color_hint.t) option) list
      * unit
      * Angular_color_stop.t
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      (Angular_color_stop.t * (unit * Angular_color_hint.t) option) list
      * unit
      * Angular_color_stop.t
  
    let parser =
      map
        (Combinators.static
           [
             map
               (repeat_by_comma (1, None)
                  (map
                     (Combinators.static
                        [
                          map Angular_color_stop.parser (fun v -> `V0 v);
                          map
                            (optional
                               (map
                                  (Combinators.static
                                     [
                                       map comma (fun v -> `V0 v);
                                       map Angular_color_hint.parser (fun v ->
                                           `V1 v);
                                     ])
                                  (fun [@ocaml.warning "-8-26-27"] [
                                                                     `V0 v0;
                                                                     `V1 v1;
                                                                   ]
                                                                 -> (v0, v1))))
                            (fun v -> `V1 v);
                        ])
                     (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] ->
                       (v0, v1))))
               (fun v -> `V0 v);
             map comma (fun v -> `V1 v);
             map Angular_color_stop.parser (fun v -> `V2 v);
           ])
        (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1; `V2 v2 ] ->
          (v0, v1, v2))
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      let v0, v1, v2 = value in
      ((((v0
         |> List.map (fun x ->
                let v0, v1 = x in
                (Angular_color_stop.toString v0 ^ " ")
                ^
                match v1 with
                | Some x ->
                    let v0, v1 = x in
                    ("," ^ " ") ^ Angular_color_hint.toString v1
                | None -> "")
         |> String.concat " ")
        ^ " ")
       ^ ",")
      ^ " ")
      ^ Angular_color_stop.toString v2
  end
  
  and Hue_interpolation_method : sig
    type nonrec t = [ `Shorter | `Longer | `Increasing | `Decreasing ] * unit
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t = [ `Shorter | `Longer | `Increasing | `Decreasing ] * unit
  
    let parser =
      map
        (Combinators.and_
           [
             map
               (Combinators.xor
                  [
                    map (keyword "shorter") (fun _v -> `Shorter);
                    map (keyword "longer") (fun _v -> `Longer);
                    map (keyword "increasing") (fun _v -> `Increasing);
                    map (keyword "decreasing") (fun _v -> `Decreasing);
                  ])
               (fun v -> `V0 v);
             map (keyword "hue") (fun v -> `V1 v);
           ])
        (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      let v0, v1 = value in
      ((match v0 with
       | `Shorter -> "shorter"
       | `Longer -> "longer"
       | `Increasing -> "increasing"
       | `Decreasing -> "decreasing")
      ^ " ")
      ^ "hue"
  end
  
  and Polar_color_space : sig
    type nonrec t = [ `Hsl | `Hwb | `Lch | `Oklch ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t = [ `Hsl | `Hwb | `Lch | `Oklch ]
  
    let parser =
      Combinators.xor
        [
          map (keyword "hsl") (fun _v -> `Hsl);
          map (keyword "hwb") (fun _v -> `Hwb);
          map (keyword "lch") (fun _v -> `Lch);
          map (keyword "oklch") (fun _v -> `Oklch);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Hsl -> "hsl"
      | `Hwb -> "hwb"
      | `Lch -> "lch"
      | `Oklch -> "oklch"
  end
  
  and Rectangular_color_space : sig
    type nonrec t =
      [ `Srgb
      | `Srgb_linear
      | `Display_p3
      | `A98_rgb
      | `Prophoto_rgb
      | `Rec2020
      | `Lab
      | `Oklab
      | `Xyz
      | `Xyz_d50
      | `Xyz_d65 ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `Srgb
      | `Srgb_linear
      | `Display_p3
      | `A98_rgb
      | `Prophoto_rgb
      | `Rec2020
      | `Lab
      | `Oklab
      | `Xyz
      | `Xyz_d50
      | `Xyz_d65 ]
  
    let parser =
      Combinators.xor
        [
          map (keyword "srgb") (fun _v -> `Srgb);
          map (keyword "srgb-linear") (fun _v -> `Srgb_linear);
          map (keyword "display-p3") (fun _v -> `Display_p3);
          map (keyword "a98-rgb") (fun _v -> `A98_rgb);
          map (keyword "prophoto-rgb") (fun _v -> `Prophoto_rgb);
          map (keyword "rec2020") (fun _v -> `Rec2020);
          map (keyword "lab") (fun _v -> `Lab);
          map (keyword "oklab") (fun _v -> `Oklab);
          map (keyword "xyz") (fun _v -> `Xyz);
          map (keyword "xyz-d50") (fun _v -> `Xyz_d50);
          map (keyword "xyz-d65") (fun _v -> `Xyz_d65);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `Srgb -> "srgb"
      | `Srgb_linear -> "srgb-linear"
      | `Display_p3 -> "display-p3"
      | `A98_rgb -> "a98-rgb"
      | `Prophoto_rgb -> "prophoto-rgb"
      | `Rec2020 -> "rec2020"
      | `Lab -> "lab"
      | `Oklab -> "oklab"
      | `Xyz -> "xyz"
      | `Xyz_d50 -> "xyz-d50"
      | `Xyz_d65 -> "xyz-d65"
  end
  
  and Color_interpolation_method : sig
    type nonrec t =
      unit
      * [ `Rectangular_color_space of Rectangular_color_space.t
        | `Static of Polar_color_space.t * Hue_interpolation_method.t option ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      unit
      * [ `Rectangular_color_space of Rectangular_color_space.t
        | `Static of Polar_color_space.t * Hue_interpolation_method.t option ]
  
    let parser =
      map
        (Combinators.and_
           [
             map (keyword "in") (fun v -> `V0 v);
             map
               (Combinators.xor
                  [
                    map Rectangular_color_space.parser (fun v ->
                        `Rectangular_color_space v);
                    map
                      (map
                         (Combinators.static
                            [
                              map Polar_color_space.parser (fun v -> `V0 v);
                              map (optional Hue_interpolation_method.parser)
                                (fun v -> `V1 v);
                            ])
                         (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] ->
                           (v0, v1)))
                      (fun v -> `Static v);
                  ])
               (fun v -> `V1 v);
           ])
        (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1))
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      let v0, v1 = value in
      ("in" ^ " ")
      ^
      match v1 with
      | `Rectangular_color_space v -> Rectangular_color_space.toString v
      | `Static v -> (
          let v0, v1 = v in
          (Polar_color_space.toString v0 ^ " ")
          ^
          match v1 with
          | Some x -> Hue_interpolation_method.toString x
          | None -> "")
  end
  
  and Function_color_mix : sig
    type nonrec t =
      Color_interpolation_method.t
      * unit
      * (Color.t * Percentage.t option)
      * unit
      * (Color.t * Percentage.t option)
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      Color_interpolation_method.t
      * unit
      * (Color.t * Percentage.t option)
      * unit
      * (Color.t * Percentage.t option)
  
    let parser =
      function_call "color-mix"
        (map
           (Combinators.static
              [
                map Color_interpolation_method.parser (fun v -> `V0 v);
                map comma (fun v -> `V1 v);
                map
                  (map
                     (Combinators.and_
                        [
                          map Color.parser (fun v -> `V0 v);
                          map (optional Percentage.parser) (fun v -> `V1 v);
                        ])
                     (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] ->
                       (v0, v1)))
                  (fun v -> `V2 v);
                map comma (fun v -> `V3 v);
                map
                  (map
                     (Combinators.and_
                        [
                          map Color.parser (fun v -> `V0 v);
                          map (optional Percentage.parser) (fun v -> `V1 v);
                        ])
                     (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] ->
                       (v0, v1)))
                  (fun v -> `V4 v);
              ])
           (fun [@ocaml.warning "-8-26-27"] [
                                              `V0 v0;
                                              `V1 v1;
                                              `V2 v2;
                                              `V3 v3;
                                              `V4 v4;
                                            ]
                                          -> (v0, v1, v2, v3, v4)))
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      (("color-mix" ^ "(")
      ^
      let v0, v1, v2, v3, v4 = value in
      (((((((Color_interpolation_method.toString v0 ^ " ") ^ ",") ^ " ")
         ^
         let v0, v1 = v2 in
         (Color.toString v0 ^ " ")
         ^ match v1 with Some x -> Percentage.toString x | None -> "")
        ^ " ")
       ^ ",")
      ^ " ")
      ^
      let v0, v1 = v4 in
      (Color.toString v0 ^ " ")
      ^ match v1 with Some x -> Percentage.toString x | None -> "")
      ^ ")"
  end
  
  and Paint : sig
    type nonrec t =
      [ `None
      | `Color of Color.t
      | `Static of Url.t * [ `None | `Color of Color.t ] option
      | `Context_fill
      | `Context_stroke
      | `Interpolation of Interpolation.t ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `None
      | `Color of Color.t
      | `Static of Url.t * [ `None | `Color of Color.t ] option
      | `Context_fill
      | `Context_stroke
      | `Interpolation of Interpolation.t ]
  
    let parser =
      Combinators.xor
        [
          map (keyword "none") (fun _v -> `None);
          map Color.parser (fun v -> `Color v);
          map
            (map
               (Combinators.static
                  [
                    map Url.parser (fun v -> `V0 v);
                    map
                      (optional
                         (Combinators.xor
                            [
                              map (keyword "none") (fun _v -> `None);
                              map Color.parser (fun v -> `Color v);
                            ]))
                      (fun v -> `V1 v);
                  ])
               (fun [@ocaml.warning "-8-26-27"] [ `V0 v0; `V1 v1 ] -> (v0, v1)))
            (fun v -> `Static v);
          map (keyword "context-fill") (fun _v -> `Context_fill);
          map (keyword "context-stroke") (fun _v -> `Context_stroke);
          map Interpolation.parser (fun v -> `Interpolation v);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `None -> "none"
      | `Color v -> Color.toString v
      | `Static v -> (
          let v0, v1 = v in
          (Url.toString v0 ^ " ")
          ^
          match v1 with
          | Some x -> (
              match x with `None -> "none" | `Color v -> Color.toString v)
          | None -> "")
      | `Context_fill -> "context-fill"
      | `Context_stroke -> "context-stroke"
      | `Interpolation v -> Interpolation.toString v
  end
  
  and Non_standard_color : sig
    type nonrec t =
      [ `_moz_ButtonDefault
      | `_moz_ButtonHoverFace
      | `_moz_ButtonHoverText
      | `_moz_CellHighlight
      | `_moz_CellHighlightText
      | `_moz_Combobox
      | `_moz_ComboboxText
      | `_moz_Dialog
      | `_moz_DialogText
      | `_moz_dragtargetzone
      | `_moz_EvenTreeRow
      | `_moz_Field
      | `_moz_FieldText
      | `_moz_html_CellHighlight
      | `_moz_html_CellHighlightText
      | `_moz_mac_accentdarkestshadow
      | `_moz_mac_accentdarkshadow
      | `_moz_mac_accentface
      | `_moz_mac_accentlightesthighlight
      | `_moz_mac_accentlightshadow
      | `_moz_mac_accentregularhighlight
      | `_moz_mac_accentregularshadow
      | `_moz_mac_chrome_active
      | `_moz_mac_chrome_inactive
      | `_moz_mac_focusring
      | `_moz_mac_menuselect
      | `_moz_mac_menushadow
      | `_moz_mac_menutextselect
      | `_moz_MenuHover
      | `_moz_MenuHoverText
      | `_moz_MenuBarText
      | `_moz_MenuBarHoverText
      | `_moz_nativehyperlinktext
      | `_moz_OddTreeRow
      | `_moz_win_communicationstext
      | `_moz_win_mediatext
      | `_moz_activehyperlinktext
      | `_moz_default_background_color
      | `_moz_default_color
      | `_moz_hyperlinktext
      | `_moz_visitedhyperlinktext
      | `_webkit_activelink
      | `_webkit_focus_ring_color
      | `_webkit_link
      | `_webkit_text ]
  
    val parser :
      Styled_ppx_css_parser.Tokens.t list ->
      t Css_grammar_parser__Rule.data * Styled_ppx_css_parser.Tokens.t list
  
    val toString : t -> string
  end = struct
    type nonrec t =
      [ `_moz_ButtonDefault
      | `_moz_ButtonHoverFace
      | `_moz_ButtonHoverText
      | `_moz_CellHighlight
      | `_moz_CellHighlightText
      | `_moz_Combobox
      | `_moz_ComboboxText
      | `_moz_Dialog
      | `_moz_DialogText
      | `_moz_dragtargetzone
      | `_moz_EvenTreeRow
      | `_moz_Field
      | `_moz_FieldText
      | `_moz_html_CellHighlight
      | `_moz_html_CellHighlightText
      | `_moz_mac_accentdarkestshadow
      | `_moz_mac_accentdarkshadow
      | `_moz_mac_accentface
      | `_moz_mac_accentlightesthighlight
      | `_moz_mac_accentlightshadow
      | `_moz_mac_accentregularhighlight
      | `_moz_mac_accentregularshadow
      | `_moz_mac_chrome_active
      | `_moz_mac_chrome_inactive
      | `_moz_mac_focusring
      | `_moz_mac_menuselect
      | `_moz_mac_menushadow
      | `_moz_mac_menutextselect
      | `_moz_MenuHover
      | `_moz_MenuHoverText
      | `_moz_MenuBarText
      | `_moz_MenuBarHoverText
      | `_moz_nativehyperlinktext
      | `_moz_OddTreeRow
      | `_moz_win_communicationstext
      | `_moz_win_mediatext
      | `_moz_activehyperlinktext
      | `_moz_default_background_color
      | `_moz_default_color
      | `_moz_hyperlinktext
      | `_moz_visitedhyperlinktext
      | `_webkit_activelink
      | `_webkit_focus_ring_color
      | `_webkit_link
      | `_webkit_text ]
  
    let parser =
      Combinators.xor
        [
          map (keyword "-moz-ButtonDefault") (fun _v -> `_moz_ButtonDefault);
          map (keyword "-moz-ButtonHoverFace") (fun _v -> `_moz_ButtonHoverFace);
          map (keyword "-moz-ButtonHoverText") (fun _v -> `_moz_ButtonHoverText);
          map (keyword "-moz-CellHighlight") (fun _v -> `_moz_CellHighlight);
          map (keyword "-moz-CellHighlightText") (fun _v ->
              `_moz_CellHighlightText);
          map (keyword "-moz-Combobox") (fun _v -> `_moz_Combobox);
          map (keyword "-moz-ComboboxText") (fun _v -> `_moz_ComboboxText);
          map (keyword "-moz-Dialog") (fun _v -> `_moz_Dialog);
          map (keyword "-moz-DialogText") (fun _v -> `_moz_DialogText);
          map (keyword "-moz-dragtargetzone") (fun _v -> `_moz_dragtargetzone);
          map (keyword "-moz-EvenTreeRow") (fun _v -> `_moz_EvenTreeRow);
          map (keyword "-moz-Field") (fun _v -> `_moz_Field);
          map (keyword "-moz-FieldText") (fun _v -> `_moz_FieldText);
          map (keyword "-moz-html-CellHighlight") (fun _v ->
              `_moz_html_CellHighlight);
          map (keyword "-moz-html-CellHighlightText") (fun _v ->
              `_moz_html_CellHighlightText);
          map (keyword "-moz-mac-accentdarkestshadow") (fun _v ->
              `_moz_mac_accentdarkestshadow);
          map (keyword "-moz-mac-accentdarkshadow") (fun _v ->
              `_moz_mac_accentdarkshadow);
          map (keyword "-moz-mac-accentface") (fun _v -> `_moz_mac_accentface);
          map (keyword "-moz-mac-accentlightesthighlight") (fun _v ->
              `_moz_mac_accentlightesthighlight);
          map (keyword "-moz-mac-accentlightshadow") (fun _v ->
              `_moz_mac_accentlightshadow);
          map (keyword "-moz-mac-accentregularhighlight") (fun _v ->
              `_moz_mac_accentregularhighlight);
          map (keyword "-moz-mac-accentregularshadow") (fun _v ->
              `_moz_mac_accentregularshadow);
          map (keyword "-moz-mac-chrome-active") (fun _v ->
              `_moz_mac_chrome_active);
          map (keyword "-moz-mac-chrome-inactive") (fun _v ->
              `_moz_mac_chrome_inactive);
          map (keyword "-moz-mac-focusring") (fun _v -> `_moz_mac_focusring);
          map (keyword "-moz-mac-menuselect") (fun _v -> `_moz_mac_menuselect);
          map (keyword "-moz-mac-menushadow") (fun _v -> `_moz_mac_menushadow);
          map (keyword "-moz-mac-menutextselect") (fun _v ->
              `_moz_mac_menutextselect);
          map (keyword "-moz-MenuHover") (fun _v -> `_moz_MenuHover);
          map (keyword "-moz-MenuHoverText") (fun _v -> `_moz_MenuHoverText);
          map (keyword "-moz-MenuBarText") (fun _v -> `_moz_MenuBarText);
          map (keyword "-moz-MenuBarHoverText") (fun _v -> `_moz_MenuBarHoverText);
          map (keyword "-moz-nativehyperlinktext") (fun _v ->
              `_moz_nativehyperlinktext);
          map (keyword "-moz-OddTreeRow") (fun _v -> `_moz_OddTreeRow);
          map (keyword "-moz-win-communicationstext") (fun _v ->
              `_moz_win_communicationstext);
          map (keyword "-moz-win-mediatext") (fun _v -> `_moz_win_mediatext);
          map (keyword "-moz-activehyperlinktext") (fun _v ->
              `_moz_activehyperlinktext);
          map (keyword "-moz-default-background-color") (fun _v ->
              `_moz_default_background_color);
          map (keyword "-moz-default-color") (fun _v -> `_moz_default_color);
          map (keyword "-moz-hyperlinktext") (fun _v -> `_moz_hyperlinktext);
          map (keyword "-moz-visitedhyperlinktext") (fun _v ->
              `_moz_visitedhyperlinktext);
          map (keyword "-webkit-activelink") (fun _v -> `_webkit_activelink);
          map (keyword "-webkit-focus-ring-color") (fun _v ->
              `_webkit_focus_ring_color);
          map (keyword "-webkit-link") (fun _v -> `_webkit_link);
          map (keyword "-webkit-text") (fun _v -> `_webkit_text);
        ]
    [@@ocaml.warning "-8-26-27"]
  
    let toString (value : t) =
      match value with
      | `_moz_ButtonDefault -> "-moz-ButtonDefault"
      | `_moz_ButtonHoverFace -> "-moz-ButtonHoverFace"
      | `_moz_ButtonHoverText -> "-moz-ButtonHoverText"
      | `_moz_CellHighlight -> "-moz-CellHighlight"
      | `_moz_CellHighlightText -> "-moz-CellHighlightText"
      | `_moz_Combobox -> "-moz-Combobox"
      | `_moz_ComboboxText -> "-moz-ComboboxText"
      | `_moz_Dialog -> "-moz-Dialog"
      | `_moz_DialogText -> "-moz-DialogText"
      | `_moz_dragtargetzone -> "-moz-dragtargetzone"
      | `_moz_EvenTreeRow -> "-moz-EvenTreeRow"
      | `_moz_Field -> "-moz-Field"
      | `_moz_FieldText -> "-moz-FieldText"
      | `_moz_html_CellHighlight -> "-moz-html-CellHighlight"
      | `_moz_html_CellHighlightText -> "-moz-html-CellHighlightText"
      | `_moz_mac_accentdarkestshadow -> "-moz-mac-accentdarkestshadow"
      | `_moz_mac_accentdarkshadow -> "-moz-mac-accentdarkshadow"
      | `_moz_mac_accentface -> "-moz-mac-accentface"
      | `_moz_mac_accentlightesthighlight -> "-moz-mac-accentlightesthighlight"
      | `_moz_mac_accentlightshadow -> "-moz-mac-accentlightshadow"
      | `_moz_mac_accentregularhighlight -> "-moz-mac-accentregularhighlight"
      | `_moz_mac_accentregularshadow -> "-moz-mac-accentregularshadow"
      | `_moz_mac_chrome_active -> "-moz-mac-chrome-active"
      | `_moz_mac_chrome_inactive -> "-moz-mac-chrome-inactive"
      | `_moz_mac_focusring -> "-moz-mac-focusring"
      | `_moz_mac_menuselect -> "-moz-mac-menuselect"
      | `_moz_mac_menushadow -> "-moz-mac-menushadow"
      | `_moz_mac_menutextselect -> "-moz-mac-menutextselect"
      | `_moz_MenuHover -> "-moz-MenuHover"
      | `_moz_MenuHoverText -> "-moz-MenuHoverText"
      | `_moz_MenuBarText -> "-moz-MenuBarText"
      | `_moz_MenuBarHoverText -> "-moz-MenuBarHoverText"
      | `_moz_nativehyperlinktext -> "-moz-nativehyperlinktext"
      | `_moz_OddTreeRow -> "-moz-OddTreeRow"
      | `_moz_win_communicationstext -> "-moz-win-communicationstext"
      | `_moz_win_mediatext -> "-moz-win-mediatext"
      | `_moz_activehyperlinktext -> "-moz-activehyperlinktext"
      | `_moz_default_background_color -> "-moz-default-background-color"
      | `_moz_default_color -> "-moz-default-color"
      | `_moz_hyperlinktext -> "-moz-hyperlinktext"
      | `_moz_visitedhyperlinktext -> "-moz-visitedhyperlinktext"
      | `_webkit_activelink -> "-webkit-activelink"
      | `_webkit_focus_ring_color -> "-webkit-focus-ring-color"
      | `_webkit_link -> "-webkit-link"
      | `_webkit_text -> "-webkit-text"
  end
