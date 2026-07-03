Custom-property declarations in [%styled.global] accept any string
interpolation verbatim - no Cascading.toString wrap.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ":root{--color-primary:var(--var-eweeub);--gutter:var(--var-nbps89);}"];
  let primary = CSS.Types.Color.toString(`hex("3A57FC"));
  let gutter = "16px";
  module Theme = {
    let to_string = () =>
      (
        (
          ((((":root{" ++ "--var-eweeub:") ++ primary) ++ ";") ++ "--var-nbps89:")
          ++ gutter
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
