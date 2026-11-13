A selector reference `.$(b)` needs a class name: `b` must be a [%css]
value binding or a string. A function is an error.

(a) a function with one block:

  $ refmt --parse re --print ml fa.re > fa.ml
  $ ../../standalone.exe --impl fa.ml -o fa.ml
  File "fa.ml", line 2, characters 19-23:
  2 | let a = [%css "&.$(tone) { padding: 1px; }"]
                         ^^^^
  Error: Selector interpolation `$(tone)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let tone = [%css "..."]`) or a string, and reference that.
  [1]

(b) a function with two blocks:

  $ refmt --parse re --print ml fb.re > fb.ml
  $ ../../standalone.exe --impl fb.ml -o fb.ml
  File "fb.ml", line 3, characters 20-24:
  3 | let b = [%css "& .$(pick) { color: red; }"]
                          ^^^^
  Error: Selector interpolation `$(pick)` refers to a function. A selector needs a class name: bind one [%css] block to a value (`let pick = [%css "..."]`) or a string, and reference that.
  [1]

(c) a value with two blocks (a conditional): no class to reference.

  $ refmt --parse re --print ml fc.re > fc.ml
  $ ../../standalone.exe --impl fc.ml -o fc.ml
  File "fc.ml", line 6, characters 20-24:
  6 | let c = [%css "& .$(pick) { color: red; }"]
                          ^^^^
  Error: `$(pick)` names a binding with 2 [%css] blocks. A selector can only reference a binding with one block; bind the block you mean to its own name, or use an empty marker binding.
  [1]

(d) a string binding is used as the class name:

  $ refmt --parse re --print ml fd.re > fd.ml
  $ ../../standalone.exe --impl fd.ml -o fd.ml
  $ refmt --parse ml --print re fd.ml
  [@css ".css-uayuzs.foo{color:red;}"];
  [@css.classes [("css-uayuzs", 0, "Fd.d", "fd.ml", 2, 15, 2, 37)]];
  [@css.bindings [("Fd.d", "css-uayuzs")]];
  let b = "foo";
  let d = CSS.make("css-uayuzs", []);

(e) not a [%css] binding: an int, a record field, a value of a local module.

  $ refmt --parse re --print ml fe1.re > fe1.ml
  $ ../../standalone.exe --impl fe1.ml -o fe1.ml
  File "fe1.ml", line 2, characters 19-20:
  2 | let e = [%css "&.$(n) { color: red; }"]
                         ^
  Error: Selector interpolation `$(n)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `n` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `n` is a computed string, inline the class name literally.
  [1]

  $ refmt --parse re --print ml fe2.re > fe2.ml
  $ ../../standalone.exe --impl fe2.ml -o fe2.ml
  $ refmt --parse ml --print re fe2.ml
  [@css ".css-rr6e6e.\000r.cls\000{color:red;}"];
  [@css.classes [("css-rr6e6e", 0, "Fe2.e", "fe2.ml", 4, 15, 4, 41)]];
  [@css.bindings [("Fe2.e", "css-rr6e6e")]];
  [@css.refs [("r.cls", "fe2.ml", 4, 19, 24)]];
  let _: CSS.styles = r.cls;
  type r = {cls: string};
  let r = { cls: "x" };
  let e = CSS.make("css-rr6e6e", []);

  $ refmt --parse re --print ml fe3.re > fe3.ml
  $ ../../standalone.exe --impl fe3.ml -o fe3.ml
  File "fe3.ml", line 2, characters 19-22:
  2 | let e = [%css "&.$(M.v) { color: red; }"]
                         ^^^
  Error: Selector interpolation `$(M.v)` does not refer to a [%css] binding or string literal earlier in this module.
  - If `M.v` is bound to a [%css] or string literal later in the file, reorder the bindings.
  - If `M.v` is a computed string, inline the class name literally.
  [1]

(f) cross-module references. The ppx sees only `Target.tone`; it emits a
typed use `let _: CSS.styles = Target.tone`, so the compiler rejects a
function. A value binding compiles.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > (using melange 0.1)
  > EOF

  $ cat > lib/dune << EOF
  > (library
  >  (name lib_native)
  >  (wrapped false)
  >  (libraries styled-ppx.native)
  >  (preprocess
  >   (pps styled-ppx)))
  > EOF

  $ mkdir js

  $ cat > js/dune << EOF
  > (copy_files ../lib/*.re)
  > (library
  >  (name lib_js)
  >  (wrapped false)
  >  (modes melange)
  >  (libraries styled-ppx.melange)
  >  (preprocess
  >   (pps styled-ppx melange.ppx)))
  > EOF

  $ dune build ./lib/.lib_native.objs/byte/ref_tone.cmo
  File "lib/ref_tone.re", line 1, characters 19-30:
  1 | let a = [%css "&.$(Target.tone) { padding: 1px; }"];
                         ^^^^^^^^^^^
  Error: The value Target.tone has type Css_types.Color.t -> CSS.styles
         but an expression was expected of type
           CSS.styles = string * ReactDOM.Style.t
  [1]

  $ dune build ./lib/.lib_native.objs/byte/ref_pick.cmo
  File "lib/ref_pick.re", line 1, characters 20-31:
  1 | let b = [%css "& .$(Target.pick) { color: red; }"];
                          ^^^^^^^^^^^
  Error: The value Target.pick has type bool -> CSS.styles
         but an expression was expected of type
           CSS.styles = string * ReactDOM.Style.t
  [1]

  $ dune build ./lib/.lib_native.objs/byte/ref_marker.cmo

  $ dune build @js/all
  File "js/ref_pick.re", line 1, characters 20-31:
  1 | let b = [%css "& .$(Target.pick) { color: red; }"];
                          ^^^^^^^^^^^
  Error: The value Target.pick has type bool -> CSS.styles
         but an expression was expected of type
           CSS.styles = string * ReactDOM.Style.t
  File "js/ref_tone.re", line 1, characters 19-30:
  1 | let a = [%css "&.$(Target.tone) { padding: 1px; }"];
                         ^^^^^^^^^^^
  Error: The value Target.tone has type Css_types.Color.t -> CSS.styles
         but an expression was expected of type
           CSS.styles = string * ReactDOM.Style.t
  [1]

  $ dune describe pp lib/ref_tone.re
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
      cookies: [("library-name", "lib_native")],
    }
  ];
  [@css ".css-9phg70.\000Target.tone\000{padding:1px;}"];
  [@css.classes
    [("css-9phg70", 0, "Ref_tone.a", "lib/ref_tone.re", 1, 15, 1, 49)]
  ];
  [@css.bindings [("Ref_tone.a", "css-9phg70")]];
  [@css.refs [("Target.tone", "lib/ref_tone.re", 1, 19, 30)]];
  let _: CSS.styles = Target.tone;
  let a = CSS.make("css-9phg70", []);
