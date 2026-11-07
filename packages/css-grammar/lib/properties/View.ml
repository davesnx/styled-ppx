open Types
open Support

module Property_view_timeline =
  [%spec_module
  "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#",
  (module Css_types.ViewTimeline)]

let property_view_timeline : property_view_timeline Rule.rule =
  Property_view_timeline.rule

module Property_view_timeline_axis =
  [%spec_module
  "[ 'block' | 'inline' | 'x' | 'y' ]#", (module Css_types.ViewTimelineAxis)]

let property_view_timeline_axis : property_view_timeline_axis Rule.rule =
  Property_view_timeline_axis.rule

module Property_view_timeline_inset =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.ViewTimelineInset)]

let property_view_timeline_inset : property_view_timeline_inset Rule.rule =
  Property_view_timeline_inset.rule

module Property_view_timeline_name =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.ViewTimelineName)]

let property_view_timeline_name : property_view_timeline_name Rule.rule =
  Property_view_timeline_name.rule

module Property_view_transition_class =
  [%spec_module
  "<custom-ident>+ | 'none'", (module Css_types.Cascading)]

let property_view_transition_class = Property_view_transition_class.rule

module Property_view_transition_name =
  [%spec_module
  "'none' | <custom-ident>", (module Css_types.ViewTransitionName)]

let property_view_transition_name : property_view_transition_name Rule.rule =
  Property_view_transition_name.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "view-transition-class",
      pack_module (module Property_view_transition_class) );
    ( Property "view-transition-name",
      pack_module (module Property_view_transition_name) );
    Property "view-timeline", pack_module (module Property_view_timeline);
    ( Property "view-timeline-axis",
      pack_module (module Property_view_timeline_axis) );
    ( Property "view-timeline-inset",
      pack_module (module Property_view_timeline_inset) );
    ( Property "view-timeline-name",
      pack_module (module Property_view_timeline_name) );
  ]
