Regression guard: the SAME [%styled.global] module compiled from two different
file paths must mint the SAME `var(--…)` name.

This is the cross-build invariant. A shared global stylesheet is routinely
compiled twice under different paths - Dune `copy_files` into a Melange build
dir, vendoring, or a native (SSR) build plus a Melange (client) build of one
file. The interpolation variable is namespaced on the compilation-unit module
name (`Global_Css`), not the physical path, so both builds agree: the
statically extracted `body{color:var(--X)}` rule and the
`:root{--X:…}` binding emitted by the runtime `to_string` reference the
same custom property.

Before the fix the physical path was folded into the namespace, so
`native/Global_Css` and `js/Global_Css` produced different vars; the static
rule extracted by one build then pointed at a custom property the other
build's runtime `:root{}` never defined, and the declaration silently fell
back.

Compile the byte-identical source under two distinct paths sharing the
basename:

  $ mkdir -p native js
  $ cp Global_Css.re native/Global_Css.re
  $ cp Global_Css.re js/Global_Css.re
  $ refmt --parse re --print ml native/Global_Css.re > native/Global_Css.ml
  $ ../../standalone.exe --impl native/Global_Css.ml -o native/Global_Css.ml
  $ refmt --parse re --print ml js/Global_Css.re > js/Global_Css.ml
  $ ../../standalone.exe --impl js/Global_Css.ml -o js/Global_Css.ml

The static rule and the runtime :root binding reference the same variable, and
the PPX output is byte-identical across both paths:

  $ refmt --parse ml --print re native/Global_Css.ml
  [@css "body{color:var(--primary-uvgzxa);}"];
  let primary = CSS.red;
  module Styles = {
    let to_string = () =>
      (
        ((":root{" ++ "--primary-uvgzxa:") ++ CSS.Types.Color.toString(primary))
        ++ ";"
      )
      ++ "}";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  $ diff native/Global_Css.ml js/Global_Css.ml
