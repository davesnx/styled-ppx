  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body:not(.css-nk32ej-card){margin:0;}"];
  [@css ".css-nk32ej-card{background:var(--var-ivms5p);}"];
  [@css ".css-b7rhyr-active.css-nk32ej-card{color:white;}"];
  [@css ".container .css-nk32ej-card{color:var(--var-ivms5p);}"];
  [@css ".css-nk32ej-card{padding:10px;}"];
  [@css ".css-b7rhyr-active{border:1px solid;}"];
  [@css.bindings
    [
      ("Output.card", "css-nk32ej-card"),
      ("Output.active", "css-b7rhyr-active"),
    ]
  ];
  let card = CSS.make("css-nk32ej-card", []);
  let active = CSS.make("css-b7rhyr-active", []);
  let bg = CSS.red;
  module CardGlobals = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-ivms5p:") ++ CSS.Types.Background.toString(bg))
        ++ ";"
      )
      ++ "}";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    [@warning "-27-32"]
    let makeProps = (~key=?, ()) => ();
    let make = _props => CSS.global_style_tag(to_string());
  };
