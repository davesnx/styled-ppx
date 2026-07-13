REGRESSION TEST — [%styled.global] does not deduplicate one binding across
different CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{background:var(--bg-14wr489);color:var(--bg-1m147kf);}"];
  let bg: CSS.Types.Background.t = `color(CSS.red);
  module Theme = {
    let to_string = () =>
      (
        (
          (
            (
              (
                (":root{" ++ "--bg-14wr489:")
                ++ CSS.Types.Background.toString(bg)
              )
              ++ ";"
            )
            ++ "--bg-1m147kf:"
          )
          ++ CSS.Types.Color.toString(bg)
        )
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
