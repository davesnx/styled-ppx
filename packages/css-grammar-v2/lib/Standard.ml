module Tokens = Styled_ppx_css_parser.Tokens
module Parser = Styled_ppx_css_parser.Parser

type calc_sum = calc_product * ([ `Add | `Sub ] * calc_product) list
and calc_product = calc_value * [ `Mul of calc_value | `Div of float ] list

and calc_value =
  [ `Number of float
  | `Percentage of float
  | `Length of length_unit
  | `Angle of angle_unit
  | `Time of time_unit
  | `Frequency of frequency_unit
  | `Flex of float
  | `Nested of calc_sum
  | `Interpolation of string list
  ]

and length_unit =
  [ `Cap of float
  | `Ch of float
  | `Em of float
  | `Ex of float
  | `Ic of float
  | `Lh of float
  | `Rcap of float
  | `Rch of float
  | `Rem of float
  | `Rex of float
  | `Ric of float
  | `Rlh of float
  | `Vh of float
  | `Vw of float
  | `Vmax of float
  | `Vmin of float
  | `Vb of float
  | `Vi of float
  | `Cqw of float
  | `Cqh of float
  | `Cqi of float
  | `Cqb of float
  | `Cqmin of float
  | `Cqmax of float
  | `Px of float
  | `Cm of float
  | `Mm of float
  | `Q of float
  | `In of float
  | `Pc of float
  | `Pt of float
  | `Zero
  ]

and angle_unit =
  [ `Deg of float
  | `Grad of float
  | `Rad of float
  | `Turn of float
  ]

and time_unit =
  [ `S of float
  | `Ms of float
  ]

and frequency_unit =
  [ `Hz of float
  | `KHz of float
  ]

type length =
  [ `Cap of float
  | `Ch of float
  | `Em of float
  | `Ex of float
  | `Ic of float
  | `Lh of float
  | `Rcap of float
  | `Rch of float
  | `Rem of float
  | `Rex of float
  | `Ric of float
  | `Rlh of float
  | `Vh of float
  | `Vw of float
  | `Vmax of float
  | `Vmin of float
  | `Vb of float
  | `Vi of float
  | `Cqw of float
  | `Cqh of float
  | `Cqi of float
  | `Cqb of float
  | `Cqmin of float
  | `Cqmax of float
  | `Px of float
  | `Cm of float
  | `Mm of float
  | `Q of float
  | `In of float
  | `Pc of float
  | `Pt of float
  | `Zero
  | `Calc of calc_sum
  | `Min of calc_sum list
  | `Max of calc_sum list
  | `Clamp of calc_sum * calc_sum * calc_sum
  | `Interpolation of string list
  ]

type angle =
  [ `Deg of float
  | `Grad of float
  | `Rad of float
  | `Turn of float
  | `Calc of calc_sum
  | `Min of calc_sum list
  | `Max of calc_sum list
  | `Clamp of calc_sum * calc_sum * calc_sum
  | `Interpolation of string list
  ]

type time =
  [ `S of float
  | `Ms of float
  | `Calc of calc_sum
  | `Min of calc_sum list
  | `Max of calc_sum list
  | `Clamp of calc_sum * calc_sum * calc_sum
  | `Interpolation of string list
  ]

type frequency =
  [ `Hz of float
  | `KHz of float
  | `Calc of calc_sum
  | `Min of calc_sum list
  | `Max of calc_sum list
  | `Clamp of calc_sum * calc_sum * calc_sum
  | `Interpolation of string list
  ]

type resolution =
  [ `Dpi of float
  | `Dpcm of float
  | `Dppx of float
  | `Interpolation of string list
  ]

type percentage =
  [ `Percentage of float
  | `Calc of calc_sum
  | `Min of calc_sum list
  | `Max of calc_sum list
  | `Clamp of calc_sum * calc_sum * calc_sum
  | `Interpolation of string list
  ]

type flex_value =
  [ `Fr of float
  | `Interpolation of string list
  ]

type css_wide_keywords =
  [ `Initial
  | `Inherit
  | `Unset
  | `Revert
  | `RevertLayer
  ]

type number =
  [ `Number of float
  | `Calc of calc_sum
  | `Min of calc_sum list
  | `Max of calc_sum list
  | `Clamp of calc_sum * calc_sum * calc_sum
  | `Interpolation of string list
  ]

type integer =
  [ `Integer of int
  | `Interpolation of string list
  ]

