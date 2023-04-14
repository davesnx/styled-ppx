  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [%%ocaml.error "apply expected"];
  let css_apply = css([label("css_apply"), CssJs.block(`blue)]);
  let css_apply_with_empty = css([label("css_apply_with_empty")]);
  let css_apply_multiple =
    css([label("css_apply_multiple"), prop("1"), prop("2")]);
  let%label should_complain = [prop("1"), prop("2")];
  let should_render_custom_ident =
    Css.style([label("should_render_custom_ident"), prop("1"), prop("2")]);
  let should_not_touch_this = css([prop("1"), prop("2")]);
  let function_should_append_to_apply =
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
