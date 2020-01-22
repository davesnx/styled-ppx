open Migrate_parsetree
open Ast_406
open Ast_helper
open Asttypes
open Parsetree
open Css_types

type mode =
  | Bs_css
  | Bs_typed_css

let grammar_error loc message =
  raise (Css_lexer.GrammarError (message, loc))

let is_overloaded mode declaration =
  (* Overloaded declarations are rendered as function applications where function name
     ends with a number that specifies the number of parameters.
     E.g.: margin: 1em 2px -> margin2 em(1.) px(2.)
  *)
  match mode with
  | Bs_css -> false
  | Bs_typed_css -> 
    begin match declaration with
      | "unsafe" -> false
      | _ -> true
    end

let is_variant mode ident =
  (* bs-css uses polymorphic variants to enumerate values. Some of them
     have corresponding constant, but some others have conflicting names
     (e.g.: left) or don't have a corresponding constant (e.g.: justify).
  *)
  match mode with
  | Bs_css ->
    begin match ident with
      (* float/clear/text-align *)
      | "left"
      | "right"
      | "justify"
      (* cursor *)
      | "pointer"
      | "alias"
      | "all-scroll"
      | "cell"
      | "context-menu"
      | "default"
      | "crosshair"
      | "copy"
      | "grab"
      | "grabbing"
      | "help"
      | "move"
      | "not-allowed"
      | "progress"
      | "text"
      | "wait"
      | "zoom-in"
      | "zoom-out"
      (* list-style-type *)
      | "disc"
      | "circle"
      | "decimal"
      | "lower-alpha"
      | "upper-alpha"
      | "lower-greek"
      | "upper-greek"
      | "lower-latin"
      | "upper-latin"
      | "lower-roman"
      | "upper-roman"
      (* outline-style *)
      | "groove"
      | "ridge"
      | "inset"
      | "outset"
      (* transform-style *)
      | "preserve-3d"
      | "flat"
      (* font-variant *)
      | "small-caps"
      (* step-timing-function *)
      | "start"
      | "end"
      (* display *)
      | "flex"
      | "inline-flex"
      (* font-weight *)
      | "thin"
      | "extra-light"
      | "light"
      | "medium"
      | "semi-bold"
      | "bold"
      | "extra-bold"
      | "lighter"
      | "bolder" -> true
      | _ -> false
    end
  | Bs_typed_css -> false

let split c s =
  let rec loop s accu =
    try
      let index = String.index s c in
      (String.sub s 0 index) :: (loop (String.sub s (index + 1) (String.length s - index - 1)) accu)
    with Not_found -> s :: accu
  in
  loop s []

let to_caml_case s =
  let splitted = split '-' s in
  List.fold_left
    (fun s part ->
       s ^ (if s <> "" then String.capitalize part else part))
    ""
    splitted

let number_to_const number =
  if String.contains number '.' then Const.float number
  else Const.integer number

let float_to_const number =
  let number =
    if String.contains number '.' then number
    else number ^ "." in
  Const.float number

let string_to_const ~loc s =
  Exp.constant ~loc (Const.string ~quotation_delimiter:"js" s)

let list_to_expr end_loc xs =
  List.fold_left
    (fun e param ->
       let loc =
         Lex_buffer.make_loc
           ~loc_ghost:true e.pexp_loc.Location.loc_start end_loc.Location.loc_end in
       Exp.construct ~loc
         { txt = Lident "::"; loc }
         (Some (Exp.tuple ~loc [param; e]))
    )
    (Exp.construct ~loc:end_loc
       { txt = Lident "[]"; loc = end_loc }
       None)
    xs

let group_params params =
  let rec group_param (accu, loc) xs =
    match xs with
    | [] -> (accu, loc), []
    | (Component_value.Delim ",", _) :: rest -> (accu, loc), rest
    | (_, cv_loc) as hd :: rest ->
      let loc =
        let loc_start =
          if loc = Location.none then cv_loc.Location.loc_start
          else loc.Location.loc_start in
        Lex_buffer.make_loc loc_start cv_loc.Location.loc_end in
      group_param (accu @ [hd], loc) rest
  in
  let rec group_params accu xs =
    match xs with
    | [] -> accu
    | _ ->
      let param, rest = group_param ([], Location.none) xs in
      group_params (accu @ [param]) rest
  in
  group_params [] params

let is_time component_value =
  let open Component_value in
  match component_value with
  | Float_dimension (_, _, Time) -> true
  | _ -> false

