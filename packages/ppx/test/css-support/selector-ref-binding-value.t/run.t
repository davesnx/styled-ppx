A selector reference `.$(x)` names one block. The binding `x` is
referenceable when its body contains exactly one [%css] block (or empty
marker) anywhere, and it is not a function; `.$(x)` is that block's class.
A string literal is used as a class name. Two or more blocks, or a
function, is an error at the reference. Aliases (`let x = a`) are not
followed.

Shadowing: the new `a` can reference the `a` it replaces.

  $ cat > shadow.ml <<EOF
  > let a = [%css "color: red"]
  > let a = [%css "& .\$(a) { color: blue; }"]
  > let b = "foo"
  > let b = [%css "& .\$(b) { color: blue; }"]
  > EOF
  $ ../../standalone.exe --impl shadow.ml -o shadow.out.ml
  $ refmt --parse ml --print re shadow.out.ml
  [@css ".css-vwcp0u{color:red;}"];
  [@css ".css-y9q6oj .css-vwcp0u{color:blue;}"];
  [@css ".css-1bad5fb .foo{color:blue;}"];
  [@css.classes
    [
      ("css-vwcp0u", 0, "Shadow.a", "shadow.ml", 1, 15, 1, 25),
      ("css-y9q6oj", 1, "Shadow.a", "shadow.ml", 2, 15, 2, 39),
      ("css-1bad5fb", 2, "Shadow.b", "shadow.ml", 4, 15, 4, 39),
    ]
  ];
  [@css.bindings [("Shadow.a", "css-y9q6oj"), ("Shadow.b", "css-1bad5fb")]];
  let a = CSS.make("css-vwcp0u", []);
  let a = CSS.make("css-y9q6oj", []);
  let b = "foo";
  let b = CSS.make("css-1bad5fb", []);

`let rec`: the binding is not defined yet inside its own body.

  $ cat > rec.ml <<EOF
  > let rec a = [%css "& .\$(a) { color: blue; }"]
  > EOF
  $ ../../standalone.exe --impl rec.ml -o rec.out.ml
  File "rec.ml", line 1, characters 24-25:
  1 | let rec a = [%css "& .$(a) { color: blue; }"]
                              ^
  Error: Selector interpolation `$(a)` refers to a binding of its own `let rec` group, which is not defined yet. Move the referenced block out of the `let rec` group, before this binding.
  [1]

