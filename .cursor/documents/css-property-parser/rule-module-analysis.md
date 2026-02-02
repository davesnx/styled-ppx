# Rule Module Analysis

A comprehensive analysis of `packages/css-property-parser/lib/Rule.re`, examining its monadic design, usage patterns, identified defects, and proposed improvements.

## 1. Architecture Overview

### Core Types

```reason
type error = list(string);
type data('a) = result('a, error);
type rule('a) = list(token) => (data('a), list(token));
```

The `rule` type is a **parser combinator** that:
- Takes a token list as input
- Returns a result (success with value or error with messages)
- Returns remaining unconsumed tokens

### Two-Layer Monad Design

The module implements **two related monads**:

| Module | Purpose | Returns on success | Returns on error |
|--------|---------|-------------------|------------------|
| `Data` | Low-level, preserves result wrapper | `result('a, error)` | `result('a, error)` |
| `Match` | High-level, assumes success | `'a` | Short-circuits |

## 2. Current Usage Analysis

### Usage in Standard.re

The `Standard.re` file provides basic CSS value parsers built on `Rule`:

```reason
let keyword =
  fun
  | "<=" => expect(LTE)
  | ">=" => expect(GTE)
  | s =>
    token(
      fun
      | IDENT(value) when value == s => Ok()
      | token => Error(["Expected '" ++ s ++ "'. Got '" ++ humanize(token) ++ "' instead."])
    );

let integer =
  token(
    fun
    | NUMBER(float) =>
      Float.(
        is_integer(float)
          ? Ok(float |> to_int)
          : Error(["Expected an integer, got a float instead."])
      )
    | _ => Error(["Expected an integer."])
  );
```

### Usage in Combinator.re

Combinators build complex parsers from simple ones:

```reason
let xor =
  fun
  | [] => failwith("xor doesn't make sense without a single value")
  | [left, ...rules] => {
      let rules = List.map(rule => ((), rule), rules);
      let.map_match ((), value) = match_longest(((), left), rules);
      value;
    };

let and_ = rules => {
  let rec match_everything = (values, rules) =>
    switch (rules) {
    | [] => return_match(values |> List.rev)
    | [left, ...new_rules] =>
      let.bind_match (key, value) = match_longest(left, new_rules);
      let rules = List.remove_assoc(key, rules);
      match_everything([(key, value), ...values], rules);
    };
  ...
};
```

### Usage in Generate.re (PPX)

The PPX generates parser code from CSS spec strings like `[%value "<number> | B"]`:

```reason
let terminal_op = (kind, modifier) => {
  let rule =
    switch (kind) {
    | Delim(delim) when delim == "," => evar("comma")
    | Delim(delim) => eapply(evar("delim"), [estring(delim)])
    | Keyword(name) => eapply(evar("keyword"), [estring(name)])
    | Data_type(name) => value_name_of_css(name) |> evar
    | Property_type(name) => property_value_name(name) |> value_name_of_css |> evar
    };
  apply_modifier(modifier, rule);
};
```

## 3. Identified Defects

### Defect 1: Inconsistent Token Consumption on Error

**Location**: `Rule.Data.bind` (lines 24-30)

```reason
let bind = (rule, f, tokens) => {
  let (data, remaining_tokens) = rule(tokens);
  switch (data) {
  | Ok(d) => f(Ok(d), remaining_tokens)
  | Error(message) => f(Error(message), tokens)  // <-- restores original tokens
  };
};
```

The comment on line 27 says "TODO: maybe combinators should guarantee that". The issue is:
- On success: passes `remaining_tokens` (tokens after consumption)
- On error: passes `tokens` (original tokens, nothing consumed)

But this behavior isn't consistent with `Match.bind_shortest_or_longest` which uses `left_tokens`/`right_tokens` even on error:

```reason
| (Error(left_data), Error(right_data)) =>
  use_left
    ? Data.return(Error(left_data), left_tokens)  // <-- uses consumed tokens
    : Data.return(Error(right_data), right_tokens)
```

**Impact**: Unpredictable backtracking behavior. Some errors consume tokens, some don't.

### Defect 2: Error Information Loss

**Location**: Throughout the module

Error messages are collected as `list(string)` but:
1. When choosing between `left` and `right` in `bind_shortest_or_longest`, one error is discarded
2. No location/position information is attached to errors
3. Nested errors lose their context

