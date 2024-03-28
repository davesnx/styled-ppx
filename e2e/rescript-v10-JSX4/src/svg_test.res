open Vitest

let toBe = (e, x) => Expect.toBe(e, x->Js.Json.stringifyAny)
let expect = x => expect(CssJs.toJson([x])->Js.Json.stringifyAny)

describe("Fill", () =>
  test("test values", _ => {
    open CssJs
    expect(SVG.fill(hex("FF0044")))->toBe({"fill": "#FF0044"})
    expect(SVG.fill(url("#mydef")))->toBe({"fill": "url(#mydef)"})
    expect(SVG.fill(#contextFill))->toBe({"fill": "context-fill"})
    expect(SVG.fill(#contextStroke))->toBe({"fill": "context-stroke"})
    expect(SVG.fill(#none))->toBe({"fill": "none"})
  })
)
