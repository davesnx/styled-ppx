open Vitest

let toBe = (e, x) => Expect.toBe(e, x->Js.Json.stringifyAny)

let expect = x => expect(CssJs.toJson(x)->Js.Json.stringifyAny)

describe("border-top-style", () => {
  test("test output", _ => {
    expect([%css("border-top-style: hidden")])->toBe({"borderTopStyle": "hidden"})
    expect([%css("border-top-style: none")])->toBe({"borderTopStyle": "none"})
    expect([%css("border-top-style: dotted")])->toBe({"borderTopStyle": "dotted"})
    expect([%css("border-top-style: dashed ")])->toBe({"borderTopStyle": "dashed"})
    expect([%css("border-top-style: solid")])->toBe({"borderTopStyle": "solid"})
    expect([%css("border-top-style: double")])->toBe({"borderTopStyle": "double"})
    expect([%css("border-top-style: groove")])->toBe({"borderTopStyle": "groove"})
    expect([%css("border-top-style: ridge")])->toBe({"borderTopStyle": "ridge"})
    expect([%css("border-top-style: inset")])->toBe({"borderTopStyle": "inset"})
    expect([%css("border-top-style: outset")])->toBe({"borderTopStyle": "outset"})
  })
})

describe("height", () => {
  test("test output", _ => {
    expect([%css("height: 80px")])->toBe({"height": "80px"})
    expect([%css("height: 80%")])->toBe({"height": "80%"})
    expect([%css("height: auto")])->toBe({"height": "auto"})
    expect([%css("height: fit-content ")])->toBe({"height": "fit-content"})
    expect([%css("height: max-content")])->toBe({"height": "max-content"})
    expect([%css("height: min-content")])->toBe({"height": "min-content"})
    expect([%css("height: calc(50% - 20px)")])->toBe({"height": "calc(50% - 20px)"})
    /* expect([%css("height: calc(calc(100% - 20px) + calc(1vw / 2))")])->toBe({
      "height": "calc(calc(100% - 20px) + calc(1vw / 2))"
    }) */
    expect([%css("height: var(--foo)")])->toBe({"height": "var(--foo)"})
  })
})

describe("lineHeight", () => {
  test("test output", _ => {
    expect([%css("line-height: 80px")])->toBe({"lineHeight": "80px"})
    expect([%css("line-height: 80%")])->toBe({"lineHeight": "80%"})
    expect([%css("line-height: calc(100% - 20px)")])->toBe({"lineHeight": "calc(100% - 20px)"})
  })
})

describe("contentRule", () => {
  test("add missing quotes", _ => {
    expect([%css("content: ''")])->toBe({"content": "''"})
    expect([%css("content: '\"'")])->toBe({"content": "'\"'"})
    expect([%css(`content: '\"'`)])->toBe({"content": "'\"'"})
    expect([%css("content: ' '")])->toBe({"content": "' '"})
    expect([%css("content: 'single'")])->toBe({"content": "'single'"})
  })

  test("values", _ => {
    expect([%css("content: none")])->toBe({"content": "none"})
    expect([%css("content: normal")])->toBe({"content": "normal"})
    expect([%css("content: open-quote")])->toBe({"content": "open-quote"})
    expect([%css("content: close-quote")])->toBe({"content": "close-quote"})
    expect([%css("content: no-open-quote")])->toBe({"content": "no-open-quote"})
    expect([%css("content: no-close-quote")])->toBe({"content": "no-close-quote"})
  })
})

describe("Var", () => {
  test("test usage (limited)", _ => {
    expect([%css("color: var(--foo)")])->toBe({"color": "var(--foo)"})
    expect([%css("margin-top: var(--bar)")])->toBe({"marginTop": "var(--bar)"})
    expect([%css("text-decoration: var(--foo)")])->toBe({
      "textDecoration": "var(--foo)",
    })
  })

  /* test("test usage with default (limited)", _ => {
     expect([%css("text-decoration: var(--foo,default)")])->toBe({
      "textDecoration": "var(--foo,default)",
    }) 
    expect([%css("align-items: var(--bar,default)")])->toBe({"alignItems": "var(--bar,default)"})
  }) */
})

