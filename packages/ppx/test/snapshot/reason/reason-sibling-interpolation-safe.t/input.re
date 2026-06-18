/* Safe look-alikes for the subtree-escaping guard: every selector here
   pairs a sibling combinator (or a descendant) with a value interpolation,
   yet the subject stays inside `&`'s subtree (or is `&` itself), so the
   inline custom property is still readable. These must continue to extract
   `var(--var-x)` rather than being rejected. Contrast with the broken
   `& + .x` shape, which is a hard error (see the css-support error tests). */

let color = CSS.Types.Color.toString(`hex("3A57FC"));

/* Subject is `&` itself (self-sibling): the next instance carries its own
   inline var. */
let selfSibling = [%css {|
  & + & {
    color: $(color);
  }
|}];

/* Subject is `&` (a sibling precedes it). */
let siblingBeforeAmpersand = [%css {|
  .x + & {
    color: $(color);
  }
|}];

/* A child step before the sibling keeps the subject inside `&`'s subtree. */
let childThenSibling = [%css {|
  & > * + * {
    color: $(color);
  }
|}];

/* The canonical working case: descendant interpolation. */
let descendant = [%css {|
  & .child {
    border-color: $(color);
  }
|}];

/* A sibling rule with a literal value hoists nothing, so it is unaffected. */
let literalSibling = [%css {|
  & + .x {
    color: red;
  }
|}];
