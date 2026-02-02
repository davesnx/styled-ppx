# Parser.mly -> Tokens.re Mapping for External Tokens

This note summarizes the constructor differences between `Parser.mly` inline
tokens and `Tokens.re`, plus the intended mappings when switching to
`--external-tokens`.

## Direct Matches

These tokens already align (same constructor, same shape):

- `EOF`
- `IDENT(string)`
- `BAD_IDENT`
- `FUNCTION(string)`
- `STRING(string)`
- `URL(string)`
- `BAD_URL`
- `DELIM(string)`
- `WS`
- `COLON`
- `SEMI_COLON`
- `COMMA`
- `LEFT_BRACKET` / `RIGHT_BRACKET`
- `LEFT_PAREN` / `RIGHT_PAREN`
- `LEFT_BRACE` / `RIGHT_BRACE`

## Representation Changes

- `NUMBER(string)` -> `NUMBER(float)` (Parser/AST will convert to float)
- `DIMENSION(string * string)` -> `DIMENSION(float, string)`
- `FLOAT_DIMENSION(string * string)` -> `DIMENSION(float, string)` (unit-aware stays semantic)
- `NUMBER("n"), PERCENT` -> `PERCENTAGE(float)`
- `HASH(string)` -> `HASH(string, kind)` (parser must extract the string)

## Parser.mly-Specific Tokens -> DELIM Patterns

These become `DELIM` in the unified stream and are matched in the grammar:

- `COMBINATOR("+")` -> `DELIM("+")`
- `COMBINATOR("~")` -> `DELIM("~")`
- `COMBINATOR(">")` -> `DELIM(">")`
- `OPERATOR("~=")` -> `DELIM("~")`, `DELIM("=")`
- `OPERATOR("|=")` -> `DELIM("|")`, `DELIM("=")`
- `OPERATOR("^=")` -> `DELIM("^")`, `DELIM("=")`
- `OPERATOR("$=")` -> `DELIM("$")`, `DELIM("=")`
- `OPERATOR("*=")` -> `ASTERISK`, `DELIM("=")`
- `OPERATOR("=")` -> `DELIM("=")`

## Tokens to Keep as Dedicated Constructors

These are parser-facing tokens that will be added to `Tokens.re`:

- `DOT` (kept to avoid selector ambiguity)
- `AMPERSAND` (kept to avoid selector ambiguity)
- `ASTERISK` (kept to avoid selector ambiguity)
- `DOUBLE_COLON`
- `IMPORTANT`
- `UNICODE_RANGE`
- `INTERPOLATION(string list)`
- `TAG(string)` (explicitly kept for the grammar)
- `NTH_FUNCTION(string)` (preserve selector parsing)

## At-Rule Tokens

Decision:
- Keep specialized at-rule tokens in `Tokens.re` (`AT_KEYFRAMES`, `AT_RULE`,
  `AT_RULE_STATEMENT`) to avoid grammar ambiguity and to keep the parser
  structure stable.

## Whitespace and TAG Decisions

- **Whitespace**: keep emitting `WS` tokens in all contexts. The grammar already
  models whitespace explicitly (selector descendant combinator and value
  rendering), so a context-aware lexer that drops whitespace would break
  parsing and output fidelity.
- **TAG**: keep `TAG(string)` and `is_tag` in the lexer to avoid grammar
  conflicts and minimize churn during the external-tokens migration.