describe("Color style", () =>
  test("test values", _ => {
    expect([%css("color: rgb(1, 2, 3)")])->toBe({"color": "rgb(1, 2, 3)"})
    expect([%css("color: rgba(4, 5, 6, 0.3)")])->toBe({"color": "rgba(4, 5, 6, 0.3)"})
    expect([%css("color: hsl(7deg, 8%, 9%)")])->toBe({"color": "hsl(7deg, 8%, 9%)"})
    expect([%css("color: hsla(10deg, 11%, 12%, 0.5)")])->toBe({
      "color": "hsla(10deg, 11%, 12%, 0.5)",
    })
    expect([%css("color: hsla(4.7rad, 11%, 12%, 50%)")])->toBe({
      "color": "hsla(4.7rad, 11%, 12%, 50%)",
    })
    expect([%css("color: transparent")])->toBe({"color": "transparent"})
    expect([%css("color: #FFF")])->toBe({"color": "#FFF"})
    expect([%css("color: currentColor")])->toBe({"color": "currentColor"})
    expect([%css("color: var(--main-c)")])->toBe({"color": "var(--main-c)"})
  })
)

/* describe("Color style", () =>
  test("test values", _ => {
     expect([%css("label: a")])->toBe({"label": "a"})
  })) */

describe("Filter", () =>
  test("test values", _ => {
    expect([%css("filter: blur(5px)")])->toBe({"filter": "blur(5px)"})
    expect([%css("filter: opacity(10%) invert(20%)")])->toBe({"filter": "opacity(10%) invert(20%)"})
    expect([%css("filter: blur(20px) brightness(20%)")])->toBe({
      "filter": "blur(20px) brightness(20%)",
    })
    expect([%css("filter: contrast(30%) drop-shadow(5px 6px 7px rgb(255, 0, 0))")])->toBe({
      "filter": "contrast(30%) drop-shadow(5px 6px 7px rgb(255, 0, 0))",
    })
    expect([%css("filter: grayscale(10%) hue-rotate(180deg)")])->toBe({
      "filter": "grayscale(10%) hue-rotate(180deg)",
    })
    expect([%css("filter: saturate(10%) sepia(100%)")])->toBe({
      "filter": "saturate(10%) sepia(100%)",
    })
    expect([%css("filter: none")])->toBe({"filter": "none"})
    expect([%css("filter: inherit")])->toBe({"filter": "inherit"})
    expect([%css("filter: initial")])->toBe({"filter": "initial"})
    expect([%css("filter: unset")])->toBe({"filter": "unset"})
    expect([%css("filter: url(myURL)")])->toBe({"filter": "url(myURL)"})
  })
)

describe("Angle", () =>
  test("test values", _ => {
    expect([%css("transform: rotate(1deg)")])->toBe({"transform": "rotate(1deg)"})
    expect([%css("transform: rotate(6.28rad)")])->toBe({"transform": "rotate(6.28rad)"})
    expect([%css("transform: rotate(38.8grad)")])->toBe({"transform": "rotate(38.8grad)"})
    expect([%css("transform: rotate(0.25turn)")])->toBe({"transform": "rotate(0.25turn)"})
  })
)

describe("Direction", () =>
  test("test values", _ => {
    expect([%css("direction: ltr")])->toBe({"direction": "ltr"})
    expect([%css("direction: rtl")])->toBe({"direction": "rtl"})
    expect([%css("direction: inherit")])->toBe({"direction": "inherit"})
    expect([%css("direction: unset")])->toBe({"direction": "unset"})
    expect([%css("direction: initial")])->toBe({"direction": "initial"})
  })
)

describe("Resize", () =>
  test("test values", _ => {
    expect([%css("resize: none")])->toBe({"resize": "none"})
    expect([%css("resize: both")])->toBe({"resize": "both"})
    expect([%css("resize: horizontal")])->toBe({"resize": "horizontal"})
    expect([%css("resize: vertical")])->toBe({"resize": "vertical"})
    expect([%css("resize: block")])->toBe({"resize": "block"})
    expect([%css("resize: inline")])->toBe({"resize": "inline"})
    expect([%css("resize: inherit")])->toBe({"resize": "inherit"})
    expect([%css("resize: unset")])->toBe({"resize": "unset"})
    expect([%css("resize: initial")])->toBe({"resize": "initial"})
  })
)

