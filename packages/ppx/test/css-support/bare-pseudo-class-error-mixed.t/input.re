/* Mixed compound selectors with at least one non-pseudo component
   (Class / Id / Attribute / Type) are NOT rejected — those compounds
   are unambiguous in CSS Nesting (they get descendant-joined per
   spec, which is the only sensible interpretation). */
let _accepted_mixed_compound = [%css {|
  :hover.foo { color: red; }
|}];

let _accepted_pseudo_with_attr = [%css
  {|
  :hover[disabled] { color: red; }
|}
];

let _accepted_class_with_pseudo = [%css {|
  .a:hover { color: red; }
|}];

let _accepted_amp = [%css {|
  &:hover { color: red; }
|}];
