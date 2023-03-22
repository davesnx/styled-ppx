  $ bsc -ppx styled-ppx -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-super-errors -color never -dsource input.res 2> output.ml

No clue why bsc generates a invalid syntax, but it does. This removes this particual bit.
  $ sed -e 's/.I1//g' output.ml > fixed.ml

  $ rescript convert fixed.ml

  $ cat fixed.res
  let className: _ = Js.Internal.opaqueFullApply(
    Js.Internal.opaque((CssJs.style: Js.Fn.arity1<_>))([
      CssJs.label("className"),
      CssJs.display(#block),
    ]),
  )
  let classNameWithMultiLine: _ = Js.Internal.opaqueFullApply(
    Js.Internal.opaque((CssJs.style: Js.Fn.arity1<_>))([
      CssJs.label("classNameWithMultiLine"),
      CssJs.display(#block),
    ]),
  )
  let classNameWithArray: _ = Js.Internal.opaqueFullApply(
    Js.Internal.opaque((CssJs.style: Js.Fn.arity1<_>))([
      CssJs.label("classNameWithArray"),
      cssProperty,
    ]),
  )
  let cssRule = CssJs.color(CssJs.blue)
  let classNameWithCss: _ = Js.Internal.opaqueFullApply(
    Js.Internal.opaque((CssJs.style: Js.Fn.arity1<_>))([
      CssJs.label("classNameWithCss"),
      cssRule,
      CssJs.backgroundColor(CssJs.green),
    ]),
  )