describe("Backdrop filter", () =>
  test("test values", _ => {
    expect([%css("backdrop-filter: none")])->toBe({"backdropFilter": "none"})
    expect([%css("backdrop-filter: blur(2px)")])->toBe({"backdropFilter": "blur(2px)"})
    expect([%css("backdrop-filter: blur(10px) brightness(42%)")])->toBe({
      "backdropFilter": "blur(10px) brightness(42%)",
    })
    expect([%css("backdrop-filter: contrast(10) drop-shadow(4px 4px 10px rgb(1,2,3))")])->toBe({
      "backdropFilter": "contrast(10) drop-shadow(4px 4px 10px rgb(1, 2, 3))",
    })
    expect([%css("backdrop-filter: grayscale(99.9%) hue-rotate(90deg)")])->toBe({
      "backdropFilter": "grayscale(99.9%) hue-rotate(90deg)",
    })
    expect([%css("backdrop-filter: invert(30) opacity(10%)")])->toBe({
      "backdropFilter": "invert(30) opacity(10%)",
    })
    expect([%css("backdrop-filter: saturate(30) sepia(10%)")])->toBe({
      "backdropFilter": "saturate(30) sepia(10%)",
    })
  })
)

/* describe("Gradient background", () =>
  test("test values", _ => {
    expect([%css("background: linear-gradient(45deg, #FF0000 0, #0000FF 100%)")])->toBe({
      "background": "linear-gradient(45deg, #FF0000 0, #0000FF 100%)",
    })
    expect([%css("background: repeating-linear-gradient(45deg, #FF0000 0, #0000FF 10px)")])->toBe({
      "background": "repeating-linear-gradient(45deg, #FF0000 0, #0000FF 10px)",
    })
    expect([%css("background: radial-gradient(#FF0000 0, #0000FF 100%) ")])->toBe({
      "background": "radial-gradient(#FF0000 0, #0000FF 100%)",
    })
    expect([
      %css("background: repeating-radial-gradient(#FF0000 0, #0000FF calc(20% + 5px))"),
    ])->toBe({
      "background": "repeating-radial-gradient(#FF0000 0, #0000FF calc(20% + 5px))",
    })
    expect([%css("background: conic-gradient(from 45deg, #FF0000 0, #0000FF 100%)")])->toBe({
      "background": "conic-gradient(from 45deg, #FF0000 0, #0000FF 100%)",
    })
  })
) */

describe("Position", () => {
  test("should use length", _ => {
    expect([%css("top: 10px")])->toBe({"top": "10px"})
    expect([%css("right: 1rem")])->toBe({"right": "1rem"})
    expect([%css("bottom: 20%")])->toBe({"bottom": "20%"})
    expect([%css("left: 4vh")])->toBe({"left": "4vh"})
  })

  test("should allow cascading", _ => {
    expect([%css("top: initial")])->toBe({"top": "initial"})
    expect([%css("right: inherit")])->toBe({"right": "inherit"})
    expect([%css("bottom: unset")])->toBe({"bottom": "unset"})
    expect([%css("left: initial")])->toBe({"left": "initial"})
  })
})

describe("isolation", () => {
  test("test values", _ => {
    expect([%css("isolation: auto")])->toBe({"isolation": "auto"})
    expect([%css("isolation: isolate")])->toBe({"isolation": "isolate"})
    expect([%css("isolation: inherit")])->toBe({"isolation": "inherit"})
    expect([%css("isolation: initial")])->toBe({"isolation": "initial"})
    expect([%css("isolation: unset")])->toBe({"isolation": "unset"})
  })
})

describe("object-fit", () =>
  test("test values", _ => {
    expect([%css("object-fit: fill")])->toBe({"objectFit": "fill"})
    expect([%css("object-fit: contain")])->toBe({"objectFit": "contain"})
    expect([%css("object-fit: cover")])->toBe({"objectFit": "cover"})
    expect([%css("object-fit: none")])->toBe({"objectFit": "none"})
    expect([%css("object-fit: scale-down")])->toBe({"objectFit": "scale-down"})
    expect([%css("object-fit: inherit")])->toBe({"object-fit": "inherit"})
    expect([%css("object-fit: initial")])->toBe({"object-fit": "initial"})
    expect([%css("object-fit: unset")])->toBe({"object-fit": "unset"})
  })
)

