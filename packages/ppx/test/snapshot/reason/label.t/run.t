  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [%%ocaml.error "apply expected"];
  let css_apply = css([CssJs.label("css_apply"), CssJs.block(`blue)]);
  let css_apply_with_empty = css([CssJs.label("css_apply_with_empty")]);
  let css_apply_multiple =
    css([CssJs.label("css_apply_multiple"), prop("1"), prop("2")]);
  let%label should_complain = [prop("1"), prop("2")];
  [%expr
    [%ocaml.error
      "The 'label' extension expects a css call with a list of \
                    declarations, e.g. `let%%label foo = css([])`"
    ]
  ];
  let should_not_touch_this = css([prop("1"), prop("2")]);
