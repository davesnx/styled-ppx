  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  ignore(
    CSS.global([|
      CSS.selector(
        {js|html|js},
        [|
          CSS.lineHeight(`abs(1.15)),
          CSS.unsafe({js|textSizeAdjust|js}, {js|100%|js}),
        |],
      ),
      CSS.selector({js|body|js}, [|CSS.margin(`zero)|]),
      CSS.selector({js|main|js}, [|CSS.display(`block)|]),
      CSS.selector(
        {js|h1|js},
        [|CSS.fontSize(`em(2.)), CSS.margin2(~v=`em(0.67), ~h=`zero)|],
      ),
      CSS.selector(
        {js|hr|js},
        [|
          CSS.boxSizing(`contentBox),
          CSS.height(`zero),
          CSS.overflow(`visible),
        |],
      ),
      CSS.selector(
        {js|pre|js},
        [|
          CSS.fontFamilies([|"monospace", "monospace"|]),
          CSS.fontSize(`em(1.)),
        |],
      ),
      CSS.selector({js|a|js}, [|CSS.backgroundColor(`transparent)|]),
      CSS.selector(
        {js|abbr[title]|js},
        [|
          CSS.unsafe({js|borderBottom|js}, {js|none|js}),
          CSS.textDecoration(`underline),
          CSS.unsafe({js|textDecoration|js}, {js|underline dotted|js}),
        |],
      ),
      CSS.selector({js|b, strong|js}, [|CSS.fontWeight(`bolder)|]),
      CSS.selector(
        {js|code, kbd, samp|js},
        [|
          CSS.fontFamilies([|"monospace", "monospace"|]),
          CSS.fontSize(`em(1.)),
        |],
      ),
      CSS.selector({js|small|js}, [|CSS.fontSize(`percent(80.))|]),
      CSS.selector(
        {js|sub, sup|js},
        [|
          CSS.fontSize(`percent(75.)),
          CSS.lineHeight(`zero),
          CSS.unsafe({js|position|js}, {js|relative|js}),
          CSS.verticalAlign(`baseline),
        |],
      ),
      CSS.selector({js|sub|js}, [|CSS.bottom(`em(-0.25))|]),
      CSS.selector({js|sup|js}, [|CSS.top(`em(-0.5))|]),
      CSS.selector({js|img|js}, [|CSS.borderStyle(`none)|]),
      CSS.selector(
        {js|button, input, optgroup, select, textarea|js},
        [|
          CSS.unsafe({js|fontFamily|js}, {js|inherit|js}),
          CSS.fontSize(`percent(100.)),
          CSS.lineHeight(`abs(1.15)),
          CSS.margin(`zero),
        |],
      ),
      CSS.selector({js|button, input|js}, [|CSS.overflow(`visible)|]),
      CSS.selector({js|button, select|js}, [|CSS.textTransform(`none)|]),
      CSS.selector(
        {js|button, [type="button"], [type="reset"], [type="submit"]|js},
        [|CSS.unsafe({js|WebkitAppearance|js}, {js|button|js})|],
      ),
      CSS.selector(
        {js|button::-moz-focus-inner, [type="button"]::-moz-focus-inner, [type="reset"]::-moz-focus-inner, [type="submit"]::-moz-focus-inner|js},
        [|CSS.borderStyle(`none), CSS.padding(`zero)|],
      ),
      CSS.selector(
        {js|button:-moz-focusring, [type="button"]:-moz-focusring, [type="reset"]:-moz-focusring, [type="submit"]:-moz-focusring|js},
        [|CSS.unsafe({js|outline|js}, {js|1px dotted ButtonText|js})|],
      ),
      CSS.selector(
        {js|fieldset|js},
        [|CSS.padding3(~top=`em(0.35), ~h=`em(0.75), ~bottom=`em(0.625))|],
      ),
      CSS.selector(
        {js|legend|js},
        [|
          CSS.boxSizing(`borderBox),
          CSS.unsafe({js|color|js}, {js|inherit|js}),
          CSS.display(`table),
          CSS.maxWidth(`percent(100.)),
          CSS.padding(`zero),
          CSS.whiteSpace(`normal),
        |],
      ),
      CSS.selector({js|progress|js}, [|CSS.verticalAlign(`baseline)|]),
      CSS.selector({js|textarea|js}, [|CSS.overflow(`auto)|]),
      CSS.selector(
        {js|[type="checkbox"], [type="radio"]|js},
        [|CSS.boxSizing(`borderBox), CSS.padding(`zero)|],
      ),
      CSS.selector(
        {js|[type="number"]::-webkit-inner-spin-button, [type="number"]::-webkit-outer-spin-button|js},
        [|CSS.height(`auto)|],
      ),
      CSS.selector(
        {js|[type="search"]|js},
        [|
          CSS.unsafe({js|WebkitAppearance|js}, {js|textfield|js}),
          CSS.outlineOffset(`pxFloat(-2.)),
        |],
      ),
      CSS.selector(
        {js|[type="search"]::-webkit-search-decoration|js},
        [|CSS.unsafe({js|WebkitAppearance|js}, {js|none|js})|],
      ),
      CSS.selector(
        {js|::-webkit-file-upload-button|js},
        [|
          CSS.unsafe({js|WebkitAppearance|js}, {js|button|js}),
          CSS.unsafe({js|font|js}, {js|inherit|js}),
        |],
      ),
      CSS.selector({js|details|js}, [|CSS.display(`block)|]),
      CSS.selector({js|summary|js}, [|CSS.display(`listItem)|]),
      CSS.selector({js|template|js}, [|CSS.display(`none)|]),
      CSS.selector({js|[hidden]|js}, [|CSS.display(`none)|]),
      CSS.selector(
        {js|:root|js},
        [|CSS.unsafe({js|--shiki-color-text|js}, {js|oklch(37.53% 0 0)|js})|],
      ),
    |]),
  );
