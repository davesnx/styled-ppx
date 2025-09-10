## Idea

We can remove the runtime completely and go for static file generation. Generate CSS files in the _build folder (for Melange/native) and in-source in ReScript.

- We will remove the runtime completely allowing much faster implementation
- Output real CSS (can be extracted to a new file, cached)
- Dynamic components can be translated to CSS variables

```reason
let fancy = main => [%cx
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div style={fancy(CSS.red)} />;

/* Needs to get transformed into */

let css = main =>
  CSS.make(
    "css-123",
    {
      "--main": main,
      "--background-color": CSS.black,
    },
  );

/* inject into a style.css file:
   .css-123-1 {
     color: var(--main);
     background-color: var(--background-color);
     display: flex;
   }
*/

<div className={css(CSS.red).className} styles={css(CSS.red).styles} />;
// Note: `css(CSS.red).styles` will need a bit of boilerplate/runtime with `ReactDOM.Style.make`
```

## Design

### styled.div
```ocaml
module C = [%styled.div "height: 100%"]
(* pushes into an external stylesheet ".div12312 {height: 100%}" *)
(* and generates `module C = <div className="div12312" />` *)

module C = [%styled.div (~what) => "width: $(what); height: 100%"]
(* pushes static properties ".div12312 {height: 100%}" *)
(* generates dynamic properties with CSS vars ".div12345 {width: (--var-what)}" *)
(* module C = <div className="div12312 div12345" style={ReactDOM.Style.make("--var-what": what)} /> *)
```

### cx
```ocaml
let cx = [%cx "height: 100%"]
(* pushes properties ".hash {height: 100%}" *)
(* let cx = ".hash" *)
```

## Todos

- [x] Understand what it means 0 runtime cost with dynamic styling compiledcssinjs.com https://github.com/callstack/linaria
- [x] Read a few resources about it
  - [x] https://shud.in/posts/ssr-streaming-and-css-in-js
  - [x] https://github.com/andreipfeiffer/css-in-js
  - [x] https://medium.com/@tkh44/writing-a-css-in-js-library-from-scratch-96cd23a017b4
  - https://scrimba.com/g/gcssvariables
  - [x] Stitches CSS-in-JS Demo https://www.youtube.com/watch?v=Gw28VgyKGkw
  - https://joshwcomeau.com/css/css-variables-for-react-devs/
  - [x] Rethinking CSS - Introducing Stylex https://youtu.be/ur-sGzUWId4
  - [x] The problem with importing css https://www.coolcomputerclub.com/posts/importing-css
  - [x] Take a look at ppx_css from janestreet https://github.com/janestreet/ppx_css/blob/master/inline_css/src/inline_css.ml
  - React 18's discussion https://github.com/reactwg/react-18/discussions/110
- [x] Create the logic at runtime first (styled-ppx.emotion-native)
- [x] Implement a CSS printer for static styles
  - Can we reuse runtime/native/CSS module to print it
- [x] Generate static files from the output of the runtime/native/CSS
  - [x] Generate css files similarly to https://github.com/hyper-systems/rescript-sx
  - [x] Create a cache for it (don’t re-generate files that don’t change)
- [x] Dynamic styling
  - [x] Parser should support CSS variables
  - [x] Render to styles should render to inline styles as well (native-react + to_string)
- [x] Support dynamic values. (Transform to CSS variables and inject static CSS)
  - What should we do on interpolation in selectors and mediaqueries?
- [x] Implement a vendor-prefixer for unsupported properties https://github.com/kripod/style-vendorizer (styled-ppx.emotion-native)
- [x] `style={ReactDOM.Style.make() |> ...}`
- [x] Support inline variables
- [x] Support render single values, not entire variables
- [x] Implement styled.div/span
- [ ] Bring back type-safety lol
- [ ] selectors
- [ ] media-queries
- [ ] keyframes
- [ ] global
- [ ] Generate atomic
- [ ] Implement CSS.merge
  ```reason
  let boring = value => [%cx2 {| color: $(value); |}];
  <div style={CSS.merge(fancy(CSS.red), boring(CSS.blue))} />
  ```
- [ ] Make a beta release
- [ ] Support "label" or avoid the hashing in development?
- [ ] Make sure variable names are unique
  - [ ] Maybe hashing with locations?
  - [ ] Enable this only in production?
- [ ] Hack something for array API?
- [ ] CSS.unsafe?
- [ ] WTF do we do with CSS.style API?
- [ ] WTF do we do with css extension? Maybe rename cx2 to css and deprecate original css?
- [ ] Remove emotion
  - [ ] Remove the "bridge" from css to bs-emotion and move it to inline-styles
- [ ] Create a CSS minifier pretty printer (enabled disabled by production env?)
  - https://github.com/janestreet/ppx_css/blob/master/css_jane/src/css_jane.ml
  - https://github.com/astrada/ocaml-css-parser/blob/master/test/css_fmt_printer.ml
  - https://git.chimrod.com/css_lib.git/tree/lib/print.ml
- [ ] Lovely documentation
