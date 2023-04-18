  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  let append_to_list = [label("append_to_list")];
  let append_to_apply_list = any([label("append_to_apply_list")]);
  let ignore_array = [||];
  let ignore_array = any([||]);
  let append_to_css_apply =
    css([CssJs.block(`blue), label("append_to_css_apply")]);
  let css_apply_multiple =
    css([prop("1"), prop("2"), label("css_apply_multiple")]);
  let should_render_custom_ident =
    Css.style([prop("1"), prop("2"), label("should_render_custom_ident")]);
  let should_not_touch_this = css([prop("1"), prop("2")]);
  let function_should_append_to_apply = argument =>
    style([
      justifyContent(
        switch (argument) {
        | Left => `flexStart
        | Center => `center
        | Right => `flexEnd
        },
      ),
      label("function_should_append_to_apply"),
    ]);
  let function_should_append_to_apply = (argument1, argument2) =>
    style([
      justifyContent(
        switch (argument1, argument2) {
        | Left => `flexStart
        | Center => `center
        | Right => `flexEnd
        },
      ),
      label("function_should_append_to_apply"),
    ]);
  let cosis =
    switch (whatever) {
    | True => style([label("cosis")])
    | False => style([label("cosis")])
    };
  let cosis =
    style(
      switch (whatever) {
      | True => [Css.color(Css.blue), label("cosis")]
      | False => [label("cosis")]
      },
    );
