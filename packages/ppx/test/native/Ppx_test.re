open Alcotest;
open Ppxlib;
open Ast_builder.Default;

let loc = Location.none;

let tests = [
  test_case(
    "Should not transform other module ppx that aren't styled",
    `Quick,
    () => {
      let pp_structure_item = (ppf, x) =>
        Fmt.pf(ppf, "%S", Pprintast.string_of_structure([x]));
      let check_structure_item = testable(pp_structure_item, (==));
      let input = [%stri module X = [%graphql]];
      // The AST of the expected needs to be created with Ast_builder
      // otherwise we would will always have success
      let expected =
        pstr_module(
          ~loc,
          module_binding(
            ~loc,
            ~name=Located.mk(~loc, Some("X")),
            ~expr=
              pmod_extension(
                ~loc,
                (Located.mk(~loc, "graphql"), PStr([])),
              ),
          ),
        );
      check(check_structure_item, "", expected, input);
    },
  ),
];
