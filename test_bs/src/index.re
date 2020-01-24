open Jest;

describe("Test", () => {
  open Expect;
  open! Expect.Operators;

  test("inline", () => {
    let output = [%styled "display: block;"];
    let result = 42;
    expect(output) === (result);
  });
});
