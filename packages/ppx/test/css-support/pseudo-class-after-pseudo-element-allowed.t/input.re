/* A pseudo-class after a pseudo-element is valid, in at least one engine, for
   these, so none of them is rejected: `::part()` with a user-action
   pseudo-class, `::file-selector-button:hover`, `::placeholder:hover`
   (Firefox, WebKit), `::selection:window-inactive` (Chromium, WebKit), the `-webkit-` scrollbar and slider pseudo-elements,
   `::view-transition-old(x):only-child` and `::details-content:hover`.
   The right order, `&:hover::before`, stays accepted. */
let a = [%css {|
  &:hover::before { color: red; }
  &:not(.on)::after { color: red; }
  &::part(label):hover { color: red; }
  &::file-selector-button:hover { color: red; }
  &::placeholder:hover { color: red; }
  &::selection:window-inactive { color: red; }
  &::-webkit-scrollbar-thumb:hover { color: red; }
  &::-webkit-slider-thumb:hover { color: red; }
  &::view-transition-old(x):only-child { color: red; }
  &::details-content:hover { color: red; }
|}];
let _ = a;
