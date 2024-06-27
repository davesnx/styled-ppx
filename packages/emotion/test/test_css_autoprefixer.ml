let prefix_one_declaration declaration output =
  let hash = Css.style [ declaration ] in
  let css = Css.render_style_tag () in
  let _ = Css.flush () in
  assert_string css (Printf.sprintf ".%s { %s }" hash output)

let text_size_adjust =
  test "text_size_adjust" (fun () ->
      prefix_one_declaration
        (Css.unsafe "text-size-adjust" "none")
        "-webkit-text-size-adjust: none; -moz-text-size-adjust: none; \
         -ms-text-size-adjust: none; text-size-adjust: none;")

let text_decoration =
  test "text_decoration" (fun () ->
      prefix_one_declaration
        (Css.textDecoration `lineThrough)
        "-webkit-text-decoration: line-through; text-decoration: line-through;")

let display_grid =
  test "display_grid" (fun () ->
      prefix_one_declaration (Css.display `grid) "display: grid;")

let animation_duration =
  test "animation_duration" (fun () ->
      prefix_one_declaration
        (Css.animationIterationCount `infinite)
        "-webkit-animation-iteration-count: infinite; \
         animation-iteration-count: infinite;")

let tests =
  ( "Autoprefixer",
    [ text_size_adjust; text_decoration; display_grid; animation_duration ] )
