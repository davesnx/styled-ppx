(* Full integration test for cx2 extraction pipeline *)

(* Test 1: Basic static cx2 *)
let staticCss = [%css "display: flex; justify-content: center;"]

(* Test 2: cx2 with interpolation *)
let dynamicCss color = [%css {|
  color: $(color);
  display: flex;
|}]

(* Test 3: Logical properties (new mappings) *)
let logicalProps spacing =
  [%css
    {|
  margin-block: $(spacing);
  margin-inline: $(spacing);
  padding-block-start: $(spacing);
  padding-inline-end: $(spacing);
  inset-block-start: $(spacing);
|}]

(* Test 4: Nested selectors *)
let nestedCss =
  [%css
    {|
  display: flex;
  &:hover {
    opacity: 0.8;
  }
  .child {
    flex: 1;
  }
|}]

(* Test 5: Basic media query *)
let responsiveCss =
  [%css
    {|
  display: flex;
  @media (max-width: 768px) {
    display: block;
  }
|}]

(* Test 5b: Multiple media queries *)
let multipleMediaQueries =
  [%css
    {|
  font-size: 16px;
  @media (max-width: 768px) {
    font-size: 14px;
  }
  @media (max-width: 480px) {
    font-size: 12px;
  }
|}]

(* Test 5c: Media query with nested selector *)
let mediaWithSelector =
  [%css
    {|
  display: flex;
  .item {
    flex: 1;
  }
  @media (max-width: 768px) {
    flex-direction: column;
    .item {
      flex: none;
    }
  }
|}]

(* Test 5d: Complex media query conditions *)
let complexMedia =
  [%css
    {|
  display: grid;
  @media screen and (min-width: 768px) and (max-width: 1024px) {
    display: flex;
  }
  @media (prefers-color-scheme: dark) {
    background-color: #1a1a1a;
  }
|}]

(* Test 5e: Media query with interpolation *)
let mediaWithInterpolation color =
  [%css
    {|
  color: $(color);
  @media (max-width: 768px) {
    opacity: 0.8;
  }
|}]

(* Test 6: keyframe extraction *)
let fadeIn = [%keyframe {|
  from { opacity: 0; }
  to { opacity: 1; }
|}]

let slideUp =
  [%keyframe
    {|
  0% { transform: translateY(100%); }
  100% { transform: translateY(0); }
|}]

(* Test 7: styled.global *)
module GlobalReset =
  [%styled.global
  {|
  :root {
    --primary-color: blue;
  }

  body {
    margin: 0;
    font-family: system-ui, sans-serif;
  }
|}]

(* Test 8: Multiple variables in one cx2 *)
let multiVar primary secondary size =
  [%css
    {|
  color: $(primary);
  background-color: $(secondary);
  font-size: $(size);
  padding: 10px;
|}]

(* Test 9: Grid properties *)
let gridCss =
  [%css
    {|
  display: grid;
  grid-template-columns: 1fr 2fr 1fr;
  gap: 20px;
|}]

(* Test 10: Scroll properties *)
let scrollCss = [%css "scroll-behavior: smooth; overflow-y: auto;"]

(* Usage examples to verify the generated code compiles *)
let _ = ReactDOM.jsx "div" (ReactDOM.domProps ~className:(fst staticCss) ())

let _ =
  ReactDOM.jsx "div"
    (ReactDOM.domProps
       ~className:(fst (dynamicCss CSS.red))
       ~style:(snd (dynamicCss CSS.red))
       ())

let _ =
  ReactDOM.jsx "div"
    (ReactDOM.domProps
       ~className:(fst (logicalProps (CSS.px 20)))
       ~style:(snd (logicalProps (CSS.px 20)))
       ())

let _ = ReactDOM.jsx "div" (ReactDOM.domProps ~className:(fst responsiveCss) ())

let _ =
  ReactDOM.jsx "div"
    (ReactDOM.domProps ~className:(fst multipleMediaQueries) ())

let _ =
  ReactDOM.jsx "div" (ReactDOM.domProps ~className:(fst mediaWithSelector) ())

let _ = ReactDOM.jsx "div" (ReactDOM.domProps ~className:(fst complexMedia) ())

let _ =
  ReactDOM.jsx "div"
    (ReactDOM.domProps
       ~className:(fst (mediaWithInterpolation CSS.blue))
       ~style:(snd (mediaWithInterpolation CSS.blue))
       ())