type length_percentage =
  [ `Length of length
  | `Percentage of percentage
  | `Calc of calc_sum
  | `Min of calc_sum list
  | `Max of calc_sum list
  | `Clamp of calc_sum * calc_sum * calc_sum
  | `Interpolation of string list
  ]

let keyword kw =
  match kw with
  | "<=" -> Rule.Pattern.expect (Parser.DELIM "<=")
  | ">=" -> Rule.Pattern.expect (Parser.DELIM ">=")
  | _ ->
    let kw_lower = String.lowercase_ascii kw in
    Rule.Pattern.token (function
      | Parser.IDENT s when String.lowercase_ascii s = kw_lower -> Ok ()
      | Parser.TAG s when String.lowercase_ascii s = kw_lower -> Ok ()
      | token ->
        Error
          [
            "Expected '"
            ^ kw
            ^ "' but instead got '"
            ^ Tokens.humanize token
            ^ "'.";
          ])

let comma = Rule.Pattern.expect Parser.COMMA

let delim = function
  | "(" -> Rule.Pattern.expect Parser.LEFT_PAREN
  | ")" -> Rule.Pattern.expect Parser.RIGHT_PAREN
  | "[" -> Rule.Pattern.expect Parser.LEFT_BRACKET
  | "]" -> Rule.Pattern.expect Parser.RIGHT_BRACKET
  | ":" -> Rule.Pattern.expect Parser.COLON
  | ";" -> Rule.Pattern.expect Parser.SEMI_COLON
  | "*" -> Rule.Pattern.expect Parser.ASTERISK
  | "." -> Rule.Pattern.expect Parser.DOT
  | "," -> Rule.Pattern.expect Parser.COMMA
  | "+" ->
    Combinators.xor
      [
        Rule.Pattern.expect (Parser.COMBINATOR "+");
        Rule.Pattern.expect (Parser.DELIM "+");
        Rule.Pattern.expect (Parser.OPERATOR "+");
      ]
  | "-" ->
    Combinators.xor
      [
        Rule.Pattern.expect (Parser.DELIM "-");
        Rule.Pattern.expect (Parser.OPERATOR "-");
      ]
  | "~" -> Rule.Pattern.expect (Parser.COMBINATOR "~")
  | ">" -> Rule.Pattern.expect (Parser.COMBINATOR ">")
  | "/" ->
    Combinators.xor
      [
        Rule.Pattern.expect (Parser.DELIM "/");
        Rule.Pattern.expect (Parser.OPERATOR "/");
      ]
  | s -> Rule.Pattern.expect (Parser.DELIM s)

let function_call name rule =
  Rule.Match.bind
    (Rule.Pattern.token (function
      | Parser.FUNCTION called_name when name = called_name -> Ok ()
      | token ->
        Error
          [
            "Expected 'function "
            ^ name
            ^ "'. Got '"
            ^ Tokens.humanize token
            ^ "' instead.";
          ]))
    (fun () ->
      Rule.Match.bind rule (fun value ->
        Rule.Match.bind (Rule.Pattern.expect Parser.RIGHT_PAREN) (fun () ->
          Rule.Match.return value)))

let interpolation : string list Rule.rule =
  Rule.Pattern.token (function
    | Parser.INTERPOLATION parts -> Ok parts
    | _ -> Error [ "Expected interpolation." ])

let number_pure : float Rule.rule =
  Rule.Pattern.token (function
    | Parser.NUMBER num_str -> Ok (Float.of_string num_str)
    | token ->
      Error
        [ "Expected a number. Got '" ^ Tokens.humanize token ^ "' instead." ])

let integer_pure : int Rule.rule =
  Rule.Pattern.token (function
    | Parser.NUMBER string ->
      let f = Float.of_string string in
      if Float.is_integer f then Ok (Float.to_int f)
      else Error [ "Expected an integer, got a float instead." ]
    | _ -> Error [ "Expected an integer." ])

let percentage_pure : float Rule.rule =
  Rule.Match.bind number_pure (fun num ->
    Rule.Match.bind (Rule.Pattern.expect Parser.PERCENT) (fun () ->
      Rule.Match.return num))

let length_unit : length_unit Rule.rule =
  Rule.Pattern.token (function
    | Parser.FLOAT_DIMENSION (number_str, dimension)
    | Parser.DIMENSION (number_str, dimension) ->
      let num = Float.of_string number_str in
      (match dimension with
      | "cap" -> Ok (`Cap num)
      | "ch" -> Ok (`Ch num)
      | "em" -> Ok (`Em num)
      | "ex" -> Ok (`Ex num)
      | "ic" -> Ok (`Ic num)
      | "lh" -> Ok (`Lh num)
      | "rcap" -> Ok (`Rcap num)
      | "rch" -> Ok (`Rch num)
      | "rem" -> Ok (`Rem num)
      | "rex" -> Ok (`Rex num)
      | "ric" -> Ok (`Ric num)
      | "rlh" -> Ok (`Rlh num)
      | "vh" -> Ok (`Vh num)
      | "vw" -> Ok (`Vw num)
      | "vmax" -> Ok (`Vmax num)
      | "vmin" -> Ok (`Vmin num)
      | "vb" -> Ok (`Vb num)
      | "vi" -> Ok (`Vi num)
      | "cqw" -> Ok (`Cqw num)
      | "cqh" -> Ok (`Cqh num)
      | "cqi" -> Ok (`Cqi num)
      | "cqb" -> Ok (`Cqb num)
      | "cqmin" -> Ok (`Cqmin num)
      | "cqmax" -> Ok (`Cqmax num)
      | "px" -> Ok (`Px num)
      | "cm" -> Ok (`Cm num)
      | "mm" -> Ok (`Mm num)
      | "Q" -> Ok (`Q num)
      | "in" -> Ok (`In num)
      | "pc" -> Ok (`Pc num)
      | "pt" -> Ok (`Pt num)
      | dim -> Error [ "Invalid length unit '" ^ dim ^ "'." ])
    | Parser.NUMBER "0" -> Ok `Zero
    | _ -> Error [ "Expected length." ])

let angle_unit : angle_unit Rule.rule =
  Rule.Pattern.token (function
    | Parser.FLOAT_DIMENSION (number_str, dimension)
    | Parser.DIMENSION (number_str, dimension) ->
      let num = Float.of_string number_str in
      (match dimension with
      | "deg" -> Ok (`Deg num)
      | "grad" -> Ok (`Grad num)
      | "rad" -> Ok (`Rad num)
      | "turn" -> Ok (`Turn num)
      | dim -> Error [ "Invalid angle unit '" ^ dim ^ "'." ])
    | Parser.NUMBER "0" -> Ok (`Deg 0.)
    | _ -> Error [ "Expected angle." ])

