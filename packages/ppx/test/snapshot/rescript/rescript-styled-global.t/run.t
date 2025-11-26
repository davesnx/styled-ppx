  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res
  npx: command not found
  [127]

Since OCaml syntax doesn't support *j in strings. We replace them to make the test pass
  $ sed -e 's/*j/js/g' output.ml > fixed.ml
  sed: output.ml: No such file or directory
  [1]

  $ npx rescript convert fixed.ml
  npx: command not found
  [127]
