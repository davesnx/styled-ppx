module Builder = Ppxlib.Ast_builder.Default;

let expr = (~loc, str) => {
  Builder.pexp_extension(~loc) @@
  Ppxlib.Location.Error.to_extension @@
  Ppxlib.Location.Error.make(~loc, str, ~sub=[]);
};

let raise = (~loc, ~description, ~example, ~link) => {
  let error =
    switch (example) {
    | Some(e) =>
      Ppxlib.Location.raise_errorf(
        ~loc,
        "%s\n\n%s\n\nMore info: %s",
        description,
        e,
        link,
      )
    | None =>
      Ppxlib.Location.raise_errorf(
        ~loc,
        "%s\n\nMore info: %s",
        description,
        link,
      )
    };

  raise(error);
};
