`--layers` no longer exists: `styled-ppx.generate` emits no cascade layer at
all (see `no-layers.t`), so there is nothing left to nest a library's rules
inside. The flag is rejected the same way any other unrecognized flag is -
no special-cased error message for it.

  $ cat > a.ml <<EOF
  > [@@@css ".a{color:red;}"]
  > EOF

  $ styled-ppx.generate --layers a.ml
  styled-ppx: unknown flag "--layers"
  [2]

Flag position doesn't matter: it is still the first unrecognized flag
`parse_args` reaches, whether it comes before or after a real one.

  $ styled-ppx.generate --order source --layers a.ml
  styled-ppx: unknown flag "--layers"
  [2]
