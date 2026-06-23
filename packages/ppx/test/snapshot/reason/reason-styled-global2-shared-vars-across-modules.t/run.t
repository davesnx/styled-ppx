  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "header{color:var(--accent-1vrtjuf);}"];
  [@css "footer{background-color:var(--accent-1ga370w);}"];
  let accent = CSS.blue;
  module HeaderStyles = {
    let to_string = () =>
      (
        ((":root{" ++ "--accent-1vrtjuf:") ++ CSS.Types.Color.toString(accent))
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
        ((":root{" ++ "--accent-1ga370w:") ++ CSS.Types.Color.toString(accent))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
