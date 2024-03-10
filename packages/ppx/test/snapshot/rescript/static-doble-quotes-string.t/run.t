  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

  $ npx rescript convert output.ml
  Error when converting output.ml
  File "", line 7, characters 7-9:
  Error: Syntax error
  





