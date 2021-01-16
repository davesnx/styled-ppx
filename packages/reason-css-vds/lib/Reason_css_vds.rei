include (module type of {
  include Ast;
});
let value_to_string: Ast.value => string;
let value_of_string: string => option(Ast.value);
