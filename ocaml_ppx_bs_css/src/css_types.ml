type 'a with_loc = 'a * Location.t

type dimension =
  | Length
  | Angle
  | Time
  | Frequency

module rec Component_value : sig
  type t =
    | Paren_block of t with_loc list
    | Bracket_block of t with_loc list
    | Percentage of string
    | Ident of string
    | String of string
    | Uri of string
    | Operator of string
    | Delim of string
    | Function of string with_loc * t with_loc list with_loc
    | Hash of string
    | Number of string
    | Unicode_range of string
    | Float_dimension of (string * string * dimension)
    | Dimension of (string * string)
end =
  Component_value

and Brace_block : sig
  type t =
    | Empty
    | Declaration_list of Declaration_list.t
    | Stylesheet of Stylesheet.t
end =
  Brace_block

and At_rule : sig
  type t =
    { name: string with_loc;
      prelude: Component_value.t with_loc list with_loc;
      block: Brace_block.t;
      loc: Location.t;
    }
end =
  At_rule

and Declaration : sig
  type t =
    { name: string with_loc;
      value: Component_value.t with_loc list with_loc;
      important: bool with_loc;
      loc: Location.t;
    }
end =
  Declaration

and Declaration_list : sig
  type kind =
    | Declaration of Declaration.t
    | At_rule of At_rule.t
  type t = kind list with_loc
end =
  Declaration_list

and Style_rule : sig
  type t =
    { prelude: Component_value.t with_loc list with_loc;
      block: Declaration_list.t;
      loc: Location.t;
    }
end =
  Style_rule

and Rule : sig
  type t =
    | Style_rule of Style_rule.t
    | At_rule of At_rule.t
end =
  Rule

and Stylesheet : sig
  type t = Rule.t list with_loc
end =
  Stylesheet
