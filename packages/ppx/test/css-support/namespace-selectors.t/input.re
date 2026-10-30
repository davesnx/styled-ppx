/* Selectors 4 <ns-prefix>: namespace-qualified type selectors reach the
   extracted CSS verbatim. */
let _a = [%css "svg|circle { fill: red; }"];
let _b = [%css "*|a { color: blue; }"];
let _c = [%css "|a { color: green; }"];
let _d = [%css "svg|* { color: pink; }"];
let _e = [%css "[xlink|href] { color: black; }"];
