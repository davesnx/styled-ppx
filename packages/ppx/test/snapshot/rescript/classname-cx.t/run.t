  $ bsc -ppx styled-ppx -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

No clue why bsc generates a invalid syntax, but it does. This removes this particual bit.
  $ sed -e 's/.I1//g' output.ml > fixed.ml

  $ rescript convert fixed.ml

  $ cat fixed.res
  let className = CssJs.style(. [CssJs.label("className"), CssJs.display(#block)])
  let classNameWithMultiLine = CssJs.style(. [
    CssJs.label("classNameWithMultiLine"),
    CssJs.display(#block),
  ])
  let classNameWithArray = CssJs.style(. [CssJs.label("classNameWithArray"), cssProperty])
