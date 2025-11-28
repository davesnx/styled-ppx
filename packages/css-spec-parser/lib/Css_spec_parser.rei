/* TODO: include (module type of Ast); */
include (module type of {
  include Ast;
});
let string_of_value: Ast.value => string;
let value_of_string: string => option(Ast.value);
