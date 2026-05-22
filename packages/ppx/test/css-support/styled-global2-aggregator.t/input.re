/* End-to-end aggregator check for styled.global.

   The PPX emits each top-level rule as a [@@@css ...] attribute (with
   `var(--var-<hash>)` already substituted for interpolation positions).
   The aggregator harvests those attributes and writes them to the
   final stylesheet.

   The runtime `:root { --var-<hash>: <value>; }` block lives inside the
   generated module's to_string and MUST NOT appear in styles.css - that
   block is supplied at runtime by mounting <Module.make /> or calling
   to_string () on native. */

let primary = CSS.red;

module ThemeStyles = [%styled.global {|
  body {
    color: $(primary);
    margin: 0;
  }
  html {
    box-sizing: border-box;
  }
|}];
