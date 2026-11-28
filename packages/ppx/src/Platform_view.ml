(* What one platform's build keeps of a structure, after server-reason-react's
   browser_ppx: [switch%platform] keeps the [Server] or the [Client] case,
   [browser_only] (and the effect argument of [React.useEffect*]) loses its
   function bodies in the native build, and [[@platform native]],
   [[@platform js]] and [[@browser_only]] drop what they annotate from the
   other build. Only what decides which [%css] blocks remain is modelled; a
   removed expression becomes [()].

   The naming pass in [Ppx] runs on both views (see [Css_file.Naming]), so
   it sees every block of the module, whichever build compiles it. *)

open Ppxlib

type t =
  | Native
  | Js

let removed ~loc = Ast_builder.Default.eunit ~loc

let is_platform_tag = function
  | "browser_ppx" | "browser_only" | "platform" -> true
  | _ -> false

let drops platform (attr : attribute) =
  match attr.attr_name.txt, attr.attr_payload, platform with
  | "browser_only", _, Native -> true
  | ( "platform",
      PStr
        [
          {
            pstr_desc =
              Pstr_eval
                ({ pexp_desc = Pexp_ident { txt = Lident target; _ }; _ }, []);
            _;
          };
        ],
      _ ) ->
    (match target, platform with
    | "js", Native | "native", Js -> true
    | _ -> false)
  | _ -> false

let keeps platform attrs = not (List.exists (drops platform) attrs)

let case_name (case : case) =
  match case.pc_lhs.ppat_desc with
  | Ppat_construct ({ txt = Lident name | Ldot (Lident "Runtime", name); _ }, _)
    ->
    Some name
  | _ -> None

let rec is_function (expr : expression) =
  match expr.pexp_desc with
  | Pexp_function _ -> true
  | Pexp_constraint (inner, _) | Pexp_newtype (_, inner) -> is_function inner
  | _ -> false

let effect_hooks =
  List.concat_map
    (fun hook ->
      ("React." ^ hook)
      :: List.init 8 (fun arity -> "React." ^ hook ^ string_of_int arity))
    [ "useEffect"; "useLayoutEffect" ]

let rec longident_name = function
  | Lident name -> name
  | Ldot (parent, name) -> longident_name parent ^ "." ^ name
  | Lapply _ -> ""

let single_expression = function
  | PStr [ { pstr_desc = Pstr_eval (expr, _); _ } ] -> Some expr
  | _ -> None

let view platform =
  object (self)
    inherit Ast_traverse.map as super

    (* The payload of [browser_only]: the client build keeps it; the native
       build keeps a non-function value and the body of a local [let]. *)
    method browser_only (payload : expression) =
      let loc = payload.pexp_loc in
      match platform with
      | Js -> self#expression payload
      | Native ->
        (match payload.pexp_desc with
        | Pexp_let (rec_flag, bindings, body) ->
          let bindings =
            List.map
              (fun (vb : value_binding) -> { vb with pvb_expr = removed ~loc })
              bindings
          in
          {
            payload with
            pexp_desc = Pexp_let (rec_flag, bindings, self#expression body);
          }
        | _ -> removed ~loc)

    method! expression expr =
      let loc = expr.pexp_loc in
      if not (keeps platform expr.pexp_attributes) then removed ~loc
      else (
        match expr.pexp_desc with
        | Pexp_let (_, [ vb ], _) when not (keeps platform vb.pvb_attributes) ->
          removed ~loc
        | Pexp_extension ({ txt = "platform"; _ }, payload) ->
          (match single_expression payload with
          | Some { pexp_desc = Pexp_match (_, [ first; second ]); _ } ->
            let wanted =
              match platform with Native -> "Server" | Js -> "Client"
            in
            (match
               List.find_opt
                 (fun case -> case_name case = Some wanted)
                 [ first; second ]
             with
            | Some case -> self#expression case.pc_rhs
            | None -> super#expression expr)
          | _ -> super#expression expr)
        | Pexp_extension ({ txt = "browser_only"; _ }, payload) ->
          (match single_expression payload with
          | Some payload -> self#browser_only payload
          | None -> super#expression expr)
        | Pexp_apply
            (({ pexp_desc = Pexp_ident { txt = hook; _ }; _ } as fn), args)
          when platform = Native && List.mem (longident_name hook) effect_hooks
          ->
          (match args with
          | (Nolabel, effect_fn) :: rest when is_function effect_fn ->
            {
              expr with
              pexp_desc =
                Pexp_apply
                  ( self#expression fn,
                    (Nolabel, removed ~loc:effect_fn.pexp_loc)
                    :: List.map
                         (fun (label, arg) -> label, self#expression arg)
                         rest );
            }
          | _ -> super#expression expr)
        | _ -> super#expression expr)

    method! structure_item item =
      match item.pstr_desc with
      | Pstr_extension
          ( ( { txt = "browser_only"; _ },
              PStr
                [ ({ pstr_desc = Pstr_value (rec_flag, [ vb ]); _ } as inner) ]
            ),
            _ ) ->
        (match platform with
        | Js -> self#structure_item inner
        | Native when is_function vb.pvb_expr ->
          {
            inner with
            pstr_desc =
              Pstr_value
                (rec_flag, [ { vb with pvb_expr = removed ~loc:vb.pvb_loc } ]);
          }
        | Native -> self#structure_item inner)
      | _ -> super#structure_item item

    method! structure items =
      let items =
        match items with
        | { pstr_desc = Pstr_attribute attr; _ } :: rest
          when is_platform_tag attr.attr_name.txt ->
          if drops platform attr then [] else rest
        | items -> items
      in
      let kept (item : structure_item) =
        match item.pstr_desc with
        | Pstr_typext { ptyext_attributes = attrs; _ }
        | Pstr_modtype { pmtd_attributes = attrs; _ }
        | Pstr_open { popen_attributes = attrs; _ }
        | Pstr_include { pincl_attributes = attrs; _ }
        | Pstr_exception { ptyexn_attributes = attrs; _ }
        | Pstr_primitive { pval_attributes = attrs; _ }
        | Pstr_eval (_, attrs)
        | Pstr_module { pmb_attributes = attrs; _ } ->
          keeps platform attrs
        | Pstr_value (_, vbs) ->
          List.for_all
            (fun (vb : value_binding) -> keeps platform vb.pvb_attributes)
            vbs
        | Pstr_recmodule mbs ->
          List.for_all
            (fun (mb : module_binding) -> keeps platform mb.pmb_attributes)
            mbs
        | Pstr_type _ | Pstr_class _ | Pstr_class_type _ | Pstr_extension _
        | Pstr_attribute _ ->
          true
      in
      List.map self#structure_item (List.filter kept items)
  end

let structure platform str = (view platform)#structure str
