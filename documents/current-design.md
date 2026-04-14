# Current CSS Pipeline Design

This document describes the code as it exists today.

It is a baseline for redesign work, not the target architecture.

## Status

- Current implementation snapshot
- Focused on `packages/parser` and `packages/css-grammar`
- Descriptive, not prescriptive

## Pipeline At A Glance

Today the pipeline is split in two layers:

1. `packages/parser` lexes and parses full CSS input into a structural AST.
2. `packages/css-grammar` validates declaration values and some at-rule preludes
   with property-specific grammars.

The important detail is that the handoff between those layers is still mostly a
string boundary, not a shared typed value AST.

## `packages/parser`

### Main responsibility

`packages/parser` owns the full CSS syntax front-end.

Its job is to understand the outer shape of the stylesheet:

- lexing CSS input in `packages/parser/lib/Lexer.re`
- managing context-sensitive lexer modes in
  `packages/parser/lib/Lexer_context.re`
- defining the token vocabulary in `packages/parser/lib/Tokens.re`
- parsing declarations, rules, selectors, keyframes, and at-rules in
  `packages/parser/lib/Parser.mly`
- producing the shared AST in `packages/parser/lib/Ast.re`

### What it parses well

This package already owns most of the structural CSS language:

- declaration lists and standalone declarations
- full rule lists and stylesheets
- selector syntax, including compound and complex selectors
- nesting syntax through `&`
- pseudo-classes, pseudo-elements, attribute selectors, and `nth-*`
- `@keyframes` plus generic at-rules with preludes and blocks
- interpolation tokenization for `$(...)`

### What it returns

The parser AST is strong on structure and weak on value semantics.

- declarations carry `name`, `important`, and `value`
- style rules carry a typed selector AST for the prelude
- at-rules carry `name`, `prelude`, and `block`

The important current contract is:

- declaration values are stored as `component_value_list`
- at-rule preludes are also stored as `component_value_list`

That means the parser preserves value syntax, but it does not attach
property-specific meaning to most values.

### Extra responsibilities beyond parsing

`packages/parser` also contains post-parse helpers that are important to the
current pipeline:

- `packages/parser/lib/Render.re` turns the AST back into CSS text
- `packages/parser/lib/Resolve.re` resolves nested selectors
- `packages/parser/lib/Transform.re` expands nested selectors and prepares rules
  for extraction/runtime-oriented output

So today this package is not just a parser. It is also the owner of the
structural AST, selector rewriting, and AST-to-string rendering.

### What it does not own

`packages/parser` does not currently own:

- property-specific type checking
- typed value ASTs for declarations
- typed parsing of most at-rule preludes
- runtime lowering into `CSS.*` expressions

## `packages/css-grammar`

### Main responsibility

`packages/css-grammar` owns CSS value grammar and semantic validation.

Its job is to answer questions like:

- is this value valid for property `width`?
- if a value contains interpolation, what runtime type should that interpolation
  have?
- does this media query prelude match the supported grammar?

### Main building blocks

The package is split into a few layers:

- `packages/css-grammar/lib/Rule.re` provides the rule engine over token lists
- `packages/css-grammar/lib/Combinators.re` implements CSS grammar combinators
- `packages/css-grammar/lib/Modifier.re` implements repetition and optionality
- `packages/css-grammar/lib/Css_value_types.re` defines primitive token matchers
  such as lengths, angles, strings, identifiers, interpolation, and keywords
- `packages/css-grammar/lib/Parser.ml` contains the big registry of value,
  function, property, and media-query grammars plus the public entrypoints

### Generated grammar layer

`packages/css-grammar` is partly handwritten and partly generated.

- `packages/css-grammar/ppx/Css_grammar_ppx.re` defines `[%spec]` and
  `[%spec_module]`
- `packages/css-grammar/ppx/Generate.re` turns CSS spec strings into concrete
  parser modules and extraction helpers
- `packages/css-grammar/lib/Parser.ml` uses those generated modules to register
  properties, values, functions, and media-query rules

This package is therefore the semantic grammar engine for CSS values, not the
full stylesheet parser.

### Public responsibilities today

The current public API in `packages/css-grammar/lib/Parser.ml` is centered on:

- `check_property` for property validation
- `get_interpolation_types` for typed interpolation extraction
- `parse` for property-specific or value-specific parsing
- `parse_at_rule_prelude` for media-query style prelude parsing
- `suggest_property_name` for diagnostics

### What it does not own

`packages/css-grammar` does not currently own:

- full stylesheet parsing
- selector parsing or nesting
- declaration block parsing
- source slicing / location recovery from the original CSS string

## How The Packages Connect Today

### Declaration validation

For declarations, the flow is currently:

