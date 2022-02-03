let replace = (before, after, name) =>
  name |> String.split_on_char(before) |> String.concat(after);

let name = name => name |> replace('-', "_");

let variant = name =>
  /* TODO: Discover why we are receivng `_` instead of `-` */
  switch (name) {
  | "_" => "dash"
  | _ =>
    name
    |> replace('+', "cross")
    |> replace('-', "dash")
    |> replace('*', "asterisk")
    |> replace('/', "bar")
    |> replace('@', "at")
  };
