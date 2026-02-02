# Parser.mly Analysis

Analysis of `packages/parser/lib/Parser.mly` using menhir's diagnostic tools.

## Summary

Running `menhir --explain --strict packages/parser/lib/Parser.mly`:

| Metric | Count |
|--------|-------|
| States with shift/reduce conflicts | 54 |
| States with reduce/reduce conflicts | 4 |
| Shift/reduce conflicts arbitrarily resolved | 84 |
| Reduce/reduce conflicts arbitrarily resolved | 9 |
| Unused tokens | 1 |
| Unreachable symbols | 6 |

---

## Issue 1: Unused Token

```mly
%token <string> AT_KEYWORD
```

Declared on line 57 but never used in any grammar production.

**Fix**: Remove the declaration or wire it into the grammar.

---

## Issue 2: Unreachable Symbols (Dead Code)

These symbols exist but can't be reached from any start symbol:

| Symbol | Location | Notes |
|--------|----------|-------|
| `interpolation` | line 113 | Rule defined but never referenced |
| `prelude_any` | line 230 | Defined but never used |
| `skip_ws(value)` | line 95 | Only used by unreachable `prelude_any` |
| `loc(skip_ws(value))` | line 90 | Transitive dead code |
| `list(loc(skip_ws(value)))` | standard.mly | Transitive dead code |
| `delimited(option(WS),value,option(WS))` | standard.mly | Transitive dead code |

```mly
interpolation:
  v = INTERPOLATION { Variable v }  /* Never referenced! */

prelude_any: xs = list(loc(skip_ws(value))) { Paren_block xs }  /* Never referenced! */
```

**Fix**: Remove these unused rules.

---

## Issue 3: Whitespace Handling (Root Cause of Most Conflicts)

**The root cause of ~80% of conflicts**: The grammar uses `option(WS)` and `WS?` extensively, but `WS` is also a valid `value`. This creates systematic ambiguity.

### The Pattern

```mly
skip_ws(X): x = delimited(WS?, X, WS?) { x }
value: | WS { Whitespace } | ...
```

When the parser sees `WS`, it can either:
1. **Shift**: Consume `WS` as part of `option(WS)`
2. **Reduce**: Produce empty `option(WS)`, then let `values` start with `WS`

### Example: State 9

```
declaration -> loc(IDENT) option(WS) COLON . option(WS) loc(skip_ws(values)) ...
```

After seeing `property:`, when `WS` appears:
- Shift: `WS` is optional whitespace before value
- Reduce: Empty `option(WS)`, then `WS` becomes first value token

### Affected States

States 9, 10, 12, 42, 55, 57, 60, 67, 148, 149, 156, 165, 167, 175, 180, 182, 183, 185, 189, 194, 198, 203, 207, 229, 230, 234, 235, 250, 267, 269, 273, 277, 287, 289 (and more).

**Fix Options**:
1. Handle whitespace in the lexer - filter/collapse and only emit where truly needed
2. Remove `WS` as a `value` production
3. Use explicit whitespace handling instead of `option(WS)` patterns

---

## Issue 4: Ambiguous `declarations` Rule

```mly
declarations:
  | WS? xs = nonempty_list(rule) SEMI_COLON? { xs }
  | WS? xs = separated_nonempty_list(SEMI_COLON, rule) SEMI_COLON? { xs }
```

These alternatives overlap. After parsing a single rule:
- `nonempty_list(rule)` matches `[rule]`
- `separated_nonempty_list(SEMI_COLON, rule)` also matches `[rule]`

Causes **reduce/reduce conflicts** in states 70, 147, 210, 217.

**Fix**: Use only one approach:
```mly
declarations:
  | WS? xs = separated_nonempty_list(SEMI_COLON, rule) SEMI_COLON? { xs }
```

---

## Issue 5: `selector` vs `relative_selector` Ambiguity

In state 147, both reduce from the same input:

```mly
selector -> skip_ws_right(complex_selector)
relative_selector -> skip_ws_right(complex_selector)
```

Inside `:has()` or `:not()` pseudo-classes, the parser can't distinguish which to use.

```mly
pseudo_class_selector:
  | COLON f = FUNCTION xs = loc(relative_selector_list) RIGHT_PAREN /* :has() */
  | COLON f = FUNCTION xs = loc(selector_list) RIGHT_PAREN /* :not() */
```

