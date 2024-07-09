open Vitest

module Content = CssJs.Types.Content
module FontFamily = CssJs.Types.FontFamilyName

let testData = [
  (Content.toString(#text("")), "''"),
  (Content.toString(#text(" ")), "\" \""),
  (Content.toString(#text(" ")), `" "`),
  (Content.toString(#text(`""`)), `''`),
  (Content.toString(#text(`" "`)), `" "`),
  (Content.toString(#text(`'single'`)), `'single'`),
  (Content.toString(#text(`"double"`)), `"double"`),
  (Content.toString(#text(`'`)), `"'"`),
  (FontFamily.toString("Inter"), `"Inter"`),
  (FontFamily.toString(`"Inter Bold"`), `"Inter Bold"`),
]

describe("content as string", () => {
  Belt.Array.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index + 1), _t => expect(cssIn)->Expect.toBe(emotionOut))
  )
})

let testData = list{
  (%css("content: ''"), CssJs.contentRule(#text("''"))),
  (%css("content: '\"'"), CssJs.contentRule(#text(`'"'`))),
  (%css(`content: '\"'`), CssJs.contentRule(#text("'\"'"))),
  (%css("content: ' '"), CssJs.contentRule(#text("' '"))),
  (%css("content: 'single'"), CssJs.contentRule(#text("'single'"))),
  (%css(`font-family: "Lola"`), CssJs.fontFamily("Lola")),
  (%css(`font-family: "Lola del rio"`), CssJs.fontFamily("Lola del rio")),
}

describe("content to rule", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index + 1), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
