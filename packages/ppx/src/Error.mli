val expressions :
  loc:Ppxlib.location ->
  description:string ->
  ?examples:string list ->
  ?link:string ->
  (Ppxlib.location * string) list ->
  Ppxlib.expression

val expr :
  loc:Ppxlib.location ->
  ?examples:string list ->
  ?link:string ->
  string ->
  Ppxlib.expression

val raise :
  loc:Ppxlib.location -> ?examples:string list -> ?link:string -> string -> 'a
