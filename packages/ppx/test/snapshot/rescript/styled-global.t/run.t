  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

  $ cat output.ml
  ;;ignore
      (CssJs.global
         [|(CssJs.selector (({*j|html, body, #root, .class|*j})
              [@res.template ]) [|(CssJs.margin `zero)|])|])

  $ sed -e 's/\*j//g' output.ml > fixed.ml

  $ npx rescript convert output.ml
