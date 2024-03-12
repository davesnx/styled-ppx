  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  ignore(
    CssJs.global([|
      CssJs.selector(
        {js|html, body, #root, .class|js},
        [|CssJs.margin(`zero)|],
      ),
    |]),
  );
