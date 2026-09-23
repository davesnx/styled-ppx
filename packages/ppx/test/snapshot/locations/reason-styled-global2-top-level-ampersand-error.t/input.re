/* A parentless `&` inside [%styled.global] has no selector to resolve
   against. The old pipeline shipped it literally to the extracted
   stylesheet (`&:hover { ... }`), which browsers discard. It now raises
   a compile error with a precise location. */

module Broken = [%styled.global
  {|
  &:hover {
    color: red;
  }
|}
];
