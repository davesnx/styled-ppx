module Builder =
  Ppxlib.Ast_builder.Make({
    let loc = Ppxlib.Location.none;
  });

let tests: tests = [
  test(
    "Should not transform other module ppx that aren't styled extensions", () => {
    let pp_structure_item = (ppf, x) =>
      Fmt.pf(ppf, "%S", Ppxlib.Pprintast.string_of_structure([x]));
    let check_structure_item = Alcotest.testable(pp_structure_item, (==));
    let loc = Ppxlib.Location.none;
    let input = [%stri module X = [%graphql]];
    // The AST of the expected needs to be created with Ast_builder
    // otherwise we would will always have success
    let expected =
      Builder.pstr_module(
        Builder.module_binding(
          ~name=Builder.Located.mk(Some("X")),
          ~expr=
            Builder.pmod_extension((
              Builder.Located.mk("graphql"),
              PStr([]),
            )),
        ),
      );
    Alcotest.check(~pos=__POS__, check_structure_item, "", expected, input);
  }),
];
