type context = Context_key.context = {
  scope : string;
  conditions : string list;
  important : bool;
}

type decl = {
  context : context;
  prop : string;
  text : string;
}

type unit_ = {
  pieces : decl list;
  bundle : bool;
  tier : int;
  conds : int;
  cover : int;
}

let tier _ = failwith "todo"
let units _ = failwith "todo"
