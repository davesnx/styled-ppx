open Setup;

describe("my first test suite", ({test, _}) =>
  test("1 + 1 should equal 2", ({expect, _}) =>
    expect.int(1 + 2).toBe(3)
  )
);
