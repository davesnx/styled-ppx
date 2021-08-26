type alias = option(string);
type event = { name: string, type_: string };
type attr = { name: string, type_: string, alias };
type domProp = | Event(event) | Attribute(attr);

let get: (list(string)) => list(domProp);
