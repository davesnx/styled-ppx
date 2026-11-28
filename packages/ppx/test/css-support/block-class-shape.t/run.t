A block's class is `css-`, four base36 characters hashed from the module
name, and three base36 characters hashed from the module, scope, binding,
and content. Every class of a module shares the four-character prefix, so
the classes of one module compress well, and two modules get different
prefixes. A block's variables are named the same way: `--`, the module's
prefix, and three characters of the variable's own seed.

  $ cat > input.ml <<EOF
  > let card c = [%css {|color: \$(c); width: 10px;|}]
  > let title = [%css "font-weight: bold"]
  > let empty = [%css ""]
  > module Nested = struct
  >   let title = [%css "font-weight: bold"]
  > end
  > EOF
  $ cat > other.ml <<EOF
  > let title = [%css "font-weight: bold"]
  > EOF
  $ ../../standalone.exe --impl input.ml -o input.out.ml
  $ ../../standalone.exe --impl other.ml -o other.out.ml
  $ refmt --parse ml --print re input.out.ml
  [@css "@property --ivpcpc4{syntax:\"*\";inherits:false;}"];
  [@css ".css-ivpcvpw{color:var(--ivpcpc4);width:10px;}"];
  [@css ".css-ivpcyoc{font-weight:bold;}"];
  [@css ".css-ivpcong{font-weight:bold;}"];
  [@css.classes
    [
      ("css-ivpcvpw", 1, "Input.card", "input.ml", 1, 21, 1, 46),
      ("css-ivpcyoc", 2, "Input.title", "input.ml", 2, 19, 2, 36),
      ("css-ivpcgaz", (-1), "Input.empty", "input.ml", 3, 19, 3, 19),
      ("css-ivpcong", 3, "Input.Nested.title", "input.ml", 5, 21, 5, 38),
    ]
  ];
  [@css.bindings
    [
      ("Input.card", ""),
      ("Input.title", "css-ivpcyoc"),
      ("Input.empty", "css-ivpcgaz"),
      ("Input.Nested.title", "css-ivpcong"),
    ]
  ];
  let card = c =>
    CSS.make("css-ivpcvpw", [("--ivpcpc4", CSS.Types.Color.toString(c))]);
  let title = CSS.make("css-ivpcyoc", []);
  let empty = CSS.make("css-ivpcgaz", []);
  module Nested = {
    let title = CSS.make("css-ivpcong", []);
  };
  $ refmt --parse ml --print re other.out.ml
  [@css ".css-sjjcete{font-weight:bold;}"];
  [@css.classes [("css-sjjcete", 0, "Other.title", "other.ml", 1, 19, 1, 36)]];
  [@css.bindings [("Other.title", "css-sjjcete")]];
  let title = CSS.make("css-sjjcete", []);

Every class is exactly `css-` plus seven characters:

  $ grep -oh '"css-[0-9a-z]*"' input.out.ml other.out.ml | sort -u | awk '{ print length($0) - 2 }' | sort -u
  11

All classes of `Input` share one prefix, and `Other` has another:

  $ grep -oh '"css-[0-9a-z]*"' input.out.ml | cut -c6-9 | sort -u | wc -l | tr -d ' '
  1
  $ grep -oh '"css-[0-9a-z]*"' input.out.ml other.out.ml | cut -c6-9 | sort -u | wc -l | tr -d ' '
  2

The variable of `card` has the prefix of `Input` and seven characters:

  $ prefix=$(grep -o '"css-[0-9a-z]*"' input.out.ml | head -1 | cut -c6-9)
  $ grep -o "\"--$prefix[0-9a-z]*\"" input.out.ml | sort -u | awk '{ print length($0) - 4 }'
  7

Three characters of suffix leave room for clashes inside a module. When a
block would get the class of a different earlier block, it widens its own
suffix to four characters (then five, six), and the earlier block keeps its
class. `b66` and `b76` get the same three characters:

  $ cat > input.ml <<EOF
  > let b66 = [%css "width: 66px"]
  > let b76 = [%css "width: 76px"]
  > EOF
  $ ../../standalone.exe --impl input.ml -o input.out.ml
  $ grep '^\[@@@css "\|CSS.make' input.out.ml
  [@@@css ".css-ivpc5y3{width:66px;}"]
  [@@@css ".css-ivpcx5y3{width:76px;}"]
  let b66 = CSS.make "css-ivpc5y3" []
  let b76 = CSS.make "css-ivpcx5y3" []

A wider suffix keeps the narrower one at its end (it is the hash modulo a
power of 36), so the last three characters of each class show the clash:
both classes end in the same three characters.

  $ grep -o '"css-[0-9a-z]*"' input.out.ml | tr -d '"' | sort -u | awk '{ s = substr($0, length($0) - 2); n[s]++ } END { for (s in n) print s, n[s] }'
  5y3 2

Blocks differ by their binding too: `b695` and `b954` have the same rules
and the same three characters, so `b954` widens and the two keep their own
classes.

  $ cat > input.ml <<EOF
  > let b695 = [%css "color: red"]
  > let b954 = [%css "color: red"]
  > EOF
  $ ../../standalone.exe --impl input.ml -o input.out.ml
  $ grep '^\[@@@css "\|CSS.make' input.out.ml
  [@@@css ".css-ivpcyt4{color:red;}"]
  [@@@css ".css-ivpc7yt4{color:red;}"]
  let b695 = CSS.make "css-ivpcyt4" []
  let b954 = CSS.make "css-ivpc7yt4" []
  $ grep -o '"css-[0-9a-z]*"' input.out.ml | tr -d '"' | sort -u | awk '{ s = substr($0, length($0) - 2); n[s]++ } END { for (s in n) print s, n[s] }'
  yt4 2

Swapping the two blocks swaps which one widens:

  $ cat > input.ml <<EOF
  > let b954 = [%css "color: red"]
  > let b695 = [%css "color: red"]
  > EOF
  $ ../../standalone.exe --impl input.ml -o input.out.ml
  $ grep 'CSS.make' input.out.ml
  let b954 = CSS.make "css-ivpcyt4" []
  let b695 = CSS.make "css-ivpcxyt4" []
  $ grep -o '"css-[0-9a-z]*"' input.out.ml | tr -d '"' | sort -u | awk '{ s = substr($0, length($0) - 2); n[s]++ } END { for (s in n) print s, n[s] }'
  yt4 2

The aggregator accepts the widened classes:

  $ styled-ppx.generate input.out.ml
  /* This file is generated by styled-ppx, do not edit manually */
  .css-ivpcyt4{color:red;}
  .css-ivpcxyt4{color:red;}

A selector reference from another module resolves to the widened class:

  $ cat > page.ml <<EOF
  > let p = [%css {|& .\$(Input.b695) { color: blue; }|}]
  > EOF
  $ ../../standalone.exe --impl page.ml -o page.out.ml
  $ styled-ppx.generate input.out.ml page.out.ml | grep 'blue'
  .css-u54s2ie .css-ivpcxyt4{color:blue;}
