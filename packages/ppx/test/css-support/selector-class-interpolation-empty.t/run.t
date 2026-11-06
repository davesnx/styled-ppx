Empty `[%css {||}]` bindings are minted as a unique className handle
with no extracted CSS rule. Consumer `&.$(name)` and `& .$(name)`
selectors must resolve to that handle, not silently drop.

Without this, the bug shape is: `let m = [%css {||}]` registers `m -> []`
in the per-file class registry, then `&.$(m) { ... }` resolves to an
empty class chain (`List.map(_, []) = []`), the `&.$(m)` qualifier is
gone from the extracted selector, and the rule applies unconditionally
to every consumer.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

The empty binding `active` mints a binding id (hash of module, scope and
binding name). No rule is emitted for it, because there is nothing to write. The
consumer `container`'s nested rule keeps the id as a qualifier,
so `background: blue` only applies when the class is actually present
on the element.

  $ dune describe pp ./input.re
  [@ocaml.ppx.context
    {
      tool_name: "ppx_driver",
      include_dirs: [],
      hidden_include_dirs: [],
      load_path: ([], []),
      open_modules: [],
      for_package: None,
      debug: false,
      use_threads: false,
      use_vmthreads: false,
      recursive_types: false,
      principal: false,
      no_alias_deps: false,
      unboxed_types: false,
      unsafe_string: false,
      cookies: [],
    }
  ];
  [@css.atoms
    [
      (
        "_a4hT1uK_l",
        ["._a4hT1uK_l{background:red;}"],
        1,
        0,
        9,
        [("value", "T1uK_l", "val\\04h\\0& | \\0background:red")],
      ),
      (
        "_c4hBENvGZQAM_5L",
        ["._c4hBENvGZQAM_5L._iluOI4zYi{background:blue;}"],
        2,
        1,
        9,
        [
          ("ctx", "BENvGZ", "ctx\\0&._iluOI4zYi | "),
          ("value", "QAM_5L", "val\\04h\\0&._iluOI4zYi | \\0background:blue"),
        ],
      ),
      (
        "_afyeH052M",
        ["._afyeH052M{padding:1rem;}"],
        1,
        0,
        4,
        [("value", "eH052M", "val\\0fy\\0& | \\0padding:1rem")],
      ),
      (
        "_c5kkn2nErhiu6iI",
        ["._c5kkn2nErhiu6iI._i-2yQxf20{border-color:blue;}"],
        2,
        1,
        4,
        [
          ("ctx", "kn2nEr", "ctx\\0&._i-2yQxf20 | "),
          ("value", "hiu6iI", "val\\05k\\0&._i-2yQxf20 | \\0border-color:blue"),
        ],
      ),
      (
        "_c4h9-n-D1gypHII",
        ["._c4h9-n-D1gypHII._iUuvKz6fh{background:yellow;}"],
        2,
        1,
        9,
        [
          ("ctx", "9-n-D1", "ctx\\0&._iUuvKz6fh | "),
          ("value", "gypHII", "val\\04h\\0&._iUuvKz6fh | \\0background:yellow"),
        ],
      ),
      (
        "_a9fMU0SCS",
        ["._a9fMU0SCS{display:flex;}"],
        1,
        0,
        1,
        [("value", "MU0SCS", "val\\09f\\0& | \\0display:flex")],
      ),
      (
        "_c7fPPr647RMF621",
        ["._c7fPPr647RMF621 ._isj_AlCHx{color:black;}"],
        0,
        1,
        1,
        [
          ("ctx", "PPr647", "ctx\\0& ._isj_AlCHx | "),
          ("value", "RMF621", "val\\07f\\0& ._isj_AlCHx | \\0color:black"),
        ],
      ),
      (
        "_iluOI4zYi",
        [],
        1,
        0,
        0,
        [("id", "_iluOI4zYi", "bind\\0\\0Input\\0\\0active\\00")],
      ),
      (
        "_i5xwEIDfv",
        [],
        1,
        0,
        0,
        [("id", "_i5xwEIDfv", "bind\\0\\0Input\\0\\0container\\00")],
      ),
      (
        "_i-2yQxf20",
        [],
        1,
        0,
        0,
        [("id", "_i-2yQxf20", "bind\\0\\0Input\\0\\0selected\\00")],
      ),
      (
        "_iUuvKz6fh",
        [],
        1,
        0,
        0,
        [("id", "_iUuvKz6fh", "bind\\0\\0Input\\0\\0highlighted\\00")],
      ),
      (
        "_iFPpHlqxh",
        [],
        1,
        0,
        0,
        [("id", "_iFPpHlqxh", "bind\\0\\0Input\\0\\0card\\00")],
      ),
      (
        "_isj_AlCHx",
        [],
        1,
        0,
        0,
        [("id", "_isj_AlCHx", "bind\\0\\0Input\\0\\0actionButton\\00")],
      ),
      (
        "_iabkBhnjd",
        [],
        1,
        0,
        0,
        [("id", "_iabkBhnjd", "bind\\0\\0Input\\0\\0panel\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.active", "_iluOI4zYi", "_iluOI4zYi"),
      (
        "Input.container",
        "_i5xwEIDfv _a4hT1uK_l _c4hBENvGZQAM_5L",
        "_i5xwEIDfv",
      ),
      ("Input.selected", "_i-2yQxf20", "_i-2yQxf20"),
      ("Input.highlighted", "_iUuvKz6fh", "_iUuvKz6fh"),
      (
        "Input.card",
        "_iFPpHlqxh _afyeH052M _c5kkn2nErhiu6iI _c4h9-n-D1gypHII",
        "_iFPpHlqxh",
      ),
      ("Input.actionButton", "_isj_AlCHx", "_isj_AlCHx"),
      ("Input.panel", "_iabkBhnjd _a9fMU0SCS _c7fPPr647RMF621", "_iabkBhnjd"),
    ]
  ];
  
  let active = CSS.make("_iluOI4zYi", []);
  
  let container = CSS.make("_i5xwEIDfv _a4hT1uK_l _c4hBENvGZQAM_5L", []);
  
  let selected = CSS.make("_i-2yQxf20", []);
  let highlighted = CSS.make("_iUuvKz6fh", []);
  
  let card =
    CSS.make("_iFPpHlqxh _afyeH052M _c5kkn2nErhiu6iI _c4h9-n-D1gypHII", []);
  
  let actionButton = CSS.make("_isj_AlCHx", []);
  
  let panel = CSS.make("_iabkBhnjd _a9fMU0SCS _c7fPPr647RMF621", []);
  
  let _ = (active, container, selected, highlighted, card, actionButton, panel);

  $ dune build
