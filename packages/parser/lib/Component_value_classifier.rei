module Ast = Ast;

module Ident: {
  let value: Ast.component_value => option(string);
  let matches: (~expected: string, Ast.component_value) => bool;
  let starts_with: (~prefix: string, Ast.component_value) => bool;
};

module Textual: {
  let value: Ast.component_value => option(string);
  let matches: (~expected: string, Ast.component_value) => bool;
};

module Function: {
  let kind: Ast.component_value => option(Ast.function_kind);
  let body_if_named:
    (~expected: string, Ast.component_value) => option(Ast.component_value_list);
};

module Delim: {
  let of_string: string => option(Ast.delimiter);
  let value: Ast.component_value => option(Ast.delimiter);
  let matches: (~expected: string, Ast.component_value) => bool;
};

module Dimension: {
  let payload: Ast.component_value => option(Ast.dimension);
  let make: ((float, string)) => Ast.dimension;
  let kind_of_unit: string => Ast.dimension_kind;

  module Length_unit: {
    let of_string: string => option(Ast.length_unit);
  };

  module Angle_unit: {
    let of_string: string => option(Ast.angle_unit);
  };

  module Time_unit: {
    let of_string: string => option(Ast.time_unit);
  };

  module Frequency_unit: {
    let of_string: string => option(Ast.frequency_unit);
  };

  module Resolution_unit: {
    let of_string: string => option(Ast.resolution_unit);
  };

  module Flex_unit: {
    let of_string: string => option(Ast.flex_unit);
  };
};

module Keyword: {
  type media_reserved =
    | Only
    | Not
    | And
    | Or
    | Layer;

  let media_reserved_of_string: string => option(media_reserved);
  let media_reserved: Ast.component_value => option(media_reserved);

  type container_reserved =
    | None_
    | And_
    | Not_
    | Or_;

  let container_reserved_of_string: string => option(container_reserved);
  let container_reserved: Ast.component_value => option(container_reserved);

  type custom_ident_exclusion =
    | Auto
    | Span;

  let custom_ident_exclusion_of_string: string => option(custom_ident_exclusion);
  let custom_ident_exclusion: Ast.component_value => option(custom_ident_exclusion);
};
