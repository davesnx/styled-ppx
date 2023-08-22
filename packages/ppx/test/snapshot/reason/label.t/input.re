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
let empty = [%style_label []];

type t =
  | A
  | B;

let fn1 = x =>
  switch%style_label (x) {
  | A => [prop("a")]
  | B => [prop("b")]
  };

let fn2 = (x, y) =>
  switch%style_label (x) {
  | A when y => [prop("ay")]
  | A => [prop("a")]
  | B when y => [prop("by")]
  | B => [prop("b")]
  };

let className = [%cx {|
      font-size: 28px;
    |}];

let fn = () => {
  let className = [%cx
    {|
        margin-bottom: 4px;
        font-size: 28px;
      |}
  ];

  className;
};
