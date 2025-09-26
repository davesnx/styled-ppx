let css main =
  CSS.make "css-3tpy8b css-1uzc9um css-17vxl0k"
    [("--var-19ja411", (CSS.get_value_from_rule (CSS.color main)));
    ("--var-1xt8d8f",
      (CSS.get_value_from_rule (CSS.backgroundColor CSS.black)))]
;;((div ~className:(css CSS.red) ~children:[] ())[@JSX ])
[@@@EXTRACT_CSS
  ".css-3tpy8b { color: var(--var-19ja411); }\n.css-1uzc9um { background-color: var(--var-1xt8d8f); }\n.css-17vxl0k { display: flex; }\n"]
