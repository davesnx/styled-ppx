A top-level binding with several `[%css]` gets one id, shared by every
`[%css]` inside it, so `.$(f)` matches the element whichever branch made
its class.

  $ cat > m.ml <<EOF
  > let f active = if active then [%css "color: red;"] else [%css "color: blue;"]
  > let make () =
  >   let a = [%css "margin: 0;"] in
  >   let b = [%css "padding: 0;"] in
  >   (a, b)
  > let card = [%css {|& .\$(f) { color: green; }|}]
  > EOF
  $ ../../standalone.exe --env production --impl m.ml -o m.ml
  $ cat m.ml
  [@@@css.config [("env", "production")]]
  [@@@css.atoms
    [("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
       [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_a7fCPHFf-", ["._a7fCPHFf-{color:blue;}"], 1, 0, 1,
      [("value", "CPHFf-", "val\\07f\\0& | \\0color:blue")]);
    ("_act0587xC", ["._act0587xC{margin:0;}"], 1, 0, 4,
      [("value", "0587xC", "val\\0ct\\0& | \\0margin:0")]);
    ("_afyzehsbK", ["._afyzehsbK{padding:0;}"], 1, 0, 4,
      [("value", "zehsbK", "val\\0fy\\0& | \\0padding:0")]);
    ("_c7fzki-2zx9klg9", ["._c7fzki-2zx9klg9 ._ioWRYR6TY{color:green;}"], 0, 1,
      1,
      [("ctx", "zki-2z", "ctx\\0& ._ioWRYR6TY | ");
      ("value", "x9klg9", "val\\07f\\0& ._ioWRYR6TY | \\0color:green")]);
    ("_ioWRYR6TY", [], 1, 0, 0,
      [("id", "_ioWRYR6TY", "bind\\0\\0M\\0\\0f\\00")]);
    ("_ifB3pCROS", [], 1, 0, 0,
      [("id", "_ifB3pCROS", "bind\\0\\0M\\0\\0make\\00")]);
    ("_il-9sFgHR", [], 1, 0, 0,
      [("id", "_il-9sFgHR", "bind\\0\\0M\\0\\0card\\00")])]]
  [@@@css.bindings
    [("M.f", "_ioWRYR6TY _a7fCPHFf-", "_ioWRYR6TY");
    ("M.make", "_ifB3pCROS _afyzehsbK", "_ifB3pCROS");
    ("M.card", "_il-9sFgHR _c7fzki-2zx9klg9", "_il-9sFgHR")]]
  let f active =
    if active
    then CSS.make "_ioWRYR6TY _a7fadbhEW" []
    else CSS.make "_ioWRYR6TY _a7fCPHFf-" []
  let make () =
    let a = CSS.make "_ifB3pCROS _act0587xC" [] in
    let b = CSS.make "_ifB3pCROS _afyzehsbK" [] in (a, b)
  let card = CSS.make "_il-9sFgHR _c7fzki-2zx9klg9" []
