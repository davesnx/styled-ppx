REGRESSION TEST — [%styled.global] does not deduplicate one binding across
different CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{background:var(--var-7p3efj);color:var(--var-18pexj3);}"];
  let bg: CSS.Types.Background.t = `color(CSS.red);
  module Theme = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (":root{" ++ "--var-7p3efj:")
                ++ CSS.Types.Background.toString(bg)
              )
              ++ ";"
            )
            ++ "--var-18pexj3:"
          )
          ++ CSS.Types.Color.toString(bg)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
