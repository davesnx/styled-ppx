Same-file submodule selector interpolation resolves locally in
[%styled.global] blocks.

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
  [@css "body ._ixRBiAnCL{font-weight:bold;}"];
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
        "_ixRBiAnCL",
        [],
        1,
        0,
        0,
        [("id", "_ixRBiAnCL", "bind\\0\\0Input\\0Css\\0marker\\00")],
      ),
    ]
  ];
  [@css.bindings
    [("Input.Css.marker", "_ixRBiAnCL _a7fadbhEW", "_ixRBiAnCL")]
  ];
  module Css = {
    let marker = CSS.make("_ixRBiAnCL _a7fadbhEW", []);
  };
  
  module Globals = {
    let to_string = () => "";
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => Js.Obj.empty();
    let make = _props => CSS.global_style_tag(to_string());
  };
  
  let _ = (Css.marker, Globals.to_string, Globals.make);

  $ dune build
