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
    ".css-1m9rf13{background:red;}.css-1m9rf13.css-zlnhoy{background:blue;}"
  ];
  [@css
    ".css-15jd6vo{padding:1rem;}.css-15jd6vo.css-1jcvpdb{border-color:blue;}.css-15jd6vo.css-1t9q4wc{background:yellow;}"
  ];
  [@css ".css-1kdj4sx{display:flex;}.css-1kdj4sx .css-1x56c2i{color:black;}"];
  [@css.classes
    [
      ("css-1m9rf13", 0, "Input.container", "input.re", 19, 2, 24, 0),
      ("css-15jd6vo", 1, "Input.card", "input.re", 35, 2, 44, 0),
      ("css-1kdj4sx", 2, "Input.panel", "input.re", 54, 2, 59, 0),
    ]
  ];
  [@css.bindings
    [
      ("Input.active", "css-zlnhoy"),
      ("Input.container", "css-1m9rf13"),
      ("Input.selected", "css-1jcvpdb"),
      ("Input.highlighted", "css-1t9q4wc"),
      ("Input.card", "css-15jd6vo"),
      ("Input.actionButton", "css-1x56c2i"),
      ("Input.panel", "css-1kdj4sx"),
    ]
  ];
  
  let active = CSS.make("css-zlnhoy", []);
  
  let container = CSS.make("css-1m9rf13", []);
  
  let selected = CSS.make("css-1jcvpdb", []);
  let highlighted = CSS.make("css-1t9q4wc", []);
  
  let card = CSS.make("css-15jd6vo", []);
  
  let actionButton = CSS.make("css-1x56c2i", []);
  
  let panel = CSS.make("css-1kdj4sx", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
