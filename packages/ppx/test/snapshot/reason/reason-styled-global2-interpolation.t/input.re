/* Single value interpolation in styled.global.

   The static rule extracts as `body{color:var(--var-...)}` (the
   self-reference half). The generated module's `to_string` builds the
   actual `body{color:<value>}` at runtime by reading the in-scope
   `themeColor` binding.

   For custom-property interpolation (`--foo: $(expr)`) see
   `reason-styled-global2-custom-property-interpolation.t` - those go
   through the `CustomProperty` var_type and accept any `string`
   expression verbatim. */

let themeColor = CSS.red;

module ThemeStyles = [%styled.global
  {|
  body {
    color: $(themeColor);
    margin: 0;
  }
|}
];
