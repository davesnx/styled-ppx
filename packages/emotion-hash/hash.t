  $ node ./compare.js ""
  0
  $ node ./compare.js "something "
  5aqktu
  $ node ./compare.js "something"
  crsxd7
  $ node ./compare.js "padding: 0;"
  14em68c
  $ node ./compare.js "paddinxg: 1;"
  103fxnp
  $ node ./compare.js "padding: 0px;"
  1mqllfw
  $ node ./compare.js "padding: 2px;"
  1kgw61x
  $ node ./compare.js "color: #323337"
  v3ltn7
  $ node ./compare.js "color: #323335"
  pru0h8
  $ node ./compare.js "font-size: 32px;"
  1aeywr2
  $ node ./compare.js "font-size: 33px;"
  xts11q
  $ node ./compare.js "display: block"
  1ni8fbp
  $ node ./compare.js "display: blocki"
  1rb2f34
  $ node ./compare.js "display: block;"
  avwy6
  $ node ./compare.js "display: flex"
  18hxz5k
  $ node ./compare.js "display: flex;"
  17vxl0k
  $ node ./compare.js "color: #333;"
  m97760
  $ node ./compare.js "font-size: 22px;"
  1m7bgz5
  $ node ./compare.js "font-size: 40px;"
  pm5q90
  $ node ./compare.js "line-height: 22px;"
  lehwic
  $ node ./compare.js "display: flex; font-size: 33px"
  c8y5k7
  $ node ./compare.js "background-color: red"
  mhqmk0
  $ node ./compare.js "width: 100%"
  71gbl7
  $ node ./compare.js "height: 100%"
  t3ccau
  $ node ./compare.js "min-width: auto"
  13s44nx
  $ node ./compare.js "min-height: auto"
  8zn0wa
  $ node ./compare.js "max-width: 100vw"
  qilhjh
  $ node ./compare.js "max-height: 100vh"
  1tmr74f
  $ node ./compare.js "margin: 3px"
  1dpky6u
  $ node ./compare.js "border: 1px solid red"
  1j0fwx2
  $ node ./compare.js "border: none"
  zn5chm
  $ node ./compare.js "border-color: grey"
  7nfkvr
  $ node ./compare.js "border-radius: 6px"
  wyudoy
  $ node ./compare.js "font-family: Inter"
  1bfbb9d
  $ node ./compare.js "font-style: italic"
  9i7il8
  $ node ./compare.js "font-weight: 400"
  1q1joro
  $ node ./compare.js "position: absolute"
  1vmrgk7
  $ node ./compare.js "position: relative"
  1dcu5cj
  $ node ./compare.js "z-index: 9999999"
  1w4us3o
  $ node ./compare.js "z-index: 10"
  7au0g0

The following two rule sets produced the same hash (see https://github.com/davesnx/styled-ppx/pull/376)

  $ node ./compare.js "color:var(--alt-text--tertiary);:disabled{color:var(--alt-text--tertiary);}:hover{color:var(--alt-text--primary);}"
  66bc4u
  $ node ./compare.js "display:flex;:before, :after{content:'';flex:0 0 16px;}"
  ab0yh7
