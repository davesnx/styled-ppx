`--layers` requires the dependency order: there are no library groups in
source-file order, so combining the two flags is rejected up front.

  $ cat > a.ml <<EOF
  > [@@@css ".a{color:red;}"]
  > EOF

  $ styled-ppx.generate --layers --order source a.ml
  styled-ppx: --layers requires --order dependency: source order has no library groups to layer
  [2]

Flag order doesn't matter.

  $ styled-ppx.generate --order source --layers a.ml
  styled-ppx: --layers requires --order dependency: source order has no library groups to layer
  [2]