let time_unit : time_unit Rule.rule =
  Rule.Pattern.token (function
    | Parser.FLOAT_DIMENSION (number_str, dimension)
    | Parser.DIMENSION (number_str, dimension) ->
      let num = Float.of_string number_str in
      (match String.lowercase_ascii dimension with
      | "s" -> Ok (`S num)
      | "ms" -> Ok (`Ms num)
      | un -> Error [ "Invalid time unit '" ^ un ^ "'." ])
    | _ -> Error [ "Expected time." ])

let frequency_unit : frequency_unit Rule.rule =
  Rule.Pattern.token (function
    | Parser.FLOAT_DIMENSION (number_str, dimension)
    | Parser.DIMENSION (number_str, dimension) ->
      let num = Float.of_string number_str in
      (match String.lowercase_ascii dimension with
      | "hz" -> Ok (`Hz num)
      | "khz" -> Ok (`KHz num)
      | dim -> Error [ "Invalid frequency unit '" ^ dim ^ "'." ])
    | _ -> Error [ "Expected frequency." ])

let flex_value_pure : float Rule.rule =
  Rule.Pattern.token (function
    | Parser.DIMENSION (number_str, dimension) ->
      let num = Float.of_string number_str in
      (match dimension with
      | "fr" -> Ok num
      | _ ->
        Error
          [
            Printf.sprintf "Invalid flex value %g%s, only fr is valid." num
              dimension;
          ])
    | _ -> Error [ "Expected flex_value." ])

let resolution_unit : resolution Rule.rule =
  Rule.Pattern.token (function
    | Parser.FLOAT_DIMENSION (number_str, dimension)
    | Parser.DIMENSION (number_str, dimension) ->
      let num = Float.of_string number_str in
      (match String.lowercase_ascii dimension with
      | "dpi" -> Ok (`Dpi num)
      | "dpcm" -> Ok (`Dpcm num)
      | "x" | "dppx" -> Ok (`Dppx num)
      | dim -> Error [ "Invalid resolution unit '" ^ dim ^ "'." ])
    | _ -> Error [ "Expected resolution." ])

let rec calc_value_parser () : calc_value Rule.rule =
  Combinators.xor
    [
      Rule.Match.map number_pure (fun n -> `Number n);
      Rule.Match.map percentage_pure (fun p -> `Percentage p);
      Rule.Match.map length_unit (fun l -> `Length l);
      Rule.Match.map angle_unit (fun a -> `Angle a);
      Rule.Match.map time_unit (fun t -> `Time t);
      Rule.Match.map frequency_unit (fun f -> `Frequency f);
      Rule.Match.map flex_value_pure (fun f -> `Flex f);
      Rule.Match.map interpolation (fun i -> `Interpolation i);
      nested_calc_parser ();
    ]

and nested_calc_parser () : calc_value Rule.rule =
 fun tokens ->
  let open Rule.Match in
  bind (delim "(")
    (fun () ->
      bind (calc_sum_parser ()) (fun sum ->
        bind (delim ")") (fun () -> return (`Nested sum))))
    tokens

