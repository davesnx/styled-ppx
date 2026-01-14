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

## Next Steps

1. **Answer the open questions above**
2. Create the folder structure
3. Implement core modules (Rule, Combinators, Modifier, Standard)
4. Implement the PPX (Generate, Css_grammar_ppx)
5. Implement POC properties
6. Write tests
7. Integrate with existing `styled-ppx`
