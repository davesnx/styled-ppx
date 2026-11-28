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

Non-ASCII input. The native hash reads the UTF-8 bytes of the string;
@emotion/hash (murmur2.js) reads the low byte of each UTF-16 code unit, so
the two differ on non-ASCII input and only the native hash is pinned below.
Reading the low byte made inputs such as `…` (U+2026), `✦` (U+2726) and `&`
hash the same.

Special chars
  $ ./cli_murmur2.exe 'é'
  ilzlt2
  $ ./cli_murmur2.exe '®'
  g7jfu6
  $ ./cli_murmur2.exe '😀'
  lmvgqi
  $ ./cli_murmur2.exe '中'
  190d7mz
  $ ./cli_murmur2.exe '𐍈'
  1yt2tcr
  $ ./cli_murmur2.exe '™'
  1e9udzs
  $ ./cli_murmur2.exe '☃'
  u7spzg
  $ ./cli_murmur2.exe 'أ'
  17cq4li
  $ ./cli_murmur2.exe 'ß'
  1rfv3ty
  $ ./cli_murmur2.exe 'α'
  1e1uxzs
  $ ./cli_murmur2.exe '♥'
  lq5pl6
  $ ./cli_murmur2.exe 'א'
  1w0lns2
  $ ./cli_murmur2.exe 'ᵖ'
  1jk7esd

UTF-16 Code Units (real code points U+FFFF and astral U+10000, via raw UTF-8 bytes)
  $ ./cli_murmur2.exe "$(printf '\357\277\277')"
  1giifmf
  $ ./cli_murmur2.exe "$(printf '\360\220\200\200')"
  9ycxuf
  $ ./cli_murmur2.exe "$(printf '\357\277\277\360\220\200\200')"
  gz5fuh

Surrogate pairs (astral U+1D11E and U+10FFFF). Lone surrogates are not representable
in valid UTF-8 and cannot pass through argv, so only paired code points are exercised.
  $ ./cli_murmur2.exe "$(printf '\360\235\204\236')"
  m9w5lc
  $ ./cli_murmur2.exe "$(printf '\364\217\277\277')"
  s2nfxe

Combining Marks (real combining acute U+0301 and tilde U+0303, via raw UTF-8 bytes)
  $ ./cli_murmur2.exe "$(printf 'e\314\201')"
  on1yyj
  $ ./cli_murmur2.exe "$(printf 'n\314\203o\314\201')"
  17ie8y0

Mixed BMP and non-BMP
  $ ./cli_murmur2.exe 'a𐍈z'
  1ctl70h
  $ ./cli_murmur2.exe 'é😀中'
  1uekv9k

Emoji combinations
  $ ./cli_murmur2.exe '👍🏽'
  1yjas9n
  $ ./cli_murmur2.exe '👩‍💻'
  1ho5ehw

Chinese and Hindi characters
  $ ./cli_murmur2.exe 'content: "漢字"'
  iylsm3
  $ ./cli_murmur2.exe 'content: "हिन्दी"'
  og9pwq

Non-Printable ASCII and Control Characters (real newline and tab, via printf)
  $ ./compare.sh "$(printf 'Line1\nLine2')"
  Hashes match: xqjxd9
  $ ./compare.sh "$(printf 'Tab\tSpace')"
  Hashes match: d2gg3s

Long strings
  $ ./compare.sh "$(head -c 1000 < /dev/zero | tr '\0' 'a')"
  Hashes match: 11lsq50
  $ ./cli_murmur2.exe "😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀😀"
  ze004f

The following two rule sets produced the same hash (see https://github.com/davesnx/styled-ppx/pull/376)
  $ ./compare.sh "color:var(--alt-text--tertiary);:disabled{color:var(--alt-text--tertiary);}:hover{color:var(--alt-text--primary);}"
  Hashes match: 66bc4u
  $ ./compare.sh "display:flex;:before, :after{content:'';flex:0 0 16px;}"
  Hashes match: ab0yh7

Malformed UTF-8: the bytes are hashed as they are.
  $ ./malformed.exe
  zp11b8 (2 bytes) - 1wob9r9 (3 bytes) - 1x3lfa8 (4 bytes)
