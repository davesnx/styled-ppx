open Jest

let testData = [
  ("top", %cx("margin-top: auto"), CssJs.style(. [CssJs.marginTop(#auto)])),
  /* ([%cx "margin-right: 1px"], CssJs.style(. [|CssJs.marginRight(`pxFloat(1.))|])),
  ([%cx "margin-bottom: 2px"], CssJs.style(. [|CssJs.marginBottom(`pxFloat(2.))|])),
  ([%cx "margin-left: 3px"], CssJs.style(. [|CssJs.marginLeft(`pxFloat(3.))|])),
  ([%cx "margin: 1px"], CssJs.style(. [|CssJs.margin(`pxFloat(1.))|])),
  ([%cx "margin: 1px 2px"], CssJs.style(. [|CssJs.margin2(~v=`pxFloat(1.), ~h=`pxFloat(2.))|])), */
  /* ([%cx "margin: 1px 2px 3px"], CssJs.style(. [|
    CssJs.margin3(~top=`pxFloat(1.), ~h=`pxFloat(2.), ~bottom=`pxFloat(3.)),
  |])),
  ([%cx "margin: 1px 2px 3px 4px"], CssJs.style(. [|
    CssJs.margin4(
      ~top=`pxFloat(1.),
      ~right=`pxFloat(2.),
      ~bottom=`pxFloat(3.),
      ~left=`pxFloat(4.),
    ),
  |])), */
]

describe("margin", _ =>
  Belt.Array.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) =>
    test(string_of_int(index) ++ (". Supports " ++ name), () =>
      Expect.expect(cssIn) |> Expect.toMatch(emotionOut)
    )
  )
)
