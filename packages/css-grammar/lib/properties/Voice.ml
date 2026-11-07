open Types
open Support

module Property_voice_balance =
  [%spec_module
  "<number> | 'left' | 'center' | 'right' | 'leftwards' | 'rightwards'",
  (module Css_types.VoiceBalance)]

let property_voice_balance : property_voice_balance Rule.rule =
  Property_voice_balance.rule

module Property_voice_duration =
  [%spec_module
  "'auto' | <extended-time>", (module Css_types.VoiceDuration)]

let property_voice_duration : property_voice_duration Rule.rule =
  Property_voice_duration.rule

module Property_voice_family =
  [%spec_module
  "[ [ <family-name> | <generic-voice> ] ',' ]* [ <family-name> | \
   <generic-voice> ] | 'preserve'",
  (module Css_types.VoiceFamily)]

let property_voice_family : property_voice_family Rule.rule =
  Property_voice_family.rule

module Property_voice_pitch =
  [%spec_module
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]",
  (module Css_types.VoicePitch)]

let property_voice_pitch : property_voice_pitch Rule.rule =
  Property_voice_pitch.rule

module Property_voice_range =
  [%spec_module
  "<extended-frequency> && 'absolute' | [ 'x-low' | 'low' | 'medium' | 'high' \
   | 'x-high' ] || [ <extended-frequency> | <semitones> | \
   <extended-percentage> ]",
  (module Css_types.VoiceRange)]

let property_voice_range : property_voice_range Rule.rule =
  Property_voice_range.rule

module Property_voice_rate =
  [%spec_module
  "[ 'normal' | 'x-slow' | 'slow' | 'medium' | 'fast' | 'x-fast' ] || \
   <extended-percentage>",
  (module Css_types.VoiceRate)]

let property_voice_rate : property_voice_rate Rule.rule =
  Property_voice_rate.rule

module Property_voice_stress =
  [%spec_module
  "'normal' | 'strong' | 'moderate' | 'none' | 'reduced'",
  (module Css_types.VoiceStress)]

let property_voice_stress : property_voice_stress Rule.rule =
  Property_voice_stress.rule

module Property_voice_volume =
  [%spec_module
  "'silent' | [ 'x-soft' | 'soft' | 'medium' | 'loud' | 'x-loud' ] || <decibel>",
  (module Css_types.VoiceVolume)]

let property_voice_volume : property_voice_volume Rule.rule =
  Property_voice_volume.rule

let entries : (kind * packed_rule) list =
  [
    Property "voice-balance", pack_module (module Property_voice_balance);
    Property "voice-duration", pack_module (module Property_voice_duration);
    Property "voice-family", pack_module (module Property_voice_family);
    Property "voice-pitch", pack_module (module Property_voice_pitch);
    Property "voice-range", pack_module (module Property_voice_range);
    Property "voice-rate", pack_module (module Property_voice_rate);
    Property "voice-stress", pack_module (module Property_voice_stress);
    Property "voice-volume", pack_module (module Property_voice_volume);
  ]
