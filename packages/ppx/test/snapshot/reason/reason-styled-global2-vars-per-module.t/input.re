/* Two styled.global modules in one file using the same expression.

   Each module gets its own custom property for `accent`, and its own
   to_string sets that property in its own :root block, so the two
   modules never share a variable. */

let accent = CSS.blue;

module HeaderStyles = [%styled.global
  {|
  header {
    color: $(accent);
  }
|}
];

module FooterStyles = [%styled.global
  {|
  footer {
    background-color: $(accent);
  }
|}
];
