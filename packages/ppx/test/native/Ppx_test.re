open Alcotest;
open Ppxlib;
open Ast_builder.Default;

let loc = Location.none;

let compare = (result, expected, {expect, _}) => {
  let result = Pprintast.string_of_structure([result]);
  let expected = Pprintast.string_of_structure([expected]);
  expect.string(result).toEqual(expected);
};

describe("Should not transform other module ppx", ({test, _}) => {
  test(
    "If doesn't start with styled",
    compare(
      [%stri module X = [%graphql]],
      // the AST needs to be here by hand otherwise we would will always have success
      pstr_module(
        ~loc,
        module_binding(
          ~loc,
          ~name=Located.mk(~loc, Some("X")),
          ~expr=pmod_extension(~loc,
            (
              Located.mk(~loc, "graphql"),
              PStr([])
            )
          ),
        ),
      ),
    ),
  )
});
