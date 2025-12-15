  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-17vxl0k { display: flex; }\n.css-3tpy8b { color: var(--var-19ja411); }\n.css-1uzc9um { background-color: var(--var-1xt8d8f); }\n"
  ];
  let woo = CSS.make("css-17vxl0k", []);
  
  let css = main =>
    CSS.make(
      "css-3tpy8b css-1uzc9um css-17vxl0k",
      [("--var-19ja411", CSS.Types.Color.toString(main)), ("--var-1xt8d8f", CSS.Types.Color.toString(CSS.black))],
    );
  
  let maybe_css = Some(CSS.make("css-17vxl0k", []));
  
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(~className=fst(css(CSS.red)), ~style=snd(css(CSS.red)), ()),
    );
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~className=?
          switch (maybe_css) {
          | None => None
          | Some(x) => Some(fst(x))
          },
        ~style=?
          switch (maybe_css) {
          | None => None
          | Some(x) => Some(snd(x))
          },
        (),
      ),
    );
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~className=fst(css(CSS.red)) ++ " " ++ "extra-classname",
        ~style=snd(css(CSS.red)),
        (),
      ),
    );
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~className=
          switch (
            switch (maybe_css) {
            | None => None
            | Some(x) => Some(fst(x))
            }
          ) {
          | None => "extra-classname"
          | Some(x) => x ++ " " ++ "extra-classname"
          },
        ~style=?
          switch (maybe_css) {
          | None => None
          | Some(x) => Some(snd(x))
          },
        (),
      ),
    );
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~className=fst(css(CSS.red)),
        ~style=ReactDOM.Style.combine(ReactDOM.Style.make(~display="flex", ()), snd(css(CSS.red))),
        (),
      ),
    );
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~className=?
          switch (maybe_css) {
          | None => None
          | Some(x) => Some(fst(x))
          },
        ~style=
          switch (
            switch (maybe_css) {
            | None => None
            | Some(x) => Some(snd(x))
            }
          ) {
          | None => ReactDOM.Style.make(~display="flex", ())
          | Some(x) => ReactDOM.Style.combine(ReactDOM.Style.make(~display="flex", ()), x)
          },
        (),
      ),
    );
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~className=fst(css(CSS.red)) ++ " " ++ "extra-classname",
        ~style=ReactDOM.Style.combine(ReactDOM.Style.make(~display="flex", ()), snd(css(CSS.red))),
        (),
      ),
    );
  let _ =
    ReactDOM.jsx(
      "div",
      ([@merlin.hide] ReactDOM.domProps)(
        ~className=
          switch (
            switch (maybe_css) {
            | None => None
            | Some(x) => Some(fst(x))
            }
          ) {
          | None => "extra-classname"
          | Some(x) => x ++ " " ++ "extra-classname"
          },
        ~style=
          switch (
            switch (maybe_css) {
            | None => None
            | Some(x) => Some(snd(x))
            }
          ) {
          | None => ReactDOM.Style.make(~display="flex", ())
          | Some(x) => ReactDOM.Style.combine(ReactDOM.Style.make(~display="flex", ()), x)
          },
        (),
      ),
    );
