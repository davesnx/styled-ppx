REGRESSION TEST — [%styled.global] does not deduplicate one binding across
different CSS runtime types. See input.re for the full rationale.

  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{background:var(--bg-gv7w7d);color:var(--bg-1xcky)}"];
  let bg: CSS.Types.Background.t = `color(CSS.red);
  module Theme = {
    let to_string = () =>
      (
        (
          (
            (
              ((":root{" ++ "--bg-gv7w7d:") ++ CSS.Types.Background.toString(bg))
              ++ ";"
            )
            ++ "--bg-1xcky:"
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
