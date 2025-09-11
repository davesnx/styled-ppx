open Ppxlib.Ast_builder.Default;

let loc = Ppxlib.Location.none;

let tests = [
  test("Should not transform other module ppx that aren't styled", () => {
    let pp_structure_item = (ppf, x) =>
      Fmt.pf(ppf, "%S", Ppxlib.Pprintast.string_of_structure([x]));
    let check_structure_item = Alcotest.testable(pp_structure_item, (==));
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
            pmod_extension(~loc, (Located.mk(~loc, "graphql"), PStr([]))),
        ),
      );
    check(~__POS__, check_structure_item, expected, input);
  }),
];