let is_timing_function component_value =
  let open Component_value in
  match component_value with
  | Ident "linear"
  (* cubic-bezier-timing-function *)
  | Ident "ease"
  | Ident "ease-in"
  | Ident "ease-out"
  | Ident "ease-in-out"
  | Function (("cubic-bezier", _), _)
  (* step-timing-function *)
  | Ident "step-start"
  | Ident "step-end"
  | Function (("steps", _), _)
  (* frames-timing-function *)
  | Function (("frames", _), _) -> true
  | _ -> false

let is_animation_iteration_count component_value =
  let open Component_value in
  match component_value with
  | Ident "infinite"
  | Function (("count", _), _) -> true
  | _ -> false

let is_animation_direction component_value =
  let open Component_value in
  match component_value with
  | Ident "normal"
  | Ident "reverse"
  | Ident "alternate"
  | Ident "alternate-reverse" -> true
  | _ -> false

let is_animation_fill_mode component_value =
  let open Component_value in
  match component_value with
  | Ident "none"
  | Ident "forwards"
  | Ident "backwards"
  | Ident "both" -> true
  | _ -> false

let is_animation_play_state component_value =
  let open Component_value in
  match component_value with
  | Ident "running"
  | Ident "paused" -> true
  | _ -> false

let is_keyframes_name component_value =
  let open Component_value in
  match component_value with
  | Ident _
  | String _ -> true
  | _ -> false

let is_ident ident component_value =
  let open Component_value in
  match component_value with
  | Ident i when i = ident -> true
  | _ -> false

let is_length component_value =
  let open Component_value in
  match component_value with
  | Number "0"
  | Float_dimension (_, _, Length) -> true
  | _ -> false

let is_color component_value =
  let open Component_value in
  match component_value with
  | Function (("rgb", _), _)
  | Function (("rgba", _), _)
  | Function (("hsl", _), _)
  | Function (("hsla", _), _)
  | Hash _
  | Ident _ -> true
  | _ -> false

let is_line_width component_value =
  let open Component_value in
  match component_value with
  | Ident i -> begin match i with
      | "thin"
      | "medium"
      | "thick" -> true
      | _ -> false
    end
  | _ -> is_length component_value

let is_line_style component_value =
  let open Component_value in
  match component_value with
  | Ident i -> begin match i with
      | "none"
      | "hidden"
      | "dotted"
      | "dashed"
      | "solid"
      | "double"
      | "groove"
      | "ridge"
      | "inset"
      | "outset" -> true
      | _ -> false
    end
  | _ -> false

