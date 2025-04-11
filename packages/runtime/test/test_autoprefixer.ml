[@@@warning "-32"]

let prefix_one_declaration declaration output =
  let hash = CSS.style [| declaration |] in
  let css = CSS.get_stylesheet () in
  let _ = CSS.flush () in
  assert_string css (Printf.sprintf ".%s { %s }" hash output)

let text_size_adjust =
  test "text_size_adjust" (fun () ->
    prefix_one_declaration
      (CSS.unsafe "text-size-adjust" "none")
      "-webkit-text-size-adjust: none; -moz-text-size-adjust: none; \
       -ms-text-size-adjust: none; text-size-adjust: none;")

let text_decoration =
  test "text_decoration" (fun () ->
    prefix_one_declaration
      (CSS.textDecorations
         ~line:(CSS.Types.TextDecorationLine.Value.make ~lineThrough:true ())
         ())
      "-webkit-text-decoration: line-through; text-decoration: line-through;")

let display_grid =
  test "display_grid" (fun () ->
    prefix_one_declaration (CSS.display `grid) "display: grid;")

let animation_duration =
  test "animation_duration" (fun () ->
    prefix_one_declaration
      (CSS.animationIterationCount `infinite)
      "-webkit-animation-iteration-count: infinite; animation-iteration-count: \
       infinite;")

let backdrop_filter =
  test "backdrop_filter" (fun () ->
    prefix_one_declaration
      (CSS.backdropFilter [| `blur (`px 30) |])
      "-webkit-backdrop-filter: blur(30px); backdrop-filter: blur(30px);")

let tests =
  ( "Autoprefixer",
    [
      text_size_adjust;
      text_decoration;
      display_grid;
      animation_duration;
      backdrop_filter;
    ] )
