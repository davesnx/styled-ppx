/* `@layer base { ... }`, `@media (...) { ... }`, and `@font-face { ... }`
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
