/* End-to-end check that statement (`;`-terminated) at-rules flow through
   [%styled.global] the same way block (`{...}`-terminated) at-rules
   already do.

   `@charset`/`@import`/`@namespace` were already allowlisted for the
   statement form; `@layer`'s statement form (the standard
   layer-order-declaration syntax, no block) was not, so it died with a
   raw parser error before it ever reached the ppx (see
   .workplace/docs/parser-audit-defects.md #4). Statement vs block is now
   decided by what follows the prelude (`;` vs `{`), not by an at-rule
   name allowlist, so `@layer` gets both forms like everything else.

   `@layer base { ... }`, `@media (...) { ... }`, and `@font-face { ... }`
   are included alongside to prove the block form did not regress. */

module GlobalStyles = [%styled.global {|
  @charset "utf-8";
  @import url("reset.css");
  @namespace svg url(http://www.w3.org/2000/svg);
  @layer utilities;
  @layer a, b;
  @layer base {
    .example {
      color: red;
    }
  }
  @media (min-width: 1px) {
    .responsive {
      color: blue;
    }
  }
  @font-face {
    font-family: "Inter";
  }
  body {
    margin: 0;
  }
|}];
