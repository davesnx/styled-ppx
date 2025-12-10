module Builder = Ppxlib.Ast_builder.Default

(* ?x:(y : int = 0) *)
let make ?examples ?link description =
  let examples =
    match examples with
    | Some examples ->
      Printf.sprintf "\n\nExample:\n  %s" (String.concat "\n  " examples)
    | None -> ""
  in
  let link =
    match link with
    | Some link -> Printf.sprintf "\n\nMore info: %s" link
    | None -> ""
  in
  Printf.sprintf "%s%s%s" description examples link

(** Generates an expressin with a main error and sub-errors. The main error
    should contain the location of the payload, while the rest can be relative
    to the main error. *)
let expressions ~loc ~description ?examples ?link errors =
  Builder.pexp_extension ~loc
  @@ Ppxlib.Location.Error.to_extension
  @@ Ppxlib.Location.Error.make ~loc
       (make ?examples ?link description)
       ~sub:errors

(** Generates an expressin with a single error. Error.expressions is preferred
    instead, it handles multiple errors in the right locations *)
let expr ~loc ?examples ?link description =
  Builder.pexp_extension ~loc
  @@ Ppxlib.Location.Error.to_extension
  @@ Ppxlib.Location.Error.make ~loc (make ?examples ?link description) ~sub:[]

let raise ~loc ?examples ?link description =
  let message = make ?examples ?link description in
  raise @@ Ppxlib.Location.raise_errorf ~loc "%s" message
