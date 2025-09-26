let css main =
  CSS.make "css-3tpy8b css-1uzc9um css-17vxl0k"
    [("--var-19ja411", (CSS.get_value_from_rule (CSS.color main)));
    ("--var-1xt8d8f",
      (CSS.get_value_from_rule (CSS.backgroundColor CSS.black)))]
;;((div ~className:(css CSS.red) ~children:[] ())[@JSX ])