1. `packages/parser` parses the CSS snippet into a declaration AST.
2. The declaration value remains a generic `component_value_list`.
3. The PPX renders that value back to a string with
   `Styled_ppx_css_parser.Render.component_value_list`.
4. `packages/css-grammar` reparses that string with a property-specific grammar
   through `Css_grammar.Parser.check_property`.

So the parser owns the initial syntax tree, but css-grammar owns the semantic
decision about whether the property value is valid.

### `[%cx2]` interpolation typing

The extraction path repeats the same boundary:

1. `packages/parser` produces the declaration AST.
2. `packages/ppx/src/Css_file.re` renders the value list back to text.
3. `packages/css-grammar` reparses that text with
   `Css_grammar.Parser.get_interpolation_types`.
4. The extracted interpolation metadata is then used to pick CSS variable names
   and runtime module witnesses.

### Runtime lowering

Runtime generation introduces a second string boundary:

1. `packages/parser` records source locations for declaration values.
2. `packages/ppx/src/Css_to_runtime.re` slices the original source text back out
   with `source_code_of_loc`.
3. `packages/ppx/src/Property_to_runtime.re` validates/parses that string again
   through `Css_grammar.Parser.check_property` and `Css_grammar.Parser.parse`.
4. The typed value is then lowered into `CSS.*` runtime expressions.

So even after the initial stylesheet parse, runtime generation still relies on
the original source string instead of a shared typed value tree.

### At-rule preludes

At-rule preludes follow the same pattern, but less consistently.

- `packages/parser` stores generic prelude values on the AST.
- `@media` is later sliced back to source text and reparsed by
  `Css_grammar.Parser.parse_at_rule_prelude`.
- `@container` is currently kept largely as raw text during runtime generation,
  even though `packages/css-grammar` already contains container-related grammar
  rules.

## Where The Responsibilities Are Clean

There is already a useful conceptual split:

- `packages/parser` owns structural CSS syntax
- `packages/css-grammar` owns semantic value grammar

That split is reasonable at a high level.

## Where They Overlap Today

The overlap is not mostly about ownership on paper. It is about duplicated work
and a leaky boundary in practice.

### 1. Shared token and lexer model

`packages/css-grammar` does not define its own token model. It reuses
`Styled_ppx_css_parser.Tokens` and the parser lexer.

That means:

- `packages/parser` owns the token vocabulary
- `packages/css-grammar` is tightly coupled to that vocabulary
- value parsing logic in css-grammar still depends on parser-level tokenization

### 2. Two parses of the same value

The same declaration value is typically:

- lexed and parsed once by `packages/parser`
- rendered back to a string
- lexed and parsed again by `packages/css-grammar`

For runtime lowering it may be parsed yet another time through the
property-specific runtime path.

### 3. Two representations for declaration values

Both packages understand declaration values, but at different semantic levels:

- `packages/parser` represents them as generic `component_value_list`
- `packages/css-grammar` represents them as property-specific typed values

The redesign problem is not that either representation is wrong. It is that the
current pipeline crosses between them through strings instead of through a
shared intermediate structure.

### 4. Interpolation handling is split across layers

Interpolation is recognized in both places:

- `packages/parser` tokenizes and preserves `$(...)`
- `packages/css-grammar` decides what type an interpolation should have in a
  given value position
- runtime lowering handles interpolation again when building `CSS.*`

So interpolation support is cross-cutting rather than owned by one clean layer.

### 5. At-rule preludes exist in both generic and typed forms

Both packages have a notion of at-rule prelude syntax:

- `packages/parser` stores a generic prelude AST for every at-rule
- `packages/css-grammar` defines typed grammars for media queries and container
  conditions

But those typed grammars are not the canonical representation carried by the
parser AST.

### 6. Rendering is part of the semantic boundary

`packages/parser/lib/Render.re` is currently part of the handoff between parsing
and type checking.

That is a strong sign that the parser/css-grammar boundary is still text-based,
even after the initial parse succeeded.

## Current Boundary Summary

The current split can be summarized like this:

- `packages/parser` answers: "what is the structural shape of this CSS?"
- `packages/css-grammar` answers: "is this value valid for this property, and
  what typed meaning does it have?"

The main architectural weakness is that the boundary between those answers is
mostly a rendered string.

## Current Design Takeaways

- The parser already has strong ownership of stylesheet syntax, selectors,
  nesting, and source locations.
- css-grammar already has strong ownership of property/value semantics,
  interpolation typing, and value-level grammars.
- The current connection between them is the weak point: render to string,
  re-lex, reparse, and sometimes slice source text again.
- Any redesign should treat the parser/css-grammar handoff itself as the main
  problem area, more than the high-level package split.
