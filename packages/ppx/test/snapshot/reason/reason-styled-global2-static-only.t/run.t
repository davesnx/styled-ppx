  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "html{box-sizing:border-box;}"];
  [@css "body{margin:0;font-family:system-ui, sans-serif;}"];
  [@css "*,*::before,*::after{box-sizing:inherit;}"];
  module ResetStyles = {
    let to_string = () => "";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    let make = () => CSS.global_style_tag(to_string());
  };
