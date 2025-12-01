include (module type of Ast);
let string_of_value: Ast.value => string;
let value_of_string: string => option(Ast.value);
