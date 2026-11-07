# cx conformance suite

Differential tests for class merging. The oracle is `@emotion/css` 11.13.5
`cx`. Each case is rendered by the oracle and by a candidate, loaded in
headless Chromium, and compared property by property with `getComputedStyle`.

## Setup

```sh
cd packages/cx-conformance
npm ci
```

Node 22.6 or later (`--experimental-strip-types`). No browser download: the
runner uses `$CX_CHROMIUM`, else the newest
`~/.cache/ms-playwright/chromium_headless_shell-*`, else `/usr/bin/chromium`.

## Commands

From the repository root, `make test-cx` runs the self-test, then the `model`
and `ppx` candidates.

From `packages/cx-conformance`:

```sh
node --experimental-strip-types --no-warnings src/main.ts --candidate model
node --experimental-strip-types --no-warnings src/main.ts --candidate model,main-concat --report
node --experimental-strip-types --no-warnings src/main.ts --candidate ppx --filter 'T0*,shorthand-*'
node --experimental-strip-types --no-warnings src/main.ts --prior --candidate model
node --experimental-strip-types --no-warnings src/main.ts --generate 300 --seed 1
node --experimental-strip-types --no-warnings src/main.ts --self-test
node --experimental-strip-types --no-warnings src/main.ts --candidate model,ppx --write-pins
npm run typecheck
```

| Option | Meaning |
|---|---|
| `--candidate a,b` | `model`, `main-concat`, `ppx`, or a model variant (see self-test) |
| `--filter glob` | case ids, comma list, `*` and `?` |
| `--prior` | run the 37 cases of `src/prior.ts` instead of `cases/` |
| `--report` | write `report/<candidate>.md` and `report/<candidate>.json` |
| `--cap n` | orders per case (default 64); above it, a sample seeded by the case id |
| `--jobs n` | browser pages in parallel (default 8) |
| `--generate n --seed s` | random cases, model against cx, failures shrunk |
| `--refresh-coverage` | derive `coverage.json` again |
| `--write-pins` | run `model` and `ppx` on every case and write `pins.json` |

Exit code: 0 when every case has its expected result, 1 otherwise, 2 on a
harness error (invalid cases, no browser).

## Cases

`cases/*.ts` each export `cases: Case[]` (`src/case.ts`). The loader fails
with the case id when ids repeat, a merge name or `.$(name)` is not a block, a
`$(name)` is not in `vars`, or a probe names an element that is not in the
tree.

- `$(name)` becomes `vars[name].css`. `.$(name)` becomes the class of block
  `name`: the emotion class in the oracle, the binding id class in `model`,
  the atom class chain in `main-concat`.
- `orders`: `all-permutations` (default) permutes each merge list with two or
  more names, cartesian over elements. `as-written` uses the tree as is.
- A probe without `props` reads every longhand of every property in the
  case (expanded with `coverage.json`). When a block mentions `::before` or
  `::after`, the probe also reads those pseudo-elements.
- `viewport` defaults to 1024x768. `state` is forced on the element with CDP
  `CSS.forcePseudoState` (not on its ancestors).

## Statuses

| Status | Meaning | Expected |
|---|---|---|
| `pass` | every order matches cx | yes |
| `known-fail` | `expect: known-fail` and the orders differ exactly as `pins.json` records | yes |
| `fail` | `expect: pass` (default) and some order differs, or `expect: known-fail` and the differences are not the ones in `pins.json` | no |
| `now-passing` | `expect: known-fail` but every order matches: remove the pin | no |
| `error` | the oracle threw | no |

Pins (`expect`) apply to `model` and `ppx`. `main-concat` and the model
variants ignore them.

`pins.json` holds, per known-fail case, every difference line
(`order | probe | property: cx value, got value`) at the default `--cap`. One
list applies to both candidates; `{ "model": [...], "ppx": [...] }` when
they differ (the model and the generated sheet use different fixed orders,
so the losing merge order differs). A pin for a case that is not `known-fail` is a
harness error. After an accepted change, run `--write-pins` and review the
diff of `pins.json`. `--prior` and `--self-test` do not read `pins.json`.

## Candidates

- `emotion` (`src/candidates/emotion.ts`): the oracle. One `createEmotion`
  per case-order. Blocks are inserted lazily in tree pre-order: before an
  element's `cx(...merge)`, `css()` runs for each of its blocks (as
  written) not yet inserted, and for any block they reference. Blocks no
  element uses are inserted last. Baseline of 2026-11-06 (decision 10): cx
  plus the referenced bindings' classes. `.$(m)` becomes the rule-less marker
  class `b-m`, and every element whose merge list has a referenced `m` carries
  `b-m`. The emotion class of `m` still leaves the element when `m` is merged
  with another block.
