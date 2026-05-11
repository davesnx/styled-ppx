/* Two styled.global2 modules in one file using the same expression.

   Hashing is content-addressed on the OCaml source `accent`, so the
   same `var(--var-<hash>)` is minted in both modules. Each module has
   its own self-contained to_string (which always rebuilds its own
   :root block), but they reference the same custom property name -
   harmless because they both bind it to the same value. */

let accent = CSS.blue;

module HeaderStyles = [%styled.global2 {|
  header {
    color: $(accent);
  }
|}];

module FooterStyles = [%styled.global2 {|
  footer {
    background-color: $(accent);
  }
|}];
