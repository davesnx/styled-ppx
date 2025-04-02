let pp_selectors =
  Format.(
    pp_print_array ~pp_sep:(fun out () -> fprintf out ",") pp_print_string)

let pp_declaration ppf (property, value) =
  Format.fprintf ppf "%s:%s;" property value

let rec pp_rule ppf = function
  | Rule.Selector (selectors, rules) ->
    Format.(
      fprintf ppf "%a{%a}" pp_selectors selectors (pp_print_array pp_rule) rules)
  | Rule.Declaration (property, value) ->
    Format.fprintf ppf "%a" pp_declaration (property, value)

let pp_rules = Format.(pp_print_array ~pp_sep:pp_print_nothing pp_rule)

let print_rules rules =
  let out = Format.asprintf "%a" pp_rules rules in
  Str.global_replace (Str.regexp "\n") "" out

let nested_selector =
  test "nested_selector" @@ fun () ->
  let rules =
    [|
      CSS.selectorMany [| "div"; ":hover" |]
        [|
          CSS.color CSS.black;
          CSS.selector "main" [||];
          CSS.selector ":hover" [||];
          CSS.selector "&:hover" [||];
          CSS.selector "&.foo" [||];
          CSS.selector "@media (min-width: 30em)" [||];
        |];
    |]
    |> Emotion_bindings_helper.replaceSelector
  in
  assert_string (print_rules rules)
    "& div,& :hover{color:#000000;& main{}& :hover{}&:hover{}&.foo{}@media \
     (min-width: 30em){}}"

let tests = "Emotion Bindings Helper", [ nested_selector ]
