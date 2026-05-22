/* This file centralizes attributes emitted for Reason/Melange output. */

open Ppxlib;

module Helper = Ast_helper;
module Builder = Ppxlib.Ast_builder.Default;

let withLoc = (~loc, txt) => {
  loc,
  txt,
};

module ReasonAttributes = {
  let preserveBraces = (~loc) =>
    Helper.Attr.mk(withLoc("reason.preserve_braces", ~loc), PStr([]));

  let rawLiteral = (~loc, structure_item) =>
    Helper.Attr.mk(
      withLoc("reason.raw_literal", ~loc),
      PStr([structure_item]),
    );
};

module MelangeAttributes = {
  /* [@optional] */
  let optional = (~loc) =>
    Helper.Attr.mk(withLoc("optional", ~loc), PStr([]));

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

  let objExternal = (~loc) =>
    Helper.Attr.mk(withLoc("mel.obj", ~loc), PStr([]));

  let get = (~loc) => Helper.Attr.mk(withLoc("mel.get", ~loc), PStr([]));

  let module_ = (~loc, structure_item) =>
    Helper.Attr.mk(withLoc("mel.module", ~loc), PStr([structure_item]));
};

let optional = (~loc) => {
  MelangeAttributes.optional(~loc);
};

let alias = (~loc) => {
  MelangeAttributes.alias(~loc);
};

let module_ = (~loc) => {
  MelangeAttributes.module_(~loc);
};

let obj = (~loc) => {
  MelangeAttributes.obj(~loc);
};

let objExternal = (~loc) => {
  MelangeAttributes.objExternal(~loc);
};

let get = (~loc) => {
  MelangeAttributes.get(~loc);
};

let derivingAbstract = (~loc) => {
  MelangeAttributes.derivingAbstract(~loc);
};

let uncurried = (~loc) => {
  MelangeAttributes.uncurried(~loc);
};

let rawLiteral = (~loc, structure_item) => {
  [ReasonAttributes.rawLiteral(~loc, structure_item)];
};

let preserveBraces = (~loc) => {
  [ReasonAttributes.preserveBraces(~loc)];
};

let template = (~loc as _) => {
  [];
};

let string_delimiter = (~loc as _) => {
  ("js", []);
};

let val_ = (~loc as _) => {
  [];
};