let rec render_component_value mode ((cv, loc): Component_value.t with_loc) : expression =
  let render_block start_char _ _ =
    grammar_error loc ("Unsupported " ^ start_char ^ "-block")
  in

  let render_dimension number dimension const =
    let number_loc =
      { loc with
        Location.loc_end =
          { loc.Location.loc_end with
            Lexing.pos_cnum =
              loc.Location.loc_end.Lexing.pos_cnum - (String.length dimension)
          };
      } in
    let dimension_loc =
      { loc with
        Location.loc_start =
          { loc.Location.loc_start with
            Lexing.pos_cnum =
              loc.Location.loc_start.Lexing.pos_cnum + (String.length number)
          };
      } in
    let ident =
      Exp.ident ~loc:dimension_loc { txt = Lident dimension; loc = dimension_loc } in
    let arg =
      Exp.constant ~loc:number_loc const in
    Exp.apply ~loc ident [(Nolabel, arg)]
  in

  let render_function (name, name_loc) (params, params_loc) =
    let caml_case_name = to_caml_case name in
    let ident =
      Exp.ident ~loc:name_loc { txt = Lident caml_case_name; loc = name_loc } in
    let grouped_params = group_params params in
    let rcv = render_component_value mode in
    let args =
      let open Component_value in
      let side_or_corner_expr deg loc =
        rcv (Float_dimension (deg, "deg", Angle), loc)
      in
      let color_stops_to_expr_list color_stop_params =
        List.rev_map
          (function
            | ([(_, start_loc) as color_cv;
                (Percentage perc, end_loc)], _)
            | ([(_, start_loc) as color_cv;
                (Number ("0" as perc), end_loc)], _) ->
              let color_expr = rcv color_cv in
              let perc_expr = rcv (Percentage perc, end_loc) in
              let loc =
                Lex_buffer.make_loc start_loc.Location.loc_start end_loc.Location.loc_end in
              Exp.tuple ~loc [perc_expr; color_expr]
            | (_, loc) ->
              grammar_error loc "Unexpected color stop"
          )
          color_stop_params
      in
      let end_loc =
        Lex_buffer.make_loc ~loc_ghost:true loc.Location.loc_end loc.Location.loc_end in
      let render_params params =
        params
        |> List.filter
          (function (Delim ",", _) -> false | _ -> true)
        |> List.map
          (function
            | (Number "0", loc) ->
              Exp.constant ~loc (Const.int 0)
            | c -> rcv c)
      in
      match name with
      | "linear-gradient"
      | "repeating-linear-gradient" ->
        let (side_or_corner, color_stop_params) =
          match List.hd grouped_params with
          | ([(Float_dimension (_, "deg", Angle), _) as cv], _) ->
            rcv cv, List.tl grouped_params
          | ([(Ident "to", _);
              (Ident "bottom", _)], loc) ->
            side_or_corner_expr "180" loc, List.tl grouped_params
          | ([(Ident "to", _);
              (Ident "top", _)], loc) ->
            side_or_corner_expr "0" loc, List.tl grouped_params
          | ([(Ident "to", _);
              (Ident "right", _)], loc) ->
            side_or_corner_expr "90" loc, List.tl grouped_params
          | ([(Ident "to", _);
              (Ident "left", _)], loc) ->
            side_or_corner_expr "270" loc, List.tl grouped_params
          | ((Ident _, _) :: _, _) ->
            let implicit_side_or_corner_loc =
              Lex_buffer.make_loc ~loc_ghost:true
                params_loc.Location.loc_start
                params_loc.Location.loc_start in
            rcv
              (Float_dimension ("180", "deg", Angle), implicit_side_or_corner_loc), grouped_params
          | (_, loc) ->
            grammar_error loc "Unexpected first parameter"
          | exception (Failure _) ->
            grammar_error params_loc "Missing parameters"
        in
        let color_stops = color_stops_to_expr_list color_stop_params in
        let color_stop_expr = list_to_expr end_loc color_stops in
        [side_or_corner; color_stop_expr]
      | "radial-gradient"
      | "repeating-radial-gradient" ->
        let color_stops = color_stops_to_expr_list grouped_params in
        let color_stop_expr = list_to_expr end_loc color_stops in
        [color_stop_expr]
      | "hsl" ->
        let ps = params
          |> List.filter
            (function (Delim ",", _) -> false | _ -> true)
        in
        begin match ps with
        | [(Number n, l1); (Percentage p1, l2); (Percentage p2, l3)]
        | [(Float_dimension (n, "deg", Angle), l1); (Percentage p1, l2); (Percentage p2, l3)] ->
          [rcv (Float_dimension (n, "deg", Angle), l1);
           Exp.constant ~loc:l2 (float_to_const p1);
           Exp.constant ~loc:l3 (float_to_const p2);
          ]
        | _ ->
          grammar_error params_loc "Unexpected parameters (hsl)"
        end
      | "hsla" ->
        let ps = params
          |> List.filter
            (function (Delim ",", _) -> false | _ -> true)
        in
        begin match ps with
        | [(Number n, l1); (Percentage p1, l2); (Percentage p2, l3); (Number p3, l4)]
        | [(Float_dimension (n, "deg", Angle), l1); (Percentage p1, l2); (Percentage p2, l3); (Number p3, l4)] ->
          [rcv (Float_dimension (n, "deg", Angle), l1);
           Exp.constant ~loc:l2 (float_to_const p1);
           Exp.constant ~loc:l3 (float_to_const p2);
           Exp.variant ~loc:l4 "num" (Some (Exp.constant ~loc:l4 (float_to_const p3)));
          ]
        | [(Number n, l1); (Percentage p1, l2); (Percentage p2, l3); (Percentage p3, l4)]
        | [(Float_dimension (n, "deg", Angle), l1); (Percentage p1, l2); (Percentage p2, l3); (Percentage p3, l4)] ->
          [rcv (Float_dimension (n, "deg", Angle), l1);
           Exp.constant ~loc:l2 (float_to_const p1);
           Exp.constant ~loc:l3 (float_to_const p2);
           Exp.variant ~loc:l4 "perc" (Some (Exp.constant ~loc:l4 (float_to_const p3)));
          ]
        | _ ->
          grammar_error params_loc "Unexpected parameters (hsla)"
        end
      | _ ->
        render_params params
    in
    Exp.apply ~loc ident (List.map (fun a -> (Nolabel, a)) args)
  in

  match cv with
  | Component_value.Paren_block cs -> render_block "(" ")" cs
  | Bracket_block cs -> render_block "[" "]" cs
  | Percentage p ->
    let ident = Exp.ident ~loc { txt = Lident "pct"; loc } in
    let const = float_to_const p in
    let arg = Exp.constant ~loc const in
    Exp.apply ~loc ident [(Nolabel, arg)]
  | Ident i ->
    let name = to_caml_case i in
    if is_variant mode i then
      Exp.variant ~loc name None
    else  
      Exp.ident ~loc { txt = Lident name; loc }
  | String s ->
    string_to_const ~loc s
  | Uri s ->
    let ident = Exp.ident ~loc { txt = Lident "url"; loc } in
    let arg = string_to_const ~loc s in
    Exp.apply ~loc ident [(Nolabel, arg)]
  | Operator _ ->
    grammar_error loc "Unsupported operator"
  | Delim _ ->
    grammar_error loc "Unsupported delimiter"
  | Hash s ->
    let ident = Exp.ident ~loc { txt = Lident "hex"; loc } in
    let arg = string_to_const ~loc s in
    Exp.apply ~loc ident [(Nolabel, arg)]
  | Number s ->
    if s = "0" then Exp.ident ~loc { txt = Lident "zero"; loc }
    else Exp.constant ~loc (number_to_const s)
  | Unicode_range _ ->
    grammar_error loc "Unsupported unicode range"
  | Function (f, params) ->
    render_function f params
  | Float_dimension (number, "ms", Time) when mode = Bs_css ->
    (* bs-css expects milliseconds as an int constant *)
    let const = Const.integer number in
    Exp.constant ~loc const
  | Float_dimension (number, dimension, _) ->
    let const =
      if dimension = "px" then
        (* Pixels are treated as integers by both libraries *)
        Const.integer number
      else if mode = Bs_css && dimension = "pt" then
        (* bs-css uses int points *)
        Const.integer number
      else if mode = Bs_typed_css && dimension = "ms" then
        (* bs-typed-css uses int milliseconds *)
        Const.integer number
      else
        float_to_const number in
    render_dimension number dimension const
  | Dimension (number, dimension) ->
    let const = number_to_const number in
    render_dimension number dimension const

