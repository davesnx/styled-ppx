- Remove the last_buffer, there's no need.
- Also, remove the complexity arround unclassified token, there's no need now to do this, we control the parser and we will classify them in one go (actually classify is not even a thing), so remove type unclassified_token =
  | Unclassified_whitespace
  | Unclassified_ident(string)
  | Unclassified_token(Tokens.token) and handle all cases in the parsing code.

---

There's clearly something missing because /css-grammar/lib/Rule.re still handles strings and shit like this. We should operate on AST only.
