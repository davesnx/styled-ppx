/* Single value interpolation in styled.global2.

   The static rule extracts as `body{color:var(--var-...)}` (the
   self-reference half). The generated module's `to_string` builds the
   actual `body{color:<value>}` at runtime by reading the in-scope
   `themeColor` binding.

   Note: this test uses a regular CSS property (`color`) rather than a
   custom property like `--primary` because custom-property
   interpolation typing is a pre-existing gap (the PPX emits
   `Cascading.toString` for unknown property names, which only handles
   keyword values). For now, users wanting to interpolate values into
   custom properties should manually convert at the call site, e.g.
   `let primary_str = CSS.Types.Color.toString CSS.red` then
   `$(primary_str)` after also adapting the binding to a string-typed
   property like `unsafe`. */

let themeColor = CSS.red;

module ThemeStyles = [%styled.global2 {|
  body {
    color: $(themeColor);
    margin: 0;
  }
|}];
