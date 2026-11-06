Malformed atoms payloads are protocol errors.

  $ cat > a.ml <<EOT
  > [@@@css.atoms [("_a", 1)]]
  > EOT

  $ styled-ppx.generate a.ml
  styled-ppx: a.ml: malformed [@@@css.atoms]: malformed css.atoms payload at entry 0: expected (cls, rules, tier, conds, cover, hashes) tuple
  [1]
