Every named [%css] binding and [%styled.<tag>] component carries its binding
name as the label of its styles carrier (`CSS.make(~label, ...)`), and styled
components render that label as the element's `part` attribute. `part` is a
global HTML attribute that does nothing outside a shadow root, so it costs no
CSS and survives production; DevTools can find every instance with
`[part~="layout"]`. Anonymous (`let _`) and statement-position bindings have
no name, so no label and no `part`.

  $ refmt --parse re --print ml input.re > input.ml

Native: the label is the third component of the carrier, and the generated
component prepends a `part` prop when the label is non-empty.

  $ ../../standalone.exe --native --impl input.ml -o native.ml
  $ refmt --parse ml --print re native.ml | grep -E "CSS.make|part"
    CSS.make(~label="layout", "cid-1jj5tmt css-k008qs css-38zrbw", []);
  let _ = CSS.make("css-tokvmb", []);
  CSS.make("css-14ksm7b", []);
    let styles = CSS.make(~label="Button", "cid-1qldrk3 css-kbn7if", []);
      and part = CSS.label(styles);
        switch (part) {
            React.JSX.string("part", "part", label),

Melange: same carrier, and the props object gets `part` only when the label
is non-empty.

  $ ../../standalone.exe --impl input.ml -o js.ml
  $ refmt --parse ml --print re js.ml | grep -E "CSS.make|part"
    CSS.make(~label="layout", "cid-1jj5tmt css-k008qs css-38zrbw", []);
  let _ = CSS.make("css-tokvmb", []);
  CSS.make("css-14ksm7b", []);
        ~part: string=?,
    let styles = CSS.make(~label="Button", "cid-1qldrk3 css-kbn7if", []);
      and part = CSS.label(styles);
          ~part=?part == "" ? None : Some(part),

The label never reaches the extracted CSS: the rules carry only the atom
hashes.

  $ grep '@@@css "' native.ml
  [@@@css ".css-k008qs{display:flex;}"]
  [@@@css ".css-38zrbw{padding:12px;}"]
  [@@@css ".css-tokvmb{color:red;}"]
  [@@@css ".css-14ksm7b{color:blue;}"]
  [@@@css ".css-kbn7if{color:white;}"]
