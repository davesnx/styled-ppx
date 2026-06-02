  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "header{color:var(--var-p73s17);}"];
  [@css "footer{background-color:var(--var-p73s17);}"];
  let accent = CSS.blue;
  module HeaderStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-p73s17:") ++ CSS.Types.Color.toString(accent))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
  module FooterStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-p73s17:") ++ CSS.Types.Color.toString(accent))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
