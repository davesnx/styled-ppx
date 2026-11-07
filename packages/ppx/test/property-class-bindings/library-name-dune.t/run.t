Two libraries with the same module and binding names, built by dune, get
different binding ids, so `.$(root)` in one library does not match the
element of the other.

  $ cat > dune-project << EOF
  > (lang dune 3.16)
  > EOF
  $ mkdir liba libb
  $ for lib in liba libb; do
  >   cat > $lib/dune << EOF
  > (library
  >  (name $lib)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx -- --env production)))
  > EOF
  >   cat > $lib/styles.re << EOF
  > let root = [%css "color: red;"];
  > let card = [%css {|& .\$(root) { color: blue; }|}];
  > EOF
  > done
  $ dune describe pp liba/styles.re | sed '1,/^];$/d'
  [@css.config [("env", "production")]];
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
        "_c7fGIMTgjCNkVtE",
        ["._c7fGIMTgjCNkVtE ._ijm6bO8CO{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "GIMTgj", "ctx\\0& ._ijm6bO8CO | "),
          ("value", "CNkVtE", "val\\07f\\0& ._ijm6bO8CO | \\0color:blue"),
        ],
      ),
      (
        "_ijm6bO8CO",
        [],
        1,
        0,
        0,
        [("id", "_ijm6bO8CO", "bind\\0liba\\0Styles\\0\\0root\\00")],
      ),
      (
        "_iFDQLCR6K",
        [],
        1,
        0,
        0,
        [("id", "_iFDQLCR6K", "bind\\0liba\\0Styles\\0\\0card\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Styles.root", "_ijm6bO8CO _a7fadbhEW", "_ijm6bO8CO"),
      ("Styles.card", "_iFDQLCR6K _c7fGIMTgjCNkVtE", "_iFDQLCR6K"),
    ]
  ];
  let root = CSS.make("_ijm6bO8CO _a7fadbhEW", []);
  let card = CSS.make("_iFDQLCR6K _c7fGIMTgjCNkVtE", []);
  $ dune describe pp libb/styles.re | sed '1,/^];$/d'
  [@css.config [("env", "production")]];
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
        "_c7fVMVmMA9dOnK6",
        ["._c7fVMVmMA9dOnK6 ._iGxgQ2Ca_{color:blue;}"],
        0,
        1,
        1,
        [
          ("ctx", "VMVmMA", "ctx\\0& ._iGxgQ2Ca_ | "),
          ("value", "9dOnK6", "val\\07f\\0& ._iGxgQ2Ca_ | \\0color:blue"),
        ],
      ),
      (
        "_iGxgQ2Ca_",
        [],
        1,
        0,
        0,
        [("id", "_iGxgQ2Ca_", "bind\\0libb\\0Styles\\0\\0root\\00")],
      ),
      (
        "_i6nwzNSHs",
        [],
        1,
        0,
        0,
        [("id", "_i6nwzNSHs", "bind\\0libb\\0Styles\\0\\0card\\00")],
      ),
    ]
  ];
  [@css.bindings
    [
      ("Styles.root", "_iGxgQ2Ca_ _a7fadbhEW", "_iGxgQ2Ca_"),
      ("Styles.card", "_i6nwzNSHs _c7fVMVmMA9dOnK6", "_i6nwzNSHs"),
    ]
  ];
  let root = CSS.make("_iGxgQ2Ca_ _a7fadbhEW", []);
  let card = CSS.make("_i6nwzNSHs _c7fVMVmMA9dOnK6", []);
