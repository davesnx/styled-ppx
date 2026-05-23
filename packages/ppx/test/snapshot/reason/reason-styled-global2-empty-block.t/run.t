  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module EmptyStyles = {
    let to_string = () => "";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
  };
  module CommentOnly = {
    let to_string = () => "";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
  };
