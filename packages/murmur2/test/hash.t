  $ ./compare.sh ""
  Hashes match: 0
  $ ./compare.sh "something "
  Hashes match: 5aqktu
  $ ./compare.sh "something"
  Hashes match: crsxd7
  $ ./compare.sh "padding: 0;"
  Hashes match: 14em68c
  $ ./compare.sh "paddinxg: 1;"
  Hashes match: 103fxnp
  $ ./compare.sh "padding: 0px;"
  Hashes match: 1mqllfw
  $ ./compare.sh "padding: 2px;"
  Hashes match: 1kgw61x
  $ ./compare.sh "color: #323337"
  Hashes match: v3ltn7
  $ ./compare.sh "color: #323335"
  Hashes match: pru0h8
  $ ./compare.sh "font-size: 32px;"
  Hashes match: 1aeywr2
  $ ./compare.sh "font-size: 33px;"
  Hashes match: xts11q
  $ ./compare.sh "display: block"
  Hashes match: 1ni8fbp
  $ ./compare.sh "display: blocki"
  Hashes match: 1rb2f34
  $ ./compare.sh "display: block;"
  Hashes match: avwy6
  $ ./compare.sh "display: flex"
  Hashes match: 18hxz5k
  $ ./compare.sh "display: flex;"
  Hashes match: 17vxl0k
  $ ./compare.sh "color: #333;"
  Hashes match: m97760
  $ ./compare.sh "font-size: 22px;"
  Hashes match: 1m7bgz5
  $ ./compare.sh "font-size: 40px;"
  Hashes match: pm5q90
  $ ./compare.sh "line-height: 22px;"
  Hashes match: lehwic
  $ ./compare.sh "display: flex; font-size: 33px"
  Hashes match: c8y5k7
  $ ./compare.sh "background-color: red"
  Hashes match: mhqmk0
  $ ./compare.sh "width: 100%"
  Hashes match: 71gbl7
  $ ./compare.sh "height: 100%"
  Hashes match: t3ccau
  $ ./compare.sh "min-width: auto"
  Hashes match: 13s44nx
  $ ./compare.sh "min-height: auto"
  Hashes match: 8zn0wa
  $ ./compare.sh "max-width: 100vw"
  Hashes match: qilhjh
  $ ./compare.sh "max-height: 100vh"
  Hashes match: 1tmr74f
  $ ./compare.sh "margin: 3px"
  Hashes match: 1dpky6u
  $ ./compare.sh "border: 1px solid red"
  Hashes match: 1j0fwx2
  $ ./compare.sh "border: none"
  Hashes match: zn5chm
  $ ./compare.sh "border-color: grey"
  Hashes match: 7nfkvr
  $ ./compare.sh "border-radius: 6px"
  Hashes match: wyudoy
  $ ./compare.sh "font-family: Inter"
  Hashes match: 1bfbb9d
  $ ./compare.sh "font-style: italic"
  Hashes match: 9i7il8
  $ ./compare.sh "font-weight: 400"
  Hashes match: 1q1joro
  $ ./compare.sh "position: absolute"
  Hashes match: 1vmrgk7
  $ ./compare.sh "position: relative"
  Hashes match: 1dcu5cj
  $ ./compare.sh "z-index: 9999999"
  Hashes match: 1w4us3o
  $ ./compare.sh "z-index: 10"
  Hashes match: 7au0g0

The following two rule sets produced the same hash (see https://github.com/davesnx/styled-ppx/pull/376)

  $ ./compare.sh "color:var(--alt-text--tertiary);:disabled{color:var(--alt-text--tertiary);}:hover{color:var(--alt-text--primary);}"
  Hashes match: 66bc4u
  $ ./compare.sh "display:flex;:before, :after{content:'';flex:0 0 16px;}"
  Hashes match: ab0yh7
