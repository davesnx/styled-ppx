Malformed extraction attributes are protocol errors, not silent skips.

  $ cat > malformed_css.ml <<EOF
  > [@@@css 1]
  > EOF

  $ styled-ppx.generate malformed_css.ml
  styled-ppx: malformed_css.ml: malformed [@@@css]: expected [@@@css] payload to be a string literal or a (text, class, scope, family, mask, descendant) tuple
  [1]

  $ cat > malformed_bindings.ml <<EOF
  > [@@@css.bindings [("A.x", 1)]]
  > EOF

  $ styled-ppx.generate malformed_bindings.ml
  styled-ppx: malformed_bindings.ml: malformed [@@@css.bindings]: malformed css.bindings payload at entry 0: expected (longident, identity, class_string) tuple
  [1]

  $ cat > malformed_refs.ml <<EOF
  > [@@@css.refs [("A.x", "a.ml", "line", 0, 1)]]
  > EOF

  $ styled-ppx.generate malformed_refs.ml
  styled-ppx: malformed_refs.ml: malformed [@@@css.refs]: malformed css.refs payload at entry 0: expected (longident, file, start_line, start_col, end_col) tuple
  [1]

  $ cat > malformed_config.ml <<EOF
  > [@@@css.config [("env", 1)]]
  > EOF

  $ styled-ppx.generate malformed_config.ml
  styled-ppx: malformed_config.ml: malformed [@@@css.config]: malformed css.config payload at entry 0: expected (key, value) string tuple
  [1]

  $ cat > unterminated_sentinel.ml <<EOF
  > [@@@css ".target.\000A.x{color:red;}"]
  > EOF

  $ styled-ppx.generate unterminated_sentinel.ml
  styled-ppx: unterminated_sentinel.ml: malformed [@@@css]: unterminated cross-module selector sentinel
  [1]

An atom entry must carry the whole key:

  $ cat > malformed_key.ml <<EOF
  > [@@@css ("._a_x{color:red;}", "_a_x", "0,1,0 own", "color", "1", false)]
  > EOF

  $ styled-ppx.generate malformed_key.ml
  styled-ppx: malformed_key.ml: malformed [@@@css]: expected [@@@css] payload (text, class, scope, family, mask, descendant)
  [1]

A block names rules of its own file, and a merge names blocks of its own
file:

  $ cat > block_out_of_range.ml <<EOF
  > [@@@css ("._a_x{color:red;}", "_a_x", "0,1,0 own", "color", 1, false)]
  > [@@@css.blocks [(1, "", [0; 1])]]
  > EOF

  $ styled-ppx.generate block_out_of_range.ml
  styled-ppx: block_out_of_range.ml: malformed [@@@css.blocks]: block at line 1 names a rule this file lacks
  [1]

  $ cat > merge_out_of_range.ml <<EOF
  > [@@@css ("._a_x{color:red;}", "_a_x", "0,1,0 own", "color", 1, false)]
  > [@@@css.blocks [(1, "", [0])]]
  > [@@@css.merges [(2, [0; 1])]]
  > EOF

  $ styled-ppx.generate merge_out_of_range.ml
  styled-ppx: merge_out_of_range.ml: malformed [@@@css.merges]: merge at line 2 names a block this file lacks
  [1]

  $ cat > malformed_merges.ml <<EOF
  > [@@@css.merges [(2, [true])]]
  > EOF

  $ styled-ppx.generate malformed_merges.ml
  styled-ppx: malformed_merges.ml: malformed [@@@css.merges]: malformed css.merges payload at entry 0: expected (line, [operands]) tuple
  [1]