and calc_product_parser () : calc_product Rule.rule =
 fun tokens ->
  let open Rule.Match in
  bind (calc_value_parser ())
    (fun first_value ->
      let rec parse_ops acc tokens =
        Combinators.xor
          [
            (fun tokens ->
              bind (delim "*")
                (fun () ->
                  bind (calc_value_parser ()) (fun v ->
                    parse_ops (`Mul v :: acc)))
                tokens);
            (fun tokens ->
              bind (delim "/")
                (fun () ->
                  bind number_pure (fun n -> parse_ops (`Div n :: acc)))
                tokens);
            (fun tokens -> return (first_value, List.rev acc) tokens);
          ]
          tokens
      in
      parse_ops [])
    tokens

and calc_sum_parser () : calc_sum Rule.rule =
 fun tokens ->
  let open Rule.Match in
  bind (calc_product_parser ())
    (fun first_product ->
      let rec parse_ops acc tokens =
        Combinators.xor
          [
            (fun tokens ->
              bind (delim "+")
                (fun () ->
                  bind (calc_product_parser ()) (fun p ->
                    parse_ops ((`Add, p) :: acc)))
                tokens);
            (fun tokens ->
              bind (delim "-")
                (fun () ->
                  bind (calc_product_parser ()) (fun p ->
                    parse_ops ((`Sub, p) :: acc)))
                tokens);
            (fun tokens -> return (first_product, List.rev acc) tokens);
          ]
          tokens
      in
      parse_ops [])
    tokens

let calc_sum = calc_sum_parser ()
let calc_product = calc_product_parser ()
let calc_value = calc_value_parser ()
let function_calc : calc_sum Rule.rule = function_call "calc" calc_sum

let function_min : calc_sum list Rule.rule =
  function_call "min" (Modifier.repeat_by_comma (1, None) calc_sum)

let function_max : calc_sum list Rule.rule =
  function_call "max" (Modifier.repeat_by_comma (1, None) calc_sum)

let function_clamp : (calc_sum * calc_sum * calc_sum) Rule.rule =
  function_call "clamp"
    (Rule.Match.bind calc_sum (fun min ->
       Rule.Match.bind (Rule.Pattern.expect Parser.COMMA) (fun () ->
         Rule.Match.bind calc_sum (fun val_ ->
           Rule.Match.bind (Rule.Pattern.expect Parser.COMMA) (fun () ->
             Rule.Match.bind calc_sum (fun max ->
               Rule.Match.return (min, val_, max)))))))

