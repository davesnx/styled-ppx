/* Mixed compound selectors with at least one non-pseudo component
   (Class / Id / Attribute / Type) are NOT rejected — those compounds
   are unambiguous in CSS Nesting (they get descendant-joined per
   spec, which is the only sensible interpretation). */
let _accepted_mixed_compound = [%cx2 {|
  :hover.foo { color: red; }
|}];

let _accepted_pseudo_with_attr = [%cx2 {|
  :hover[disabled] { color: red; }
|}];

let _accepted_class_with_pseudo = [%cx2 {|
  .a:hover { color: red; }
|}];

let _accepted_amp = [%cx2 {|
  &:hover { color: red; }
|}];
