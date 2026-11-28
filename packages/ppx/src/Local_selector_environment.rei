/** Ordered, per-compilation-unit selector environment for [%css]. */;

let register_module: (~file: string, ~path: list(string)) => unit;

let register_alias:
  (
    ~file: string,
    ~scope: list(string),
    ~name: string,
    ~target: list(string)
  ) =>
  unit;

/** What a selector reference to a binding resolves to: a value with no
    [%css] block, a string literal, the class of the one block it holds, a
    function, a value with several blocks, an alias of another binding (not
    followed), or a member of the [let rec] group being expanded. */
type binding =
  | Not_css
  | Literal(string)
  | Block(string)
  | Function
  | Several(int)
  | Alias
  | In_rec_group;

/** The latest binding of [name] in [scope]; it replaces any earlier one. */
let set_binding:
  (~file: string, ~scope: list(string), ~name: string, binding) => unit;

let include_module:
  (~file: string, ~scope: list(string), ~module_path: list(string)) => unit;

let module_alias_target:
  (~file: string, ~scope: list(string), list(string)) => list(string);

let resolve_local_module_path:
  (~file: string, ~scope: list(string), list(string)) =>
  option(list(string));

let resolve_selector_class_ref:
  (
    ~file: string,
    ~scope: list(string),
    ~opens: list(list(string)),
    ~loc: Ppxlib.Location.t,
    string
  ) =>
  string;

let clear: unit => unit;
