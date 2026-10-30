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

/** A variable bound inside a top-level binding. [identity] is the identity
    class of a local `let` bound to [%css]; [None] for any other variable. */
type local = {
  name: string,
  identity: option(string),
};

/** The variables [pattern] binds, none of them bound to [%css]. */
let bound_locals: Ppxlib.pattern => list(local);

/** What a `$(path)` or merge argument names: a class registered earlier in
    this file, or a binding of another module (its longident, aliases
    expanded). An unqualified name in [locals] shadows any binding of that
    name: it resolves to the local's identity class, or to [None] when the
    local is not bound to [%css]. [None] also when [path] names nothing.
    Records nothing. */
type class_ref =
  | Local(string)
  | Cross_module(string);

let resolve_class_ref:
  (
    ~file: string,
    ~scope: list(string),
    ~opens: list(list(string)),
    ~locals: list(local),
    string
  ) =>
  option(class_ref);

let resolve_selector_class_ref:
  (
    ~file: string,
    ~scope: list(string),
    ~opens: list(list(string)),
    ~locals: list(local),
    ~loc: Ppxlib.Location.t,
    string
  ) =>
  string;

let clear: unit => unit;
