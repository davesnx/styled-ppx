  $ bsc -ppx "rewriter --jsx-version 4" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

  $ rescript convert output.ml
  Error when converting output.ml
  File "", line 23, characters 29-30:
  Error: Syntax error: operator expected.
  

