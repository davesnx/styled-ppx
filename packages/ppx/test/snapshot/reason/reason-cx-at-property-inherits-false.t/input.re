/* @property{syntax:"*";inherits:false} for `&`-local interpolation vars. A
   non-inheriting var does not reach descendants, so changing it invalidates
   only the element, not its subtree. Emitted only when every rule reading the
   var matches `&` itself; a descendant reads it via inheritance and must keep
   the default. The rule is content-deduped, so a var reused N times ships one
   registration. */

let color = CSS.Types.Color.toString(`hex("3A57FC"));
let str = "literal";

/* Top-level on `&`: registers @property. */
let topLevel = [%css {| color: $(color) |}];

/* `&:hover` is the same element: registers. */
let hover = [%css {| &:hover { color: $(color) } |}];

/* `@media` does not change the matched element: registers. */
let media = [%css {| @media (max-width: 768px) { color: $(color) } |}];

/* Descendant reads the var via inheritance: no @property. */
let descendant = [%css {| & .child { color: $(color) } |}];

/* Shared bundle var read by `.child` via inheritance: no @property, even though
   the base and descendant atoms share one var. */
let bundleSpan = [%css {| color: $(color); & .child { color: $(color) } |}];

/* The `$(str)` feeder is `&`-local and registers; the `--brand` property it
   feeds is untouched and still inherits. */
let customFeeder = [%css {| --brand: $(str) |}];

/* A pseudo-element is a separate box that reads the originating element's
   custom properties via inheritance — an inherits:false var set inline on `&`
   is invisible to it. No @property. */
let pseudoElement = [%css {| &::placeholder { color: $(color) } |}];

/* CSS2 legacy single-colon pseudo-element spelling parses as a pseudo-class
   but still creates a separate box: no @property. */
let legacyPseudoElement = [%css {| &:before { color: $(color) } |}];

/* The base atom is `&`-local but the same var is also read by `&::before`
   (through inheritance), so the var must keep the default. */
let mixedPseudo = [%css {| color: $(color); &::before { color: $(color) } |}];

/* Pseudo-CLASSES restrict which states of `&` match — still `&`'s own box:
   registers. */
let pseudoClassOnly = [%css {| &:focus-visible:not(:disabled) { color: $(color) } |}];