and render_at_rule mode (ar: At_rule.t) : expression =
  match ar.At_rule.name with
  | ("keyframes" as n, loc) when mode = Bs_css ->
    let ident = Exp.ident ~loc { txt = Lident n; loc } in
    begin match ar.At_rule.block with
      | Brace_block.Stylesheet (rs, loc) ->
        let end_loc =
          Lex_buffer.make_loc ~loc_ghost:true loc.Location.loc_end loc.Location.loc_end in
        let arg =
          List.fold_left
            (fun e r ->
               match r with
               | Rule.Style_rule sr ->
                 let progress_expr =
                   begin match sr.Style_rule.prelude with
                     | ([Component_value.Percentage p, loc], _) ->
                       Exp.constant ~loc (number_to_const p)
                     | ([Component_value.Ident "from", loc], _)
                     |  ([Component_value.Number "0", loc], _) ->
                       Exp.constant ~loc (Const.int 0)
                     | ([Component_value.Ident "to", loc], _) ->
                       Exp.constant ~loc (Const.int 100)
                     | (_, loc) ->
                       grammar_error loc "Unexpected @keyframes prelude"
                   end in
                 let block_expr =
                   render_declaration_list mode sr.Style_rule.block in
                 let tuple =
                   Exp.tuple ~loc:sr.Style_rule.loc [progress_expr; block_expr] in
                 let loc =
                   Lex_buffer.make_loc
                     ~loc_ghost:true sr.Style_rule.loc.Location.loc_start loc.Location.loc_end in
                 Exp.construct ~loc
                   { txt = Lident "::"; loc }
                   (Some (Exp.tuple ~loc [tuple; e]));
               | Rule.At_rule ar ->
                 grammar_error ar.At_rule.loc "Unexpected at-rule in @keyframes body"
            )
            (Exp.construct ~loc:end_loc
               { txt = Lident "[]"; loc = end_loc }
               None)
            (List.rev rs) in
        Exp.apply ~loc:ar.At_rule.loc ident [(Nolabel, arg)]
      | _ -> assert false
    end
  | (n, _) ->
    grammar_error ar.At_rule.loc ("At-rule @" ^ n ^ " not supported")

