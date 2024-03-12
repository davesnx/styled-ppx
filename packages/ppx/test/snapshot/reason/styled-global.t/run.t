  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  ignore(
    CssJs.global([|
      CssJs.selector(
        {js|html|js},
        [|
          CssJs.lineHeight(`abs(1.15)),
          [%ocaml.error "Unknown property '-webkit-text-size-adjust'"],
        |],
      ),
      CssJs.selector({js|body|js}, [|CssJs.margin(`zero)|]),
      CssJs.selector({js|main|js}, [|CssJs.display(`block)|]),
      CssJs.selector(
        {js|h1|js},
        [|CssJs.fontSize(`em(2.)), CssJs.margin2(~v=`em(0.67), ~h=`zero)|],
      ),
      CssJs.selector(
        {js|hr|js},
        [|
          CssJs.boxSizing(`contentBox),
          CssJs.height(`zero),
          CssJs.overflow(`visible),
        |],
      ),
      CssJs.selector(
        {js|pre|js},
        [|
          CssJs.fontFamilies([|`monospace, `monospace|]),
          CssJs.fontSize(`em(1.)),
        |],
      ),
      CssJs.selector({js|a|js}, [|CssJs.backgroundColor(`transparent)|]),
      CssJs.selector(
        {js|abbr[title]|js},
        [|
          CssJs.unsafe({js|borderBottom|js}, {js|none|js}),
          CssJs.textDecoration(`underline),
          CssJs.textDecoration(`underline),
        |],
      ),
      CssJs.selector({js|b, strong|js}, [|CssJs.fontWeight(`bolder)|]),
      CssJs.selector(
        {js|code, kbd, samp|js},
        [|
          CssJs.fontFamilies([|`monospace, `monospace|]),
          CssJs.fontSize(`em(1.)),
        |],
      ),
      CssJs.selector({js|small|js}, [|CssJs.fontSize(`percent(80.))|]),
      CssJs.selector(
        {js|sub, sup|js},
        [|
          CssJs.fontSize(`percent(75.)),
          CssJs.lineHeight(`zero),
          CssJs.unsafe({js|position|js}, {js|relative|js}),
          CssJs.verticalAlign(`baseline),
        |],
      ),
      CssJs.selector({js|sub|js}, [|CssJs.bottom(`em(-0.25))|]),
      CssJs.selector({js|sup|js}, [|CssJs.top(`em(-0.5))|]),
      CssJs.selector({js|img|js}, [|CssJs.borderStyle(`none)|]),
      CssJs.selector(
        {js|button, input, optgroup, select, textarea|js},
        [|
          CssJs.unsafe({js|font-family|js}, {js|inherit|js}),
          CssJs.fontSize(`percent(100.)),
          CssJs.lineHeight(`abs(1.15)),
          CssJs.margin(`zero),
        |],
      ),
      CssJs.selector({js|button, input|js}, [|CssJs.overflow(`visible)|]),
      CssJs.selector({js|button, select|js}, [|CssJs.textTransform(`none)|]),
      CssJs.selector(
        {js|button, [type="button"], [type="reset"], [type="submit"]|js},
        [|CssJs.unsafe({js|WebkitAppearance|js}, {js|button|js})|],
      ),
      CssJs.selector(
        {js|button::-moz-focus-inner, [type="button"]::-moz-focus-inner, [type="reset"]::-moz-focus-inner, [type="submit"]::-moz-focus-inner|js},
        [|CssJs.borderStyle(`none), CssJs.padding(`zero)|],
      ),
      CssJs.selector(
        {js|button:-moz-focusring, [type="button"]:-moz-focusring, [type="reset"]:-moz-focusring, [type="submit"]:-moz-focusring|js},
        [|CssJs.unsafe({js|outline|js}, {js|1px dotted ButtonText|js})|],
      ),
      CssJs.selector(
        {js|fieldset|js},
        [|
          CssJs.padding3(~top=`em(0.35), ~h=`em(0.75), ~bottom=`em(0.625)),
        |],
      ),
      CssJs.selector(
        {js|legend|js},
        [|
          CssJs.boxSizing(`borderBox),
          CssJs.unsafe({js|color|js}, {js|inherit|js}),
          CssJs.display(`table),
          CssJs.maxWidth(`percent(100.)),
          CssJs.padding(`zero),
          CssJs.whiteSpace(`normal),
        |],
      ),
      CssJs.selector({js|progress|js}, [|CssJs.verticalAlign(`baseline)|]),
      CssJs.selector({js|textarea|js}, [|CssJs.overflow(`auto)|]),
      CssJs.selector(
        {js|[type="checkbox"], [type="radio"]|js},
        [|CssJs.boxSizing(`borderBox), CssJs.padding(`zero)|],
      ),
      CssJs.selector(
        {js|[type="number"]::-webkit-inner-spin-button, [type="number"]::-webkit-outer-spin-button|js},
        [|CssJs.height(`auto)|],
      ),
      CssJs.selector(
        {js|[type="search"]|js},
        [|
          CssJs.unsafe({js|WebkitAppearance|js}, {js|textfield|js}),
          CssJs.outlineOffset(`pxFloat(-2.)),
        |],
      ),
      CssJs.selector(
        {js|[type="search"]::-webkit-search-decoration|js},
        [|CssJs.unsafe({js|WebkitAppearance|js}, {js|none|js})|],
      ),
      CssJs.selector(
        {js|::-webkit-file-upload-button|js},
        [|
          CssJs.unsafe({js|WebkitAppearance|js}, {js|button|js}),
          CssJs.unsafe({js|font|js}, {js|inherit|js}),
        |],
      ),
      CssJs.selector({js|details|js}, [|CssJs.display(`block)|]),
      CssJs.selector({js|summary|js}, [|CssJs.display(`listItem)|]),
      CssJs.selector({js|template|js}, [|CssJs.display(`none)|]),
      CssJs.selector({js|[hidden]|js}, [|CssJs.display(`none)|]),
    |]),
  );
