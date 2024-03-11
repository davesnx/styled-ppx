  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

Since OCaml syntax doesn't support escaping reserved keywords (e.g `as`) ], we replace them to make the test pass
  $ sed -e 's/as:/as_:/g' -e 's/props.as/props.as_/g' output.ml > fixed.ml

No clue why bsc generates a invalid syntax, but it does. This removes this particual bit.
  $ sed -i 's/\*j//g' fixed.ml

  $ npx rescript convert fixed.ml







