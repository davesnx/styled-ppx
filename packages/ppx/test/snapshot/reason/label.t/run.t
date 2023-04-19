  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let append_to_list = style([label("append_to_list")]);
  let append_to_css_apply =
    style([label("append_to_css_apply"), CssJs.block(`blue)]);
  let css_apply_multiple =
    style([label("css_apply_multiple"), prop("1"), prop("2")]);
  let should_not_touch_this = style([prop("1"), prop("2")]);
  let function_should_append_to_apply = argument =>
    style([
      label("function_should_append_to_apply"),
      justifyContent(
        switch (argument) {
        | Left => `flexStart
        | Center => `center
        | Right => `flexEnd
        },
      ),
    ]);
  let function_should_append_to_apply = (argument1, argument2) =>
    style([
      label("function_should_append_to_apply"),
      justifyContent(
        switch (argument1, argument2) {
        | Left => `flexStart
        | Center => `center
        | Right => `flexEnd
        },
      ),
    ]);
  let cosis =
    switch%style_label (whatever) {
    | True => [Css.color(Css.blue)]
    | False => []
    };
