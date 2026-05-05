  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css "body{color:var(--var-p73s17);}"];
  [@css "*{box-sizing:border-box;}"];
  [@css "div.container#main{padding:0;}"];
  [@css ".btn.primary.large{font-weight:bold;}"];
  [@css "nav a{text-decoration:none;}"];
  [@css "ul > li{list-style:none;}"];
  [@css "h1 + p{margin-top:0;}"];
  [@css "h2 ~ p{color:gray;}"];
  [@css "[type=\"text\"]{padding:4px;}"];
  [@css "[data-state]{opacity:0.5;}"];
  [@css "[href^=\"https\"]{color:green;}"];
  [@css "a[target=\"_blank\"]::after{content:\" ↗\";}"];
  [@css "a:hover{color:var(--var-p73s17);}"];
  [@css "input:focus-visible{outline:2px solid blue;}"];
  [@css "li:nth-child(2n){background:#eee;}"];
  [@css "button:not(:disabled){cursor:pointer;}"];
  [@css "p::first-line{font-weight:bold;}"];
  [@css "q::before{content:\"\\\"\";}"];
  [@css ":is(h1,h2,h3){margin:0;}"];
  [@css ":where(article,section) > p{line-height:1.6;}"];
  [@css "h1,h2,h3{font-family:serif;}"];
  [@css "form input[type=\"submit\"]:hover{background:var(--var-p73s17);}"];
  [@css "*,*::before,*::after{box-sizing:inherit;}"];
  let accent = CSS.red;
  module AllSelectors = {
    let to_string = () =>
      (
        ((":root{" ++ "--var-p73s17:") ++ CSS.Types.Color.toString(accent))
        ++ ";"
      )
      ++ "}";
    let to_buffer = buf => Buffer.add_string(buf, to_string());
    let make = () => CSS.global_style_tag(to_string());
  };
