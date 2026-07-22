(* Expands the `styles=` JSX prop on lowercase (DOM) elements into
   `className=` / `style=` props, going through the `CSS.className` /
   `CSS.styles` accessors.

   This used to be delegated to server-reason-react's `styles-attribute`
   library, which destructures the carrier with `fst`/`snd` and therefore
   pins `CSS.styles` to a pair. Owning the expansion here keeps the carrier
   representation an internal detail of the runtime (it now also carries a
   debug label — see `CSS.label`), and removes the cross-package
   representation contract.

   The emitted identifiers (`CSS.className`, `CSS.styles`,
   `ReactDOM.Style.combine`) resolve in user scope, exactly like the
   `CSS.make` calls the PPX already generates. *)

let is_jsx_attribute { Ppxlib.attr_name; _ } = attr_name.txt = "JSX"

let has_jsx_attribute apply_expr =
  List.exists is_jsx_attribute apply_expr.Ppxlib.pexp_attributes

let is_lowercase_name name =
  String.length name > 0 && match name.[0] with 'a' .. 'z' -> true | _ -> false

let is_lowercase_html_tag_call (fn : Ppxlib.expression) =
  match fn.pexp_desc with
  | Pexp_ident { txt = Lident name; _ } -> is_lowercase_name name
  | _ -> false

let should_expand_apply (apply_expr : Ppxlib.expression) =
  match apply_expr.pexp_desc with
  | Pexp_apply (fn, _) ->
    has_jsx_attribute apply_expr && is_lowercase_html_tag_call fn
  | _ -> false

let expand_attributes ~loc attributes =
  let merge_className current_className (label, expr) =
    match current_className with
    | Some (existing_label, existing_expr) ->
      let merged =
        match label with
        | Ppxlib.Optional "className" ->
          [%expr
            match [%e expr] with
            | None -> [%e existing_expr]
            | Some x -> x ^ " " ^ [%e existing_expr]]
        | _ -> [%expr [%e expr] ^ " " ^ [%e existing_expr]]
      in
      Some (existing_label, merged)
    | None -> Some (label, expr)
  in
  let merge_style current_style (label, expr) =
    match current_style with
    | Some (existing_label, existing_expr) ->
      let merged =
        match label with
        | Ppxlib.Optional "style" ->
          [%expr
            match [%e expr] with
            | None -> [%e existing_expr]
            | Some x -> ReactDOM.Style.combine [%e existing_expr] x]
        | _ -> [%expr ReactDOM.Style.combine [%e existing_expr] [%e expr]]
      in
      Some (existing_label, merged)
    | None -> Some (label, expr)
  in
  let handle_styles className style label arg =
    let className_label, className_expr, style_label, style_expr =
      match label with
      | Ppxlib.Labelled "styles" ->
        ( Ppxlib.Labelled "className",
          [%expr CSS.className [%e arg]],
          Ppxlib.Labelled "style",
          [%expr CSS.styles [%e arg]] )
      | _ ->
        ( Ppxlib.Optional "className",
          [%expr
            match [%e arg] with
            | None -> None
            | Some x -> Some (CSS.className x)],
          Ppxlib.Optional "style",
          [%expr
            match [%e arg] with None -> None | Some x -> Some (CSS.styles x)]
        )
    in
    ( merge_className className (className_label, className_expr),
      merge_style style (style_label, style_expr) )
  in
  let rec aux (className, style, other_args) args =
    match args with
    | [] ->
      let rest = List.rev other_args in
      ([ className; style ] |> List.filter_map Stdlib.Fun.id) @ rest
    | (label, arg) :: rest -> (
      match label with
      | Ppxlib.Labelled "className" | Ppxlib.Optional "className" ->
        aux (merge_className className (label, arg), style, other_args) rest
      | Ppxlib.Labelled "style" | Ppxlib.Optional "style" ->
        aux (className, merge_style style (label, arg), other_args) rest
      | Ppxlib.Labelled "styles" | Ppxlib.Optional "styles" ->
        let new_className, new_style = handle_styles className style label arg in
        aux (new_className, new_style, other_args) rest
      | _ -> aux (className, style, (label, arg) :: other_args) rest)
  in
  aux (None, None, []) attributes

let expand (expr : Ppxlib.expression) =
  match expr.pexp_desc with
  | Pexp_apply (({ pexp_loc = loc; _ } as tag), attributes)
    when should_expand_apply expr ->
    let new_attributes = expand_attributes ~loc attributes in
    { expr with pexp_desc = Pexp_apply (tag, new_attributes) }
  | _ -> expr
