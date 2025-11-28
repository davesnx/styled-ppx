  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-diagnose -bs-no-version-header -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml
  [127]

Since OCaml syntax doesn't support escaping reserved keywords (e.g `as`) ], we replace them to make the test pass
  $ sed -e 's/as:/as_:/g' -e 's/props.as/props.as_/g' output.ml > fixed.ml

  $ npx rescript convert fixed.ml
  npx: command not found
  [127]