and render_declaration mode (d: Declaration.t) (d_loc: Location.t) : expression =
  let open Component_value in
  let rcv = render_component_value mode in
  let (name, name_loc) = d.Declaration.name in

  (* https://developer.mozilla.org/en-US/docs/Web/CSS/animation *)
  let render_animation () =
    let animation_ident =
      Exp.ident ~loc:name_loc { txt = Ldot (Lident "Animation", "shorthand"); loc = name_loc } in
    let animation_args (grouped_param, _) =
      List.fold_left
        (fun args ((v, loc) as cv) ->
           if is_time v then
             if not (List.exists (function (Labelled "duration", _) -> true | _ -> false) args) then
               (Labelled "duration", rcv cv) :: args
             else if not (List.exists (function (Labelled "delay", _) -> true | _ -> false) args) then
               (Labelled "delay", rcv cv) :: args
             else grammar_error loc "animation canot have more than 2 time values"
           else if is_timing_function v then
             (Labelled "timingFunction", rcv cv) :: args
           else if is_animation_iteration_count v then
             (Labelled "iterationCount", rcv cv) :: args
           else if is_animation_direction v then
             (Labelled "direction", rcv cv) :: args
           else if is_animation_fill_mode v then
             (Labelled "fillMode", rcv cv) :: args
           else if is_animation_play_state v then
             (Labelled "playState", rcv cv) :: args
           else if is_keyframes_name v then
             let s = match v with | Ident s | String s -> s | _ -> assert false in
             let i = Exp.ident ~loc { txt = Lident s; loc } in
             (Nolabel, i) :: args
           else grammar_error loc "Unexpected animation value"
        )
        []
        grouped_param
    in
    let (params, _) = d.Declaration.value in
    let grouped_params = group_params params in
    let args =
      List.rev_map
        (fun params -> animation_args params)
        grouped_params in
    let ident = Exp.ident ~loc:name_loc { txt = Lident "animations"; loc = name_loc } in
    let box_shadow_list =
      List.map
        (fun arg -> Exp.apply animation_ident arg)
        args in
    Exp.apply ident [(Nolabel, list_to_expr name_loc box_shadow_list)]
  in

  (* https://developer.mozilla.org/en-US/docs/Web/CSS/box-shadow *)
  let render_box_shadow () =
    let box_shadow_args args ((v, loc) as cv) =
      if is_ident "inset" v then
        (Labelled "inset",
         (Exp.construct ~loc
            { txt = Lident "true"; loc }
            None)) :: args
      else if is_length v then
        if not (List.exists (function (Labelled "x", _) -> true | _ -> false) args) then
          (Labelled "x", rcv cv) :: args
        else if not (List.exists (function (Labelled "y", _) -> true | _ -> false) args) then
          (Labelled "y", rcv cv) :: args
        else if not (List.exists (function (Labelled "blur", _) -> true | _ -> false) args) then
          (Labelled "blur", rcv cv) :: args
        else if not (List.exists (function (Labelled "spread", _) -> true | _ -> false) args) then
          (Labelled "spread", rcv cv) :: args
        else grammar_error loc "box-shadow cannot have more than 4 length values"
      else if is_color v then
        (Nolabel, rcv cv) :: args
      else grammar_error loc "Unexpected box-shadow value"
    in
    let txt =
      if mode = Bs_css then (Longident.Ldot (Longident.Lident "Shadow", "box"))
      else (Longident.Lident "shadow") in
    let box_shadow_ident =
      Exp.ident ~loc:name_loc { txt; loc = name_loc } in
    let box_shadow_args (grouped_param, _) =
      List.fold_left
        box_shadow_args
        []
        grouped_param
    in
    let (params, _) = d.Declaration.value in
    let grouped_params = group_params params in
    let args =
      List.rev_map
        (fun params -> box_shadow_args params)
        grouped_params in
    let ident = Exp.ident ~loc:name_loc { txt = Lident "boxShadows"; loc = name_loc } in
    let box_shadow_list =
      List.map
        (fun arg -> Exp.apply box_shadow_ident arg)
        args in
    Exp.apply ident [(Nolabel, list_to_expr name_loc box_shadow_list)]
  in

  (* https://developer.mozilla.org/en-US/docs/Web/CSS/text-shadow *)
  let render_text_shadow () =
    let text_shadow_args args ((v, loc) as cv) =
      if is_ident "inset" v then
        (Labelled "inset",
        (Exp.construct ~loc
           { txt = Lident "true"; loc }
           None)) :: args
      else if is_length v then
        if not (List.exists (function (Labelled "x", _) -> true | _ -> false) args) then
          (Labelled "x", rcv cv) :: args
      else if not (List.exists (function (Labelled "y", _) -> true | _ -> false) args) then
        (Labelled "y", rcv cv) :: args
        else if not (List.exists (function (Labelled "blur", _) -> true | _ -> false) args) then
          (Labelled "blur", rcv cv) :: args
      else grammar_error loc "box-shadow cannot have more than 3 length values"
        else if is_color v then
          (Nolabel, rcv cv) :: args
      else grammar_error loc "Unexpected box-shadow value"
    in
    let text_shadow_ident =
      Exp.ident ~loc:name_loc { txt = Ldot (Lident "Shadow", "text"); loc = name_loc } in
    let text_shadow_args (grouped_param, _) =
      List.fold_left
        text_shadow_args
        []
        grouped_param
    in
    let (params, _) = d.Declaration.value in
    let grouped_params = group_params params in
    let args =
      List.rev_map
        (fun params -> text_shadow_args params)
        grouped_params in
    let ident = Exp.ident ~loc:name_loc { txt = Lident "textShadows"; loc = name_loc } in
    let text_shadow_list =
      List.map
        (fun arg -> Exp.apply text_shadow_ident arg)
        args in
    Exp.apply ident [(Nolabel, list_to_expr name_loc text_shadow_list)]
  in

  (* https://developer.mozilla.org/en-US/docs/Web/CSS/transition *)
  let render_transition () =
    let transition_ident =
      Exp.ident ~loc:name_loc { txt = Ldot (Lident "Transition", "shorthand"); loc = name_loc } in
    let render_property property loc =
      Exp.constant ~loc (Const.string property)
    in
    let transition_args (grouped_param, _) =
      List.fold_left
        (fun args ((v, loc) as cv) ->
           if is_time v then
             if not (List.exists (function (Labelled "duration", _) -> true | _ -> false) args) then
               (Labelled "duration", rcv cv) :: args
             else if not (List.exists (function (Labelled "delay", _) -> true | _ -> false) args) then
               (Labelled "delay", rcv cv) :: args
             else grammar_error loc "transition cannot have more than 2 time values"
           else if is_timing_function v then
             (Labelled "timingFunction", rcv cv) :: args
           else
             match v with
             | Ident p -> (Nolabel, render_property p loc) :: args
             | _ -> grammar_error loc "Unexpected transition value"
        )
        []
        grouped_param
    in
    let (params, _) = d.Declaration.value in
    let grouped_params = group_params params in
    let args =
      List.rev_map
        (fun params -> transition_args params)
        grouped_params in
    let ident = Exp.ident ~loc:name_loc { txt = Lident "transitions"; loc = name_loc } in
    let transition_list =
      List.map
        (fun arg -> Exp.apply transition_ident arg)
        args in
    Exp.apply ident [(Nolabel, list_to_expr name_loc transition_list)]
  in

  let render_standard_declaration () =
    let name = to_caml_case name in
    let (vs, _) = d.Declaration.value in
    let name =
      if is_overloaded mode name then
        let parameter_count = List.length vs in
        if parameter_count > 1 then
          name ^ (string_of_int parameter_count)
        else name
      else name in
    let ident = Exp.ident ~loc:name_loc { txt = Lident name; loc = name_loc } in
    let args =
      List.map (fun v -> rcv v) vs in
    Exp.apply ~loc:d_loc ident (List.map (fun a -> (Nolabel, a)) args)
  in

  let render_transform () =
    let (vs, loc) = d.Declaration.value in
    if List.length vs = 1 then
      render_standard_declaration ()
    else
      let cvs = List.rev_map (fun v -> rcv v) vs in
      let arg = list_to_expr loc cvs in
      let ident = Exp.ident ~loc:name_loc { txt = Lident "transforms"; loc = name_loc } in
      Exp.apply ~loc:d_loc ident [Nolabel, arg]
  in

  let render_font_family () =
    let (vs, loc) = d.Declaration.value in
    match mode with
    | Bs_css ->
      let arg =
        let s =
          List.fold_left
            (fun s (v, loc) ->
              match v with
              | Ident x ->
                s ^ (if String.length s > 0 then " " else "") ^ x
              | String x ->
                s ^ (if String.length s > 0 then " " else "") ^ "\"" ^ x ^ "\""
              | Delim ("," as x) ->
                s ^ x
              | _ ->
                grammar_error loc "Unexpected font-family value"
            )
            ""
            vs
        in
        rcv ((String s), loc)
      in
      let ident =
        Exp.ident ~loc:name_loc { txt = Lident "fontFamily"; loc = name_loc } in
      Exp.apply ~loc:name_loc ident [(Nolabel, arg)]
    | Bs_typed_css ->
      let font_family_args (params, _) =
        let s =
          List.fold_left
            (fun s (v, loc) ->
              match v with
              | Ident x
              | String x ->
                s ^ (if String.length s > 0 then " " else "") ^ x
              | _ ->
                grammar_error loc "Unexpected font-family value"
            )
            ""
            params
        in
        rcv ((String s), loc)
      in
      let grouped_params = group_params vs in
      let args =
        List.rev_map
        (fun params -> font_family_args params)
        grouped_params in
      let ident =
        Exp.ident ~loc:name_loc { txt = Lident "fontFamilies"; loc = name_loc } in
      Exp.apply ~loc:name_loc ident [(Nolabel, list_to_expr name_loc args)]
  in

  let render_z_index () =
    let (vs, loc) = d.Declaration.value in
    let arg =
      if List.length vs = 1 then
        let ((v, loc) as c) = List.hd vs in
        match v with
        | Ident _ -> rcv c
        | Number _ ->
          let ident =
            Exp.ident ~loc:name_loc { txt = Lident "int"; loc = loc } in
          Exp.apply ~loc:loc ident [(Nolabel, rcv c)]
        | _ ->
          grammar_error loc "Unexpected z-index value"
      else
        grammar_error loc "z-index should have a single value"
    in
    let ident =
      Exp.ident ~loc:name_loc { txt = Lident "zIndex"; loc = name_loc } in
    Exp.apply ~loc:name_loc ident [(Nolabel, arg)]
  in

  let render_flex_grow_shrink () =
    let name = to_caml_case name in
    let (vs, loc) = d.Declaration.value in
    let arg =
      if List.length vs = 1 then
        let (v, loc) = List.hd vs in
        match v with
        | Number n ->
          Exp.constant ~loc (float_to_const n)
        | _ ->
          grammar_error loc ("Unexpected " ^ name ^ " value")
      else
        grammar_error loc (name ^ " should have a single value")
    in
    let ident =
      Exp.ident ~loc:name_loc { txt = Lident name; loc = name_loc } in
    Exp.apply ~loc:name_loc ident [(Nolabel, arg)]
  in

  let render_font_weight () =
    let (vs, loc) = d.Declaration.value in
    let arg =
      if List.length vs = 1 then
        let ((v, loc) as c) = List.hd vs in
        match v with
        | Ident _ -> rcv c
        | Number _ ->
          Exp.variant ~loc "num" (Some (rcv c))
        | _ ->
          grammar_error loc "Unexpected font-weight value"
      else
        grammar_error loc "font-weight should have a single value"
    in
    let ident =
      Exp.ident ~loc:name_loc { txt = Lident "fontWeight"; loc = name_loc } in
    Exp.apply ~loc:name_loc ident [(Nolabel, arg)]
  in

  let render_border_outline_2 () =
    let border_outline_args params _ =
      List.fold_left
        (fun args ((v, loc) as cv) ->
           if is_line_width v then
             (Labelled "width", rcv cv) :: args
           else if is_line_style v then
             (Nolabel, rcv cv) :: args
           else if is_color v then
             (Labelled "color", rcv cv) :: args
           else grammar_error loc ("Unexpected " ^ name ^ " value")
        )
        []
        params
    in
    let (params, loc) = d.Declaration.value in
    let args = border_outline_args params loc in
    let name = to_caml_case name ^ "2" in
    let ident =
      Exp.ident ~loc:name_loc { txt = Lident name; loc = name_loc } in
    Exp.apply ident args
  in

  let render_with_labels labels =
    let name = to_caml_case name in
    let (vs,_) = d.Declaration.value in
    let parameter_count = List.length vs in
    let name =
      if parameter_count > 1
      then name ^ (string_of_int parameter_count)
      else name 
    in
    let ident =
      Exp.ident ~loc:name_loc
        { txt = Lident (name); loc = name_loc } in
    let args = List.map (fun v  -> rcv v) vs in
    Exp.apply ~loc:d_loc ident (List.mapi (
      (fun i a ->
        try
          let (_, matching_label) =
            List.find
              (fun ((params, param), _) ->
                 params = parameter_count &&
                 param = i
              )
              labels
          in
          (Labelled matching_label, a)
        with Not_found -> (Nolabel, a)
      )
    ) args)
  in

  match name with
  | "animation" when mode = Bs_css ->
    render_animation ()
  | "box-shadow" ->
    render_box_shadow ()
  | "text-shadow" when mode = Bs_css ->
    render_text_shadow ()
  | "transform" when mode = Bs_css ->
    render_transform ()
  | "transition" when mode = Bs_css ->
    render_transition ()
  | "font-family" ->
    render_font_family ()
  | "z-index" when mode = Bs_typed_css ->
    render_z_index ()
  | "flex-grow"
  | "flex-shrink" when mode = Bs_css ->
    render_flex_grow_shrink ()
  | "font-weight" when mode = Bs_css ->
    render_font_weight ()
  | "padding"
  | "margin" ->
    render_with_labels [
      ((2, 0), "v");
      ((2, 1), "h");
      ((3, 0), "top");
      ((3, 1), "h");
      ((3, 2), "bottom");
      ((4, 0), "top");
      ((4, 1), "right");
      ((4, 2), "bottom");
      ((4, 3), "left");
    ]
  | "border-top-right-radius"
  | "border-top-left-radius"
  | "border-bottom-right-radius"
  | "border-bottom-left-radius" when mode = Bs_typed_css ->
    render_with_labels [
      ((2, 0), "v");
      ((2, 1), "h");
    ]
  | "background-position"
  | "transform-origin" when mode = Bs_typed_css ->
    render_with_labels [
      ((2, 0), "h");
      ((2, 1), "v");
    ]
  | "flex" when mode = Bs_typed_css ->
    render_with_labels [
      ((3, 0), "grow");
      ((3, 1), "shrink");
    ]
  | "border"
  | "outline" when mode = Bs_typed_css &&
                   List.length (fst d.Declaration.value) = 2 ->
    render_border_outline_2 ()
  | _ ->
    render_standard_declaration ()

and render_declarations mode (ds: Declaration_list.kind list) : expression list =
  List.rev_map
    (fun declaration ->
       match declaration with
       | Declaration_list.Declaration decl ->
         render_declaration mode decl decl.loc
       | Declaration_list.At_rule ar ->
         render_at_rule mode ar
    )
    ds

and render_declaration_list mode ((dl, loc): Declaration_list.t) : expression =
  let expr_with_loc_list = render_declarations mode dl in
  list_to_expr loc expr_with_loc_list

and render_style_rule mode (sr: Style_rule.t) : expression =
  let (prelude, prelude_loc) = sr.Style_rule.prelude in
  let selector =
    List.fold_left
      (fun s (value, value_loc) ->
         match value with
         | Component_value.Delim ":" -> ":" ^ s
         | Ident v
         | Operator v
         | Delim v -> if String.length s > 0 then v ^ " " ^ s else v ^ s
         | _ ->
           grammar_error value_loc "Unexpected selector"
      )
      ""
      (List.rev prelude) in
  let selector_expr = string_to_const ~loc:prelude_loc selector in
  let dl_expr = render_declaration_list mode sr.Style_rule.block in
  let lident =
    match mode with
    | Bs_css -> "selector"
    | Bs_typed_css -> "select" in
  let ident = Exp.ident ~loc:prelude_loc { txt = Lident lident; loc = prelude_loc } in
  Exp.apply ~loc:sr.Style_rule.loc ident [(Nolabel, selector_expr); (Nolabel, dl_expr)]

and render_rule mode (r: Rule.t) : expression =
  match r with
  | Rule.Style_rule sr -> render_style_rule mode sr
  | Rule.At_rule ar -> render_at_rule mode ar

and render_stylesheet mode ((rs, loc): Stylesheet.t) : expression =
  let rule_expr_list =
    List.rev_map
      (fun rule ->
         match rule with
         | Rule.Style_rule { Style_rule.prelude = ([], _);
                             block = (ds, _);
                             loc = _;
                           } ->
           render_declarations mode ds
         | Rule.Style_rule _
         | Rule.At_rule _ ->
           [render_rule mode rule]
      )
      rs |> List.concat in
  list_to_expr loc rule_expr_list