describe("box-shadow", () => {
  test("should allow single or list definition", _ => {
    expect([%css("box-shadow: 0 0 0 0 #008000")])->toBe({"boxShadow": "0 0 0 0 #008000"})
    expect([%css("box-shadow: 0 0 0 0 #FFFF00, 0 0 0 0 #FF0000")])->toBe({
      "boxShadow": "0 0 0 0 #FFFF00, 0 0 0 0 #FF0000",
    })
  })

  test("should use options when present", _ => {
    expect([%css("box-shadow: 1px 2px 0 0 #FF0000")])->toBe({
      "boxShadow": "1px 2px 0 0 #FF0000",
    })
    // expect([%css("box-shadow: 0 0 0 0 #FF0000 inset")])->toBe({"boxShadow": "0 0 0 0 #FF0000 inset"})
  })

  test("should allow special values", _ => {
    expect([%css("box-shadow: none")])->toBe({"boxShadow": "none"})
    expect([%css("box-shadow: inherit")])->toBe({"box-shadow": "inherit"})
    expect([%css("box-shadow: initial")])->toBe({"box-shadow": "initial"})
    expect([%css("box-shadow: unset")])->toBe({"box-shadow": "unset"})
    expect([%css("box-shadow: none !important")])->toBe({"boxShadow": "none !important"})
  })
})

describe("text-shadow", () => {
  test("should allow single or list definition", _ => {
    expect([%css("text-shadow: 0 0 0 #008000")])->toBe({"textShadow": "0 0 0 #008000"})
    expect([%css("text-shadow: 0 0 0 #FFFF00, 0 0 0 #FF0000")])->toBe({
      "textShadow": "0 0 0 #FFFF00, 0 0 0 #FF0000",
    })
  })

  test("should use options when present", _ => {
    expect([%css("text-shadow: 1px 2px 0 #FF0000")])->toBe({
      "textShadow": "1px 2px 0 #FF0000",
    })
    expect([%css("text-shadow: 0 0 1vh #FF0000")])->toBe({"textShadow": "0 0 1vh #FF0000"})
  })

  test("should allow special values", _ => {
    expect([%css("text-shadow: none")])->toBe({"textShadow": "none"})
    expect([%css("text-shadow: inherit")])->toBe({"text-shadow": "inherit"})
    expect([%css("text-shadow: initial")])->toBe({"text-shadow": "initial"})
    expect([%css("text-shadow: unset")])->toBe({"text-shadow": "unset"})
    expect([%css("text-shadow: none !important")])->toBe({"textShadow": "none !important"})
  })
})

describe("transitions", () => {
  test("should allow single or list definition", _ => {
    expect([%css("transition: 0ms ease 0ms transform")])->toBe({
      "transition": "0ms ease 0ms transform",
    })
    expect([%css("transition: 0ms ease 0ms height, 0ms ease 0ms top")])->toBe({
      "transition": "0ms ease 0ms height, 0ms ease 0ms top",
    })
  })

  test("should use options when present", _ =>
    expect([%css("transition: 3ms ease-out 4ms top")])->toBe({
      "transition": "3ms ease-out 4ms top",
    })
  )
})

describe("animation", () => {
  test("should allow single or list definition", _ => {
    expect([%css("animation: a 0ms ease 0ms 1 normal none running")])->toBe({
      "animation": "a 0ms ease 0ms 1 normal none running",
    })
    expect([
      %css(
        "animation: a1 0ms ease 0ms 1 normal none running, a2 0ms ease 0ms 1 normal none running"
      ),
    ])->toBe({
      "animation": "a1 0ms ease 0ms 1 normal none running, a2 0ms ease 0ms 1 normal none running",
    })
  })

  test("should use options when present", _ => {
    expect([%css("animation: a 300ms linear 400ms infinite reverse forwards running")])->toBe({
      "animation": "a 300ms linear 400ms infinite reverse forwards running",
    })
  })
})