- `model` (`src/candidates/model.ts`): the design in
  `.workplace/docs/property-class-design.md`, decisions of 2026-11-05.
  - Atoms: one per declaration. Context = selector scope + at-rule chain +
    `!important`. Declarations of one property in one block and one context
    form one atom. Inside the block, that atom takes the position of its
    last declaration (in `align-items:end; place-items:center;
    align-items:end` the `align-items` atom comes after `place-items`, so
    merge does not drop it). Identical atoms from different blocks are one
    class.
  - Bundles: inside one block, two declarations with overlapping longhands
    whose source order the fixed sheet cannot give go into one bundle class.
    Its rules are printed in the block's stylis order (plain declarations
    first, then nested rules in source order), as `cx` prints them. A pair
    needs a bundle when it is in one context with partial coverage
    (`border-top; border-color`), or in two contexts whose sheet key (tier,
    condition count) does not put the earlier one strictly first (two
    `@media`, `:hover` then `:active`, `@media & span` then `& span`). Two
    contexts overlap unless their subjects differ (descendant scope, own
    element, `::before`, `::after`); there is no other disjointness test.
    Bundling repeats until no pair between units breaks this rule; a bundle
    sorts with the largest tier and condition count of its rules. Atoms
    with no such partner stay single. Bundles are content-addressed per
    block, so a bundle never shares a class or a sheet position with
    another block's atoms.
  - Context normalization: a selector list gives one context per selector;
    whitespace in at-rule preludes is collapsed; the condition list is
    sorted (nested conditions are a conjunction); pseudo-classes at the end
    of the subject compound are sorted (`&:hover:focus` = `&:focus:hover`).
  - Sheet: tier 0 scopes where `&` is in a compound before the subject
    (`& > *`, `& td`, `& + &`), tier 1 own base (`&`, no condition), tier
    2 the rest (pseudo-classes, pseudo-elements, at-rules, ancestor scopes
    such as `.$(x) &`). Inside a tier: fewer
    conditions first, then larger coverage first (shorthand before longhand),
    then first use.
  - Merge `a b` = normalize(`a` ++ `b`): over the whole joined list, drop
    every atom whose (context, longhand) pairs the union of later atoms
    covers. For a bundle, these are the pairs of all its rules, so it is
    dropped only when later atoms cover every pair. Operands fold left, `(a b) c`, as `+++` does in OCaml. Because
    normalize sees the whole list, the result does not depend on grouping,
    and it also applies inside one operand.
  - Elements also carry a binding id class (`b-name`) for each referenced or
    empty block in their merge list. Merge never drops it.
  - Sibling scopes (decision 11): in a scope where `&` follows a `+` or `~`
    combinator, every `&` becomes the atom class plus the binding id of the
    block that wrote the rule (`.a0.b-s + .a0.b-s`). The atom is per block, and
    the block counts as referenced.
  - Variables (decision 12): `$(x)` stays `var(--cxv-x)` in the atom, and the
    element sets `--cxv-x` inline for every kept atom that reads it. A rule in
    a descendant tier (child, descendant, sibling) reads `--cxv-x-d` instead,
    and the element sets that name for such atoms. `vars` has one value per
    case, so a per-element value is not expressible; `--self-test` checks the
    role split with a changed inline value.
- `main-concat` (`src/candidates/main-concat.ts`): today's semantics. Same
  atoms without normalization or bundles, sheet in first-use order, merge =
  concatenation, `.$(x)` = atom chain.
- `ppx`: `pipeline/candidate.ts` when present (export `candidate`). The
  runner calls its optional `prepare(cases)` once before rendering and
  `close()` after; a thrown error with a `kind` is reported as
  `ppx <kind>: <message>`.

A new candidate implements `Candidate` from `src/case.ts` and returns
`{ css, html }`; the html must keep each element's `id`.

## Coverage table

`coverage.json` maps each shorthand (and alias) to the longhands it sets.
Method: for every property the browser exposes on `CSSStyleDeclaration`
that `CSS.supports(name, "initial")`, set `name: initial` on a scratch
element's inline style and read back the inline style's longhands. This
includes reset-only members (`font` sets `font-kerning`, `border` sets
`border-image-*`). `all` lists only itself, so for it every computed
longhand is read back instead. Logical and physical longhands stay separate.
A property used by a case and not yet checked is derived the same way and
kept in `extra`. The file records the Chromium version;
`--refresh-coverage` writes it again.

The oracle keeps emotion's default stylis prefixer, so `cx` output can
contain vendor-prefixed declarations that a candidate does not emit
(`color-adjust` becomes `-webkit-print-color-adjust`).

Probes call `finish()` on every running animation before reading, so a
`transition` does not leave a value half way after a viewport or state
change.

## Generator

`--generate n --seed s` builds `n` random cases from a fixed pool: values for
about 40 properties, grouped into families by shared longhands; contexts base,
`@media (min-width:700px)`, `@media (min-width:800px)` (overlapping),
`@media (max-width:600px)` (disjoint), `:hover`, `::before` with `content`,
and `& > *` on the parent; `!important` at 6%. Each case has 2-4 blocks, 1-3
elements (the first is the parent of the others) and random merge lists,
probed at widths 1024, 750 and 500, with and without `:hover`. Up to 12
orders per case.

Shapes are labelled with the issue or decision that accepts them (RT-01,
RT-05, RT-06, decisions 14 and 15). `NEW` and `OPEN` shapes are not accepted. A
`& > *` failure counts as decision 14 only when the child carries a block the
parent also carries; any other descendant failure is `NEW`.

A failing case is shrunk greedily (drop elements, blocks, merge entries,
declarations; move a declaration to base; drop `!important`; first value),
classified by shape, and the smallest case per shape is printed in case
format. The same seed gives the same output.

## Self-test

`--self-test` proves the harness detects failures, on `src/prior.ts`:

- `emotion` against itself: no difference.
- `model`: no unexpected result.
- Broken variants must fail given cases: `model-no-cover` (merge drops only
  the same property) T02 T03; `model-cross-context` (drop across contexts)
  T26 T28 T37; `model-no-tiers` (first-use sheet) T03 T26 T37;
  `model-no-reset-only` (no reset-only longhands for `font`, `border`) T09
  T10.
- Var roles: a child that sets its own value for the variable keeps the
  parent's `& > *` rule on the parent's value (8px, not 99px); with one var
  name per property (`vars: "one-name"`) the check must fail.

