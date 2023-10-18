open Vitest

let testData = list{
  (CssJs.Types.Content.toString(#text("")), "''"),
  (CssJs.Types.Content.toString(#text(" ")), "\" \""),
  (CssJs.Types.Content.toString(#text(" ")), `" "`),
  (CssJs.Types.Content.toString(#text(`""`)), `''`),
  (CssJs.Types.Content.toString(#text(`" "`)), `" "`),
  (CssJs.Types.Content.toString(#text(`'single'`)), `'single'`),
  (CssJs.Types.Content.toString(#text(`"double"`)), `"double"`),
  (CssJs.Types.Content.toString(#text(`'`)), `"'"`),
}

describe("content as string", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index + 1), _t => expect(cssIn)->Expect.toBe(emotionOut))
  )
})

let testData = list{
  (%css("content: ''"), CssJs.contentRule(#text("''"))),
  (%css("content: '\"'"), CssJs.contentRule(#text(`'"'`))),
  (%css(`content: '\"'`), CssJs.contentRule(#text("'\"'"))),
  (%css("content: ' '"), CssJs.contentRule(#text("' '"))),
  (%css("content: 'single'"), CssJs.contentRule(#text("'single'"))),
}

describe("content to rule", () => {
  Belt.List.forEachWithIndex(testData, (index, (cssIn, emotionOut)) =>
    test(string_of_int(index + 1), _t => expect(cssIn)->Expect.toEqual(emotionOut))
  )
})
