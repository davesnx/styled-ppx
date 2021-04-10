open Setup;

open Ppxlib.Ast_builder.Make({
       let loc = Location.none;
     });

let compare = (result, expected, {expect, _}) => {
  let result = Pprintast.string_of_structure([result]);
  let expected = Pprintast.string_of_structure([expected]);
  expect.string(result).toEqual(expected);
};

describe("transform module ppx", ({test, _}) => {
  test(
    "doesn't start with styled",
    compare(
      [%stri module X = [%graphql]],
      // the AST needs to be here by hand otherwise we would will always have success
      pstr_module(
        module_binding(
          ~name=Located.mk(Some("X")),
          ~expr=pmod_extension((Located.mk("graphql"), PStr([]))),
        ),
      ),
    ),
  )
});
