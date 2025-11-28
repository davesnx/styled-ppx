  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml
  [127]

  $ cat output.ml
  /var/folders/yq/h17dmhjj3rz_6dqsnrd950gc0000gn/T/dune_cram_ea11ed_.cram.sh/1.sh: line 1: npx: command not found