One block merged with something that is not a block is referenceable, also
inside `let ... in`, a sequence, a local open or a type constraint.

  $ cat > actions.ml <<EOF
  > let ( +++ ) a _ = a
  > let other = "z-layer"
  > let actions = [%css "color: red"] +++ other
  > let merged = CSS.merge [%css "color: blue"] CSS.empty
  > let wrapped = (let k = 1 in ignore k; M.(([%css "color: green"] : CSS.styles)))
  > let row = [%css "& .\$(actions), & .\$(merged), & .\$(wrapped) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl actions.ml -o actions.out.ml
  $ refmt --parse ml --print re actions.out.ml
  [@css ".css-17qsgv5{color:red;}"];
  [@css ".css-2cft91{color:blue;}"];
  [@css ".css-u6lwzg{color:green;}"];
  [@css
    ".css-1yumumb .css-17qsgv5{padding:1px;}.css-1yumumb .css-2cft91{padding:1px;}.css-1yumumb .css-u6lwzg{padding:1px;}"
  ];
  [@css.classes
    [
      ("css-17qsgv5", 0, "Actions.actions", "actions.ml", 3, 21, 3, 31),
      ("css-2cft91", 1, "Actions.merged", "actions.ml", 4, 30, 4, 41),
      ("css-u6lwzg", 2, "Actions.wrapped", "actions.ml", 5, 49, 5, 61),
      ("css-1yumumb", 3, "Actions.row", "actions.ml", 6, 17, 6, 77),
    ]
  ];
  [@css.bindings
    [
      ("Actions.actions", "css-17qsgv5"),
      ("Actions.merged", "css-2cft91"),
      ("Actions.wrapped", "css-u6lwzg"),
      ("Actions.row", "css-1yumumb"),
    ]
  ];
  let (+++) = (a, _) => a;
  let other = "z-layer";
  let actions = CSS.make("css-17qsgv5", []) +++ other;
  let merged = CSS.merge(CSS.make("css-2cft91", []), CSS.empty);
  let wrapped = {
    let k = 1;
    ignore(k);
    M.((CSS.make("css-u6lwzg", []): CSS.styles));
  };
  let row = CSS.make("css-1yumumb", []);

Known limit, as on main: a conditional whose branches are another binding
and one inline block holds one block, so `.$(x)` resolves to the inline
block only and misses elements styled by `a`. The check counts blocks; it
does not follow names.

  $ cat > cond.ml <<EOF
  > let a = [%css "color: red"]
  > let x = if true then a else [%css "color: blue"]
  > let y = [%css "& .\$(x) { color: green; }"]
  > EOF
  $ ../../standalone.exe --impl cond.ml -o cond.out.ml
  $ refmt --parse ml --print re cond.out.ml
  [@css ".css-1b29lro{color:red;}"];
  [@css ".css-pcs2bf{color:blue;}"];
  [@css ".css-xhvs24 .css-pcs2bf{color:green;}"];
  [@css.classes
    [
      ("css-1b29lro", 0, "Cond.a", "cond.ml", 1, 15, 1, 25),
      ("css-pcs2bf", 1, "Cond.x", "cond.ml", 2, 35, 2, 46),
      ("css-xhvs24", 2, "Cond.y", "cond.ml", 3, 15, 3, 40),
    ]
  ];
  [@css.bindings
    [
      ("Cond.a", "css-1b29lro"),
      ("Cond.x", "css-pcs2bf"),
      ("Cond.y", "css-xhvs24"),
    ]
  ];
  let a = CSS.make("css-1b29lro", []);
  let x =
    if (true) {
      a;
    } else {
      CSS.make("css-pcs2bf", []);
    };
  let y = CSS.make("css-xhvs24", []);

Two blocks in one binding.

  $ cat > merge.ml <<EOF
  > let m = CSS.merge [%css "color: red"] [%css "color: blue"]
  > let y = [%css "& .\$(m) { color: green; }"]
  > EOF
  $ ../../standalone.exe --impl merge.ml -o merge.out.ml
  File "merge.ml", line 2, characters 20-21:
  2 | let y = [%css "& .$(m) { color: green; }"]
                          ^
  Error: `$(m)` names a binding with 2 [%css] blocks. A selector can only reference a binding with one block; bind the block you mean to its own name, or use an empty marker binding.
  [1]

Aliases are not followed: reference the block itself.

  $ cat > alias.ml <<EOF
  > let a = [%css "color: red"]
  > let z = a
  > let y = [%css "& .\$(z) { color: green; }"]
  > EOF
  $ ../../standalone.exe --impl alias.ml -o alias.out.ml
  File "alias.ml", line 3, characters 20-21:
  3 | let y = [%css "& .$(z) { color: green; }"]
                          ^
  Error: Selector interpolation `$(z)` refers to an alias of another binding. Aliases are not followed: reference the block itself (`$(a)` or `$(M.a)`).
  [1]

  $ cat > alias_ext.ml <<EOF
  > let z = Ext.a
  > let y = [%css "& .\$(z) { color: green; }"]
  > EOF
  $ ../../standalone.exe --impl alias_ext.ml -o alias_ext.out.ml
  File "alias_ext.ml", line 2, characters 20-21:
  2 | let y = [%css "& .$(z) { color: green; }"]
                          ^
  Error: Selector interpolation `$(z)` refers to an alias of another binding. Aliases are not followed: reference the block itself (`$(a)` or `$(M.a)`).
  [1]

Names reached through `let ... in`, a local open or a `let rec` are not
followed either: only the blocks in the body count. `x2` holds one block,
so it resolves to that block although its value is `b` (the known limit
above); the others hold none.

  $ cat > scope1.ml <<EOF
  > let a = [%css "color: red"]
  > module M = struct let a = [%css "color: blue"] end
  > let b = [%css "color: green"]
  > let x1 = M.(a)
  > let y = [%css "& .\$(x1) { color: black; }"]
  > EOF
  $ ../../standalone.exe --impl scope1.ml -o scope1.out.ml
  File "scope1.ml", line 5, characters 20-22:
  5 | let y = [%css "& .$(x1) { color: black; }"]
                          ^^
  Error: Selector interpolation `$(x1)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `x1` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `x1` is a computed string, inline the class name literally.
  [1]

  $ cat > scope2.ml <<EOF
  > let a = [%css "color: red"]
  > module M = struct let a = [%css "color: blue"] end
  > let b = [%css "color: green"]
  > let x2 = (let a = [%css "color: red"] in let (a, _) = (b, 1) in a)
  > let y = [%css "& .\$(x2) { color: black; }"]
  > EOF
  $ ../../standalone.exe --impl scope2.ml -o scope2.out.ml

  $ cat > scope3.ml <<EOF
  > let a = [%css "color: red"]
  > module M = struct let a = [%css "color: blue"] end
  > let b = [%css "color: green"]
  > let x3 = (let rec a = 1 in a)
  > let y = [%css "& .\$(x3) { color: black; }"]
  > EOF
  $ ../../standalone.exe --impl scope3.ml -o scope3.out.ml
  File "scope3.ml", line 5, characters 20-22:
  5 | let y = [%css "& .$(x3) { color: black; }"]
                          ^^
  Error: Selector interpolation `$(x3)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `x3` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `x3` is a computed string, inline the class name literally.
  [1]

  $ cat > scope4.ml <<EOF
  > let a = [%css "color: red"]
  > module M = struct let a = [%css "color: blue"] end
  > let b = [%css "color: green"]
  > let x4 = (let open M in a)
  > let y = [%css "& .\$(x4) { color: black; }"]
  > EOF
  $ ../../standalone.exe --impl scope4.ml -o scope4.out.ml
  File "scope4.ml", line 5, characters 20-22:
  5 | let y = [%css "& .$(x4) { color: black; }"]
                          ^^
  Error: Selector interpolation `$(x4)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `x4` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `x4` is a computed string, inline the class name literally.
  [1]

  $ cat > scope5.ml <<EOF
  > let x5 = (let s = [%css "color: blue"] in s)
  > let y = [%css "& .\$(x5) { color: black; }"]
  > EOF
  $ ../../standalone.exe --impl scope5.ml -o scope5.out.ml

Exports: a referenceable binding exports its block's class; a function or
a binding with two or more blocks exports an empty class string, so
`generate` reports a reference to it; aliases, strings and other values
export nothing.

  $ mkdir out
  $ cat > g.ml <<EOF
  > let a = [%css "color: red"]
  > let b = a
  > let one = CSS.merge [%css "color: blue"] CSS.empty
  > let two = CSS.merge a [%css "color: green"] |> CSS.merge [%css "color: black"]
  > let f c = if c then [%css "color: red"] else [%css "color: red"]
  > let s = "plain"
  > EOF
  $ ../../standalone.exe --impl g.ml -o out/g.ml
  $ refmt --parse ml --print re out/g.ml
  [@css ".css-1xhgjuy{color:red;}"];
  [@css ".css-1n8wwht{color:blue;}"];
  [@css ".css-zi400i{color:green;}"];
  [@css ".css-c96qmi{color:black;}"];
  [@css ".css-4yxeg1{color:red;}"];
  [@css.classes
    [
      ("css-1xhgjuy", 0, "G.a", "g.ml", 1, 15, 1, 25),
      ("css-1n8wwht", 1, "G.one", "g.ml", 3, 27, 3, 38),
      ("css-zi400i", 2, "G.two", "g.ml", 4, 29, 4, 41),
      ("css-c96qmi", 3, "G.two", "g.ml", 4, 64, 4, 76),
      ("css-4yxeg1", 4, "G.f", "g.ml", 5, 27, 5, 37),
    ]
  ];
  [@css.bindings
    [
      ("G.a", "css-1xhgjuy"),
      ("G.one", "css-1n8wwht"),
      ("G.two", ""),
      ("G.f", ""),
    ]
  ];
  let a = CSS.make("css-1xhgjuy", []);
  let b = a;
  let one = CSS.merge(CSS.make("css-1n8wwht", []), CSS.empty);
  let two =
    CSS.merge(a, CSS.make("css-zi400i", []))
    |> CSS.merge(CSS.make("css-c96qmi", []));
  let f = c =>
    if (c) {
      CSS.make("css-4yxeg1", []);
    } else {
      CSS.make("css-4yxeg1", []);
    };
  let s = "plain";
  $ cat > h.ml <<EOF
  > let y1 = [%css "& .\$(G.one) { color: green; }"]
  > let y2 = [%css "& .\$(G.two) { color: green; }"]
  > let y3 = [%css "& .\$(G.f) { color: green; }"]
  > let y4 = [%css "& .\$(G.b) { color: green; }"]
  > EOF
  $ ../../standalone.exe --impl h.ml -o out/h.ml
  $ styled-ppx.generate out/g.ml out/h.ml
  styled-ppx: File "h.ml", line 2, characters 21-26:
  Error: Selector interpolation `$(G.two)` refers to a function or to a binding with several [%css] blocks, so it has no single class. Bind the block you mean to its own name and reference that.
  styled-ppx: File "h.ml", line 3, characters 21-24:
  Error: Selector interpolation `$(G.f)` refers to a function or to a binding with several [%css] blocks, so it has no single class. Bind the block you mean to its own name and reference that.
  styled-ppx: File "h.ml", line 4, characters 21-24:
  Error: cross-module [%css] selector reference `G.b` does not resolve.
  The target binding is missing from module `G`, or the binding is not
  a [%css] expression. Define `G.b` with [%css "..."], or remove the
  reference.
  [1]

A block cannot reference a binding of its own `let rec` group.

  $ cat > recgroup.ml <<EOF
  > let rec a = [%css "color: red"]
  > and b = [%css "& .\$(a) { color: red; }"]
  > EOF
  $ ../../standalone.exe --impl recgroup.ml -o recgroup.out.ml
  File "recgroup.ml", line 2, characters 20-21:
  2 | and b = [%css "& .$(a) { color: red; }"]
                          ^
  Error: Selector interpolation `$(a)` refers to a binding of its own `let rec` group, which is not defined yet. Move the referenced block out of the `let rec` group, before this binding.
  [1]

A rule with an empty body is dropped before its selector is resolved, so a
reference in it is not checked.

  $ cat > empty.ml <<EOF
  > let y = [%css "& .\$(nowhere) {}"]
  > EOF
  $ ../../standalone.exe --impl empty.ml -o empty.out.ml
  $ refmt --parse ml --print re empty.out.ml
  [@css.bindings [("Empty.y", "css-1821kyq")]];
  let y = CSS.make("css-1821kyq", []);
