Malformed extraction attributes are protocol errors, not silent skips.

  $ cat > malformed_css.ml <<EOF
  > [@@@css 1]
  > EOF

  $ styled-ppx.generate malformed_css.ml
  styled-ppx: malformed_css.ml: malformed [@@@css]: expected [@@@css] payload to be a string literal
  [1]

  $ cat > malformed_bindings.ml <<EOF
  > [@@@css.bindings [("A.x", 1)]]
  > EOF

  $ styled-ppx.generate malformed_bindings.ml
  styled-ppx: malformed_bindings.ml: malformed [@@@css.bindings]: malformed css.bindings payload at entry 0: expected (longident, class_string) string tuple
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
