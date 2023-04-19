let append_to_list = [%style_label []];
let append_to_css_apply = [%style_label [CssJs.block(`blue)]];
let css_apply_multiple = [%style_label [prop("1"), prop("2")]];
let should_not_touch_this = style([prop("1"), prop("2")]);
let function_should_append_to_apply = argument => [%style_label
  [
    justifyContent(
      switch (argument) {
      | Left => `flexStart
      | Center => `center
      | Right => `flexEnd
      },
    ),
  ]
];

let function_should_append_to_apply = (argument1, argument2) => [%style_label
  [
    justifyContent(
      switch (argument1, argument2) {
      | Left => `flexStart
      | Center => `center
      | Right => `flexEnd
      },
    ),
  ]
];

let cosis =
  switch%style_label (whatever) {
  | True => [Css.color(Css.blue)]
  | False => []
  };
