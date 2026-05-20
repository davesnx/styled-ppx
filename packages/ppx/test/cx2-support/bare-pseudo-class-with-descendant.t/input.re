/* Regression coverage for bare-leading-pseudo handling in `[%cx2]`.

   Per CSS Nesting Level 1 §3.1, a bare leading pseudo-class /
   pseudo-element selector descendant-joins with its parent
   (`<parent> :hover`), which rarely matches the typical author intent
   (`<parent>:hover`). The PPX rejects bare leading pseudos with a
   precise error and steers authors toward `&:hover` (compound) or
   `& :hover` (explicit descendant).

   This test exercises the spec-correct shapes only. The companion
   `bare-pseudo-class-error.t` test verifies the diagnostic. */

let _amp_pseudo_with_class_descendant = [%cx2 {|
  &:hover {
    .child { color: red; }
  }
|}];

let _amp_pseudo_with_type_descendant = [%cx2 {|
  &:hover {
    span { color: blue; }
  }
|}];

let _amp_pseudo_with_explicit_ampersand_descendant = [%cx2 {|
  &:hover {
    & .child { color: green; }
  }
|}];

let _amp_pseudo_with_compound_inner = [%cx2 {|
  &:hover {
    &:focus { color: yellow; }
  }
|}];

let _amp_pseudo_with_pseudo_element_inner = [%cx2 {|
  &:hover {
    &::after { color: orange; }
  }
|}];

/* Three-level (and deeper) nesting under an `&`-prefixed pseudo-class.
   Each nesting layer pushes the parent compound deeper into the `left`
   of the merged Combinator. The implementation must walk recursively
   through both `ComplexSelector(Selector(_))` wrappers and `left`
   chains so prefixes resolve correctly at any depth. */
let _amp_pseudo_three_levels = [%cx2 {|
  &:hover {
    .child {
      .grandchild { color: purple; }
    }
  }
|}];

let _amp_pseudo_five_levels = [%cx2 {|
  &:hover {
    .a {
      .b {
        .c {
          .d { color: pink; }
        }
      }
    }
  }
|}];

/* Mixed compound + descendant chain inside an `&`-pseudo. */
let _amp_pseudo_mixed_inner = [%cx2 {|
  &:hover {
    .a {
      &:focus {
        .b { color: brown; }
      }
    }
  }
|}];
