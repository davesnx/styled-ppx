Same-file submodule selector interpolation resolves locally instead of being
emitted as a cross-module sentinel.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

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
        "_a7fadbhEW",
        ["._a7fadbhEW{color:red;}"],
        1,
        0,
        1,
        [("value", "adbhEW", "val\\07f\\0& | \\0color:red")],
      ),
      (
        "_c7fU9l6zcq4-ii1",
        ["._c7fU9l6zcq4-ii1._ixRBiAnCL{color:orange;}"],
        2,
        1,
        1,
        [
          ("ctx", "U9l6zc", "ctx\\0&._ixRBiAnCL | "),
          ("value", "q4-ii1", "val\\07f\\0&._ixRBiAnCL | \\0color:orange"),
        ],
      ),
      (
        "_carU9l6zchCzkw2",
        ["._carU9l6zchCzkw2._ixRBiAnCL{font-weight:bold;}"],
        2,
        1,
        1,
        [
          ("ctx", "U9l6zc", "ctx\\0&._ixRBiAnCL | "),
          ("value", "hCzkw2", "val\\0ar\\0&._ixRBiAnCL | \\0font-weight:bold"),
        ],
      ),
      (
        "_a7fBq58Im",
        ["._a7fBq58Im{color:green;}"],
        1,
        0,
        1,
        [("value", "Bq58Im", "val\\07f\\0& | \\0color:green")],
      ),
      (
        "_c7fRhRPz4XOYxq0",
        ["._c7fRhRPz4XOYxq0._iB2CBciJ0{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "RhRPz4", "ctx\\0&._iB2CBciJ0 | "),
          ("value", "XOYxq0", "val\\07f\\0&._iB2CBciJ0 | \\0color:blue"),
        ],
      ),
      (
        "_ixRBiAnCL",
        [],
        1,
        0,
        0,
        [("id", "_ixRBiAnCL", "bind\\0\\0Input\\0Css\\0marker\\00")],
      ),
      (
        "_i2tmrgooJ",
        [],
        1,
        0,
        0,
        [("id", "_i2tmrgooJ", "bind\\0\\0Input\\0Css\\0wrapper\\00")],
      ),
      (
        "_iLqyzJ4k2",
        [],
        1,
        0,
        0,
        [("id", "_iLqyzJ4k2", "bind\\0\\0Input\\0\\0wrapper\\00")],
      ),
      (
        "_iB2CBciJ0",
        [],
        1,
        0,
        0,
        [("id", "_iB2CBciJ0", "bind\\0\\0Input\\0Theme.Css\\0marker\\00")],
      ),
      (
        "_i1wyaPls1",
        [],
        1,
        0,
        0,
        [
          (
            "id",
            "_i1wyaPls1",
            "bind\\0\\0Input\\0Theme.Components\\0wrapper\\00",
          ),
        ],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Input.Css.marker", "_ixRBiAnCL _a7fadbhEW", "_ixRBiAnCL"),
      ("Input.Css.wrapper", "_i2tmrgooJ _c7fU9l6zcq4-ii1", "_i2tmrgooJ"),
      ("Input.wrapper", "_iLqyzJ4k2 _carU9l6zchCzkw2", "_iLqyzJ4k2"),
      ("Input.Theme.Css.marker", "_iB2CBciJ0 _a7fBq58Im", "_iB2CBciJ0"),
      (
        "Input.Theme.Components.wrapper",
        "_i1wyaPls1 _c7fRhRPz4XOYxq0",
        "_i1wyaPls1",
      ),
    ]
  ];
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
  
    let wrapper = CSS.make("_i2tmrgooJ _c7fU9l6zcq4-ii1", []);
  };
  
  let wrapper = CSS.make("_iLqyzJ4k2 _carU9l6zchCzkw2", []);
  
  module Theme = {
    module Css = {
      let marker = CSS.make("_iB2CBciJ0 _a7fBq58Im", []);
    };
  
    module Components = {
      let wrapper = CSS.make("_i1wyaPls1 _c7fRhRPz4XOYxq0", []);
    };
  };
  
  let _ = (
    Css.marker,
    Css.wrapper,
    wrapper,
    Theme.Css.marker,
    Theme.Components.wrapper,
  );

  $ dune build
