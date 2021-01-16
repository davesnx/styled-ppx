let replace = (before, after, name) =>
  name |> String.split_on_char(before) |> String.concat(after);

let name = name => name |> replace('-', "_");

let variant = name =>
  name
  |> replace('+', "cross")
  |> replace('-', "dash")
  |> replace('*', "asterisk")
  |> replace('/', "bar")
  |> replace('@', "at");
