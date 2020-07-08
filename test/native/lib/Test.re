open Migrate_parsetree;
open Ast_410;
open Setup;
open Css_types;

let rec zip = (xs, ys) =>
  switch (xs, ys) {
  | ([], _) => []
  | (_, []) => []
  | ([x, ...xs], [y, ...ys]) => [(x, y), ...zip(xs, ys)]
  };

let eq_ast = (ast1, ast2) => {
  let eq_list = (xs, ys, eq) =>
    List.length(xs) == List.length(ys)
    && List.fold_left((e, (x, y)) => e && eq(x, y), true, zip(xs, ys));

  let rec eq_component_value = ((cv1, _), (cv2, _)) =>
    Component_value.(
      switch (cv1, cv2) {
      | (Paren_block(b1), Paren_block(b2))
      | (Bracket_block(b1), Bracket_block(b2)) =>
        eq_list(b1, b2, eq_component_value)
      | (Percentage(x1), Percentage(x2))
      | (Ident(x1), Ident(x2))
      | (String(x1), String(x2))
      | (Uri(x1), Uri(x2))
      | (Operator(x1), Operator(x2))
      | (Delim(x1), Delim(x2))
      | (Hash(x1), Hash(x2))
      | (Number(x1), Number(x2))
      | (Unicode_range(x1), Unicode_range(x2)) => x1 == x2
      | (Float_dimension(x1), Float_dimension(x2)) => x1 == x2
      | (Dimension(x1), Dimension(x2)) => x1 == x2
      | (
          [@implicit_arity] Function((n1, _), (b1, _)),
          [@implicit_arity] Function((n2, _), (b2, _)),
        ) =>
        n1 == n2 && eq_list(b1, b2, eq_component_value)
      | _ => false
      }
    )
  and eq_at_rule = (r1, r2) => {
    let (n1, _) = r1.At_rule.name;
    let (n2, _) = r2.At_rule.name;
    let (pr1, _) = r1.At_rule.prelude;
    let (pr2, _) = r2.At_rule.prelude;
    n1 == n2
    && eq_list(pr1, pr2, eq_component_value)
    && (
      switch (r1.At_rule.block, r2.At_rule.block) {
      | (Brace_block.Empty, Brace_block.Empty) => true
      | (Brace_block.Declaration_list(dl1), Brace_block.Declaration_list(dl2)) =>
        eq_declaration_list(dl1, dl2)
      | _ => false
      }
    );
  }
  and eq_declaration = (d1, d2) => {
    let (n1, _) = d1.Declaration.name;
    let (n2, _) = d2.Declaration.name;
    let (v1, _) = d1.Declaration.value;
    let (v2, _) = d2.Declaration.value;
    let (i1, _) = d1.Declaration.important;
    let (i2, _) = d2.Declaration.important;
    n1 == n2 && eq_list(v1, v2, eq_component_value) && i1 == i2;
  }
  and eq_declaration_list = ((dl1, _), (dl2, _)) => {
    let eq_kind = (k1, k2) =>
      switch (k1, k2) {
      | (Declaration_list.Declaration(d1), Declaration_list.Declaration(d2)) =>
        eq_declaration(d1, d2)
      | (Declaration_list.At_rule(r1), Declaration_list.At_rule(r2)) =>
        eq_at_rule(r1, r2)
      | _ => false
      };

    eq_list(dl1, dl2, eq_kind);
  };

  eq_declaration_list(ast1, ast2);
};

describe("Transform CSS AST to Emotion", ({test, _}) =>
  test("should parse properties and values", ({expect, _}) => {
    let css = {|
      color: blue
    |};
    let ast = Css_lexer.parse_declaration_list(css);
    let expected_ast = (
      [
        Declaration_list.Declaration({
          Declaration.name: ("color", Location.none),
          value: (
            [(Component_value.Ident("blue"), Location.none)],
            Location.none,
          ),
          important: (false, Location.none),
          loc: Location.none,
        }),
      ],
      Location.none,
    );

    expect.bool(eq_ast(ast, expected_ast)).toBeTrue();
  })
);
