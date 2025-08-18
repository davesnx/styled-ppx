val expr :
  loc:Ppxlib.location ->
  ?examples:string list ->
  ?link:string ->
  string ->
  Ppxlib.expression

(** This is a wrapper around `Ppxlib.Location.raise_errorf` that allows for
    examples and a link to the documentation, similarly to
    `Ppxlib.Location.raise_errorf` shouldn't be used much, prefer to use
    `Error.expr` instead. *)
val raise :
  loc:Ppxlib.location ->
  ?examples:string list ->
  ?link:string ->
  string ->
  'raises
