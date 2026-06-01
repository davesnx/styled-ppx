  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css
    "body .css-k008qs-multi.css-tokvmb-multi.css-eaeacs-multi{font-weight:bold;}"
  ];
  [@css ".css-k008qs-multi{display:flex;}"];
  [@css ".css-tokvmb-multi{color:red;}"];
  [@css ".css-eaeacs-multi{margin:10px;}"];
  [@css.bindings
    [("Output.multi", "css-k008qs-multi css-tokvmb-multi css-eaeacs-multi")]
  ];
  let multi =
    CSS.make("css-k008qs-multi css-tokvmb-multi css-eaeacs-multi", []);
  module Globals = {
    let to_string = () => "";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