describe("Word spacing", () =>
  test("test values", _ => {
    expect([%css("word-spacing: normal")])->toBe({"wordSpacing": "normal"})
    expect([%css("word-spacing: 1vh")])->toBe({"wordSpacing": "1vh"})
    expect([%css("word-spacing: 50%")])->toBe({"wordSpacing": "50%"})
    expect([%css("word-spacing: inherit")])->toBe({"word-spacing": "inherit"})
  })
)

describe("gridTemplateAreas", () => {
  test("takes acceptable types & cascades", _ => {
    expect([%css("grid-template-areas: none")])->toBe({"gridTemplateAreas": "none"})
    expect([%css("grid-template-areas: 'a'")])->toBe({"gridTemplateAreas": "'a'"})
    expect([%css("grid-template-areas: inherit")])->toBe({"grid-template-areas": "inherit"})
    expect([%css("grid-template-areas: initial")])->toBe({"grid-template-areas": "initial"})
    expect([%css("grid-template-areas: unset")])->toBe({"grid-template-areas": "unset"})
  })

  test("successfully combines list", _ =>
    expect([%css("grid-template-areas: 'a a a' 'b b b'")])->toBe({
      "gridTemplateAreas": "'a a a' 'b b b'",
    })
  )
})

describe("GridArea", () => {
  test("gridArea takes values & cascades", _ => {
    expect([%css("grid-area: auto")])->toBe({"gridArea": "auto"})
    expect([%css("grid-area: a")])->toBe({"gridArea": "a"})
    expect([%css("grid-area: 1")])->toBe({"gridArea": "1"})
    expect([%css("grid-area: 1 a")])->toBe({"gridArea": "1 a"})
    expect([%css("grid-area: span 1")])->toBe({"gridArea": "span 1"})
    // expect([%css("grid-area: span a")])->toBe({"gridArea": "span a"})
    expect([%css("grid-area: inherit")])->toBe({"grid-area": "inherit"})
    expect([%css("grid-area: initial")])->toBe({"grid-area": "initial"})
    expect([%css("grid-area: unset")])->toBe({"grid-area": "unset"})
  })

  test("multi-arg functions add in slashes", _ => {
    expect([%css("grid-area: auto / 1")])->toBe({"gridArea": "auto / 1"})
    expect([%css("grid-area: a / 1 a / auto")])->toBe({"gridArea": "a / 1 a / auto"})
    // expect([%css("grid-area: 5 / span 16 / span b / auto")])->toBe({
    //   "gridArea": "5 / span 16 / span b / auto",
    // })
  })
})

describe("gridTemplateColumns", () => {
  test("concatenates list", _ => {
    expect([%css("grid-template-columns: 1fr 100px auto")])->toBe({
      "gridTemplateColumns": "1fr 100px auto",
    })
  })

  test("unfolds repeats", _ => {
    expect([%css("grid-template-columns: repeat(4, 1fr)")])->toBe({
      "gridTemplateColumns": "repeat(4, 1fr)",
    })
    expect([%css("grid-template-columns: repeat(4, auto)")])->toBe({
      "gridTemplateColumns": "repeat(4, auto)",
    })
    expect([%css("grid-template-columns: repeat(4, min-content)")])->toBe({
      "gridTemplateColumns": "repeat(4, min-content)",
    })
    expect([%css("grid-template-columns: repeat(4, max-content)")])->toBe({
      "gridTemplateColumns": "repeat(4, max-content)",
    })
    expect([%css("grid-template-columns: repeat(4, minmax(100px,1fr))")])->toBe({
      "gridTemplateColumns": "repeat(4, minmax(100px,1fr))",
    })
    expect([%css("grid-template-columns: repeat(4, minmax(100px,calc(80% + 10px)))")])->toBe({
      "gridTemplateColumns": "repeat(4, minmax(100px,calc(80% + 10px)))",
    })
  })
})