**Fix**: Differentiate based on function name at the lexer level, or restructure to avoid needing both in the same context.

---

## Issue 6: `compound_selector` Construction Ambiguity

Six overlapping alternatives:

```mly
compound_selector:
  | t = type_selector sub = nonempty_list(subclass_selector) ps = pseudo_list { ... }
  | sub = nonempty_list(subclass_selector) ps = pseudo_list { ... }
  | t = type_selector sub = nonempty_list(subclass_selector) { ... }
  | sub = nonempty_list(subclass_selector) { ... }
  | t = type_selector ps = pseudo_list { ... }
  | ps = pseudo_list { ... }
```

Combined with `simple_selector -> type_selector`, parsing `div.class`:
- Is `div` a complete `simple_selector`?
- Or does `div` start a `compound_selector` continuing with `.class`?

Conflicts in states 132, 133, 144, 153.

**Fix**: Restructure to have clearer boundaries, possibly using factored rules.

---

## Issue 7: `combinator_sequence` Whitespace Ambiguity

```mly
combinator_sequence:
  | WS s = non_complex_selector { (None, s) }           /* WS as descendant combinator */
  | s = non_complex_selector WS? { (None, s) }          /* trailing WS */
  | c = combinator WS? s = non_complex_selector WS? { (Some c, s) }
```

Is whitespace:
- A descendant combinator (CSS spec)?
- Optional trailing whitespace?
- Part of the next element?

Conflicts in states 149, 156, 159, 161, 165, 167, 182, 183.

**Fix**: Make whitespace-as-combinator explicit and distinct from optional padding.

---

## Issue 8: `brace_block` Optional Semicolon

```mly
brace_block(X): xs = delimited(LEFT_BRACE, X, RIGHT_BRACE) SEMI_COLON? { xs }
```

The `SEMI_COLON?` after `}` conflicts with `SEMI_COLON?` in `declarations`:

```mly
declarations:
  | WS? xs = nonempty_list(rule) SEMI_COLON? { xs }
```

Parser can't decide which production "owns" the optional semicolon.

Conflicts in states 61, 223, 240, 283.

**Fix**: Remove `SEMI_COLON?` from `brace_block` - let the containing rule handle trailing semicolons.

---

## Issue 9: `keyframes` Start Ambiguity

```mly
keyframes:
  | rules = loc(keyframe) EOF { rules }
  | rules = brace_block(loc(keyframe)) EOF { rules }
```

Conflict at state 296: seeing `LEFT_BRACE` could mean:
- Start of `brace_block(loc(keyframe))`
- First `keyframe_style_rule` inside `loc(keyframe)`

**Fix**: Decide on one canonical form for keyframes input.

---

## Recommendations

### Immediate Fixes (Low Risk)

1. **Remove dead code**: Delete `AT_KEYWORD`, `interpolation`, and `prelude_any`
2. **Unify `declarations`**: Use single approach for rule lists

### Medium-Term Fixes

3. **Refactor whitespace handling**:
   - Option A: Filter whitespace in lexer, emit only significant tokens
   - Option B: Remove `WS` as a `value`, handle separately

4. **Use precedence declarations**: For intentional shift-preference cases, add `%left`/`%right`/`%nonassoc`

### Longer-Term Refactoring

5. **Restructure selectors**: Reduce overlap between `simple_selector`, `compound_selector`, `complex_selector`

6. **Separate concerns**: Consider splitting stylesheet parsing from value parsing more clearly

---

## Diagnostic Commands

```bash
# Full analysis with conflict explanations
menhir --explain --dump --strict packages/parser/lib/Parser.mly

# View conflicts only
cat packages/parser/lib/Parser.conflicts

# View automaton states
cat packages/parser/lib/Parser.automaton

# Preprocess and view expanded grammar
menhir --only-preprocess packages/parser/lib/Parser.mly

# Check if conflicts are LALR-specific
menhir --canonical packages/parser/lib/Parser.mly
```

---

## Files Referenced

| File | Purpose |
|------|---------|
| `packages/parser/lib/Parser.mly` | Menhir grammar definition |
| `packages/parser/lib/Parser.conflicts` | Generated conflict explanations |
| `packages/parser/lib/Parser.automaton` | Generated automaton states |
| `packages/parser/lib/Tokens.re` | Token type definitions |
| `packages/parser/lib/Lexer.re` | Lexer implementation |
