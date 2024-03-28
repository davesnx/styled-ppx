open Vitest

let toBe = (e, x) => Expect.toBe(e, x->Js.Json.stringifyAny)
let expect = x => expect(CssJs.toJson([x])->Js.Json.stringifyAny)

let ruleSelector = %css("display: block")
let ruleJson = {"display": "block"}

describe("Pseudo classes", () => {
  test("test selectors that have no parameters", _ => {
    open CssJs
    expect(active([ruleSelector]))->toBe({":active": ruleJson})
    expect(checked([ruleSelector]))->toBe({":checked": ruleJson})
    expect(default([ruleSelector]))->toBe({":default": ruleJson})
    expect(defined([ruleSelector]))->toBe({":defined": ruleJson})
    expect(disabled([ruleSelector]))->toBe({":disabled": ruleJson})
    expect(empty([ruleSelector]))->toBe({":empty": ruleJson})
    expect(enabled([ruleSelector]))->toBe({":enabled": ruleJson})
    expect(first([ruleSelector]))->toBe({":first": ruleJson})
    expect(firstChild([ruleSelector]))->toBe({":first-child": ruleJson})
    expect(firstOfType([ruleSelector]))->toBe({":first-of-type": ruleJson})
    expect(focus([ruleSelector]))->toBe({":focus": ruleJson})
    expect(focusVisible([ruleSelector]))->toBe({":focus-visible": ruleJson})
    expect(focusWithin([ruleSelector]))->toBe({":focus-within": ruleJson})
    expect(hover([ruleSelector]))->toBe({":hover": ruleJson})
    expect(indeterminate([ruleSelector]))->toBe({":indeterminate": ruleJson})
    expect(inRange([ruleSelector]))->toBe({":in-range": ruleJson})
    expect(invalid([ruleSelector]))->toBe({":invalid": ruleJson})
    expect(lastChild([ruleSelector]))->toBe({":last-child": ruleJson})
    expect(lastOfType([ruleSelector]))->toBe({":last-of-type": ruleJson})
    expect(link([ruleSelector]))->toBe({":link": ruleJson})
    expect(onlyChild([ruleSelector]))->toBe({":only-child": ruleJson})
    expect(onlyOfType([ruleSelector]))->toBe({":only-of-type": ruleJson})
    expect(optional([ruleSelector]))->toBe({":optional": ruleJson})
    expect(outOfRange([ruleSelector]))->toBe({":out-of-range": ruleJson})
    expect(readOnly([ruleSelector]))->toBe({":read-only": ruleJson})
    expect(readWrite([ruleSelector]))->toBe({":read-write": ruleJson})
    expect(required([ruleSelector]))->toBe({":required": ruleJson})
    expect(root([ruleSelector]))->toBe({":root": ruleJson})
    expect(scope([ruleSelector]))->toBe({":scope": ruleJson})
    expect(target([ruleSelector]))->toBe({":target": ruleJson})
    expect(valid([ruleSelector]))->toBe({":valid": ruleJson})
    expect(visited([ruleSelector]))->toBe({":visited": ruleJson})
  })

  test("test host", _ => {
    open CssJs
    expect(host([ruleSelector]))->toBe({":host": ruleJson})
    expect(host(~selector=".special-custom-element", [ruleSelector]))->toBe({
      ":host(.special-custom-element)": ruleJson,
    })
  })

  test("test not", _ => {
    open CssJs
    expect(not_("p", [ruleSelector]))->toBe({":not(p)": ruleJson})
  })

  test("test nth-child", _ => {
    open CssJs
    expect(nthChild(#odd, [ruleSelector]))->toBe({":nth-child(odd)": ruleJson})
    expect(nthChild(#even, [ruleSelector]))->toBe({":nth-child(even)": ruleJson})
    expect(nthChild(#n(2), [ruleSelector]))->toBe({":nth-child(2n)": ruleJson})
    expect(nthChild(#add((3, 4)), [ruleSelector]))->toBe({":nth-child(3n+4)": ruleJson})
  })

  test("test nth-last-child", _ => {
    open CssJs
    expect(nthLastChild(#odd, [ruleSelector]))->toBe({":nth-last-child(odd)": ruleJson})
    expect(nthLastChild(#even, [ruleSelector]))->toBe({":nth-last-child(even)": ruleJson})
    expect(nthLastChild(#n(2), [ruleSelector]))->toBe({":nth-last-child(2n)": ruleJson})
    expect(nthLastChild(#add((3, 4)), [ruleSelector]))->toBe({
      ":nth-last-child(3n+4)": ruleJson,
    })
  })

  test("test nth-last-of-type", _ => {
    open CssJs
    expect(nthLastOfType(#odd, [ruleSelector]))->toBe({":nth-last-of-type(odd)": ruleJson})
    expect(nthLastOfType(#even, [ruleSelector]))->toBe({":nth-last-of-type(even)": ruleJson})
    expect(nthLastOfType(#n(2), [ruleSelector]))->toBe({":nth-last-of-type(2n)": ruleJson})
    expect(nthLastOfType(#add((3, 4)), [ruleSelector]))->toBe({
      ":nth-last-of-type(3n+4)": ruleJson,
    })
  })

  test("test nth-of-type", _ => {
    open CssJs
    expect(nthOfType(#odd, [ruleSelector]))->toBe({":nth-of-type(odd)": ruleJson})
    expect(nthOfType(#even, [ruleSelector]))->toBe({":nth-of-type(even)": ruleJson})
    expect(nthOfType(#n(2), [ruleSelector]))->toBe({":nth-of-type(2n)": ruleJson})
    expect(nthOfType(#add((3, 4)), [ruleSelector]))->toBe({":nth-of-type(3n+4)": ruleJson})
  })
})