Example from `Match.bind_shortest_or_longest`:
```reason
| (Error(left_data), Error(right_data)) =>
  use_left
    ? Data.return(Error(left_data), left_tokens)  // right_data is lost!
    : Data.return(Error(right_data), right_tokens) // left_data is lost!
```

### Defect 3: Code Duplication Between Data and Match

**Location**: Lines 33-47 and 61-82

The `bind_shortest_or_longest` function is nearly identical in both modules:

```reason
// Data module (lines 33-47)
let bind_shortest_or_longest = (shortest, (left, right), f, tokens) => {
  let (left_data, left_tokens) = left(tokens);
  let (right_data, right_tokens) = right(tokens);
  let op = shortest ? (>) : (<);
  let use_left = op(List.length(left_tokens), List.length(right_tokens));
  use_left
    ? f(`Left(left_data), left_tokens)
    : f(`Right(right_data), right_tokens);
};

// Match module (lines 61-77) - similar but with Ok/Error pattern matching
```

### Defect 4: Eager Evaluation in bind_shortest/bind_longest

**Location**: Lines 33-47 and 61-77

Both branches are always evaluated:

```reason
let (left_data, left_tokens) = left(tokens);   // Always runs
let (right_data, right_tokens) = right(tokens); // Always runs
```

This means even when `left` fully matches, `right` is still evaluated, wasting computation.

### Defect 5: Overly Complex Type Signatures

**Location**: Lines 10-19

```reason
type best('left_in, 'left_v, 'right_in, 'right_v, 'c) =
  (
    (rule('left_in), rule('right_in)),
    [
      | `Left('left_v)
      | `Right('right_v)
    ] =>
    rule('c)
  ) =>
  rule('c);
```

This type tries to be maximally generic but:
- Has 5 type parameters when fewer would suffice
- The relationship between parameters isn't clear
- Makes code harder to read and maintain

### Defect 6: Pattern.token Silently Skips Whitespace

**Location**: Lines 120-128

```reason
let token = (expected, tokens) => {
  switch (skip_whitespace(tokens)) {  // Always skips WS
  | [token, ...tokens] =>
    switch (expected(token)) {
    | Ok () => (Ok(), tokens)
    | Error(error) => (Error(error), [token, ...tokens])
    }
  | [] => (Error(["missing the token expected"]), [])
  };
};
```

Whitespace handling is hardcoded. Some CSS contexts require whitespace sensitivity (e.g., `calc()` expressions).

## 4. Missing Functionality

### Missing 1: Simple Alternative (`alt` / `<|>`)

Currently only `xor` with longest-match semantics exists. A simple first-match alternative is missing:

```reason
// Current: xor runs both, picks longest
// Missing: try first, fallback to second only if first fails
let alt: (rule('a), rule('a)) => rule('a);
```

### Missing 2: Lookahead (`peek`)

Cannot inspect the next token without consuming it:

```reason
// Missing
let peek: rule(option(token));
```

### Missing 3: Position/Location Tracking

No way to report where in the input stream an error occurred:

```reason
// Current
type error = list(string);

// Better
type error = {
  messages: list(string),
  position: int,
  context: list(string)
};
```

### Missing 4: Generic `sepBy` Combinator

`repeat_by_comma` exists but a generic separator combinator is missing:

```reason
// Missing
let sepBy: (rule(unit), rule('a)) => rule(list('a));
```

### Missing 5: Error Recovery

No mechanism to recover from errors and continue parsing:

```reason
// Missing
let recover: (rule('a), error => 'a) => rule('a);
```

## 5. Test Coverage Analysis

From `Rules_test.re`, the tests cover:
- Basic Data monad operations (return, bind, map)
- Match monad operations
- bind_shortest and bind_longest
- Pattern helpers (identity, token, expect, value, next)

**Missing test coverage**:
- Error message quality
- Whitespace handling edge cases
- Nested parser interactions
- Performance characteristics

## 6. Proposed Solutions

---

### Proposal A: Unified Monad with Explicit Backtracking

**Goal**: Eliminate Data/Match duplication, make backtracking explicit.

```reason
type parse_state = {
  tokens: list(token),
  position: int,
  consumed: int,
};

type parse_error = {
  messages: list(string),
  position: int,
  expected: list(string),
};

type parse_result('a) =
  | Success('a, parse_state)
  | Failure(parse_error, parse_state);

type parser('a) = parse_state => parse_result('a);

module Parser = {
  let return = (value, state) => Success(value, state);

  let fail = (message, state) =>
    Failure({ messages: [message], position: state.position, expected: [] }, state);

  let bind = (parser, f, state) =>
    switch (parser(state)) {
    | Success(value, new_state) => f(value, new_state)
    | Failure(err, err_state) => Failure(err, err_state)
    };

  // Explicit backtracking - tries parser, restores state on failure
  let try_ = (parser, state) =>
    switch (parser(state)) {
    | Success(_, _) as result => result
    | Failure(err, _) => Failure(err, state)  // Restore original state
    };

  // Simple alternative - first match wins
  let alt = (p1, p2, state) =>
    switch (try_(p1, state)) {
    | Success(_, _) as result => result
    | Failure(_, _) => p2(state)
    };

  // Longest match - runs both, picks longest
  let longest = (p1, p2, state) => {
    let r1 = p1(state);
    let r2 = p2(state);
    switch (r1, r2) {
    | (Success(v1, s1), Success(v2, s2)) =>
      s1.consumed >= s2.consumed ? r1 : r2
    | (Success(_, _), Failure(_, _)) => r1
    | (Failure(_, _), Success(_, _)) => r2
    | (Failure(e1, s1), Failure(e2, s2)) =>
      // Merge errors for better diagnostics
      Failure({ ...e1, messages: e1.messages @ e2.messages }, s1)
    };
  };
};
```

**Benefits**:
- Single monad instead of two
- Explicit backtracking with `try_`
- Position tracking built-in
- Error messages merged instead of lost

**Trade-offs**:
- Larger state to pass around
- Requires updating all existing parsers

---

### Proposal B: Keep Structure, Add Error Context

**Goal**: Minimal changes, better error messages.

```reason
type error = {
  primary: string,
  alternatives: list(string),
  context: list(string),
};

type data('a) = result('a, error);
type rule('a) = list(token) => (data('a), list(token));

module Error = {
  let make = primary => { primary, alternatives: [], context: [] };

  let add_context = (ctx, err) =>
    { ...err, context: [ctx, ...err.context] };

  let merge = (err1, err2) => {
    primary: err1.primary,
    alternatives: [err2.primary, ...err1.alternatives @ err2.alternatives],
    context: err1.context @ err2.context,
  };

  let to_string = err => {
    let main = "Error: " ++ err.primary;
    let alts = switch (err.alternatives) {
      | [] => ""
      | alts => "\nAlso tried: " ++ String.concat(", ", alts)
    };
    let ctx = switch (err.context) {
      | [] => ""
      | ctx => "\nIn context: " ++ String.concat(" > ", List.rev(ctx))
    };
    main ++ alts ++ ctx;
  };
};

// Updated bind_shortest_or_longest merges errors
let bind_shortest_or_longest = (shortest, (left, right), f, tokens) => {
  let (left_data, left_tokens) = left(tokens);
  let (right_data, right_tokens) = right(tokens);
  let op = shortest ? (>) : (<);
  let use_left = op(List.length(left_tokens), List.length(right_tokens));
  switch (left_data, right_data) {
  | (Ok(l), Ok(r)) =>
    use_left ? f(`Left(l), left_tokens) : f(`Right(r), right_tokens)
  | (Ok(l), Error(_)) => f(`Left(l), left_tokens)
  | (Error(_), Ok(r)) => f(`Right(r), right_tokens)
  | (Error(e1), Error(e2)) =>
    // Merge errors instead of discarding one
    Data.return(Error(Error.merge(e1, e2)), tokens)
  };
};
```

**Benefits**:
- Backwards compatible with existing code
- Better error messages
- Preserves both error paths

**Trade-offs**:
- Still has two monads
- Error type change requires updates to all error creation sites

---

### Proposal C: Lazy Evaluation for Performance

**Goal**: Avoid evaluating both branches when unnecessary.

```reason
type lazy_rule('a) = unit => rule('a);

let bind_longest_lazy = ((left, right), f, tokens) => {
  let (left_data, left_tokens) = left()(tokens);

  switch (left_data) {
  | Ok(left_value) when List.length(left_tokens) == 0 =>
    // Left consumed everything, no need to try right
    f(`Left(left_value), left_tokens)
  | _ =>
    // Need to try right
    let (right_data, right_tokens) = right()(tokens);
    let use_left = List.length(left_tokens) < List.length(right_tokens);
    switch (left_data, right_data) {
    | (Ok(l), Ok(r)) =>
      use_left ? f(`Left(l), left_tokens) : f(`Right(r), right_tokens)
    | (Ok(l), Error(_)) => f(`Left(l), left_tokens)
    | (Error(_), Ok(r)) => f(`Right(r), right_tokens)
    | (Error(e1), Error(e2)) =>
      use_left
        ? Data.return(Error(e1), left_tokens)
        : Data.return(Error(e2), right_tokens)
    };
  };
};

