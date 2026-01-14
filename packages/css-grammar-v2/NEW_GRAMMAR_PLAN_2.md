# New CSS Grammar Architecture Plan

## Overview

Create a new `css-grammar` package that generates OCaml types and parsers from CSS BNF specifications using a PPX. The goal is to make the system more maintainable than the current 15,000+ line `Parser.ml`.

## Core Concepts

### PPX Extensions

Two PPX syntaxes:

```ocaml
(* Generate a spec record with rule, extract_interpolations, etc. *)
let property_margin = [%spec "[ <length> | <percentage> | 'auto']{1,4}"]

(* Generate both the type AND the spec record *)
[%%spec_t let property_margin = [%spec "[ <length> | <percentage> | 'auto']{1,4}"]]
```

### Generated Output

For `[%%spec_t let property_margin = [%spec "..."]]`:

```ocaml
type property_margin =
  [ `Length of length
  | `Percentage of percentage
  | `Auto
  ]
  list

let property_margin = {
  rule = ...;
  extract_interpolations = ...;
  runtime_module_path = Some "Css_types.Length";
}
```

---

## Open Questions

### 1. PPX Syntax Design

For the record-based approach (`[%spec]`), what shape should the record have?

```ocaml
type 'a spec = {
  rule: 'a Rule.rule;
  extract_interpolations: 'a -> (string * string) list;
  runtime_module_path: string option;
}
```

**Options:**
- A) This shape is correct
- B) Need additional fields (specify which)
- C) Different structure entirely

---

### 2. Interpolation Strategy

Currently, the existing system has "extended" types that explicitly include interpolation:

```ocaml
and extended_length =
  [ `Length of length
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]
```

For the new system with **pure CSS spec** (no `<extended-*>` types), how should interpolation work?

**Options:**
- A) Automatically injected at parser level (every data type parser checks for interpolation first)
- B) Part of the type definition but hidden from the generated type
- C) Something else

---

### 3. File Organization

How should the generated files be organized?

**Options:**
- A) One file per CSS category (e.g., `Box_model.ml` for margin/padding/border, `Colors.ml` for color-related)
- B) One file per property
- C) A single large generated file with all specs

---

### 4. Recursive Type Dependencies

Types like `calc()` and `color` have complex recursive dependencies:
- `calc-sum` → `calc-product` → `calc-value` → `extended-length` → `calc-sum`
- `color` → `rgb()` → `hue` → `angle`

**Options:**
- A) Use OCaml's recursive type definitions (`type ... and ...`)
- B) Use recursive modules
- C) Topologically sort dependencies and generate in order

---

### 5. toString Generation

Currently `Property_to_types.re` maps property names to `Css_types` modules for `toString`.

**Options:**
- A) PPX generates `toString` implementations that delegate to `Css_types`
- B) Keep a separate mapping file like `Property_to_types.re`
- C) Include a `runtime_module` field in the spec record that references the `Css_types` module

---

### 6. Registry/Lookup System

The current `Parser.ml` has a global registry for dynamic property lookup.

**Options:**
- A) Keep a similar global registry
- B) Use a different pattern (each module exports its own lookup)
- C) Both (module exports + registry for dynamic lookup)

---

### 7. POC Scope

Target properties: `margin`, `padding`, `border`, `layout_grid_mode`, `transition`, `line-height`, `position`, `background-color`, `color`

For `color`, this pulls in many dependencies (rgb(), hsl(), hwb(), lab(), etc.).

**Options:**
- A) Include full color spec with all functions
- B) Start with simplified color (named colors + hex + rgb only)
- C) Skip color functions for POC, just support interpolation

---

### 8. Testing Strategy

**Options:**
- A) Inline expect tests (`[%%expect ...]`)
- B) Separate test files with Alcotest
- C) Cram tests (like existing `packages/ppx/test/`)

---

### 9. New Package Location

**Options:**
- A) `packages/css-grammar-v2/` (completely new)
- B) Replace `packages/css-grammar/` (in-place)
- C) Start in `packages/css-grammar-new/` then migrate

---

### 10. Calc Support

`calc()`, `min()`, `max()` are complex because they can contain any numeric type.

**Options:**
- A) Include full calc support from the start
- B) Start without calc (just direct values + interpolation)
- C) Support calc but without full type checking inside the expression

