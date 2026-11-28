open Ppxlib

let () =
  Driver.register_transformation "css_later"
    ~rules:
      [
        Context_free.Rule.extension
          (Extension.declare "css_later" Extension.Context.expression
             Ast_pattern.(single_expr_payload __)
             (fun ~loc ~path:_ payload ->
               Ast_builder.Default.pexp_extension ~loc
                 ( { txt = "css"; loc },
                   PStr [ Ast_builder.Default.pstr_eval ~loc payload [] ] )));
      ]
