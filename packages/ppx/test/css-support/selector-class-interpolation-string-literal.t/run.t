Earlier string literals can be used as static selector refs. They are resolved
locally but are not exported through [@@@css.bindings], because the aggregator
only indexes [%css] class handles.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css.atoms
    [
      (
        "_c7fFmUzm5nnNpUY",
        ["._c7fFmUzm5nnNpUY.external-marker{color:blue;}"],
        2,
        1,
        1,
        [
          ("ctx", "FmUzm5", "ctx\\0&.external-marker | "),
          ("value", "nnNpUY", "val\\07f\\0&.external-marker | \\0color:blue"),
        ],
      ),
      (
        "_iLqyzJ4k2",
        [],
        1,
        0,
        0,
        [("id", "_iLqyzJ4k2", "bind\\0\\0Input\\0\\0wrapper\\00")],
      ),
    ]
  ];
  [@css.bindings
    [("Input.wrapper", "_iLqyzJ4k2 _c7fFmUzm5nnNpUY", "_iLqyzJ4k2")]
  ];
  module Css = {
    let marker = "external-marker";
  };
  
  let wrapper = CSS.make("_iLqyzJ4k2 _c7fFmUzm5nnNpUY", []);
  
  let _ = (Css.marker, wrapper);

  $ dune build
