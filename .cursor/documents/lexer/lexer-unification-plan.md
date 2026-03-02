# Lexer Unification Plan

## Goal

Remove the `tokenize` API and consolidate around `from_string` for batch tokenization and `get_next_tokens_with_location` for streaming (menhir parser).

## Current State

### APIs

| API | Signature | Error Handling | Encoding | Used By |
|-----|-----------|----------------|----------|---------|
| `tokenize` | `string => result(list((token, pos, pos)), string)` | Catches `LexingError`, returns `Error(string)` | Utf8 | `Lexer_test.re`, `lexer_renderer.re` |
| `from_string` | `string => list(token_with_location)` | **Mixed**: soft errors in stream, hard errors raise | Utf8 | `css-grammar`, `Lexer_from_string_test.re` |
| `get_next_tokens_with_location` | `lexbuf => (token, pos, pos)` | Raises `LexingError` | N/A (caller provides lexbuf) | `driver.re` (menhir parser) |

### Important: `from_string` Has Dual Error Handling

Contrary to what the type suggests, `from_string` can **both**:
- Return `Error(error)` in token stream (soft errors: invalid escape, unterminated string, etc.)
- Raise `LexingError` (hard errors: unterminated comments, some bad URLs)

This is tested in `Lexer_from_string_test.re` with both `lexer_error_tests` and `soft_error_tests`.

### Encoding Note

`driver.re` creates lexbufs with `Sedlexing.Latin1.from_string`, while `Lexer.from_string` uses `Sedlexing.Utf8.from_string`. This is pre-existing and not addressed by this plan.

### Internal Functions

| Function | Purpose | Action |
|----------|---------|--------|
| `consume` | Core lexer, returns `result(token, error)` | **Keep** |
| `consume_or_raise` | Wraps `consume`, raises on error | **Remove** (inline into `get_next_tokens_with_location`) |

### Files to Modify

1. `packages/parser/lib/Lexer.re` - Remove `tokenize`, inline `consume_or_raise`
2. `packages/parser/lib/Lexer.rei` - Remove `tokenize` from interface
3. `packages/parser/test/Lexer_test.re` - Migrate to `from_string`
4. `packages/renderer/lexer_renderer.re` - Migrate to `from_string`

---

## Migration Plan

### Phase 1: Verify Baseline

**Goal:** Ensure all tests pass before making changes.

```bash
eval $(opam env --switch=. --set-switch)
make test-parser
make test-ppx-native
make test-css-support
make test-css-grammar
```

---

### Phase 2: Migrate `Lexer_test.re`

**Goal:** Remove dependency on `tokenize` from tests.

#### Step 2.1: Reuse existing helpers

`Lexer_test.re` already has a `parse` helper that uses `from_string`. The `soft_error_tests` and `test_with_location` already use it. Only `success_tests` and `lexer_error_tests` use `tokenize`.

Update `success_tests` to use the same pattern as `Lexer_from_string_test.re`:

```reason
// Change from:
let okInput = Lexer.tokenize(input) |> Result.get_ok;
let inputTokens = Lexer.to_string(okInput);

// Change to:
let (_, values) = parse(input);
let inputTokens = list_parse_tokens_to_string(values);
```

#### Step 2.2: Update `lexer_error_tests`

These test for `LexingError` exceptions. Keep using try/catch with `from_string`:

```reason
// Already correct pattern in Lexer_from_string_test.re:
let result = try {
  let _ = Lexer.from_string(input);
  None;
} {
| Lexer.LexingError((_, _, msg)) => Some(msg)
};
```

#### Step 2.3: Handle EOF difference

`tokenize` excludes EOF from results, `from_string` includes it. Test cases like `({||}, [EOF])` work with `from_string` but would return `[]` with `tokenize`. No action needed since we're moving to `from_string`.

#### Step 2.4: Handle list ordering

`from_string` returns tokens in **reverse order** (newest first). The `list_parse_tokens_to_string` helper already handles this with `List.rev`. Ensure all conversions apply `List.rev` appropriately.

#### Step 2.5: Verify

```bash
make test-parser
```

---

### Phase 3: Migrate `lexer_renderer.re`

**Goal:** Remove the last external dependency on `tokenize`.

#### Step 3.1: Current implementation

```reason
let okInput = Styled_ppx_css_parser.Lexer.tokenize(css) |> Result.get_ok;
let debug = Styled_ppx_css_parser.Lexer.to_debug(okInput);
```

#### Step 3.2: New implementation

```reason
let tokens = Styled_ppx_css_parser.Lexer.from_string(css);
let okInput = 
  tokens
  |> List.filter_map(({Styled_ppx_css_parser.Lexer.txt, loc}) =>
       switch (txt) {
       | Ok(t) => Some((t, loc.loc_start, loc.loc_end))
       | Error(_) => None
       }
     )
  |> List.rev;
let debug = Styled_ppx_css_parser.Lexer.to_debug(okInput);
```