// Usage in Combinator.xor
let xor = rules => {
  let lazy_rules = List.map(r => () => r, rules);
  // ... use lazy evaluation
};
```

**Benefits**:
- Significant performance improvement for common cases
- Early exit when one parser fully matches

**Trade-offs**:
- More complex implementation
- Subtle semantics around when evaluation happens

---

### Proposal D: Monadic Let Syntax Cleanup

**Goal**: Simplify the Let module for better ergonomics.

Current:
```reason
module Let = {
  let return_data = Data.return;
  let (let.bind_data) = Data.bind;
  let (let.map_data) = Data.map;
  let (let.bind_shortest_data) = Data.bind_shortest;
  let (let.bind_longest_data) = Data.bind_longest;

  let return_match = Match.return;
  let (let.bind_match) = Match.bind;
  // ...
};
```

Proposed:
```reason
module Syntax = {
  // Use * for Match (the common case), no suffix for Data
  let (let*) = Match.bind;
  let (let+) = Match.map;
  let (and*) = Match.pair;  // NEW: for parallel binding

  // Data monad with explicit suffix only when needed
  let (let*!) = Data.bind;
  let (let+!) = Data.map;

  // Return functions with clear names
  let ok = Match.return;
  let err = msg => Data.return(Error([msg]));
};

