One class with two different rule sets fails the build.

  $ cat > a.ml <<EOT
  > [@@@css.atoms [("_x", ["._x{color:red}"], 1, 0, 1, [])]]
  > EOT

  $ cat > b.ml <<EOT
  > [@@@css.atoms [("_x", ["._x{color:blue}"], 1, 0, 1, [])]]
  > EOT

  $ styled-ppx.generate a.ml b.ml
  styled-ppx: class `_x` has two different rule sets: ._x{color:red} in a.ml and ._x{color:blue} in b.ml
  [1]
