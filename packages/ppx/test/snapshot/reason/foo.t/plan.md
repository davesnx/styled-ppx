let fancy = main => [%cx
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div style={fancy(CSS.red)} />;

/* Needs to get transformed into */

/* inject
   .css-123-1 {
     color: var(--main);
   .css-123-2 {
     background-color: var(--background-color);
   .css-123-3 {
     display: flex;
   }
   into a style.css file
   */

let css = main =>
  CSS.make(
    "css-123",
    {
      "--main": main,
      "--background-color": CSS.black,
    },
  );

let x = css(CSS.red);
<div className={x.className} styles={{ "--amazing": value }} />;

<!-- TODOS -->
- ppx to generate a css file
- ppx to split static properties and dynamic properties
- ppx to modify "style" prop into "className" and "styles"

# Problem 1

let boring = value => [%cx {|
  color: $(value);
|}];

<div style={CSS.merge(fancy(CSS.red), boring(CSS.blue))} />

We can remove the runtime completely and go for static styles. Generate CSS files in the _build folder (for Melange/native) and in-source in ReScript.

- We will remove the runtime completely allowing much faster implementation
- Output real CSS (can be extracted to a new file, cached)
- Dynamic components can be translated to CSS variables
    - Is that possible?
        - https://pawelgrzybek.com/interpolate-css-custom-properties-values/
        - can we use variables in media-queries/selectors?
    - Which dynamic values aren't representable as CSS variables?
        - If there's a list of them, can we generate inline styles for those?
- We can have development type-safety if we keep the parsing/type-checking + inline styles at run-time? Not sure how thought, maybe with unboxed?
-  We already have a css-in-js logic implemented in native

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

## Ideal plan

- [x] Understand what it means 0 runtime cost with dynamic styling compiledcssinjs.com https://github.com/callstack/linaria
- [ ] Read a few resources about it
	- https://shud.in/posts/ssr-streaming-and-css-in-js
	- https://github.com/andreipfeiffer/css-in-js
	- https://medium.com/@tkh44/writing-a-css-in-js-library-from-scratch-96cd23a017b4
	- https://scrimba.com/g/gcssvariables
	- https://github.com/threepointone/glam/tree/e9bca3950f12503246ed7fccad5cf13e5e9c86e3
	- https://www.youtube.com/watch?v=Gw28VgyKGkw&ab_channel=LeeRobinson
	- https://github.com/tw-in-js/twind
	- https://joshwcomeau.com/css/css-variables-for-react-devs/
	- https://www.lekoarts.de/javascript/writing-performant-css-with-vanilla-extract
	- Rethinking CSS - Introducing Stylex https://youtu.be/ur-sGzUWId4
	- The problem with importing css https://www.coolcomputerclub.com/posts/importing-css
	- Take a look at ppx_css from janestreet https://github.com/janestreet/ppx_css/blob/master/inline_css/src/inline_css.ml
	- React 18's discussion https://github.com/reactwg/react-18/discussions/110
- [x] Create the logic at runtime first (styled-ppx.emotion-native)
- [ ] Implement a CSS printer for static styles
    - Can we reuse runtime/native/CSS module to print it
- [ ] Generate static files from the output of the runtime/native/CSS
    - Generate css files similarly to https://github.com/hyper-systems/rescript-sx
    - Create a cache for it (don’t re-generate files that don’t change)
    - Avoid the hashing in testing (or add labels)
- [ ] Create a CSS minifier pretty printer
	    - https://github.com/janestreet/ppx_css/blob/master/css_jane/src/css_jane.ml
	    - https://github.com/astrada/ocaml-css-parser/blob/master/test/css_fmt_printer.ml
	    - https://git.chimrod.com/css_lib.git/tree/lib/print.ml
- [ ] Dynamic styling
    - Parser should support CSS variables
    - Render to styles should render to inline styles as well (native-react + to_string)
- [ ] Support dynamic values. (Transform to CSS variables and inject static CSS)
    - What should we do on interpolation in selectors and mediaqueries?
- [ ] Remove the "bridge" from css to bs-emotion and move it to inline-styles
- [x] Implement a vendor-prefixer for unsupported properties https://github.com/kripod/style-vendorizer (styled-ppx.emotion-native)
- [ ] Remove array API? and css extension?

## Similar implementations

- https://github.com/stereobooster/css-in-js-101
- https://4catalyzer.github.io/astroturf/introduction
- https://twind.dev/handbook/introduction.html#features
- https://github.com/microsoft/griffel
- https://github.com/CraigCav/css-zero
- https://github.com/callstack/linaria
- https://github.com/modulz/stitches
- https://github.com/atlassian-labs/compiled
- https://github.com/jsxstyle/jsxstyle
- cssx
https://github.com/krasimir/cssx/tree/master/packages/cssx
https://www.smashingmagazine.com/2016/04/finally-css-javascript-meet-cssx/
- emotion
https://github.com/emotion-js/emotion/blob/v9.2.12/packages/create-emotion/src/index.js
https://github.com/thysultan/stylis.js/tree/master/src
- Zero-runtime CSS-in-TypeScript with 🧁 vanilla-extract
https://www.youtube.com/watch?v=-Idub5K7K6Q&t=2556s
- https://github.com/antfu/unocss
- https://github.com/justjavac/postcss-rs
- https://github.com/4Catalyzer/astroturf
- https://twitter.com/devongovett/status/1454126641555386372?s=28
- https://blogg.bekk.no/increasing-the-performance-of-elm-css-34075512d6a6
- `withCSSVar` is a simple helper to access/modify css variables in your code
- https://github.com/kentaromiura/withCSSVar/tree/main
- https://github.com/yukukotani/just-styled
- https://github.com/Anber/wyw-in-js
- https://nerdy.dev/custom-prop-categories
- https://yak.js.org/docs/features
