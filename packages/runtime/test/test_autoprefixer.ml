let prefix_one_declaration declaration output =
  let hash = CSS.style [| declaration |] in
  let css = CSS.get_stylesheet () in
  let _ = CSS.flush () in
  assert_string css (Printf.sprintf ".%s { %s }" hash output)

let text_size_adjust () =
  prefix_one_declaration
    (CSS.unsafe "text-size-adjust" "none")
    "-webkit-text-size-adjust: none; -moz-text-size-adjust: none; \
     -ms-text-size-adjust: none; text-size-adjust: none;"

let text_decoration () =
  prefix_one_declaration
    (CSS.textDecorations
       ~line:(CSS.Types.TextDecorationLine.Value.make ~lineThrough:true ())
       ())
    "-webkit-text-decoration: line-through; text-decoration: line-through;"

let display_grid () =
  prefix_one_declaration (CSS.display `grid) "display: grid;"

let animation_duration () =
  prefix_one_declaration
    (CSS.animationIterationCount `infinite)
    "-webkit-animation-iteration-count: infinite; animation-iteration-count: \
     infinite;"

let backdrop_filter () =
  prefix_one_declaration
    (CSS.backdropFilter [| `blur (`px 30) |])
    "-webkit-backdrop-filter: blur(30px); backdrop-filter: blur(30px);"

let tests =
  [
    test "text_size_adjust" text_size_adjust;
    test "text_decoration" text_decoration;
    test "display_grid" display_grid;
    test "animation_duration" animation_duration;
    test "backdrop_filter" backdrop_filter;
  ]