#### Step 3.3: Manual smoke test

```bash
dune exec lexer-renderer ".a { color: red }"
```

Verify output matches before/after.

#### Step 3.4: Verify

```bash
make test-parser
```

---

### Phase 4: Refactor `get_next_tokens_with_location`

**Goal:** Remove `consume_or_raise` by inlining its logic.

#### Step 4.1: Current implementation

```reason
let consume_or_raise = lexbuf =>
  switch (consume(lexbuf)) {
  | Ok(token) => token
  | Error(msg) =>
    let (start_pos, curr_pos) = Sedlexing.lexing_positions(lexbuf);
    let error = Tokens.show_error(msg);
    raise(LexingError((start_pos, curr_pos, error)));
  };

let get_next_tokens_with_location = lexbuf => {
  let (position_start, _) = Sedlexing.lexing_positions(lexbuf);
  let token = consume_or_raise(lexbuf);
  let (_, position_end) = Sedlexing.lexing_positions(lexbuf);
  (token, position_start, position_end);
};
```

#### Step 4.2: Inlined implementation

```reason
let get_next_tokens_with_location = lexbuf => {
  let (position_start, _) = Sedlexing.lexing_positions(lexbuf);
  let token =
    switch (consume(lexbuf)) {
    | Ok(token) => token
    | Error(msg) =>
      let (start_pos, curr_pos) = Sedlexing.lexing_positions(lexbuf);
      raise(LexingError((start_pos, curr_pos, Tokens.show_error(msg))));
    };
  let (_, position_end) = Sedlexing.lexing_positions(lexbuf);
  (token, position_start, position_end);
};
```

#### Step 4.3: Verify

```bash
make test-parser
make test-ppx-native
make test-css-support
```

---

### Phase 5: Remove `tokenize` and `consume_or_raise`

**Goal:** Clean up unused code.

#### Step 5.1: Remove from `Lexer.re`

Delete:
- `consume_or_raise` function (already inlined)
- `tokenize` function

#### Step 5.2: Remove from `Lexer.rei`

Delete:
```reason
let tokenize:
  string =>
  result(list((Tokens.token, Lexing.position, Lexing.position)), string);
```

#### Step 5.3: Full verification

```bash
make test-parser
make test-ppx-native
make test-css-support
make test-css-grammar
make build
```

---

### Phase 6: Consolidate Test Files

**Goal:** Merge duplicate test coverage.

#### Step 6.1: Decision

Merge `Lexer_from_string_test.re` into `Lexer_test.re` since they test the same API with nearly identical cases.

#### Step 6.2: Process

1. Compare test cases between both files
2. Copy any unique tests from `Lexer_from_string_test.re` to `Lexer_test.re`
3. Delete `Lexer_from_string_test.re`
4. Update `packages/parser/test/Runner.re` to remove the reference
5. Update `packages/parser/test/dune` if needed

#### Step 6.3: Verify

```bash
make test-parser
```

---

## Verification Checklist

After each phase:

- [ ] `make build` succeeds with no warnings
- [ ] `make test-parser` passes
- [ ] `make test-ppx-native` passes
- [ ] `make test-css-support` passes
- [ ] `make test-css-grammar` passes

---

## Final State

### Remaining APIs in `Lexer.rei`

```reason
exception LexingError((Lexing.position, Lexing.position, string));

type token_with_location = {
  txt: result(Tokens.token, Tokens.error),
  loc: Ast.loc,
};

let from_string: string => list(token_with_location);
let get_next_tokens_with_location: Sedlexing.lexbuf => (Tokens.token, Lexing.position, Lexing.position);
let render_token: Tokens.token => string;
let position_to_string: Lexing.position => string;
let debug_token: ((Tokens.token, Lexing.position, Lexing.position)) => string;
let to_string: list((Tokens.token, 'a, 'b)) => string;
let to_debug: list((Tokens.token, Lexing.position, Lexing.position)) => string;
```

### Removed

- `tokenize` - replaced by `from_string`
- `consume_or_raise` - inlined into `get_next_tokens_with_location`

---

## Risk Assessment

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| List ordering bugs | Medium | Medium | Explicit `List.rev` in all conversions |
| `lexer_renderer` breaks silently | Medium | Low | Manual smoke test in Phase 3 |
| Missing test coverage after merge | Low | Medium | Careful comparison in Phase 6 |

---

## Future Considerations (Out of Scope)

These are not addressed by this plan but worth noting:

1. **Encoding inconsistency**: `driver.re` uses Latin1, `from_string` uses Utf8
2. **Dual error handling in `from_string`**: Some errors raise, some return in stream
3. **Helper function for extracting Ok tokens**: Could add convenience function to Lexer module

---

## Rollback Plan

Each phase is a separate logical unit. If issues are found:
1. Revert the specific phase's changes
2. All phases before the issue should remain stable
