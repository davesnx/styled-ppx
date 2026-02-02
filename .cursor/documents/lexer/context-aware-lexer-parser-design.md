# Context-Aware Lexer/Parser Design

This document outlines a redesign of the styled-ppx CSS lexer and parser to be context-aware, eliminating most menhir conflicts and the IDENT/TAG ambiguity.

## Problem Summary

From the [parser-mly-analysis.md](./parser-mly-analysis.md):

| Issue | Impact |
|-------|--------|
| `option(WS)` + `WS` as value | ~80% of 54 shift/reduce conflicts |
| IDENT as property vs type selector | Fundamental parsing ambiguity |
| `declarations` rule overlap | 4 reduce/reduce conflicts |
| Combinator whitespace | 8+ states with conflicts |
| Optional semicolons ownership | 4+ states with conflicts |

## Goals

1. **Zero menhir conflicts** (or minimal, intentional ones)
2. **No `is_tag` hack** - context determines token meaning
3. **No `option(WS)` patterns** - lexer handles whitespace significance
4. **Clear separation** between selectors, declarations, and values
5. **Simpler grammar** - easier to maintain and extend

---

## Design: Lexer Modes

The lexer maintains a **mode stack** that determines how tokens are interpreted.

### Mode Definitions

```
┌─────────────────────────────────────────────────────────────────────────┐
│                           LEXER MODES                                    │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                          │
│  STYLESHEET_START ──▶ At top level or after }                           │
│    • IDENT → TYPE_SELECTOR (e.g., "div", "span")                        │
│    • Skip non-significant WS                                             │
│    • Expect: selector or at-rule                                         │
│                                                                          │
│  SELECTOR ──▶ Parsing selector list                                      │
│    • IDENT → TYPE_SELECTOR                                               │
│    • WS before combinator → DESCENDANT_COMBINATOR                        │
│    • Skip other WS                                                       │
│    • Transitions: { → DECLARATION_START                                  │
│                                                                          │
│  DECLARATION_START ──▶ After { or ;                                      │
│    • IDENT followed by : → PROPERTY                                      │
│    • IDENT followed by { → TYPE_SELECTOR (nested rule)                   │
│    • . # [ : & * → selector tokens (nested rule)                         │
│    • @ → at-rule                                                         │
│    • Skip non-significant WS                                             │
│                                                                          │
│  DECLARATION_VALUE ──▶ After :                                           │
│    • IDENT → IDENT (value identifier)                                    │
│    • Preserve significant WS (e.g., "1px 2px")                           │
│    • Transitions: ; → DECLARATION_START, } → pop mode                    │
│                                                                          │
│  FUNCTION_ARGS ──▶ Inside function call                                  │
│    • Context-dependent (calc vs url vs nth-child)                        │
│    • Track parenthesis nesting                                           │
│                                                                          │
│  AT_RULE_PRELUDE ──▶ After @keyword                                      │
│    • Parse media queries, keyframe names, etc.                           │
│    • Transitions: { → appropriate inner mode                             │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### Mode Transitions

```
                    ┌──────────────────┐
                    │ STYLESHEET_START │
                    └────────┬─────────┘
                             │
            ┌────────────────┼────────────────┐
            │                │                │
            ▼                ▼                ▼
     ┌──────────┐     ┌───────────┐    ┌──────────┐
     │ SELECTOR │     │ AT_RULE_  │    │ (error)  │
     │          │     │ PRELUDE   │    │          │
     └────┬─────┘     └─────┬─────┘    └──────────┘
          │                 │
          │ {               │ {
          ▼                 ▼
    ┌─────────────────────────────┐
    │     DECLARATION_START       │◀─────────┐
    └──────────────┬──────────────┘          │
                   │                         │
      ┌────────────┼────────────┐           │
      │            │            │           │
      ▼            ▼            ▼           │
┌──────────┐ ┌──────────┐ ┌──────────┐     │
│ PROPERTY │ │ SELECTOR │ │ AT_RULE  │     │
│ (ident:) │ │ (nested) │ │ (nested) │     │
└────┬─────┘ └────┬─────┘ └────┬─────┘     │
     │            │            │           │
     │ :          │ {          │ {         │
     ▼            │            │           │
┌──────────────┐  │            │           │
│ DECLARATION_ │  │            │           │
│ VALUE        │  │            │           │
└──────┬───────┘  │            │           │
       │          │            │           │
       │ ; or }   │            │           │
       └──────────┴────────────┴───────────┘
```

---

## Whitespace Strategy

### Current Problem

```mly
(* Current: WS is both optional padding AND a value *)
skip_ws(X): x = delimited(WS?, X, WS?) { x }
value: | WS { Whitespace } | ...
```

This creates 54+ shift/reduce conflicts.

### New Strategy: Lexer-Controlled Whitespace

| Context | Whitespace Handling |
|---------|---------------------|
| Between tokens in selectors | **Skip** (not significant) |
| Before `{` or `}` | **Skip** |
| After `:` before value | **Skip** |
| Between values (e.g., `1px 2px`) | **Emit `WS`** (significant) |
| Inside `calc()` around operators | **Skip** |
| Inside strings | **Preserve** (part of string) |

### Implementation

```reason
type ws_significance =
  | Skip      (* Discard whitespace *)
  | Emit      (* Emit as WS token *)
  | Preserve; (* Keep in current token, e.g., string *)

let ws_handling = mode => switch (mode) {
  | STYLESHEET_START => Skip
  | SELECTOR => Skip  (* WS as combinator handled specially *)
  | DECLARATION_START => Skip
  | DECLARATION_VALUE => Emit  (* significant between values *)
  | FUNCTION_ARGS => context_dependent
  | AT_RULE_PRELUDE => Skip
};
```

---

## Token Changes

### Current Tokens (problematic)

```reason
type token =
  | IDENT(string)      (* Ambiguous: property? selector? value? *)
  | WS                 (* Causes conflicts everywhere *)
  | ...
```

### New Tokens (context-aware)

```reason
type token =
  (* Selectors - only emitted in selector context *)
  | TYPE_SELECTOR(string)     (* div, span, p *)
  | CLASS_SELECTOR(string)    (* .foo - includes the dot *)
  | ID_SELECTOR(string)       (* #bar - includes the hash *)
  | UNIVERSAL_SELECTOR        (* * *)
  | AMPERSAND_SELECTOR        (* & *)

  (* Combinators - lexer determines from context *)
  | DESCENDANT_COMBINATOR     (* significant whitespace *)
  | CHILD_COMBINATOR          (* > *)
  | SIBLING_COMBINATOR        (* ~ *)
  | ADJACENT_COMBINATOR       (* + *)

  (* Declarations *)
  | PROPERTY(string)          (* color, display - followed by : *)
  | COLON

  (* Values - only in value context *)
  | IDENT(string)             (* Now unambiguous - only in values *)
  | WS                        (* Only emitted where significant *)
  | NUMBER(float)
  | DIMENSION(float, string)
  | PERCENTAGE(float)
  | STRING(string)
  | HASH(string)              (* #fff for colors, not selectors *)
  | FUNCTION(string)          (* calc(, rgb(, etc. *)

  (* Structure *)
  | LEFT_BRACE
  | RIGHT_BRACE
  | LEFT_PAREN
  | RIGHT_PAREN
  | SEMICOLON
  | COMMA

  (* At-rules *)
  | AT_RULE(string)           (* @media, @keyframes, etc. *)

  | EOF
```

---

## Grammar Simplification

### Current Grammar (conflicts)

```mly
declarations:
  | WS? xs = nonempty_list(rule) SEMI_COLON?
  | WS? xs = separated_nonempty_list(SEMI_COLON, rule) SEMI_COLON?

skip_ws(X): x = delimited(WS?, X, WS?) { x }

compound_selector:
  | t = type_selector sub = nonempty_list(subclass_selector) ps = pseudo_list
  | sub = nonempty_list(subclass_selector) ps = pseudo_list
  | t = type_selector sub = nonempty_list(subclass_selector)
  | sub = nonempty_list(subclass_selector)
  | t = type_selector ps = pseudo_list
  | ps = pseudo_list
```

### New Grammar (clean)

```mly
(* No more option(WS) patterns - lexer handles whitespace *)

stylesheet:
  | rules = list(toplevel_rule) EOF { rules }

toplevel_rule:
  | s = style_rule { Style_rule s }
  | a = at_rule { At_rule a }

style_rule:
  | selector = selector_list LEFT_BRACE decls = declarations RIGHT_BRACE
    { { selector; declarations = decls } }

declarations:
  | ds = separated_list(SEMICOLON, declaration_or_nested) { ds }

declaration_or_nested:
  | p = PROPERTY COLON vs = value_list { Declaration(p, vs) }
  | s = style_rule { Nested_rule s }
  | a = at_rule { Nested_at_rule a }

(* Selectors - now unambiguous *)
selector_list:
  | s = separated_nonempty_list(COMMA, complex_selector) { s }

complex_selector:
  | s = compound_selector cs = list(combinator_and_selector) { (s, cs) }

combinator_and_selector:
  | DESCENDANT_COMBINATOR s = compound_selector { (Descendant, s) }
  | CHILD_COMBINATOR s = compound_selector { (Child, s) }
  | SIBLING_COMBINATOR s = compound_selector { (Sibling, s) }
  | ADJACENT_COMBINATOR s = compound_selector { (Adjacent, s) }

compound_selector:
  | t = type_selector? subs = list(subclass_selector) pseudos = list(pseudo)
    { { type_sel = t; subclasses = subs; pseudos } }

type_selector:
  | TYPE_SELECTOR(name) { Type name }
  | UNIVERSAL_SELECTOR { Universal }
  | AMPERSAND_SELECTOR { Ampersand }

(* Values - WS only where significant *)
value_list:
  | vs = nonempty_list(value_component) { vs }

value_component:
  | v = single_value { v }
  | WS { Whitespace }  (* Only emitted between values *)
```

---

## Lexer Implementation

### Mode Stack

```reason
type lexer_mode =
  | Stylesheet_start
  | Selector
  | Declaration_start
  | Declaration_value
  | Function_args(string)  (* function name for context *)
  | At_rule_prelude(string);

type lexer_state = {
  mutable mode_stack: list(lexer_mode),
  mutable paren_depth: int,
  mutable brace_depth: int,
};

let current_mode = state => List.hd(state.mode_stack);
let push_mode = (state, mode) => state.mode_stack = [mode, ...state.mode_stack];
let pop_mode = state => state.mode_stack = List.tl(state.mode_stack);
```

### Lookahead for IDENT Disambiguation

In `DECLARATION_START` mode, when we see an identifier, we need to look ahead:

```reason
let lex_in_declaration_start = (state, lexbuf) => {
  let ident = consume_ident(lexbuf);

  (* Peek at what follows *)
  skip_whitespace(lexbuf);
  switch (peek(lexbuf)) {
  | ':' =>
    (* It's a property *)
    PROPERTY(ident)

  | '{' | '.' | '#' | '[' | ':' | '*' | '&' =>
    (* It's a type selector starting a nested rule *)
    push_mode(state, Selector);
    TYPE_SELECTOR(ident)

  | _ =>
    (* Ambiguous - treat as property, let parser decide *)
    PROPERTY(ident)
  }
};
```

### Whitespace as Descendant Combinator

In selector context, whitespace between selectors is significant:

```reason
let lex_in_selector = (state, lexbuf) => {
  switch (peek(lexbuf)) {
  | ' ' | '\t' | '\n' =>
    skip_whitespace(lexbuf);
    switch (peek(lexbuf)) {
    | '>' | '+' | '~' =>
      (* Explicit combinator follows - skip WS *)
      lex_combinator(lexbuf)
    | '{' | ',' | ')' =>
      (* End of selector - skip WS *)
      continue_lexing(state, lexbuf)
    | _ =>
      (* Whitespace IS the combinator *)
      DESCENDANT_COMBINATOR
    }
  | ...
  }
};
```

---

## Parser-Lexer Communication

The parser can inform the lexer of context changes through a callback mechanism:

```reason
(* In driver.re *)
let lexer_state = ref(Lexer.initial_state());

let next_token = lexbuf => {
  Lexer.get_token(!lexer_state, lexbuf)
};

(* Parser can call this to adjust lexer mode *)
let set_lexer_mode = mode => {
  lexer_state := { ...!lexer_state, mode_stack: [mode, ...!lexer_state.mode_stack] }
};
```

Alternatively, use menhir's `$startpos` and `$endpos` with semantic actions to track context.

---

## Migration Strategy

### Phase 1: Lexer Mode Infrastructure

1. Add `lexer_state` type with mode stack
2. Implement mode transitions for `{`, `}`, `:`, `;`
3. Keep current tokens, just add mode tracking
4. **Tests**: Verify mode transitions are correct

### Phase 2: Whitespace Handling

1. Implement `ws_handling` function per mode
2. Skip non-significant whitespace in lexer
3. Remove `option(WS)` and `skip_ws()` from grammar
4. **Tests**: Verify whitespace behavior, check conflict count

### Phase 3: Token Differentiation

1. Split `IDENT` into `TYPE_SELECTOR`, `PROPERTY`, `IDENT`
2. Add `DESCENDANT_COMBINATOR`
3. Update grammar to use new tokens
4. Remove `is_tag` (already done)
5. **Tests**: Full test suite, zero conflicts target

### Phase 4: Grammar Cleanup

1. Unify `declarations` rule
2. Simplify `compound_selector`
3. Remove dead code (`interpolation`, `prelude_any`, etc.)
4. **Tests**: All existing tests pass

---

## Risk Assessment

| Risk | Mitigation |
|------|------------|
| Breaking existing CSS | Comprehensive snapshot tests |
| Edge cases in mode transitions | Extensive unit tests for lexer modes |
| Performance regression | Benchmark before/after |
| Menhir version compatibility | Test with current menhir version |

---

## Success Criteria

- [ ] Zero menhir conflicts (or documented intentional ones)
- [ ] All existing tests pass
- [ ] `is_tag` removed
- [ ] No `option(WS)` in grammar
- [ ] `div {}` works in stylesheet context
- [ ] `& div {}` required in declaration context
- [ ] `@container { width: 50% }` works in `[%cx]`
- [ ] `@media { div {} }` works in `[%styled.global]`

---

## References

- [parser-mly-analysis.md](./parser-mly-analysis.md) - Conflict analysis
- [CSS Syntax Module Level 3](https://www.w3.org/TR/css-syntax-3/) - Tokenization spec
- [Menhir Manual](http://gallium.inria.fr/~fpottier/menhir/) - Parser generator docs
- [sedlex](https://github.com/ocaml-community/sedlex) - Lexer library
