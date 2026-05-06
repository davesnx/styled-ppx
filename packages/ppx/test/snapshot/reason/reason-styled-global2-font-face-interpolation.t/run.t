  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "@font-face {font-family:\"Inter\";src:url(var(--var-1316rv9)) format(\"woff2\");font-display:swap;}"
  ];
  let inter_url = "https://cdn.example.com/fonts/inter.woff2";
  module Fonts = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-1316rv9:") ++ CSS.Types.Url.toString(inter_url))
        ++ ";"
      )
      ++ "}";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    let make = () => CSS.global_style_tag(to_string());
  };
