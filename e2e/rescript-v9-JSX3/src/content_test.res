open Vitest

module Content = CSS.Types.Content
module FontFamily = CSS.Types.FontFamilyName

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
  (%css(`content: ''`), CSS.contentRule(#text("''"))),
  (%css(`content: ""`), CSS.contentRule(#text("''"))),
  (%css(`content: ' '`), CSS.contentRule(#text("' '"))),
  (%css(`content: " "`), CSS.contentRule(#text("' '"))),
  (%css(`content: '"'`), CSS.contentRule(#text("\""))),
  (%css(`content: "'"`), CSS.contentRule(#text("'"))),
  (%css(`content: 'xxx'`), CSS.contentRule(#text(`xxx`))),
  (%css(`font-family: "Lola"`), CSS.fontFamily("Lola")),
  (%css(`font-family: "Lola del rio"`), CSS.fontFamily("Lola del rio")),
}

describe("content to rule", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index + 1), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
