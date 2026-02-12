module Builder = Ppxlib.Ast_builder.Default

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

let expressions ~loc ~description ?examples ?link errors =
  Builder.pexp_extension ~loc
  @@ Ppxlib.Location.Error.to_extension
  @@ Ppxlib.Location.Error.make ~loc
       (make ?examples ?link description)
       ~sub:errors

let expr ~loc ?examples ?link description =
  let message = make ?examples ?link description in
  Builder.pexp_extension ~loc
  @@ Ppxlib.Location.Error.to_extension
  @@ Ppxlib.Location.Error.make ~loc message ~sub:[]

let raise ~loc ?examples ?link description =
  let message = make ?examples ?link description in
  raise @@ Ppxlib.Location.raise_errorf ~loc "%s" message
