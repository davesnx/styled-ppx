  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

  $ cat output.ml
  ;;ignore
      (CssJs.global (({*j|html, body, #root, .class|*j})[@res.template ])
         [|(CssJs.margin `zero)|])

  $ npx rescript convert output.ml
  Error when converting output.ml
  File "", line 2, characters 22-23:
  Error: Syntax error: operator expected.
  









