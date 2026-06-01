REGRESSION TEST — pins KNOWN-BROKEN cross-property dedup in
[%styled.global]. See input.re for the full rationale. A future
fix MUST update this snapshot intentionally.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{background:var(--var-ivms5p);color:var(--var-ivms5p);}"];
  let bg: CSS.Types.Background.t = `color(CSS.red);
  module Theme = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-ivms5p:") ++ CSS.Types.Background.toString(bg))
        ++ ";"
      )
      ++ "}";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
