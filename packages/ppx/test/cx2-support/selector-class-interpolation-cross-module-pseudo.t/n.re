/* Cross-module ref inside a pseudo-class payload (`:not(...)`). The
   PPX recurses through the pseudo-class kind into the nested selector,
   so the sentinel ends up correctly nested inside the `:not(...)` in
   the rendered CSS. */
let button = [%cx2 {|
  background: blue;

  &:disabled:not(&.$(M.loadingState)) {
    background: gray;
  }
|}];
