  $ as_standalone --impl input.ml -o output.ml
  $ cat output.ml
  module Display =
    struct
      type nonrec t =
        [ `Block  | `Inline  | `Flex  | `Grid  | `None  | `Contents 
        | `Flow_root  | `Table ]
      let (rule : t Rule.rule) =
        Combinators.xor
          [Rule.Match.map (Standard.keyword "block") (fun _v -> `Block);
          Rule.Match.map (Standard.keyword "inline") (fun _v -> `Inline);
          Rule.Match.map (Standard.keyword "flex") (fun _v -> `Flex);
          Rule.Match.map (Standard.keyword "grid") (fun _v -> `Grid);
          Rule.Match.map (Standard.keyword "none") (fun _v -> `None);
          Rule.Match.map (Standard.keyword "contents") (fun _v -> `Contents);
          Rule.Match.map (Standard.keyword "flow-root") (fun _v -> `Flow_root);
          Rule.Match.map (Standard.keyword "table") (fun _v -> `Table)]
      let parse (input : string) =
        (Rule.parse_string rule input : (t, string) result)
      let to_string (value : t) =
        (match value with | _ -> "TODO: to_string" : string)
      let extract_interpolations (value : t) = ([] : string list)
      let runtime_module =
        Some ((module Css_types.Display) : (module RUNTIME_TYPE))
      let runtime_module_path = Some "Css_types.Display"
    end

