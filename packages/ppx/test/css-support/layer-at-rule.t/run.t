Block-form `@layer name { ... }` inside [%css] is a conditional group rule
(issue #589): the layer context distributes over the block, each declaration
atomizes individually, and the layer name joins the atomization hash input —
so the same declaration in two different layers mints two different classes.
Statement form (`@layer a, b;`) and anonymous block form (`@layer { ... }`)
are rejected with dedicated errors. [%styled.global] behavior is unchanged.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (modules input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

Each declaration under @layer becomes its own `@layer name{.hash{...}}`
atom. `in_layer_a`/`in_layer_b` carry the identical `color:hotpink`
declaration yet mint DIFFERENT hashes, and both differ from the bare
`color:red` atoms' family — the layer name is part of the hash input.
The layer+media and media+layer nestings compose, preserving source
nesting order:

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css "@layer components{.css-1jmluld-simple{display:block}}"];
  [@css "@layer framework.base{.css-jvqord-dotted{color:red}}"];
  [@css "@layer a{.css-1j9ug93-in_layer_a{color:hotpink}}"];
  [@css "@layer b{.css-1cft20v-in_layer_b{color:hotpink}}"];
  [@css
    "@layer responsive{@media (min-width:600px){.css-zehemw-layer_then_media{color:red}}}"
  ];
  [@css
    "@media (min-width:600px){@layer responsive{.css-7623c0-media_then_layer{color:red}}}"
  ];
  [@css "@layer components{.css-1nfhwz9-with_selector:hover{color:blue}}"];
  [@css.bindings
    [
      ("Input.simple", "css-1jmluld-simple"),
      ("Input.dotted", "css-jvqord-dotted"),
      ("Input.in_layer_a", "css-1j9ug93-in_layer_a"),
      ("Input.in_layer_b", "css-1cft20v-in_layer_b"),
      ("Input.layer_then_media", "css-zehemw-layer_then_media"),
      ("Input.media_then_layer", "css-7623c0-media_then_layer"),
      ("Input.with_selector", "css-1nfhwz9-with_selector"),
    ]
  ];
  
  let simple = CSS.make("css-1jmluld-simple", []);
  
  let dotted = CSS.make("css-jvqord-dotted", []);
  
  let in_layer_a = CSS.make("css-1j9ug93-in_layer_a", []);
  
  let in_layer_b = CSS.make("css-1cft20v-in_layer_b", []);
  
  let layer_then_media = CSS.make("css-zehemw-layer_then_media", []);
  
  let media_then_layer = CSS.make("css-7623c0-media_then_layer", []);
  
  let with_selector = CSS.make("css-1nfhwz9-with_selector", []);
  
  let _ = (
    simple,
    dotted,
    in_layer_a,
    in_layer_b,
    layer_then_media,
    media_then_layer,
    with_selector,
  );

Statement form (`@layer a, b;`) is [%styled.global]-only — inside [%css]
it errors pointing there:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_statement)
  >  (modules invalid_statement)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -8
  File "invalid_statement.re", line 4, characters 2-8:
  4 |   @layer reset, base;
        ^^^^^^
  Error: Statement-form `@layer reset, base;` is not supported inside [%css]: it declares stylesheet-wide layer order, not styles for this class. Move it to a [%styled.global] block, where it passes through and is hoisted to the top of the generated stylesheet.

Anonymous block form (`@layer { ... }`) is rejected: a hash-minted layer
name would be observable in the cascade:

  $ cat > dune << EOF
  > (executable
  >  (name invalid_anonymous)
  >  (modules invalid_anonymous)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build 2>&1 | head -8
  File "invalid_anonymous.re", line 4, characters 2-8:
  4 |   @layer {
        ^^^^^^
  Error: Anonymous `@layer { ... }` is not supported inside [%css]: styled-ppx would have to invent the layer name. Layer names are cascade-visible, they define priority order and other stylesheets can re-open them, so a generated hash would reshuffle your cascade whenever the block's contents change. Name the layer: `@layer my-layer { ... }`.

[%styled.global] behavior is unchanged: the statement form passes through
verbatim, the block form flattens its inner nesting and stays put:

  $ cat > dune << EOF
  > (executable
  >  (name global)
  >  (modules global)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

  $ dune describe pp ./global.re | sed '1,/^];$/d'
  [@css "@layer reset,base,components;"];
  [@css "@layer base{body{margin:0}.card{color:red}.card:hover{color:blue}}"];
  
  module Layers = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = Layers.make;

End to end through the aggregator: block-form `@layer name{.hash{...}}`
contains a `{`, so it does NOT match the aggregator's statement-form
classifier — atomized layer rules stay in source position while the
statement `@layer reset,base,components;` hoists to the top:

  $ refmt --parse re --print ml input.re > input_pp.ml
  $ ../../standalone.exe --impl input_pp.ml -o input_pp.ml
  $ refmt --parse re --print ml global.re > global_pp.ml
  $ ../../standalone.exe --impl global_pp.ml -o global_pp.ml
  $ styled-ppx.generate global_pp.ml input_pp.ml > styles.css
  $ cat styles.css
  /* This file is generated by styled-ppx, do not edit manually */
  @layer reset,base,components;
  @layer base{body{margin:0}.card{color:red}.card:hover{color:blue}}
  @layer components{.css-1jmluld-simple{display:block}}
  @layer framework.base{.css-jvqord-dotted{color:red}}
  @layer a{.css-1j9ug93-in_layer_a{color:hotpink}}
  @layer b{.css-1cft20v-in_layer_b{color:hotpink}}
  @layer responsive{@media (min-width:600px){.css-zehemw-layer_then_media{color:red}}}
  @media (min-width:600px){@layer responsive{.css-7623c0-media_then_layer{color:red}}}
  @layer components{.css-1nfhwz9-with_selector:hover{color:blue}}
