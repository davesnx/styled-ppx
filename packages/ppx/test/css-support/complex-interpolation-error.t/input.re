type size =
  | Big
  | Small

let prop = Big

let color = [%css
  {|
  color: $(match prop with | Big -> `red | Small -> `blue);
|}
]
