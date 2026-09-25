open Types
open Support

(* CSS Rhythmic Sizing L1: https://drafts.csswg.org/css-rhythm/ *)

module Property_block_step_size =
  [%spec_module
  "'none' | <extended-length>", (module Css_types.BlockStepSize)]

let property_block_step_size : property_block_step_size Rule.rule =
  Property_block_step_size.rule

module Property_block_step_insert =
  [%spec_module
  "'margin-box' | 'padding-box' | 'content-box'",
  (module Css_types.BlockStepInsert)]

let property_block_step_insert : property_block_step_insert Rule.rule =
  Property_block_step_insert.rule

module Property_block_step_align =
  [%spec_module
  "'auto' | 'center' | 'start' | 'end'", (module Css_types.BlockStepAlign)]

let property_block_step_align : property_block_step_align Rule.rule =
  Property_block_step_align.rule

module Property_block_step_round =
  [%spec_module
  "'up' | 'down' | 'nearest'", (module Css_types.BlockStepRound)]

let property_block_step_round : property_block_step_round Rule.rule =
  Property_block_step_round.rule

(* https://drafts.csswg.org/css-rhythm/#propdef-block-step *)
module Property_block_step =
  [%spec_module
  "<'block-step-size'> || <'block-step-insert'> || <'block-step-align'> || \
   <'block-step-round'>",
  (module Css_types.BlockStepSize)]

let property_block_step : property_block_step Rule.rule =
  Property_block_step.rule

let entries : (kind * packed_rule) list =
  [
    Property "block-step-size", pack_module (module Property_block_step_size);
    ( Property "block-step-insert",
      pack_module (module Property_block_step_insert) );
    Property "block-step-align", pack_module (module Property_block_step_align);
    Property "block-step-round", pack_module (module Property_block_step_round);
    ( Shorthand
        ( "block-step",
          [
            "block-step-size";
            "block-step-insert";
            "block-step-align";
            "block-step-round";
          ] ),
      pack_module (module Property_block_step) );
  ]
