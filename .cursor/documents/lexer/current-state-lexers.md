# Current State: Lexer & Token Systems

This document captures historical context for the lexer/token unification.

## Overview

Historically there were **two parallel token systems**. The current state is a
single token system backed by `Tokens.re` and consumed via external tokens in
`Parser.mly`.

1. **`Parser.mly` tokens** — Uses `Tokens.re` via external tokens (via `get_next_tokens_with_location`)
2. **`Tokens.re` tokens** — Used for CSS property value parsing (via `consume`)

### Entry Points

| System | Lexer Function | Returns | Used By |
|--------|---------------|---------|---------|
| Parser.mly | `get_next_tokens_with_location` | `Tokens.token_with_location` | `driver.re`, menhir parser |
| Tokens.re | `consume` | `Tokens.token` | `css-property-parser` |

---

## Token Comparison Table

Note: the parser/token comparison sections below are historical (pre-external
tokens). The canonical mapping for the current unified token stream lives in
`/.cursor/documents/external-tokens-mapping.md`.

For the external-tokens migration, see:
`/.cursor/documents/external-tokens-mapping.md`.

### Shared Tokens (with different representations)

| Token Type | Parser.mly | Tokens.re | Notes |
|------------|-----------|-----------|-------|
| EOF | `EOF` | `EOF` | Same |
| Identifier | `IDENT of string` | `IDENT of string` | Same |
| Function | `FUNCTION of string` | `FUNCTION of string` | Same |
| String | `STRING of string` | `STRING of string` | Same |
| URL | `URL of string` | `URL of string` | Same |
| Delimiter | `DELIM of string` | `DELIM of string` | Same |
| Whitespace | `WS` | `WS` | Same |
| Colon | `COLON` | `COLON` | Same |
| Semicolon | `SEMI_COLON` | `SEMI_COLON` | Same |
| Comma | `COMMA` | `COMMA` | Same |
| Brackets | `LEFT_BRACKET` / `RIGHT_BRACKET` | Same | Same |
| Parens | `LEFT_PAREN` / `RIGHT_PAREN` | Same | Same |
| Braces | `LEFT_BRACE` / `RIGHT_BRACE` | Same | Same |
| Bad URL | `BAD_URL` | `BAD_URL` | Same |
| Bad Ident | `BAD_IDENT` | `BAD_IDENT` | Same |
| **Number** | `NUMBER of string` | `NUMBER of float` | **Different representation** |
| **Dimension** | `DIMENSION of (string * string)` | `DIMENSION of (float * string)` | **Different representation** |
| **Hash** | `HASH of string` | `HASH of (string * [\`ID \| \`UNRESTRICTED])` | **Tokens.re has type flag** |
| **At-keyword** | Split into 3 variants | `AT_KEYWORD of string` | **Parser.mly specializes** |

### Parser.mly-only Tokens (Stylesheet-specific)

| Token | Purpose | Example |
|-------|---------|---------|
| `DOT` | Class selector prefix | `.class` |
| `DOUBLE_COLON` | Pseudo-element | `::before` |
| `PERCENT` | Percentage sign (separate from number) | `50%` → `NUMBER("50"), PERCENT` |
| `IMPORTANT` | Important flag | `!important` |
| `AMPERSAND` | Nesting selector | `&:hover` |
| `ASTERISK` | Universal selector | `* {}` |
| `TAG of string` | HTML tag names | `div`, `span` |
| `OPERATOR of string` | Attribute matchers | `~=`, `\|=`, `^=`, `$=`, `*=`, `=` |
| `COMBINATOR of string` | Selector combinators | `+`, `~`, `>` |
| `NTH_FUNCTION of string` | Nth-child functions | `nth-child(`, `nth-of-type(` |
| `FLOAT_DIMENSION of (string * string)` | Dimension with known units | `10px`, `2em` |
| `UNICODE_RANGE of string` | Unicode range | `U+0025-00FF` |
| `INTERPOLATION of string list` | Variable interpolation | `$(Module.variable)` |
| `AT_KEYFRAMES of string` | Specific at-rule | `@keyframes` |
| `AT_RULE of string` | Generic at-rule with body | `@media`, `@supports` |
| `AT_RULE_STATEMENT of string` | At-rule without body | `@charset`, `@import` |

