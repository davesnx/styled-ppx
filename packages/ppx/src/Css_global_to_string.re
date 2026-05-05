/* Build the `to_string` body for a [%styled.global2] generated module.

   The static rule (with `var(--var-<hash>)` already substituted in
   value positions) lives in the extracted stylesheet via [@@@css ...].
   The runtime's only job is to supply values for the custom properties
   the static rule references through `var()`. We do that with a single
   `:root { --var-h: <call expr>; ... }` block, one declaration per
   `dynamic_vars` entry.

   `dynamic_vars` is already deduplicated by [Css_file.add_dynamic_var]
   on `var_name`, so the same OCaml expression interpolated multiple
   times produces a single declaration here. */

module Helper = Ppxlib.Ast_helper;

let estring = (~loc, s) =>
  Helper.Exp.constant(~loc, Pconst_string(s, loc, None));

/* Build  s1 ^ s2 ^ ... ^ sN by left fold; for an empty list emit "". */
let concat_exprs = (~loc, parts) => {
  let concat = (a, b) => [%expr [%e a] ++ [%e b]];
  switch (parts) {
  | [] => estring(~loc, "")
  | [single] => single
  | [first, ...rest] => List.fold_left(concat, first, rest)
  };
};

/* Returns an OCaml expression of type [string]. When `dynamic_vars` is
   empty (static-only block), returns the literal `""` so the generated
   module still has a well-formed `to_string` function. */
let render_root_block =
    (
      ~loc,
      dynamic_vars: list((string, string, Css_file.var_type)),
    )
    : Ppxlib.expression => {
  switch (dynamic_vars) {
  | [] => estring(~loc, "")
  | _ =>
    let decl_parts =
      dynamic_vars
      |> List.concat_map(((var_name, path_str, var_type)) => {
           let module_name =
             switch (var_type) {
             | Css_file.RuntimeModule(name) => name
             /* Selector and MediaQuery var_types are populated only
                from selector / @media-prelude positions, never from
                declaration values. They cannot reach this code path
                under correct usage; if one ever does it indicates an
                upstream bug in transform_declaration. Fail loud
                rather than silently miscompile to Cascading.toString. */
             | Css_file.Selector
             | Css_file.MediaQuery =>
               Ppxlib.Location.raise_errorf(
                 ~loc,
                 "Internal: %s var_type leaked into [%%styled.global2] value interpolation for `$(%s)`. Please report this as a styled-ppx bug.",
                 switch (var_type) {
                 | Css_file.Selector => "Selector"
                 | Css_file.MediaQuery => "MediaQuery"
                 | _ => "Unknown"
                 },
                 path_str,
               )
             };
           let value_expr = Css_to_runtime.render_variable(~loc, path_str);
           let to_string_call =
             Property_to_types.make_to_string_call(
               ~loc,
               module_name,
               value_expr,
             );
           [
             estring(~loc, "--" ++ var_name ++ ":"),
             to_string_call,
             estring(~loc, ";"),
           ];
         });
    concat_exprs(
      ~loc,
      [estring(~loc, ":root{")] @ decl_parts @ [estring(~loc, "}")],
    );
  };
};
