Default mode expands `styles` on lowercase JSX and leaves other calls alone.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E 'passthrough|className|style|combine|Foo'
  let passthrough = (~styles) => styles;
  let _ = passthrough(~styles=buttonStyles);
  let _ = <div className={fst(buttonStyles)} style={snd(buttonStyles)} />;
      className={fst(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, snd(buttonStyles))}
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;

Native mode keeps the same `styles` expansion contract before native JSX lowering.

  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --native --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml | grep -E 'passthrough|className|style|combine|Foo'
  let passthrough = (~styles) => styles;
  let _ = passthrough(~styles=buttonStyles);
  let _ = <div className={fst(buttonStyles)} style={snd(buttonStyles)} />;
      className={fst(buttonStyles) ++ " " ++ "base"}
      style={ReactDOM.Style.combine(baseStyle, snd(buttonStyles))}
  let _ = <Foo styles=buttonStyles />;
  let _ = <Foo.Bar styles=buttonStyles />;