### Tokens.re-only Tokens (CSS Syntax 3 compliant)

| Token | Purpose | Example |
|-------|---------|---------|
| `GTE` | Media query comparison | `>=` |
| `LTE` | Media query comparison | `<=` |
| `PERCENTAGE of float` | Percentage with value | `50%` → `PERCENTAGE(50.0)` |

---

## Lexer Functions

### For Parser.mly (`get_next_token`)

Location: `Lexer.re` lines 601-675

```reason
let rec get_next_token = lexbuf => {
  switch%sedlex (lexbuf) {
  | eof => Parser.EOF
  | '.' => DOT
  | ';' => SEMI_COLON
  | '}' => RIGHT_BRACE
  | '{' => LEFT_BRACE
  | "::" => DOUBLE_COLON
  | ':' => COLON
  // ... more patterns
  | number => get_dimension(lexeme(lexbuf), lexbuf)
  | ("-", ident) => consume_ident_like(lexbuf)
  // ...
  }
}
```

Key helpers:
- `get_dimension` — classifies units into `FLOAT_DIMENSION` vs `DIMENSION`
- `consume_function` — distinguishes `FUNCTION` from `NTH_FUNCTION`
- `consume_ident_like` → returns `Parser.token` (includes `TAG` distinction via `is_tag`)
- `discard_comments` — handles `/* */`
- `is_tag` — checks ~170 HTML/SVG tag names

### For Tokens.re (`consume`)

Location: `Lexer.re` lines 852-944

```reason
let consume = lexbuf => {
  switch%sedlex (lexbuf) {
  | whitespace => Ok(consume_whitespace_(lexbuf))
  | "\"" => consume_string("\"", lexbuf)
  | "#" => consume_hash()
  | "'" => consume_string("'", lexbuf)
  | "(" => Ok(LEFT_PAREN)
  // ... more patterns
  | digit => consume_numeric(lexbuf)
  // ...
  }
}
```

Key helpers:
- `consume_numeric` — returns `NUMBER`, `PERCENTAGE`, or `DIMENSION` with **float** values
- `consume_string` — handles quote types with proper escaping
- `consume_ident_like` → returns `Tokens.token` (no TAG distinction)
- `consume_hash` — includes `ID` vs `UNRESTRICTED` flag per CSS Syntax 3
- `consume_url_` — URL token parsing

---

## Critical Semantic Differences

### 1. Number Representation

**Parser.mly** stores numbers as strings:
```ocaml
NUMBER of string                      (* "45.6" *)
FLOAT_DIMENSION of (string * string)  (* ("10", "px") *)
```

**Tokens.re** stores numbers as floats:
```ocaml
NUMBER of float                       (* 45.6 *)
DIMENSION of (float * string)         (* (10.0, "px") *)
```

### 2. Percentage Handling

**Parser.mly** — Two separate tokens:
```
50% becomes: NUMBER("50"), PERCENT
```

**Tokens.re** — Single combined token:
```
50% becomes: PERCENTAGE(50.0)
```

### 3. Dimension Classification

**Parser.mly** — Distinguishes "known" units via `get_dimension`:
```ocaml
FLOAT_DIMENSION of (string * string)  (* known: px, em, deg, s, hz... *)
DIMENSION of (string * string)        (* unknown: n, other *)
```

Known units include length (`px`, `em`, `rem`, `vh`, `vw`, etc.), angle (`deg`, `rad`, `turn`, `grad`), time (`s`, `ms`), and frequency (`hz`, `khz`).

