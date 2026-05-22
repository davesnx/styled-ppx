/* The empty class idiom: an empty [%css {||}] binding is purely a
   className handle. The consumer applies it conditionally (e.g. via
   `Cn2.ifTrue`) and a sibling [%css] block targets it via `&.$(name)`.

   For this to work, the empty body must mint a deterministic class
   name so the `$(name)` selector reference resolves to a real class
   chain. Otherwise the `&.$(name)` qualifier silently collapses and
   the rule applies unconditionally — a miscompile.

   The synthetic class is `css-<hash-of-empty>-<binding>` and NO
   `[@@@css ...]` rule is emitted for the empty class itself: there's
   nothing to write. The class only appears in the *consumer*'s
   compound selector and in the `CSS.make` className string. */

let active = [%css {||}];

let container = [%css
  {|
  background: red;

  &.$(active) {
    background: blue;
  }
|}
];

/* Two empty bindings in the same file mint distinct classNames because
   the binding label is part of the format, even though the hash
   prefix is the same (it's hashed against the empty body). */

let selected = [%css {||}];
let highlighted = [%css {||}];

let card = [%css
  {|
  padding: 1rem;

  &.$(selected) {
    border-color: blue;
  }

  &.$(highlighted) {
    background: yellow;
  }
|}
];

/* The descendant variant `& .$(name)` (note the space) must also
   resolve. This is the "empty class for a child element" pattern. */

let actionButton = [%css {||}];

let panel = [%css
  {|
  display: flex;

  & .$(actionButton) {
    color: black;
  }
|}
];

let _ = (active, container, selected, highlighted, card, actionButton, panel);