let length : length Rule.rule =
  Combinators.xor
    [
      Rule.Match.map length_unit (fun l -> (l :> length));
      Rule.Match.map function_calc (fun c -> `Calc c);
      Rule.Match.map function_min (fun m -> `Min m);
      Rule.Match.map function_max (fun m -> `Max m);
      Rule.Match.map function_clamp (fun (a, b, c) -> `Clamp (a, b, c));
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let length_runtime_module_path = [%module_path Css_types.Length]

let angle : angle Rule.rule =
  Combinators.xor
    [
      Rule.Match.map angle_unit (fun a -> (a :> angle));
      Rule.Match.map function_calc (fun c -> `Calc c);
      Rule.Match.map function_min (fun m -> `Min m);
      Rule.Match.map function_max (fun m -> `Max m);
      Rule.Match.map function_clamp (fun (a, b, c) -> `Clamp (a, b, c));
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let angle_runtime_module_path = [%module_path Css_types.Angle]

let time : time Rule.rule =
  Combinators.xor
    [
      Rule.Match.map time_unit (fun t -> (t :> time));
      Rule.Match.map function_calc (fun c -> `Calc c);
      Rule.Match.map function_min (fun m -> `Min m);
      Rule.Match.map function_max (fun m -> `Max m);
      Rule.Match.map function_clamp (fun (a, b, c) -> `Clamp (a, b, c));
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let time_runtime_module_path = [%module_path Css_types.Time]

let frequency : frequency Rule.rule =
  Combinators.xor
    [
      Rule.Match.map frequency_unit (fun f -> (f :> frequency));
      Rule.Match.map function_calc (fun c -> `Calc c);
      Rule.Match.map function_min (fun m -> `Min m);
      Rule.Match.map function_max (fun m -> `Max m);
      Rule.Match.map function_clamp (fun (a, b, c) -> `Clamp (a, b, c));
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let frequency_runtime_module_path = [%module_path Css_types.Frequency]

let resolution : resolution Rule.rule =
  Combinators.xor
    [
      resolution_unit; Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let resolution_runtime_module_path = [%module_path Css_types.Resolution]

let percentage : percentage Rule.rule =
  Combinators.xor
    [
      Rule.Match.map percentage_pure (fun p -> `Percentage p);
      Rule.Match.map function_calc (fun c -> `Calc c);
      Rule.Match.map function_min (fun m -> `Min m);
      Rule.Match.map function_max (fun m -> `Max m);
      Rule.Match.map function_clamp (fun (a, b, c) -> `Clamp (a, b, c));
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let percentage_runtime_module_path = [%module_path Css_types.Percentage]

let number : number Rule.rule =
  Combinators.xor
    [
      Rule.Match.map number_pure (fun n -> `Number n);
      Rule.Match.map function_calc (fun c -> `Calc c);
      Rule.Match.map function_min (fun m -> `Min m);
      Rule.Match.map function_max (fun m -> `Max m);
      Rule.Match.map function_clamp (fun (a, b, c) -> `Clamp (a, b, c));
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let number_runtime_module_path = [%module_path Css_types.Number]

let integer : integer Rule.rule =
  Combinators.xor
    [
      Rule.Match.map integer_pure (fun i -> `Integer i);
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let integer_runtime_module_path = [%module_path Css_types.Integer]

let flex_value : flex_value Rule.rule =
  Combinators.xor
    [
      Rule.Match.map flex_value_pure (fun f -> `Fr f);
      Rule.Match.map interpolation (fun i -> `Interpolation i);
    ]

let flex_value_runtime_module_path = [%module_path Css_types.FlexValue]

let css_wide_keywords : css_wide_keywords Rule.rule =
  Combinators.xor
    [
      Rule.Pattern.value `Initial (keyword "initial");
      Rule.Pattern.value `Inherit (keyword "inherit");
      Rule.Pattern.value `Unset (keyword "unset");
      Rule.Pattern.value `Revert (keyword "revert");
      Rule.Pattern.value `RevertLayer (keyword "revert-layer");
    ]

let css_wide_keywords_runtime_module_path = [%module_path Css_types.Cascading]

let length_percentage : length_percentage Rule.rule =
  Combinators.xor
    [
      Rule.Match.map interpolation (fun i -> `Interpolation i);
      Rule.Match.map function_calc (fun c -> `Calc c);
      Rule.Match.map function_min (fun m -> `Min m);
      Rule.Match.map function_max (fun m -> `Max m);
      Rule.Match.map function_clamp (fun (a, b, c) -> `Clamp (a, b, c));
      Rule.Match.map length (fun l -> `Length l);
      Rule.Match.map percentage (fun p -> `Percentage p);
    ]

let length_percentage_runtime_module_path =
  [%module_path Css_types.LengthPercentage]

let ident : string Rule.rule =
  Rule.Pattern.token (function
    | Parser.IDENT s -> Ok s
    | Parser.TAG s -> Ok s
    | _ -> Error [ "Expected an identifier." ])

let custom_ident : string Rule.rule =
  Rule.Pattern.token (function
    | Parser.IDENT s -> Ok s
    | Parser.TAG s -> Ok s
    | Parser.STRING s -> Ok s
    | _ -> Error [ "Expected an identifier." ])

let dashed_ident : string Rule.rule =
  Rule.Pattern.token (function
    | Parser.IDENT s when String.length s > 2 && String.sub s 0 2 = "--" -> Ok s
    | _ -> Error [ "Expected a --variable." ])

let string_token : string Rule.rule =
  Rule.Pattern.token (function
    | Parser.STRING s -> Ok s
    | _ -> Error [ "Expected a string." ])

let string = string_token

let hex_color : string Rule.rule =
  Rule.Pattern.token (function
    | Parser.HASH str when String.length str >= 3 && String.length str <= 8 ->
      Ok str
    | _ -> Error [ "Expected a hex-color." ])

let hex_color_runtime_module_path = [%module_path Css_types.Color]

let url : string Rule.rule =
  let url_token =
    Rule.Pattern.token (function
      | Parser.URL u -> Ok u
      | _ -> Error [ "Expected a url." ])
  in
  Combinators.xor [ url_token; function_call "url" string_token ]

let url_runtime_module_path = [%module_path Css_types.Url]
