Malformed atoms payloads are protocol errors.

  $ cat > a.ml <<EOT
  > [@@@css.atoms [("_a", 1)]]
  > EOT

  $ styled-ppx.generate a.ml
  styled-ppx: a.ml: malformed [@@@css.atoms]: malformed css.atoms payload at entry 0: expected (cls, rules, tier, conds, cover, hashes) tuple
  [1]

An unterminated sentinel in an atom rule names the atoms attribute.

  $ cat > b.ml <<EOT
  > [@@@css.atoms [("_c0aswitch", [".\000A.x{color:red}"], 0, 0, 1, [])]]
  > EOT

  $ styled-ppx.generate b.ml
  styled-ppx: b.ml: malformed [@@@css.atoms]: unterminated cross-module selector sentinel
  [1]