describe("backgroundPosition", () => {
  test("test single values", _ => {
    expect([%css("background-position: left")])->toBe({"backgroundPosition": "left"})
    expect([%css("background-position: right")])->toBe({"backgroundPosition": "right"})
    expect([%css("background-position: top")])->toBe({"backgroundPosition": "top"})
    expect([%css("background-position: bottom")])->toBe({"backgroundPosition": "bottom"})
    expect([%css("background-position: center")])->toBe({"backgroundPosition": "center"})
    expect([%css("background-position: 50%")])->toBe({"backgroundPosition": "50%"})
    expect([%css("background-position: initial")])->toBe({"background-position": "initial"})
    expect([%css("background-position: inherit")])->toBe({"background-position": "inherit"})
    expect([%css("background-position: unset")])->toBe({"background-position": "unset"})
  })

  test("test two values", _ => {
    expect([%css("background-position: left center")])->toBe({"backgroundPosition": "left center"})
    expect([%css("background-position: right 50%")])->toBe({"backgroundPosition": "right 50%"})
    expect([%css("background-position: 50% top")])->toBe({"backgroundPosition": "50% top"})
    expect([%css("background-position: 50% 50%")])->toBe({"backgroundPosition": "50% 50%"})
  })

  test("test multiple positions", _ => {
    expect([%css("background-position: 0px 0px, center")])->toBe({
      "backgroundPosition": "0px 0px, center",
    })
  })

  test("test edge offsets values", _ => {
    expect([%css("background-position: right 50px top 10px")])->toBe({
      "backgroundPosition": "right 50px top 10px",
    })
  })
})

describe("backgroundRepeat", () => {
  test("test single values", _ => {
    expect([%css("background-repeat: repeat-x")])->toBe({"backgroundRepeat": "repeat-x"})
    expect([%css("background-repeat: repeat-y")])->toBe({"backgroundRepeat": "repeat-y"})
    expect([%css("background-repeat: repeat")])->toBe({"backgroundRepeat": "repeat"})
    expect([%css("background-repeat: space")])->toBe({"backgroundRepeat": "space"})
    expect([%css("background-repeat: round")])->toBe({"backgroundRepeat": "round"})
    expect([%css("background-repeat: no-repeat")])->toBe({"backgroundRepeat": "no-repeat"})
    expect([%css("background-repeat: inherit")])->toBe({"background-repeat": "inherit"})
  })

  test("test two values", _ => {
    expect([%css("background-repeat: repeat space")])->toBe({"backgroundRepeat": "repeat space"})
    expect([%css("background-repeat: repeat repeat")])->toBe({"backgroundRepeat": "repeat repeat"})
    expect([%css("background-repeat: round space")])->toBe({"backgroundRepeat": "round space"})
    expect([%css("background-repeat: no-repeat round")])->toBe({
      "backgroundRepeat": "no-repeat round",
    })
  })
})

describe("backgroundImage", () =>
  test("test values", _ => {
    expect([%css("background-image: none")])->toBe({"backgroundImage": "none"})
    expect([%css("background-image: url(x)")])->toBe({"backgroundImage": "url(x)"})
    /* expect([%css("background-image: linear-gradient(5deg, #FF0000 10%)")])->toBe({
      "backgroundImage": "linear-gradient(5deg, #FF0000 10%)",
    })
    expect([%css("background-image: repeating-linear-gradient(6rad, #000000 20%)")])->toBe({
      "backgroundImage": "repeating-linear-gradient(6rad, #000000 20%)",
    })
    expect([%css("background-image: radial-gradient(#FFFF00 30%)")])->toBe({
      "backgroundImage": "radial-gradient(#FFFF00 30%)",
    })
    expect([%css("background-image: repeating-radial-gradient(#FFFF00 30%)")])->toBe({
      "backgroundImage": "repeating-radial-gradient(#FFFF00 30%)",
     }) */
  })
)

/* describe("background shorthand", () =>
  test("test values", _ => {
    expect([%css("background: rgb(1, 2, 3)")])->toBe({"background": "rgb(1, 2, 3)"})
    expect([%css("background: url(x)")])->toBe({"background": "url(x)"})
    expect([%css("background: linear-gradient(5deg, #FF0000 10%)")])->toBe({
      "background": "linear-gradient(5deg, #FF0000 10%)",
    })
    expect([%css("background: none")])->toBe({"background": "none"})
  })
) */

