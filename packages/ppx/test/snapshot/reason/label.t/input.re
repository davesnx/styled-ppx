let%label append_to_list = [];
let%label append_to_apply_list = any([]);
let%label ignore_array = [||];
let%label ignore_array = any([||]);

let%label append_to_css_apply = css([CssJs.block(`blue)]);
let%label css_apply_multiple = css([prop("1"), prop("2")]);
let%label should_render_custom_ident = Css.style([prop("1"), prop("2")]);
let should_not_touch_this = css([prop("1"), prop("2")]);
let%label function_should_append_to_apply = argument =>
  style([
    justifyContent(
      switch (argument) {
      | Left => `flexStart
      | Center => `center
      | Right => `flexEnd
      },
    ),
  ]);

let%label function_should_append_to_apply = (argument1, argument2) =>
  style([
    justifyContent(
      switch (argument1, argument2) {
      | Left => `flexStart
      | Center => `center
      | Right => `flexEnd
      },
    ),
  ]);

let%label cosis =
  switch (whatever) {
  | True => style([])
  | False => style([])
  };

let%label cosis =
  style(
    switch (whatever) {
    | True => [Css.color(Css.blue)]
    | False => []
    },
  );
