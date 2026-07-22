# Deterministic Buckets for Atomic CSS Ordering

This document proposes a deterministic ordering scheme ("buckets") for the
atomic CSS emitted by static extraction, and records why the current
first-occurrence ordering is a correctness hazard. It also analyzes the
companion problem — property conflicts in `CSS.merge` — and why buckets
alone do not solve it.

See also:

- `documents/css-extraction.md` — wire protocol (`[@@@css ...]`) and the
  `styled-ppx.generate` aggregator this proposal modifies.
- `documents/design.md` — parser/atomization pipeline
  (`packages/ppx/src/Css_file.re`).

## Status

- Proposal. Not implemented.
- Evidence gathered from `demo/melange` (bindings `queryOrder`,
  `queryOrderReversed`, `linkFirst`, `nthFirst` in
  `demo/melange/lib/native/shared/Main.re`).

## Background: how ordering works today

Atomization (`Css_file.re:atomize_rules`) turns every declaration into an
independent rule keyed by a content hash (`Hash_class.class_and_namespace`,
murmur2 over the rendered rule). The aggregator
(`packages/generate/generate.ml`) concatenates rules:

- files in the order dune passes them,
- within a file, `[@@@css ...]` attribute order (= source order),
- deduplicated by exact rule string, **keeping the first occurrence**.

There is no sorting and no grouping. An at-rule atom carries its own
wrapper, so three `@container` atoms emit three separate
`@container (...) { ... }` blocks.

### Consequences (observed in the demo)

All atomic classes have specificity `(0,1,0)` (plus whatever the selector
suffix adds), so equal-specificity conflicts are resolved purely by
stylesheet position — which is *first-writer-wins across the whole app*:

1. **A binding cannot express at-rule precedence if another binding got
   there first.** `queryOrder` declares `@media` → `@container` →
   `@supports` for the same `color`; `queryOrderReversed` declares the
   opposite. Both dedup to the same three atoms in `queryOrder`'s order.
   When all three conditions match, `@supports` wins for *both* elements,
   contradicting `queryOrderReversed`'s source.

2. **Equal-specificity selector ties are non-local.** `& a:link` vs
   `& a:nth-child(odd)` (both `(0,2,1)`): whichever binding is compiled
   first fixes the winner for every other binding sharing those atoms.

3. **Refactors silently flip winners.** Moving a binding, renaming a file,
   or reordering dune deps changes first-occurrence order and can change
   rendering with no diff in any `.re` file.

4. **Dev and prod cascade order differ.** Dev keeps `-<label>` suffixes,
   which fork atoms per binding (no dedup: `css-k008qs-stack` and
   `css-k008qs-card` are separate rules at separate positions). Prod
   (`--minify`) dedups to a single rule at the first position. A tie can
   resolve differently between dev and prod — a "works in dev, breaks in
   prod" class of bug.

## Goals

- Stylesheet order is a **function of the rule itself**, never of which
  file/binding was compiled first.
