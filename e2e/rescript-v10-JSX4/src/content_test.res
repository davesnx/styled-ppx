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
  (FontFamily.toString(#custom("Inter")), `"Inter"`),
  (FontFamily.toString(#custom("Inter Bold")), `"Inter Bold"`),
  (FontFamily.toString(#serif), `serif`),
  (FontFamily.toString(#sans_serif), `sans-serif`),
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
  (%css(`font-family: "Lola"`), CSS.fontFamily(#custom("Lola"))),
  (%css(`font-family: "Lola del rio"`), CSS.fontFamily(#custom("Lola del rio"))),
  (%css(`font-family: serif`), CSS.fontFamily(#serif)),
  (%css(`font-family: sans-serif`), CSS.fontFamily(#sans_serif)),
  (%css(`font-family: fantasy`), CSS.fontFamily(#fantasy)),
  (%css(`font-family: cursive`), CSS.fontFamily(#cursive)),
  (%css(`font-family: monospace`), CSS.fontFamily(#monospace)),
  (%css(`font-family: serif`), CSS.fontFamily(#serif)),
  (%css(`font-family: sans-serif`), CSS.fontFamily(#sans_serif)),

}

describe("content to rule", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index + 1), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