// Example usage
let parse_declaration = {
  open Syntax;
  let* name = ident;
  let* () = expect(COLON);
  let* value = parse_value;
  ok(`Declaration(name, value));
};
```

**Benefits**:
- Standard OCaml/Reason binding operator conventions
- Shorter, more readable code
- `let*` for the common case (Match)

**Trade-offs**:
- Breaking change to all existing code
- Requires migration effort

## 7. Recommended Path Forward

**Phase 1 (Low risk)**: Implement Proposal B (Error Context)
- Improves debugging without structural changes
- Can be done incrementally

**Phase 2 (Medium risk)**: Implement Proposal D (Syntax Cleanup)
- Better developer experience
- One-time migration cost

**Phase 3 (Higher risk)**: Consider Proposal A or C
- Evaluate based on performance profiling
- May require significant refactoring

## 8. Example Test Cases for Validation

```reason
// Test: Error messages should include alternatives
test("xor preserves both error messages", _ => {
  let parser = Combinator.xor([
    token(_ => Error(["Expected A"])),
    token(_ => Error(["Expected B"])),
  ]);
  switch (parser([COMMA])) {
  | (Error(err), _) =>
    assert(List.mem("Expected A", err.alternatives) || err.primary == "Expected A");
    assert(List.mem("Expected B", err.alternatives) || err.primary == "Expected B");
  | _ => fail("Should have failed")
  };
});

// Test: Backtracking should restore tokens
test("try_ restores tokens on failure", _ => {
  let consumes_then_fails = tokens => {
    switch (tokens) {
    | [_, ...rest] => (Error(["failed after consuming"]), rest)
    | [] => (Error(["empty"]), [])
    };
  };
  let wrapped = Parser.try_(consumes_then_fails);
  switch (wrapped([COMMA, COLON])) {
  | (Error(_), [COMMA, COLON]) => () // Tokens restored
  | (Error(_), _) => fail("Tokens should be restored")
  | _ => fail("Should have failed")
  };
});

// Test: Longest match with lazy evaluation
test("longest_lazy doesn't evaluate right when left consumes all", _ => {
  let evaluated = ref(false);
  let left = () => tokens => (Ok("left"), []);
  let right = () => tokens => { evaluated := true; (Ok("right"), tokens) };
  let parser = bind_longest_lazy((left, right), v => Match.return(v));
  let _ = parser([COMMA]);
  assert(!evaluated^); // Right should not have been called
});
```

## 9. Appendix: Module Dependencies

```
Rule.re
  └── Styled_ppx_css_parser.Tokens

Standard.re
  ├── Rule.Let
  ├── Rule.Pattern
  └── Combinator

Combinator.re
  ├── Rule.Let
  └── Modifier

Modifier.re
  ├── Rule.Let
  └── Rule.Pattern

Parser.re (generated)
  ├── Standard
  ├── Modifier
  └── Rule.Match
```