describe("clipPath", () =>
  test("test values", _ => {
    expect([%css("clip-path: none")])->toBe({"clipPath": "none"})
    expect([%css("clip-path: url(x)")])->toBe({"clipPath": "url(x)"})
    expect([%css("clip-path: margin-box")])->toBe({"clipPath": "margin-box"})
    expect([%css("clip-path: border-box")])->toBe({"clipPath": "border-box"})
    expect([%css("clip-path: border-box")])->toBe({"clipPath": "border-box"})
    expect([%css("clip-path: content-box")])->toBe({"clipPath": "content-box"})
    expect([%css("clip-path: fill-box")])->toBe({"clipPath": "fill-box"})
    expect([%css("clip-path: stroke-box")])->toBe({"clipPath": "stroke-box"})
    expect([%css("clip-path: view-box")])->toBe({"clipPath": "view-box"})
    expect([%css("clip-path: inherit")])->toBe({"clip-path": "inherit"})
    expect([%css("clip-path: initial")])->toBe({"clip-path": "initial"})
    expect([%css("clip-path: unset")])->toBe({"clip-path": "unset"})
  })
)

describe("columnGap", () =>
  test("test values", _ => {
    expect([%css("column-gap: normal")])->toBe({"columnGap": "normal"})
    expect([%css("column-gap: 3px")])->toBe({"columnGap": "3px"})
    expect([%css("column-gap: 2.5em")])->toBe({"columnGap": "2.5em"})
    expect([%css("column-gap: 3%")])->toBe({"columnGap": "3%"})
    expect([%css("column-gap: inherit")])->toBe({"column-gap": "inherit"})
    expect([%css("column-gap: initial")])->toBe({"column-gap": "initial"})
    expect([%css("column-gap: unset")])->toBe({"column-gap": "unset"})
  })
)

describe("rowGap", () =>
  test("test values", _ => {
    expect([%css("row-gap: normal")])->toBe({"rowGap": "normal"})
    expect([%css("row-gap: 3px")])->toBe({"rowGap": "3px"})
    expect([%css("row-gap: 2.5em")])->toBe({"rowGap": "2.5em"})
    expect([%css("row-gap: 3%")])->toBe({"rowGap": "3%"})
    expect([%css("row-gap: inherit")])->toBe({"row-gap": "inherit"})
    expect([%css("row-gap: initial")])->toBe({"row-gap": "initial"})
    expect([%css("row-gap: unset")])->toBe({"row-gap": "unset"})
  })
)

describe("gap", () => {
  test("test values single prop", _ => {
    expect([%css("gap: normal")])->toBe({"gap": "normal"})
    expect([%css("gap: 3px")])->toBe({"gap": "3px"})
    expect([%css("gap: 2.5em")])->toBe({"gap": "2.5em"})
    expect([%css("gap: 3%")])->toBe({"gap": "3%"})
    expect([%css("gap: inherit")])->toBe({"gap": "inherit"})
    expect([%css("gap: initial")])->toBe({"gap": "initial"})
    expect([%css("gap: unset")])->toBe({"gap": "unset"})
  })

  test("test values two props", _ => {
    expect([%css("gap: normal normal")])->toBe({"gap": "normal normal"})
    expect([%css("gap: 3px 3px")])->toBe({"gap": "3px 3px"})
    expect([%css("gap: 2.5em 2.5em")])->toBe({"gap": "2.5em 2.5em"})
    expect([%css("gap: 3% 3%")])->toBe({"gap": "3% 3%"})
    /* expect([%css("gap: inherit inherit")])->toBe({"gap": "inherit inherit"})
       expect([%css("gap: initial initial")])->toBe({"gap": "initial initial"})
       expect([%css("gap: unset unset")])->toBe({"gap": "unset unset"}) */
  })
})

describe("columnWidth", () =>
  test("test values", _ => {
    expect([%css("column-width: auto")])->toBe({"columnWidth": "auto"})
    expect([%css("column-width: 120px")])->toBe({"columnWidth": "120px"})
    expect([%css("column-width: 6rem")])->toBe({"columnWidth": "6rem"})
    expect([%css("column-width: 18ch")])->toBe({"columnWidth": "18ch"})
    expect([%css("column-width: inherit")])->toBe({"column-width": "inherit"})
    expect([%css("column-width: initial")])->toBe({"column-width": "initial"})
    expect([%css("column-width: unset")])->toBe({"column-width": "unset"})
  })
)

