  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

Since OCaml syntax doesn't support escaping reserved keywords (e.g `as`) ], neither *j in stirngs. We replace them to make the test pass
  $ sed -e 's/as:/as_:/g' -e 's/props.as/props.as_/g' -e 's/*j/js/g' output.ml > fixed.ml

  $ npx rescript convert fixed.ml







