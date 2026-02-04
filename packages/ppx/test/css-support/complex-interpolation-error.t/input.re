type size =
  | Big
  | Small

let prop = Big

let color = [%cx
  {|
  color: $(match prop with | Big -> `red | Small -> `blue);
|}
]
