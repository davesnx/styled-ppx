/* Block-form `@layer name { ... }` inside [%css] is treated as a
   conditional group rule (issue #589): the layer context distributes over
   the block's declarations, each atomized and hashed individually — the
   same mechanism as `@media`. The layer name joins the atomization hash
   input (via the rendered `@layer name{...}` wrapper), so identical
   declarations in different layers mint different classes. */

/* Simple block form. */
let simple = [%css {|
  @layer components {
    display: block;
  }
|}];

/* Dotted sub-layer names are just prelude component values and pass
   through untouched. */
let dotted = [%css {|
  @layer framework.base {
    color: red;
  }
|}];

/* The same declaration in two different layers must yield two DIFFERENT
   class hashes: cascade behavior differs per layer, so the atoms cannot
   dedup into one class. */
let in_layer_a = [%css {|
  @layer a {
    color: hotpink;
  }
|}];

let in_layer_b = [%css {|
  @layer b {
    color: hotpink;
  }
|}];

/* Group-rule nesting composes in both directions. */
let layer_then_media = [%css {|
  @layer responsive {
    @media (min-width: 600px) {
      color: red;
    }
  }
|}];

let media_then_layer = [%css {|
  @media (min-width: 600px) {
    @layer responsive {
      color: red;
    }
  }
|}];

/* Selectors nested inside @layer resolve `&` against the minted class. */
let with_selector = [%css {|
  @layer components {
    &:hover {
      color: blue;
    }
  }
|}];

let _ = (
  simple,
  dotted,
  in_layer_a,
  in_layer_b,
  layer_then_media,
  media_then_layer,
  with_selector,
);