**Tokens.re** — Single type:
```ocaml
DIMENSION of (float * string)  (* all dimensions treated equally *)
```

### 4. Identifier Semantics

**Parser.mly** — Distinguishes HTML/SVG tags:
```ocaml
TAG of string   (* "div", "span", "svg"... via is_tag check *)
IDENT of string (* other identifiers *)
```

The `is_tag` function (lines 142-317) contains ~170 HTML and SVG element names.

**Tokens.re** — All identifiers the same:
```ocaml
IDENT of string  (* everything *)
```

### 5. Interpolation Handling

**Both systems** now use a unified approach:
```ocaml
INTERPOLATION of string list
(* $(Module.variable) → ["Module", "variable"] *)
```

The `consume` function now produces `INTERPOLATION` as a single token (previously decomposed).

### 6. Hash Token Type Flag

**Parser.mly** — Simple string:
```ocaml
HASH of string  (* #abc → "abc" *)
```

**Tokens.re** — With type flag per CSS Syntax 3:
```ocaml
HASH of (string * [`ID | `UNRESTRICTED])
(* #abc → ("abc", `ID) — starts with identifier *)
(* #123 → ("123", `UNRESTRICTED) — starts with digit *)
```

---

## Usage Context

### Parser.mly tokens are used for:
- `parse_stylesheet` — full CSS stylesheets
- `parse_declaration_list` — rule blocks
- `parse_declaration` — single property declarations
- `parse_keyframes` — keyframe rules
- Selector parsing (needs `DOT`, `COMBINATOR`, `OPERATOR`, `TAG`, etc.)

### Tokens.re tokens are used for:
- CSS property value validation (`css-property-parser` package)
- `Rule.re` pattern matching on token streams
- `Standard.re` primitive extractors (`length`, `angle`, `percentage`, etc.)

---

## Path to Unification via `--external-tokens`

To unify with menhir's `--external-tokens`:

### 1. Define Canonical Token Type

Base on `Tokens.re` since it follows CSS Syntax Level 3 more closely, then add stylesheet-specific tokens.

### 2. Resolve Representation Conflicts

| Decision | Recommendation |
|----------|----------------|
| Numbers | Use `float` (easier for value validation) |
| Percentage | Use combined `PERCENTAGE of float` |
| Hash | Keep type flag from `Tokens.re` |
| Dimension | Single `DIMENSION of (float * string)` |

### 3. Add Stylesheet-specific Tokens

These tokens are needed for selector/stylesheet parsing:
- `DOT`, `DOUBLE_COLON`, `AMPERSAND`, `ASTERISK`
- `OPERATOR of string` (attribute matchers)
- `COMBINATOR of string` (selector combinators)
- `NTH_FUNCTION of string`
- `INTERPOLATION of string list`
- `IMPORTANT`

### 4. Handle Semantic Distinctions at Parser Level

- `TAG` vs `IDENT` — Parser can check `is_tag` when needed
- `FLOAT_DIMENSION` vs `DIMENSION` — Parser/value-checker handles unit validation
- At-rule specialization — Parser distinguishes by identifier value

### 5. Unify Lexer Functions

Merge `get_next_token` and `consume` into single function returning the unified token type. The parser or value-checker applies semantic interpretation as needed.

---

## File References

| File | Purpose |
|------|---------|
| `packages/parser/lib/Tokens.re` | CSS Syntax 3 token type + helpers |
| `packages/parser/lib/Lexer.re` | Both lexer implementations |
| `packages/parser/lib/Lexer.rei` | Public interface |
| `packages/parser/lib/Parser.mly` | Menhir grammar + token declarations |
| `packages/parser/lib/driver.re` | Parser entry points |
| `packages/parser/test/Lexer_test.re` | Tests for both lexers |
| `packages/css-property-parser/lib/Rule.re` | Token stream parsing monad |
| `packages/css-property-parser/lib/Standard.re` | Primitive value extractors |
