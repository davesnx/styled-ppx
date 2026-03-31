open Types
open Support

module Property_azimuth =
  [%spec_module
  "<extended-angle> | [ 'left-side' | 'far-left' | 'left' | 'center-left' | \
   'center' | 'center-right' | 'right' | 'far-right' | 'right-side' ] || \
   'behind' | 'leftwards' | 'rightwards'",
  (module Css_types.Azimuth)]

let property_azimuth : property_azimuth Rule.rule = Property_azimuth.rule

module Property_behavior =
  [%spec_module
  "[ <url> ]+", (module Css_types.Behavior)]

let property_behavior : property_behavior Rule.rule = Property_behavior.rule

module Property_clip =
  [%spec_module
  "<shape> | 'auto'", (module Css_types.Clip)]

let property_clip : property_clip Rule.rule = Property_clip.rule

module Property_cue =
  [%spec_module
  "<'cue-before'> [ <'cue-after'> ]?", (module Css_types.Cue)]

let property_cue : property_cue Rule.rule = Property_cue.rule

module Property_cue_after =
  [%spec_module
  "<url> [ <decibel> ]? | 'none'", (module Css_types.CueAfter)]

let property_cue_after : property_cue_after Rule.rule = Property_cue_after.rule

module Property_cue_before =
  [%spec_module
  "<url> [ <decibel> ]? | 'none'", (module Css_types.CueBefore)]

let property_cue_before : property_cue_before Rule.rule =
  Property_cue_before.rule

module Property_kerning =
  [%spec_module
  "'auto' | <svg-length>", (module Css_types.Kerning)]

let property_kerning : property_kerning Rule.rule = Property_kerning.rule

module Property_speak =
  [%spec_module
  "'auto' | 'none' | 'normal'", (module Css_types.Speak)]

let property_speak : property_speak Rule.rule = Property_speak.rule

module Property_word_space_transform =
  [%spec_module
  "'none' | 'auto' | 'ideograph-alpha' | 'ideograph-numeric'",
  (module Css_types.WordSpaceTransform)]

let property_word_space_transform : property_word_space_transform Rule.rule =
  Property_word_space_transform.rule

module Property_backdrop_blur =
  [%spec_module
  "<extended-length>", (module Css_types.BackdropBlur)]

let property_backdrop_blur : property_backdrop_blur Rule.rule =
  Property_backdrop_blur.rule

module Property_container_name_computed =
  [%spec_module
  "'none' | [ <custom-ident> ]#", (module Css_types.ContainerNameComputed)]

let property_container_name_computed :
  property_container_name_computed Rule.rule =
  Property_container_name_computed.rule

let entries : (kind * packed_rule) list =
  [
    Property "kerning", pack_module (module Property_kerning);
    Property "behavior", pack_module (module Property_behavior);
    Property "backdrop-blur", pack_module (module Property_backdrop_blur);
    Property "clip", pack_module (module Property_clip);
    ( Property "container-name-computed",
      pack_module (module Property_container_name_computed) );
    Property "azimuth", pack_module (module Property_azimuth);
    Property "cue", pack_module (module Property_cue);
    Property "cue-after", pack_module (module Property_cue_after);
    Property "cue-before", pack_module (module Property_cue_before);
    Property "speak", pack_module (module Property_speak);
    ( Property "word-space-transform",
      pack_module (module Property_word_space_transform) );
  ]