describe("cursor", () =>
  test("test values", _ => {
    expect([%css("cursor: context-menu")])->toBe({"cursor": "context-menu"})
    expect([%css("cursor: help")])->toBe({"cursor": "help"})
    expect([%css("cursor: pointer")])->toBe({"cursor": "pointer"})
    expect([%css("cursor: progress")])->toBe({"cursor": "progress"})
    expect([%css("cursor: wait")])->toBe({"cursor": "wait"})
    expect([%css("cursor: cell")])->toBe({"cursor": "cell"})
    expect([%css("cursor: crosshair")])->toBe({"cursor": "crosshair"})
    expect([%css("cursor: text")])->toBe({"cursor": "text"})
    expect([%css("cursor: vertical-text")])->toBe({"cursor": "vertical-text"})
    expect([%css("cursor: alias")])->toBe({"cursor": "alias"})
    expect([%css("cursor: copy")])->toBe({"cursor": "copy"})
    expect([%css("cursor: move")])->toBe({"cursor": "move"})
    expect([%css("cursor: no-drop")])->toBe({"cursor": "no-drop"})
    expect([%css("cursor: not-allowed")])->toBe({"cursor": "not-allowed"})
    expect([%css("cursor: grab")])->toBe({"cursor": "grab"})
    expect([%css("cursor: grabbing")])->toBe({"cursor": "grabbing"})
    expect([%css("cursor: all-scroll")])->toBe({"cursor": "all-scroll"})
    expect([%css("cursor: col-resize")])->toBe({"cursor": "col-resize"})
    expect([%css("cursor: row-resize")])->toBe({"cursor": "row-resize"})
    expect([%css("cursor: n-resize")])->toBe({"cursor": "n-resize"})
    expect([%css("cursor: e-resize")])->toBe({"cursor": "e-resize"})
    expect([%css("cursor: s-resize")])->toBe({"cursor": "s-resize"})
    expect([%css("cursor: w-resize")])->toBe({"cursor": "w-resize"})
    expect([%css("cursor: ne-resize")])->toBe({"cursor": "ne-resize"})
    expect([%css("cursor: nw-resize")])->toBe({"cursor": "nw-resize"})
    expect([%css("cursor: se-resize")])->toBe({"cursor": "se-resize"})
    expect([%css("cursor: sw-resize")])->toBe({"cursor": "sw-resize"})
    expect([%css("cursor: ew-resize")])->toBe({"cursor": "ew-resize"})
    expect([%css("cursor: ns-resize")])->toBe({"cursor": "ns-resize"})
    expect([%css("cursor: nesw-resize")])->toBe({"cursor": "nesw-resize"})
    expect([%css("cursor: nwse-resize")])->toBe({"cursor": "nwse-resize"})
    expect([%css("cursor: zoom-in")])->toBe({"cursor": "zoom-in"})
    expect([%css("cursor: zoom-out")])->toBe({"cursor": "zoom-out"})
  })
)

describe("counter", () => {
  test("test reset", _ => {
    expect([%css("counter-reset: none")])->toBe({"counterReset": "none"})
    expect([%css("counter-reset: foo 2")])->toBe({"counterReset": "foo 2"})
    // expect([%css("counter-reset: var(--bar)")])->toBe({"counterReset": "var(--bar)"})
  })

  test("test set", _ => {
    expect([%css("counter-set: none")])->toBe({"counterSet": "none"})
    expect([%css("counter-set: foo 2")])->toBe({"counterSet": "foo 2"})
    // expect([%css("counter-set: var(--bar)")])->toBe({"counterSet": "var(--bar)"})
  })

  test("test increment", _ => {
    expect([%css("counter-increment: none")])->toBe({"counterIncrement": "none"})
    expect([%css("counter-increment: foo 2")])->toBe({"counterIncrement": "foo 2"})
    // expect([%css("counter-increment: var(--bar)")])->toBe({"counterIncrement": "var(--bar)"})
  })
})