---

## Dependencies to Create

### Core Modules

1. **`Css_data_types.ml`** - Base CSS data types
   - `length`, `angle`, `time`, `frequency`, `resolution`
   - `color`, `percentage`, `flex-value`
   - `css-wide-keywords`

2. **`Rule.ml`** - Parser monad (adapt from existing)

3. **`Combinators.ml`** - Parser combinators (adapt from existing)

4. **`Modifier.ml`** - Multiplier handling (adapt from existing)

5. **`Standard.ml`** - Basic parsers for data types

### PPX Module

1. **`Generate.ml`** - Core generation logic
   - Type generation from BNF
   - Parser generation from BNF
   - `extract_interpolations` generation

2. **`Css_grammar_ppx.ml`** - PPX entry point

### Property Modules (POC)

1. **`Box_model.ml`** - margin, padding, border
2. **`Layout.ml`** - position, layout-grid-mode
3. **`Typography.ml`** - line-height
4. **`Colors.ml`** - color, background-color
5. **`Transitions.ml`** - transition

---

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                     css-grammar-v2                          │
├─────────────────────────────────────────────────────────────┤
│  ppx/                                                       │
│  ├── Generate.ml          (type/parser generation)         │
│  └── Css_grammar_ppx.ml   (PPX entry point)                │
├─────────────────────────────────────────────────────────────┤
│  lib/                                                       │
│  ├── Rule.ml              (parser monad)                   │
│  ├── Combinators.ml       (xor, and, or, static)           │
│  ├── Modifier.ml          (?, *, +, {n,m})                 │
│  ├── Standard.ml          (basic parsers)                  │
│  ├── Css_data_types.ml    (base types)                     │
│  ├── Registry.ml          (property lookup)                │
│  │                                                          │
│  ├── properties/                                            │
│  │   ├── Box_model.ml     (margin, padding, border)        │
│  │   ├── Layout.ml        (position, layout-grid-mode)     │
│  │   ├── Typography.ml    (line-height)                    │
│  │   ├── Colors.ml        (color, background-color)        │
│  │   └── Transitions.ml   (transition)                     │
│  │                                                          │
│  └── values/                                                │
│      └── Color.ml         (color value type)               │
├─────────────────────────────────────────────────────────────┤
│  test/                                                      │
│  ├── test_box_model.ml                                     │
│  ├── test_layout.ml                                        │
│  ├── test_typography.ml                                    │
│  ├── test_colors.ml                                        │
│  └── test_transitions.ml                                   │
└─────────────────────────────────────────────────────────────┘
```

---

## Example: margin Property

### Input (BNF from CSS spec)

```
margin = [ <length-percentage> | auto ]{1,4}
```

### Generated Code

```ocaml
(* In Box_model.ml *)

[%%spec_t
  let property_margin = [%spec "[ <length-percentage> | 'auto' ]{1,4}"]
]

(* Expands to: *)

type property_margin =
  [ `Length_percentage of length_percentage
  | `Auto
  ] list