- Dev and prod produce the **same cascade order**.
- Common intent ("media query overrides base", "hover overrides rest
  state", "wider breakpoint overrides narrower") works without the author
  thinking about emission order.

## Non-goals

- Per-binding custom precedence between at-rule kinds. Buckets deliberately
  remove that expressiveness in exchange for predictability (this is the
  StyleX/Tailwind trade-off). Escape hatches: raise specificity
  (`&&`-style doubling, if/when supported), or `[%styled.global]`.
- Property-conflict resolution in `CSS.merge`. Buckets fix *stylesheet*
  order, not *merge* semantics — see "What buckets do not solve".

## Design

### Bucket taxonomy

Every extracted rule is assigned a bucket. The stylesheet is emitted as
buckets in a fixed order; rules never interleave across buckets.

| # | Bucket | Contents |
|---|--------|----------|
| 0 | Registrations | `@property` registrations |
| 1 | Keyframes | `@keyframes` (referenced by name; position-independent) |
| 2 | Globals | `[%styled.global]` output (author-controlled order preserved within) |
| 3 | Base | plain declarations (`.css-x{...}`) and compound/descendant selectors without pseudo-classes |
| 4 | Structural pseudos | `:first-child`, `:nth-child()`, `:empty`, … |
| 5 | `:link` | LVFHA begins |
| 6 | `:visited` | |
| 7 | `:focus-within` | |
| 8 | `:hover` | |
| 9 | `:focus` | |
| 10 | `:focus-visible` | |
| 11 | `:active` | |
| 12 | Pseudo-elements | `::before`, `::placeholder`, … |
| 13 | `@supports` | |
| 14 | `@media` | sorted by breakpoint, see below |
| 15 | `@container` | container conditions apply "closer" to the element than viewport conditions, hence after `@media` |
| 16 | `@starting-style` | must be able to override everything it transitions from |

Rationale for the at-rule tail: a rule wrapped in a condition is almost
always an *override* of the unwrapped base, so conditional buckets come
after selector buckets. `@supports` guards are typically feature gates for
base styling (least override-like), viewport media next, container queries
are the most local/specific conditional, and `@starting-style` exists only
to be transitioned away from.

When a rule matches several dimensions (e.g. `@media (...) { &:hover }`),
the **outermost at-rule wins** and the inner pseudo-class orders *within*
the bucket (secondary key), preserving LVFHA inside each media block.
Nested conditionals (`@supports { @media }`) key on the outermost wrapper.

### Within-bucket ordering

Within a bucket, sort by a stable key rather than first occurrence:

1. secondary key: pseudo-class rank (for at-rule buckets), then
2. breakpoint key (for `@media`, below), then
3. the atom's content hash (final tiebreak).

Hash as the final key makes the order fully deterministic and independent
of file order, dedup, labels, and refactors. The winner between two
*genuinely conflicting* same-bucket atoms (two plain `color` atoms) becomes
arbitrary-but-stable.

**Caveat — this is coupled to phase 2.** The runtime docs
(`packages/website/content/reference/runtime.mdx`, "Merging") currently
*document* definition order as the override mechanism: "define base styles
before the styles that override them". Hash tiebreak deliberately destroys
that mechanism without replacing it. Therefore:

- **Phase 1 (buckets alone): keep first-occurrence within buckets.** This
  preserves the documented convention. Refactor hazard (#3) and dev/prod
  divergence (#4) survive *within* a bucket, but inter-kind ordering,
  breakpoint ordering, and LVFHA are fixed — the majority of accidental
  breakage.
- **Phase 2 (property-keyed merge): switch to hash tiebreak.** Once
  `CSS.merge` resolves conflicts by property key, definition order stops
  being the override mechanism, and hash tiebreak closes #3/#4 completely.
  Dropping label suffixes (dev/prod parity) also fully lands here, since
  first-occurrence order is what labels perturb.

  Groundwork already landed: the `styles` carrier is
  `(className, vars, label)` with `CSS.label`/`CSS.make_labeled`
  accessors, generated code and the `styles=` JSX expansion go through
  `CSS.className`/`CSS.styles` instead of `fst`/`snd` (including
  server-reason-react's copy of the expansion), so the carrier
  representation is free to evolve — dropping the `-<label>` class-name
  suffix in dev only requires moving DevTools attribution onto the
  carrier label / `cx-` marker.

### `@media` breakpoint sorting

Within bucket 14, parse the condition for a single `min-width`/`max-width`
(or range-syntax `width >= …` / `width <= …`) feature:

- `min-width` atoms sort ascending (mobile-first: wider wins),
- `max-width` atoms sort *after* min-width atoms, descending
  (desktop-first: narrower wins),
- unparseable/mixed conditions sort last, by raw condition string.

This is the `postcss-sort-media-queries` convention. Same scheme applies to
`@container` with `width`-based conditions.

### Label suffixes must go (dev/prod parity — phase 2)

Buckets fix ordering *between* rules, but dev labels still fork one atom
into N rules. This lands in phase 2 together with the hash tiebreak (both
change which rule wins first-occurrence ties). To make dev and prod
structurally identical:

- stop appending `-<label>` to class names entirely,
- keep binding identity in the DOM via the existing `--dev` marker classes
  (`cx-<label>`, `Dev_mode.marker`), which are unhashed, unstyled, and
  don't touch the stylesheet.

After this, `--minify` only controls whitespace; dev and prod stylesheets
contain identical rules in identical order.

### Where it is implemented

**In the aggregator (`packages/generate/generate.ml`), not the PPX.**
Ordering is a whole-stylesheet property; the PPX only sees one module.
The aggregator already sees every rendered rule, and the bucket is
derivable from the rendered rule string alone:

- starts with `@property` / `@keyframes` / `@supports` / `@media` /
  `@container` / `@starting-style` → buckets 0/1/13/14/15/16,
- otherwise scan the selector (the prefix before `{`) for pseudo-element
  (`::`) then pseudo-class tokens → buckets 4–12,
- otherwise bucket 3.

No wire-protocol change is required for a first implementation. If prefix
classification proves too fragile (selector strings containing `:` inside
attribute selectors, etc.), extend the `[@@@css ...]` payload to carry an
explicit bucket tag computed by `Css_file.re` from the AST, where
classification is exact. The AST-side classification is the better
long-term home; string classification is the cheaper first step.

Global rules (bucket 2) and keyframes are already emitted through separate
channels (`add_global_rule`), which maps directly onto buckets 0–2.

**Sort must be stable** and applied after dedup. Dedup can keep its current
first-occurrence semantics; position is recomputed by the sort anyway.

### Runtime consistency

Extraction covers all live extension points, so the browser stylesheet is
fully aggregator-controlled. `CSS.make` only sets class names and inline
CSS variables; it inserts no rules. No runtime change is needed for
ordering. (If a runtime insertion path is ever added, it must insert into
per-bucket `<style>` regions or use `@layer`, below.)

### Optional: make buckets explicit with `@layer`

Emitting each bucket inside a named layer:

```css
@layer sppx.base, sppx.pseudo, sppx.supports, sppx.media, sppx.container;
```

makes precedence robust even if a bundler concatenates stylesheets in the
wrong order, and self-documents the scheme in devtools. Cost: `@layer`
changes interaction with *user* CSS (unlayered author styles beat layered
ones — arguably a feature for a styling library). Recommended as a
follow-up behind a flag, not part of the initial change: buckets-by-order
alone already fix the bugs and are inert for consumers.

## What buckets do not solve: `CSS.merge` property conflicts

`CSS.merge` (`packages/runtime/melange/CSS.ml:22`) concatenates class
names. If `base` and `override` both set `color`, the winner is stylesheet
position; with buckets, that position is a hash tiebreak — deterministic,
but ignoring merge order. `merge(base, override)` still cannot express
"override wins".

### Why "sortable hashes" don't fix this

Class-attribute order is irrelevant to the cascade, so no property of the
class *names* — sortable or otherwise — can change which rule wins. Sorting
the stylesheet by hash (which buckets already do as a tiebreak) makes the
winner stable, not correct.

What a hash *can* do is carry identity: encode the property and selector
context into a prefix, e.g.

```
css-<hash(property + context)>-<hash(value)>
```

Then `merge` resolves conflicts at runtime: split each class on the last
`-`, keep the **last** class per prefix. This is the StyleX model, and it
is the real fix for merge. Costs, in order of severity:

1. **Shorthands.** `margin` and `margin-top` have different prefixes but
   conflict. String-keyed resolution cannot see this. StyleX's answer is to
   ban or expand shorthands; we would need longhand expansion in the PPX
   (we already parse values, so expansion is feasible but a large surface).
2. **Context key must include selector + at-rule wrappers**, or
   `&:hover { color }` would wrongly clobber `color`. The key is
   `(property, pseudo chain, at-rule chain)` — exactly the bucket key plus
   property, so this composes naturally with buckets.
3. **Runtime cost**: `merge` becomes a small map-build per call instead of
   string concat. Negligible for typical component trees, but it is the
   first time `merge` does per-class work.
4. **Class name length** grows by one hash segment (~7 chars/atom).

### Where the key lives: class string vs structured data

Encoding the key in the class *name* (above) is one of two carriers:

- **A — token classes**: `css-<keyHash>-<valueHash>`; `merge` parses class
  strings. Keeps `styles = (string, Style.t)` unchanged, but tokens must
  survive into production HTML (SSR payload + DOM bytes roughly double),
  hashed keys are opaque at runtime (no shorthand conflict groups), and
  bundle classes (one class, many declarations) cannot be represented.
- **B — structured data** (StyleX model): `styles` carries
  `array((key, className))`; `merge` is a right-biased union. No parsing,
  clean class names, key *sets* for bundles, structured keys enable
  shorthand conflict groups. Cost: the `styles` representation changes and
  JS bundles grow by one key per atom (measurable; must be benchmarked on
  `demo/melange` before committing).

B requires sealing the `styles` type. The tuple is destructured in exactly
two places outside the runtime: our own generator
(`packages/ppx/src/generate.re:333,341`) and server-reason-react's
`styles-attribute` ppx (`styles_attribute.ml:44`, emits `fst`/`snd` into
user code for the `styles=` JSX prop on both platforms — invoked from
`ppx.re:628` on melange). Both can migrate to the `CSS.className` /
`CSS.styles` accessors, which exist in every shipped runtime, so the
migration is compatible in both directions and needs no flag day:

1. server-reason-react PR: `styles_attribute.ml` emits `CSS.className` /
   `CSS.styles` (user-scope identifiers, like it already does for
   `ReactDOM.Style.combine`). Works with all existing styled-ppx versions.
2. styled-ppx: `generate.re` swaps its own `fst`/`snd` for the accessors.
3. Later: bump the pin, add a `server-reason-react >= <next>` bound, add an
   `.mli` sealing `styles`. From then on A vs B is an internal, reversible
   choice.

Recommendation: treat property-keyed atoms + conflict-resolving `merge` as
**phase 2**, independent of buckets. Steps 1–2 are riskless prep and ship
with phase 1; the A-vs-B decision waits for the bundle-size measurement
(expectation: B wins unless the number is surprising).

### Open problem: bundle classes (blocking for phase 2)

Interpolated blocks share one class covering *several* declarations
(`Css_file.re` bundle classes). If a bundle sets `{color, padding}` and a
merge overrides `color`, key-based eviction cannot work: removing the
bundle class would drop `padding`; keeping it leaves a stylesheet rule
that still declares `color`, so both rules apply and the tie falls back to
stylesheet order. Candidate resolutions, none decided:

- **Un-bundle**: one class per interpolated declaration. Exact semantics;
  re-opens the var-count/`@property`-count cost that motivated bundling.
  Needs measurement on a real app.
- **All-or-nothing keys**: a bundle claims all its keys; a partial conflict
  is documented UB (warn in dev via the runtime when a merge partially
  overlaps a bundle).
- **Hybrid**: un-bundle only multi-property bundles; single-declaration
  bundles (the common case) already have exact keys.

Phase 2 must resolve this before it ships; it is the one place where the
design is not yet closed.

## Guarantees and non-guarantees

What the full plan (phase 1 + phase 2) does and does not fix:

**Fixed outright**: dev/prod cascade divergence; refactor/file-order
flipping winners; breakpoint ordering; LVFHA ordering; `merge` conflicts on
the same property in the same context (including interpolated values —
keys are per-property, vars are inline per element).

**Fixed by fiat**: cross-context conflicts. `merge(a, b)` where `a` has
`@media print { color }` and `b` has base `color` keeps both atoms
(different keys); the *bucket policy* decides (media wins in print),
regardless of merge order. Deterministic and documented, but a caller can
never express "my base override beats their media query" through `merge`.
Same semantics as StyleX.

**Fixed only with extra work**: shorthand vs longhand across merges
(conflict-groups table); bundle classes (open problem above).

**Not fixable by any ordering/merge scheme**:

- Specificity: `.css-x li:nth-child(odd) a` beats `.css-x a:link` by
  weight at any stylesheet position.
- Selector equivalence: `& .child` vs `& div.child` are different keys
  forever; bucket/hash decides.
- Bypassing `merge`: hand-concatenated `className` strings and external
  classes (global CSS, other libraries) never participate in conflict
  resolution.
- Inheritance and cross-element cascade.

## Alternatives considered

- **Global sort by hash, no buckets.** Deterministic, but breaks intended
  semantics wholesale: `@media` overrides could land before base rules.
  Buckets are the minimum structure that keeps common intent working.
- **Keep first-occurrence, document it.** Rejected: refactor hazard and
  dev/prod divergence are the bugs actually likely to ship breakage.
- **`@layer` only, no sorting.** Layers fix inter-bucket precedence but
  within-layer order would still be first-occurrence; hazards #3/#4 remain.
- **Emotion-style "insert at use site" runtime.** Abandons static
  extraction; out of scope by design.

## Migration and testing

Breaking change to stylesheet output order (not to selectors, hashes, or
class names). Plan:

1. Implement bucket classification + stable sort in `generate.ml`.
   Buckets are the default; `--sort=source` is a one-release escape hatch
   (pre-1.0, no compatibility shims by policy).
2. Prep for phase 2 (riskless, ships alongside): `generate.re` and
   server-reason-react's `styles_attribute.ml` migrate from `fst`/`snd` to
   the `CSS.className`/`CSS.styles` accessors.
3. Promote snapshot/cram tests (`packages/generate/test/*.t`,
   `packages/ppx/test/css-support/*.t`); add:
   - a bucket-order test asserting the full taxonomy order from a single
     module that declares them shuffled;
   - a cross-file test asserting reversed declaration order across files
     converges on the same stylesheet order for shared atoms;
   - a breakpoint-sort test (`min-width` asc, `max-width` desc, mixed);
   - a globals test asserting `[%styled.global]` rules keep source order.
4. Update `demo/melange` — `queryOrder` vs `queryOrderReversed` becomes a
   demonstration that both orders converge on the same (bucketed) result.
5. Phase 2 (separate pass): label suffix removal everywhere + hash
   tiebreak + sealed `styles` + property-keyed merge; add the dev-vs-prod
   parity test (rule-for-rule identical output modulo whitespace) there.

## Open questions

- Should structural pseudos (bucket 4) split further (`:nth-child` after
  `:first-child`)? Probably not — no established convention, hash tiebreak
  is fine.
- `@container` with named containers: sort key includes container name?
  Proposed: name is part of the raw-string tiebreak only.
- Do we ever need author-controlled buckets (à la Tailwind `@layer
  components`)? Deferred until someone asks with a concrete case.
- Phase 2 (property-keyed merge): expand shorthands in the PPX or ban them
  in atomic contexts? Needs its own document.
