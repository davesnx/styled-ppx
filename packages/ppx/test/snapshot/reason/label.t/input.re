let%label css_apply = css([CssJs.block(`blue)]);
let%label css_apply_with_empty = css([]);
let%label css_apply_multiple = css([prop("1"), prop("2")]);
let%label should_complain = [prop("1"), prop("2")];
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
