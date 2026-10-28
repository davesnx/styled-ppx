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

let register:
  (~file: string, ~scope: list(string), ~name: string, ~className: string) =>
  unit;

let include_module:
  (~file: string, ~scope: list(string), ~module_path: list(string)) => unit;

let module_alias_target:
  (~file: string, ~scope: list(string), list(string)) => list(string);

let resolve_local_module_path:
  (~file: string, ~scope: list(string), list(string)) =>
  option(list(string));

/** The variables [pattern] binds. */
let bound_names: Ppxlib.pattern => list(string);

/** What a `$(path)` or merge argument names: a class registered earlier in
    this file, or a binding of another module (its longident, aliases
    expanded). [None] when [path] names neither, or when it is an
    unqualified name in [locals]: a function parameter or local variable
    that shadows any binding of that name. Records nothing. */
type class_ref =
  | Local(string)
  | Cross_module(string);

let resolve_class_ref:
  (
    ~file: string,
    ~scope: list(string),
    ~opens: list(list(string)),
    ~locals: list(string),
    string
  ) =>
  option(class_ref);

let resolve_selector_class_ref:
  (
    ~file: string,
    ~scope: list(string),
    ~opens: list(list(string)),
    ~locals: list(string),
    ~loc: Ppxlib.Location.t,
    string
  ) =>
  string;

let clear: unit => unit;