let property_margin = {
  rule = Modifier.repeat (1, Some 4) (
    Combinators.xor [
      Rule.Match.map length_percentage (fun v -> `Length_percentage v);
      Rule.Match.map (Standard.keyword "auto") (fun () -> `Auto);
    ]
  );
  extract_interpolations = fun value ->
    List.concat_map (function
      | `Length_percentage lp ->
          (match lp with
          | `Interpolation parts -> [(String.concat "." parts, "Css_types.Length")]
          | _ -> [])
      | `Auto -> []
    ) value;
  runtime_module_path = Some "Css_types.Length";
}
```

---

## Interpolation Examples

### Full Interpolation

```css
margin: $(foo)
```

The parser recognizes `$(foo)` as an interpolation token. The `extract_interpolations` function returns:
```ocaml
[("foo", "Css_types.Length")]
```

### Partial Interpolation

```css
margin: $(foo) 10px 20px 30px
```

The parser parses this as a list of 4 values. The `extract_interpolations` function returns:
```ocaml
[("foo", "Css_types.Length")]
```

The PPX consumer can then type-check that `foo` has type compatible with `Css_types.Length.t`.

---

## Analysis Conclusions (from codebase review)

### Current Implementation Gaps

**1. `extract_interpolations` is limited in current Parser.ml:**

The current implementation in `Parser.ml` lines 15308-15329 only handles **full interpolations**:

```ocaml
let get_interpolation_types ~name value : (string * string) list =
  match find_rule name with
  | Some (Pack_rule { rule; runtime_module_path; _ }) ->
    let rule_with_universal =
      Combinators.xor
        [
          Rule.Match.map Standard.interpolation (fun data -> `Interpolation data);
          Rule.Match.map Standard.css_wide_keywords (fun data -> `Css_wide_keyword data);
          Rule.Match.map function_var (fun data -> `Var data);
          Rule.Match.map (Obj.magic rule) (fun _ -> `Value);
        ]
    in
    (* Only checks if ENTIRE value is interpolation, not partial *)
    ...
```

This means `margin: $(x) 10px` currently **does NOT** extract the interpolation type - only `margin: $(x)` does.

**2. The PPX-generated `extract_interpolations` in Generate.re DOES walk the structure:**

Looking at `Generate.re` lines 817-1073, it generates a proper recursive function that walks the parsed value. However, it has an issue with **type inference order** in Xor combinators.

**3. `pack_rule` doesn't include `extract_interpolations`:**

```ocaml
let pack_rule (type a) (rule : a Rule.rule)
  ?(runtime_module_path : string option) () : packed_rule =
  Pack_rule { rule; validate; runtime_module_path }
  (* No extract_interpolations field! *)
```

The new architecture should include `extract_interpolations` in the packed rule.

---

### Type Inference Issue Explained

For a spec like `line-height: 'normal' | <number> | <length> | <percentage>`:

When we parse `line-height: $(lh)`:
- The interpolation token `$(lh)` could match any of `<number>`, `<length>`, or `<percentage>` (all support interpolation)
- Current PPX returns type based on **which variant matched** (implementation-dependent order)
- Should return `Css_types.LineHeight` for full interpolation

When we parse `line-height: $(lh)` with a partial value like `font: 12px/$(lh) sans-serif`:
- Here we know `$(lh)` is in the line-height position
- Should return `Css_types.LineHeight` or one of the valid alternatives

**Recommendation:** For full property interpolation, return the property's `runtime_module_path`. For partial interpolation within a complex value, use the sibling type in the Xor.

---

## Additional Questions

### 11. Interpolation Type Resolution Strategy

For full interpolation (`margin: $(x)`), we want `Css_types.Margin` (or `Length`).
For partial interpolation (`margin: $(x) 10px`), we want `Css_types.Length`.

**Options:**
- A) Always return the most specific type from the position in the spec
- B) Full interpolation returns property type, partial returns position type
- C) Return multiple valid types and let the consumer choose

---

### 12. Extended Types vs Pure CSS Spec

Current Parser.ml uses `<extended-length>` which includes `calc()` and interpolation:

```ocaml
and extended_length =
  [ `Length of length
  | `Function_calc of calc_sum
  | `Interpolation of string list
  | `Function_min of calc_sum list
  | `Function_max of calc_sum list
  ]
```

The plan mentions using **pure CSS spec** without extended types.

**Question:** How do we handle the fact that CSS properties like `margin` actually accept `calc(10px + 5%)` and `min(10px, 5%)`?

**Options:**
- A) Keep extended types but auto-generate them from pure spec
- B) Have the parser automatically wrap with calc/interpolation support at the Standard.ml level
- C) Define `<length-percentage>` as a special composite type that includes calc

---

### 13. Spec Record Shape with Extract Interpolations

The current plan shows:

```ocaml
type 'a spec = {
  rule: 'a Rule.rule;
  extract_interpolations: 'a -> (string * string) list;
  runtime_module_path: string option;
}
```

Should we add more fields?

**Potential additions:**
- `validate: string -> (unit, string) result` - Quick validation without full parse
- `to_string: 'a -> string` - Convert parsed value back to CSS
- `name: string` - The CSS property name for error messages

---

### 14. The `[%spec]` vs `[%%spec_t]` Split

The plan shows two PPX forms. Clarifying the use cases:

```ocaml
(* [%spec] - Expression level, returns a spec record *)
let margin = [%spec "[ <length-percentage> | 'auto' ]{1,4}"]

(* [%%spec_t] - Structure level, generates BOTH type AND binding *)
[%%spec_t let margin = [%spec "[ <length-percentage> | 'auto' ]{1,4}"]]
```

