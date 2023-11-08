open Ppxlib;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let withLoc = (~loc, txt) => {loc, txt};

module ReasonAttributes = {
  let preserveBraces = (~loc) =>
    Helper.Attr.mk(withLoc("reason.preserve_braces", ~loc), PStr([]));

  let rawLiteral = (~loc, structure_item) =>
    Helper.Attr.mk(
      withLoc("reason.raw_literal", ~loc),
      PStr([structure_item]),
    );
};

module ReScriptAttributes = {
  let optional = (~loc) =>
    Helper.Attr.mk(withLoc("ns.optional", ~loc), PStr([]));
  let template = (~loc) =>
    Helper.Attr.mk(withLoc("res.template", ~loc), PStr([]));
  let uncurried = (~loc) =>
    Builder.attribute(~name=withLoc(~loc, "bs"), ~loc, ~payload=PStr([]));
  let val_ = (~loc) => Helper.Attr.mk(withLoc("bs.val", ~loc), PStr([]));

  /* [@bs.deriving abstract] */
  let derivingAbstract = (~loc) =>
    Helper.Attr.mk(
      withLoc("bs.deriving", ~loc),
      PStr([
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.ident(~loc, withLoc(Lident("abstract"), ~loc)),
            [],
          ),
        ),
      ]),
    );

  /* [bs.as ""] */
  let alias = (~loc, alias) =>
    Helper.Attr.mk(
      withLoc("bs.as", ~loc),
      PStr([
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.constant(
              ~loc,
              ~attrs=[],
              Pconst_string(alias, loc, None),
            ),
            [],
          ),
        ),
      ]),
    );

  let obj = (~loc, record) => {
    Helper.Exp.extension(
      ~loc,
      (
        withLoc("bs.obj", ~loc),
        PStr([Helper.Str.mk(~loc, Pstr_eval(record, []))]),
      ),
    );
  };
  let module_ = (~loc, structure_item) =>
    Helper.Attr.mk(withLoc("bs.module", ~loc), PStr([structure_item]));
};

module MelangeAttributes = {
  /* [@mel.optional] */
  let optional = (~loc) =>
    Helper.Attr.mk(withLoc("mel.optional", ~loc), PStr([]));

  /* fn(. ) */
  let uncurried = (~loc) => {
    Builder.attribute(~name=withLoc(~loc, "u"), ~loc, ~payload=PStr([]));
  };

  /* [@deriving abstract] */
  let derivingAbstract = (~loc) =>
    Helper.Attr.mk(
      withLoc("deriving", ~loc),
      PStr([
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.ident(~loc, withLoc(Lident("abstract"), ~loc)),
            [],
          ),
        ),
      ]),
    );

  /* [mel.as ""] */
  let alias = (~loc, alias) =>
    Helper.Attr.mk(
      withLoc("mel.as", ~loc),
      PStr([
        Helper.Str.mk(
          ~loc,
          Pstr_eval(
            Helper.Exp.constant(
              ~loc,
              ~attrs=[],
              Pconst_string(alias, loc, None),
            ),
            [],
          ),
        ),
      ]),
    );

  let obj = (~loc, record) => {
    Helper.Exp.extension(
      ~loc,
      (
        withLoc("mel.obj", ~loc),
        PStr([Helper.Str.mk(~loc, Pstr_eval(record, []))]),
      ),
    );
  };

  let module_ = (~loc, structure_item) =>
    Helper.Attr.mk(withLoc("mel.module", ~loc), PStr([structure_item]));
};

let optional = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
    ReScriptAttributes.optional(~loc)
  | Some(Reason)
  | _ => MelangeAttributes.optional(~loc)
  };
};

let alias = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) when Settings.Get.jsxVersion() === 4 =>
    ReScriptAttributes.alias(~loc)
  | Some(Reason)
  | _ => MelangeAttributes.alias(~loc)
  };
};

let module_ = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => ReScriptAttributes.module_(~loc)
  | Some(Reason)
  | _ => MelangeAttributes.module_(~loc)
  };
};

let obj = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => ReScriptAttributes.obj(~loc)
  | Some(Reason)
  | _ => MelangeAttributes.obj(~loc)
  };
};

let derivingAbstract = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => ReScriptAttributes.derivingAbstract(~loc)
  | Some(Reason)
  | _ => MelangeAttributes.derivingAbstract(~loc)
  };
};

let uncurried = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => ReScriptAttributes.uncurried(~loc)
  | Some(Reason)
  | _ => MelangeAttributes.uncurried(~loc)
  };
};

let rawLiteral = (~loc, structure_item) => {
  switch (File.get()) {
  | Some(ReScript) => []
  | Some(Reason)
  | _ => [ReasonAttributes.rawLiteral(~loc, structure_item)]
  };
};

let preserveBraces = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => []
  | Some(Reason)
  | _ => [ReasonAttributes.preserveBraces(~loc)]
  };
};

let template = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => [ReScriptAttributes.template(~loc)]
  | Some(Reason)
  | _ => []
  };
};

let string_delimiter = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => ("*j", template(~loc))
  | _ => ("js", [])
  };
};

let val_ = (~loc) => {
  switch (File.get()) {
  | Some(ReScript) => [ReScriptAttributes.val_(~loc)]
  | Some(Reason)
  | _ => []
  };
};
