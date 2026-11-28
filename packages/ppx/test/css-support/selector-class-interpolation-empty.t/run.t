Empty `[%css {||}]` bindings are minted as a unique className handle
with no extracted CSS rule. Consumer `&.$(name)` and `& .$(name)`
selectors must resolve to that handle, not silently drop.

Without this, the bug shape is: `let m = [%css {||}]` registers no class,
then `&.$(m) { ... }` resolves to nothing, the `&.$(m)` qualifier is gone
from the extracted selector, and the rule applies unconditionally to every
consumer.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

The empty binding `active` has the class `css-zlnhoy` (a hash of module,
scope and binding name).
No `[@@@css ...]` is emitted for it — there's nothing to write. The
consumer `container`'s nested rule keeps the `.css-zlnhoy` qualifier,
so `background: blue` only applies when the class is actually present
on the element.

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-ivpcxxf{background:red;}.css-ivpcxxf.css-ivpchoy{background:blue;}"
  ];
  [@css
    ".css-ivpcdxl{padding:1rem;}.css-ivpcdxl.css-ivpcpdb{border-color:blue;}.css-ivpcdxl.css-ivpc4wc{background:yellow;}"
  ];
  [@css ".css-ivpcc39{display:flex;}.css-ivpcc39 .css-ivpcc2i{color:black;}"];
  [@css.classes
    [
      ("css-ivpchoy", (-1), "Input.active", "input.re", 15, 21, 15, 21),
      ("css-ivpcxxf", 0, "Input.container", "input.re", 19, 2, 24, 0),
      ("css-ivpcpdb", (-1), "Input.selected", "input.re", 30, 23, 30, 23),
      ("css-ivpc4wc", (-1), "Input.highlighted", "input.re", 31, 26, 31, 26),
      ("css-ivpcdxl", 1, "Input.card", "input.re", 35, 2, 44, 0),
      ("css-ivpcc2i", (-1), "Input.actionButton", "input.re", 50, 27, 50, 27),
      ("css-ivpcc39", 2, "Input.panel", "input.re", 54, 2, 59, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input.active", "css-ivpchoy"),
      ("Input.container", "css-ivpcxxf"),
      ("Input.selected", "css-ivpcpdb"),
      ("Input.highlighted", "css-ivpc4wc"),
      ("Input.card", "css-ivpcdxl"),
      ("Input.actionButton", "css-ivpcc2i"),
      ("Input.panel", "css-ivpcc39"),
    ]
  ];
  
  let active = CSS.make("css-ivpchoy", []);
  
  let container = CSS.make("css-ivpcxxf", []);
  
  let selected = CSS.make("css-ivpcpdb", []);
  let highlighted = CSS.make("css-ivpc4wc", []);
  
  let card = CSS.make("css-ivpcdxl", []);
  
  let actionButton = CSS.make("css-ivpcc2i", []);
  
  let panel = CSS.make("css-ivpcc39", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
