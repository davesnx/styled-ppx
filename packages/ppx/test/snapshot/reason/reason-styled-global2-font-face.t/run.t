  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "@font-face {font-family:\"Inter\";src:url(\"/fonts/inter.woff2\") format(\"woff2\");font-display:swap;font-weight:400;font-style:normal;}"
  ];
  [@css
    "@font-face {font-family:\"Inter\";src:url(\"/fonts/inter-bold.woff2\") format(\"woff2\");font-display:swap;font-weight:700;font-style:normal;}"
  ];
  module Fonts = {
    let to_string = () => "";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    let make = () => CSS.global_style_tag(to_string());
  };
