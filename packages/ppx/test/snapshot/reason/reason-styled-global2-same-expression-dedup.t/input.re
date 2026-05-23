/* Same OCaml expression interpolated multiple times in a single
   styled.global block.

   Hashing is keyed on the OCaml expression source (`themeColor`), so
   every $(themeColor) resolves to the same `var(--var-<hash>)`.
   The :root block in to_string MUST contain only one declaration for
   that var (dedup happens in Css_file.add_dynamic_var). The static
   rule still references the shared var from every position. */

let themeColor = CSS.red;

module ThemeStyles = [%styled.global
  {|
  body {
    color: $(themeColor);
    background-color: $(themeColor);
    border-color: $(themeColor);
  }
|}
];