**Question:** When would we use `[%spec]` without `[%%spec_t]`?

**Possible use cases:**
- A) Anonymous rules that don't need a named type
- B) Combining multiple specs dynamically
- C) Testing/debugging

---

### 15. How to Handle Property Name → Spec Name Mapping

CSS uses `margin-left`, OCaml uses `margin_left`, types might be `MarginLeft`.

**Question:** Where does this mapping live?

**Options:**
- A) PPX generates based on convention (kebab → snake for values, kebab → pascal for types)
- B) Explicit mapping in the spec definition
- C) Registry handles the mapping

---

### 16. `length-percentage` Handling

`<length-percentage>` is used extensively but isn't a single CSS data type - it's a shorthand for `<length> | <percentage>`.

**Question:** How should this be handled?

**Options:**
- A) Define it explicitly in `Css_data_types.ml` as a union type
- B) PPX expands it inline wherever used
- C) Special-case in Generate.ml

Current `Standard.re` doesn't have `length_percentage` - properties define it inline.

---

## My Recommendations

Based on the analysis:

### Answer to Q1 (PPX Syntax Design): **Option A with additions**
```ocaml
type 'a spec = {
  rule: 'a Rule.rule;
  extract_interpolations: 'a -> (string * string) list;
  runtime_module_path: string option;
  validate: string -> (unit, string) result;  (* Add this *)
}
```

### Answer to Q2 (Interpolation Strategy): **Option A**
Automatically inject at parser level. Each data type parser in `Standard.ml` should:
```ocaml
let length_with_interp = Combinators.xor [
  Rule.Match.map Standard.length (fun l -> `Length l);
  Rule.Match.map Standard.interpolation (fun i -> `Interpolation i);
]
```

### Answer to Q3 (File Organization): **Option A**
One file per category keeps things manageable.

### Answer to Q4 (Recursive Types): **Option C**
Topological sort. OCaml's `type ... and ...` gets unwieldy with many types.

### Answer to Q5 (toString): **Option C**
Include `runtime_module_path` in the spec record. The PPX consumer uses this to call `Css_types.X.toString`.

### Answer to Q6 (Registry): **Option C**
Both - modules export their specs, registry aggregates for dynamic lookup.

### Answer to Q7 (POC Scope): **Option B**
Start with simplified color for POC. Full color spec is complex.

### Answer to Q8 (Testing): **Option B**
Alcotest - more flexible than expect tests for this use case.

### Answer to Q9 (Package Location): **Option A**
`packages/css-grammar-v2/` - clean separation, no risk to existing code.

### Answer to Q10 (Calc Support): **Option B for POC, then A**
Start without calc, add it after core architecture is solid.

### Answer to Q11 (Interpolation Type Resolution): **Option B**
Full interpolation returns property type, partial returns position type. This matches user expectations.

### Answer to Q12 (Extended Types): **Option B**
Have the parser automatically wrap with calc/interpolation support at the Standard.ml level. The spec stays pure CSS, but `Standard.length` internally checks for `calc()` and `$(...)`.

### Answer to Q13 (Spec Record): **Add `validate`**
```ocaml
type 'a spec = {
  rule: 'a Rule.rule;
  extract_interpolations: 'a -> (string * string) list;
  runtime_module_path: string option;
  validate: string -> (unit, string) result;
}
```

### Answer to Q14 ([%spec] vs [%%spec_t]): **Both needed**
- `[%spec]` for inline rules and value types (not properties)
- `[%%spec_t]` for property definitions that need named types

### Answer to Q15 (Name Mapping): **Option A**
PPX generates based on convention. Keep it simple.

### Answer to Q16 (length-percentage): **Option A**
Define it explicitly in `Css_data_types.ml`:
```ocaml
type length_percentage =
  [ `Length of length
  | `Percentage of float
  | `Interpolation of string list
  ]
```

---

## Next Steps

1. **Answer the open questions above** ← davesnx to review recommendations
2. Create the folder structure
3. Implement core modules (Rule, Combinators, Modifier, Standard)
4. Implement the PPX (Generate, Css_grammar_ppx)
5. Implement POC properties
6. Write tests
7. Integrate with existing `styled-ppx`
