Custom-property declarations in [%styled.global] accept any string
interpolation verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ":root{--color-primary:var(--var-1v6enne);--gutter:var(--var-f6kk0p);}"];
  let primary = CSS.Types.Color.toString(`hex("3A57FC"));
  let gutter = "16px";
  module Theme = {
    let to_string = () =>
      (
        (
          (
            (((":root{" ++ "--var-1v6enne:") ++ primary) ++ ";")
            ++ "--var-f6kk0p:"
          )
          ++ gutter
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
