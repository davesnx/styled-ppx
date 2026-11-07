dune passes the library name in the `library-name` cookie. The binding id
hashes it, so one module and binding name in two libraries gets two ids.
Without the cookie the library part is empty.

  $ cat > m.ml <<EOF
  > let root = [%css "color: red;"]
  > EOF
  $ ../../standalone.exe --env production --cookie 'library-name="liba"' --impl m.ml -o liba.ml
  $ ../../standalone.exe --env production --cookie 'library-name="libb"' --impl m.ml -o libb.ml
  $ ../../standalone.exe --env production --impl m.ml -o none.ml
  $ cat liba.ml
  [@@@css.config [("env", "production")]]
  [@@@css.atoms
    [("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
       [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_i8H97A_5A", [], 1, 0, 0,
      [("id", "_i8H97A_5A", "bind\\0liba\\0M\\0\\0root\\00")])]]
  [@@@css.bindings [("M.root", "_i8H97A_5A _a7fadbhEW", "_i8H97A_5A")]]
  let root = CSS.make "_i8H97A_5A _a7fadbhEW" []
  $ cat libb.ml
  [@@@css.config [("env", "production")]]
  [@@@css.atoms
    [("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
       [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_ivXDTQGRF", [], 1, 0, 0,
      [("id", "_ivXDTQGRF", "bind\\0libb\\0M\\0\\0root\\00")])]]
  [@@@css.bindings [("M.root", "_ivXDTQGRF _a7fadbhEW", "_ivXDTQGRF")]]
  let root = CSS.make "_ivXDTQGRF _a7fadbhEW" []
  $ cat none.ml
  [@@@css.config [("env", "production")]]
  [@@@css.atoms
    [("_a7fadbhEW", ["._a7fadbhEW{color:red;}"], 1, 0, 1,
       [("value", "adbhEW", "val\\07f\\0& | \\0color:red")]);
    ("_i-puqUc3j", [], 1, 0, 0,
      [("id", "_i-puqUc3j", "bind\\0\\0M\\0\\0root\\00")])]]
  [@@@css.bindings [("M.root", "_i-puqUc3j _a7fadbhEW", "_i-puqUc3j")]]
  let root = CSS.make "_i-puqUc3j _a7fadbhEW" []
