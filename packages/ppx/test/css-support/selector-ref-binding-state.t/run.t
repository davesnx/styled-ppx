What a selector reference `.$(x)` sees is the latest binding of `x`: its
blocks and whether it is a function travel together, through `include`
and module aliases, and a later binding of the same name replaces both.

(a) A function binding brought in by `include` is still a function.

  $ cat > a.ml <<EOF
  > module S = struct let tone c = [%css "color: \$(c)"] end
  > include S
  > let user = [%css "&.\$(tone) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl a.ml -o a.out.ml
  File "a.ml", line 3, characters 22-26:
  3 | let user = [%css "&.$(tone) { padding: 1px; }"]
                            ^^^^
  Error: Selector interpolation `$(tone)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let tone = [%css "..."]`) or a string, and reference that.
  [1]

(b) A value binding brought in by `include` replaces an earlier function
of the same name: the reference resolves to its class.

  $ cat > b.ml <<EOF
  > let tone c = [%css "color: \$(c)"]
  > module S = struct let tone = [%css "color: blue"] end
  > include S
  > let user = [%css "&.\$(tone) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl b.ml -o b.out.ml
  $ refmt --parse ml --print re b.out.ml
  [@css "@property --wpabno-0{syntax:\"*\";inherits:false;}"];
  [@css ".css-wpabno{color:var(--wpabno-0);}"];
  [@css ".css-lhhywx{color:blue;}"];
  [@css ".css-16osdnb.css-lhhywx{padding:1px;}"];
  [@css.classes
    [
      ("css-wpabno", 1, "B.tone", "b.ml", 1, 20, 1, 31),
      ("css-lhhywx", 2, "B.S.tone", "b.ml", 2, 36, 2, 47),
      ("css-16osdnb", 3, "B.user", "b.ml", 4, 18, 4, 45),
    ]
  ];
  [@css.bindings
    [("B.tone", ""), ("B.S.tone", "css-lhhywx"), ("B.user", "css-16osdnb")]
  ];
  let tone = c =>
    CSS.make("css-wpabno", [("--wpabno-0", CSS.Types.Color.toString(c))]);
  module S = {
    let tone = CSS.make("css-lhhywx", []);
  };
  include S;
  let user = CSS.make("css-16osdnb", []);

(c) A function is recognised through `M.(...)`, `let ... in`,
`let module ... in` and `(e1; e2)`.

  $ cat > c1.ml <<EOF
  > module T = struct end
  > let f = T.(fun c -> [%css "color: \$(c)"])
  > let user = [%css "&.\$(f) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl c1.ml -o c1.out.ml
  File "c1.ml", line 3, characters 22-23:
  3 | let user = [%css "&.$(f) { padding: 1px; }"]
                            ^
  Error: Selector interpolation `$(f)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let f = [%css "..."]`) or a string, and reference that.
  [1]

  $ cat > c2.ml <<EOF
  > let f = let k = 1 in fun c -> ignore k; [%css "color: \$(c)"]
  > let user = [%css "&.\$(f) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl c2.ml -o c2.out.ml
  File "c2.ml", line 2, characters 22-23:
  2 | let user = [%css "&.$(f) { padding: 1px; }"]
                            ^
  Error: Selector interpolation `$(f)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let f = [%css "..."]`) or a string, and reference that.
  [1]

  $ cat > c3.ml <<EOF
  > let f = let module M = struct end in fun c -> [%css "color: \$(c)"]
  > let user = [%css "&.\$(f) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl c3.ml -o c3.out.ml
  File "c3.ml", line 2, characters 22-23:
  2 | let user = [%css "&.$(f) { padding: 1px; }"]
                            ^
  Error: Selector interpolation `$(f)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let f = [%css "..."]`) or a string, and reference that.
  [1]

  $ cat > c4.ml <<EOF
  > let f = (ignore 0; fun c -> [%css "color: \$(c)"])
  > let user = [%css "&.\$(f) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl c4.ml -o c4.out.ml
  File "c4.ml", line 2, characters 22-23:
  2 | let user = [%css "&.$(f) { padding: 1px; }"]
                            ^
  Error: Selector interpolation `$(f)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let f = [%css "..."]`) or a string, and reference that.
  [1]

(d) A later value that is not a [%css] block replaces the block: the
reference does not see the stale class.

  $ cat > d.ml <<EOF
  > let a = [%css "color: red"]
  > let a = 1
  > let user = [%css "&.\$(a) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl d.ml -o d.out.ml
  File "d.ml", line 3, characters 22-23:
  3 | let user = [%css "&.$(a) { padding: 1px; }"]
                            ^
  Error: Selector interpolation `$(a)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `a` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `a` is a computed string, inline the class name literally.
  [1]

(e) The same across modules: `E.a` is no longer exported in
[@@@css.bindings], so `generate` reports the reference as not resolving.

  $ cat > e.ml <<EOF
  > let a = [%css "color: red"]
  > let a = 1
  > EOF
  $ mkdir out
  $ ../../standalone.exe --impl e.ml -o out/e.ml
  $ cat > f.ml <<EOF
  > let user = [%css "&.\$(E.a) { padding: 1px; }"]
  > EOF
  $ ../../standalone.exe --impl f.ml -o out/f.ml
  $ styled-ppx.generate out/e.ml out/f.ml
  styled-ppx: File "f.ml", line 1, characters 22-25:
  Error: cross-module [%css] selector reference `E.a` does not resolve.
  The target binding is missing from module `E`, or the binding is not
  a [%css] expression. Define `E.a` with [%css "..."], or remove the
  reference.
  [1]
