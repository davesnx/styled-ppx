open Types
open Support

module Property_scroll_behavior =
  [%spec_module
  "'auto' | 'smooth'", (module Css_types.ScrollBehavior)]

let property_scroll_behavior : property_scroll_behavior Rule.rule =
  Property_scroll_behavior.rule

module Property_scroll_margin =
  [%spec_module
  "[ <extended-length> ]{1,4}", (module Css_types.ScrollMargin)]

let property_scroll_margin : property_scroll_margin Rule.rule =
  Property_scroll_margin.rule

module Property_scroll_margin_block =
  [%spec_module
  "[ <extended-length> ]{1,2}", (module Css_types.Length)]

let property_scroll_margin_block : property_scroll_margin_block Rule.rule =
  Property_scroll_margin_block.rule

module Property_scroll_margin_block_end =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_block_end :
  property_scroll_margin_block_end Rule.rule =
  Property_scroll_margin_block_end.rule

module Property_scroll_margin_block_start =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_block_start :
  property_scroll_margin_block_start Rule.rule =
  Property_scroll_margin_block_start.rule

module Property_scroll_margin_bottom =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_bottom : property_scroll_margin_bottom Rule.rule =
  Property_scroll_margin_bottom.rule

module Property_scroll_margin_inline =
  [%spec_module
  "[ <extended-length> ]{1,2}", (module Css_types.Length)]

let property_scroll_margin_inline : property_scroll_margin_inline Rule.rule =
  Property_scroll_margin_inline.rule

module Property_scroll_margin_inline_end =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_inline_end :
  property_scroll_margin_inline_end Rule.rule =
  Property_scroll_margin_inline_end.rule

module Property_scroll_margin_inline_start =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_inline_start :
  property_scroll_margin_inline_start Rule.rule =
  Property_scroll_margin_inline_start.rule

module Property_scroll_margin_left =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_left : property_scroll_margin_left Rule.rule =
  Property_scroll_margin_left.rule

module Property_scroll_margin_right =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_right : property_scroll_margin_right Rule.rule =
  Property_scroll_margin_right.rule

module Property_scroll_margin_top =
  [%spec_module
  "<extended-length>", (module Css_types.Length)]

let property_scroll_margin_top : property_scroll_margin_top Rule.rule =
  Property_scroll_margin_top.rule

module Property_scroll_padding =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,4}",
  (module Css_types.ScrollPadding)]

let property_scroll_padding : property_scroll_padding Rule.rule =
  Property_scroll_padding.rule

module Property_scroll_padding_block =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.Length)]

let property_scroll_padding_block : property_scroll_padding_block Rule.rule =
  Property_scroll_padding_block.rule

module Property_scroll_padding_block_end =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_block_end :
  property_scroll_padding_block_end Rule.rule =
  Property_scroll_padding_block_end.rule

module Property_scroll_padding_block_start =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_block_start :
  property_scroll_padding_block_start Rule.rule =
  Property_scroll_padding_block_start.rule

module Property_scroll_padding_bottom =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_bottom : property_scroll_padding_bottom Rule.rule =
  Property_scroll_padding_bottom.rule

module Property_scroll_padding_inline =
  [%spec_module
  "[ 'auto' | <extended-length> | <extended-percentage> ]{1,2}",
  (module Css_types.Length)]

let property_scroll_padding_inline : property_scroll_padding_inline Rule.rule =
  Property_scroll_padding_inline.rule

module Property_scroll_padding_inline_end =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_inline_end :
  property_scroll_padding_inline_end Rule.rule =
  Property_scroll_padding_inline_end.rule

module Property_scroll_padding_inline_start =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_inline_start :
  property_scroll_padding_inline_start Rule.rule =
  Property_scroll_padding_inline_start.rule

module Property_scroll_padding_left =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_left : property_scroll_padding_left Rule.rule =
  Property_scroll_padding_left.rule

module Property_scroll_padding_right =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_right : property_scroll_padding_right Rule.rule =
  Property_scroll_padding_right.rule

module Property_scroll_padding_top =
  [%spec_module
  "'auto' | <extended-length> | <extended-percentage>",
  (module Css_types.Length)]

let property_scroll_padding_top : property_scroll_padding_top Rule.rule =
  Property_scroll_padding_top.rule

module Property_scroll_snap_align =
  [%spec_module
  "[ 'none' | 'start' | 'end' | 'center' ]{1,2}",
  (module Css_types.ScrollSnapAlign)]

let property_scroll_snap_align : property_scroll_snap_align Rule.rule =
  Property_scroll_snap_align.rule

module Property_scroll_snap_coordinate =
  [%spec_module
  "'none' | [ <position> ]#", (module Css_types.ScrollSnapCoordinate)]

let property_scroll_snap_coordinate : property_scroll_snap_coordinate Rule.rule
    =
  Property_scroll_snap_coordinate.rule

module Property_scroll_snap_destination =
  [%spec_module
  "<position>", (module Css_types.ScrollSnapDestination)]

let property_scroll_snap_destination :
  property_scroll_snap_destination Rule.rule =
  Property_scroll_snap_destination.rule

module Property_scroll_snap_points_x =
  [%spec_module
  "'none' | repeat( <extended-length> | <extended-percentage> )",
  (module Css_types.ScrollSnapPointsX)]

let property_scroll_snap_points_x : property_scroll_snap_points_x Rule.rule =
  Property_scroll_snap_points_x.rule

module Property_scroll_snap_points_y =
  [%spec_module
  "'none' | repeat( <extended-length> | <extended-percentage> )",
  (module Css_types.ScrollSnapPointsY)]

let property_scroll_snap_points_y : property_scroll_snap_points_y Rule.rule =
  Property_scroll_snap_points_y.rule

module Property_scroll_snap_stop =
  [%spec_module
  "'normal' | 'always'", (module Css_types.ScrollSnapStop)]

let property_scroll_snap_stop : property_scroll_snap_stop Rule.rule =
  Property_scroll_snap_stop.rule

module Property_scroll_snap_type =
  [%spec_module
  "'none' | [ 'x' | 'y' | 'block' | 'inline' | 'both' ] [ 'mandatory' | \
   'proximity' ]?",
  (module Css_types.ScrollSnapType)]

let property_scroll_snap_type : property_scroll_snap_type Rule.rule =
  Property_scroll_snap_type.rule

module Property_scroll_snap_type_x =
  [%spec_module
  "'none' | 'mandatory' | 'proximity'", (module Css_types.Cascading)]

let property_scroll_snap_type_x : property_scroll_snap_type_x Rule.rule =
  Property_scroll_snap_type_x.rule

module Property_scroll_snap_type_y =
  [%spec_module
  "'none' | 'mandatory' | 'proximity'", (module Css_types.Cascading)]

let property_scroll_snap_type_y : property_scroll_snap_type_y Rule.rule =
  Property_scroll_snap_type_y.rule

module Property_scroll_timeline =
  [%spec_module
  "[ 'none' | <custom-ident> ]# [ 'block' | 'inline' | 'x' | 'y' ]#",
  (module Css_types.ScrollTimeline)]

let property_scroll_timeline : property_scroll_timeline Rule.rule =
  Property_scroll_timeline.rule

module Property_scroll_timeline_axis =
  [%spec_module
  "[ 'block' | 'inline' | 'x' | 'y' ]#", (module Css_types.ScrollTimelineAxis)]

let property_scroll_timeline_axis : property_scroll_timeline_axis Rule.rule =
  Property_scroll_timeline_axis.rule

module Property_scroll_timeline_name =
  [%spec_module
  "[ 'none' | <custom-ident> ]#", (module Css_types.ScrollTimelineName)]

let property_scroll_timeline_name : property_scroll_timeline_name Rule.rule =
  Property_scroll_timeline_name.rule

module Property_scroll_start =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | 'top' | 'bottom' | 'left' | 'right' | \
   <extended-length> | <extended-percentage>",
  (module Css_types.ScrollStart)]

let property_scroll_start : property_scroll_start Rule.rule =
  Property_scroll_start.rule

module Property_scroll_start_block =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartBlock)]

let property_scroll_start_block : property_scroll_start_block Rule.rule =
  Property_scroll_start_block.rule

module Property_scroll_start_inline =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartInline)]

let property_scroll_start_inline : property_scroll_start_inline Rule.rule =
  Property_scroll_start_inline.rule

module Property_scroll_start_x =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartX)]

let property_scroll_start_x : property_scroll_start_x Rule.rule =
  Property_scroll_start_x.rule

module Property_scroll_start_y =
  [%spec_module
  "'auto' | 'start' | 'end' | 'center' | <extended-length> | \
   <extended-percentage>",
  (module Css_types.ScrollStartY)]

let property_scroll_start_y : property_scroll_start_y Rule.rule =
  Property_scroll_start_y.rule

module Property_scroll_start_target =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTarget)]

let property_scroll_start_target : property_scroll_start_target Rule.rule =
  Property_scroll_start_target.rule

module Property_scroll_start_target_block =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetBlock)]

let property_scroll_start_target_block :
  property_scroll_start_target_block Rule.rule =
  Property_scroll_start_target_block.rule

module Property_scroll_start_target_inline =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetInline)]

let property_scroll_start_target_inline :
  property_scroll_start_target_inline Rule.rule =
  Property_scroll_start_target_inline.rule

module Property_scroll_start_target_x =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetX)]

let property_scroll_start_target_x : property_scroll_start_target_x Rule.rule =
  Property_scroll_start_target_x.rule

module Property_scroll_start_target_y =
  [%spec_module
  "'none' | 'auto'", (module Css_types.ScrollStartTargetY)]

let property_scroll_start_target_y : property_scroll_start_target_y Rule.rule =
  Property_scroll_start_target_y.rule

module Property_scroll_marker_group =
  [%spec_module
  "'none' | 'before' | 'after'", (module Css_types.ScrollMarkerGroup)]

let property_scroll_marker_group : property_scroll_marker_group Rule.rule =
  Property_scroll_marker_group.rule

module Property_scroll_initial_target =
  [%spec_module
  "'none' | 'nearest'", (module Css_types.Cascading)]

let property_scroll_initial_target = Property_scroll_initial_target.rule

module Property_scroll_target_group =
  [%spec_module
  "'none' | 'auto'", (module Css_types.Cascading)]

let property_scroll_target_group = Property_scroll_target_group.rule

module Property__ms_content_zoom_chaining =
  [%spec_module
  "'none' | 'chained'", (module Css_types.Cascading)]

let property__ms_content_zoom_chaining = Property__ms_content_zoom_chaining.rule

module Property__ms_content_zoom_limit =
  [%spec_module
  "<percentage> [ <percentage> ]?", (module Css_types.Cascading)]

let property__ms_content_zoom_limit = Property__ms_content_zoom_limit.rule

module Property__ms_content_zoom_limit_max =
  [%spec_module
  "<percentage>", (module Css_types.Cascading)]

let property__ms_content_zoom_limit_max =
  Property__ms_content_zoom_limit_max.rule

module Property__ms_content_zoom_limit_min =
  [%spec_module
  "<percentage>", (module Css_types.Cascading)]

let property__ms_content_zoom_limit_min =
  Property__ms_content_zoom_limit_min.rule

module Property__ms_content_zoom_snap =
  [%spec_module
  "[ 'none' | 'proximity' | 'mandatory' ] || [ snapInterval( <percentage> , \
   <percentage> ) | snapList( [ <percentage> ]# ) ]",
  (module Css_types.Cascading)]

let property__ms_content_zoom_snap = Property__ms_content_zoom_snap.rule

module Property__ms_content_zoom_snap_points =
  [%spec_module
  "snapInterval( <percentage> , <percentage> ) | snapList( [ <percentage> ]# )",
  (module Css_types.Cascading)]

let property__ms_content_zoom_snap_points =
  Property__ms_content_zoom_snap_points.rule

module Property__ms_content_zoom_snap_type =
  [%spec_module
  "'none' | 'proximity' | 'mandatory'", (module Css_types.Cascading)]

let property__ms_content_zoom_snap_type =
  Property__ms_content_zoom_snap_type.rule

module Property__ms_content_zooming =
  [%spec_module
  "'none' | 'zoom'", (module Css_types.Cascading)]

let property__ms_content_zooming = Property__ms_content_zooming.rule

module Property__ms_scroll_chaining =
  [%spec_module
  "'chained' | 'none'", (module Css_types.Cascading)]

let property__ms_scroll_chaining = Property__ms_scroll_chaining.rule

module Property__ms_scroll_limit =
  [%spec_module
  "<length> [ <length> [ 'auto' | <length> ] [ 'auto' | <length> ]? ]?",
  (module Css_types.Cascading)]

let property__ms_scroll_limit = Property__ms_scroll_limit.rule

module Property__ms_scroll_limit_x_max =
  [%spec_module
  "'auto' | <length>", (module Css_types.Cascading)]

let property__ms_scroll_limit_x_max = Property__ms_scroll_limit_x_max.rule

module Property__ms_scroll_limit_x_min =
  [%spec_module
  "<length>", (module Css_types.Length)]

let property__ms_scroll_limit_x_min = Property__ms_scroll_limit_x_min.rule

module Property__ms_scroll_limit_y_max =
  [%spec_module
  "'auto' | <length>", (module Css_types.Cascading)]

let property__ms_scroll_limit_y_max = Property__ms_scroll_limit_y_max.rule

module Property__ms_scroll_limit_y_min =
  [%spec_module
  "<length>", (module Css_types.Length)]

let property__ms_scroll_limit_y_min = Property__ms_scroll_limit_y_min.rule

module Property__ms_scroll_rails =
  [%spec_module
  "'none' | 'railed'", (module Css_types.Cascading)]

let property__ms_scroll_rails = Property__ms_scroll_rails.rule

module Property__ms_scroll_snap_points_x =
  [%spec_module
  "snapInterval( <length-percentage> , <length-percentage> ) | snapList( [ \
   <length-percentage> ]# )",
  (module Css_types.ScrollSnapPointsX)]

let property__ms_scroll_snap_points_x = Property__ms_scroll_snap_points_x.rule

module Property__ms_scroll_snap_points_y =
  [%spec_module
  "snapInterval( <length-percentage> , <length-percentage> ) | snapList( [ \
   <length-percentage> ]# )",
  (module Css_types.ScrollSnapPointsY)]

let property__ms_scroll_snap_points_y = Property__ms_scroll_snap_points_y.rule

module Property__ms_scroll_snap_type =
  [%spec_module
  "'none' | 'proximity' | 'mandatory'", (module Css_types.Cascading)]

let property__ms_scroll_snap_type = Property__ms_scroll_snap_type.rule

module Property__ms_scroll_snap_x =
  [%spec_module
  "[ 'none' | 'proximity' | 'mandatory' ] [ snapInterval( <length-percentage> \
   , <length-percentage> ) | snapList( [ <length-percentage> ]# ) ]",
  (module Css_types.Cascading)]

let property__ms_scroll_snap_x = Property__ms_scroll_snap_x.rule

module Property__ms_scroll_snap_y =
  [%spec_module
  "[ 'none' | 'proximity' | 'mandatory' ] [ snapInterval( <length-percentage> \
   , <length-percentage> ) | snapList( [ <length-percentage> ]# ) ]",
  (module Css_types.Cascading)]

let property__ms_scroll_snap_y = Property__ms_scroll_snap_y.rule

module Property__ms_scroll_translation =
  [%spec_module
  "'vertical-to-horizontal' | 'none' | 'inherit'", (module Css_types.Cascading)]

let property__ms_scroll_translation = Property__ms_scroll_translation.rule

module Property__ms_scrollbar_3dlight_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_3dlight_color =
  Property__ms_scrollbar_3dlight_color.rule

module Property__ms_scrollbar_arrow_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_arrow_color = Property__ms_scrollbar_arrow_color.rule

module Property__ms_scrollbar_base_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_base_color = Property__ms_scrollbar_base_color.rule

module Property__ms_scrollbar_darkshadow_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_darkshadow_color =
  Property__ms_scrollbar_darkshadow_color.rule

module Property__ms_scrollbar_face_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_face_color = Property__ms_scrollbar_face_color.rule

module Property__ms_scrollbar_highlight_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_highlight_color =
  Property__ms_scrollbar_highlight_color.rule

module Property__ms_scrollbar_shadow_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_shadow_color =
  Property__ms_scrollbar_shadow_color.rule

module Property__ms_scrollbar_track_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property__ms_scrollbar_track_color = Property__ms_scrollbar_track_color.rule

module Property_scrollbar_color =
  [%spec_module
  "'auto' | [ <color> <color> ]", (module Css_types.ScrollbarColor)]

let property_scrollbar_color : property_scrollbar_color Rule.rule =
  Property_scrollbar_color.rule

module Property_scrollbar_width =
  [%spec_module
  "'auto' | 'thin' | 'none'", (module Css_types.ScrollbarWidth)]

let property_scrollbar_width : property_scrollbar_width Rule.rule =
  Property_scrollbar_width.rule

module Property_scrollbar_gutter =
  [%spec_module
  "'auto' | 'stable' && 'both-edges'?", (module Css_types.ScrollbarGutter)]

let property_scrollbar_gutter : property_scrollbar_gutter Rule.rule =
  Property_scrollbar_gutter.rule

module Property_scrollbar_3dlight_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_3dlight_color :
  property_scrollbar_3dlight_color Rule.rule =
  Property_scrollbar_3dlight_color.rule

module Property_scrollbar_arrow_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_arrow_color : property_scrollbar_arrow_color Rule.rule =
  Property_scrollbar_arrow_color.rule

module Property_scrollbar_base_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_base_color : property_scrollbar_base_color Rule.rule =
  Property_scrollbar_base_color.rule

module Property_scrollbar_darkshadow_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_darkshadow_color :
  property_scrollbar_darkshadow_color Rule.rule =
  Property_scrollbar_darkshadow_color.rule

module Property_scrollbar_face_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_face_color : property_scrollbar_face_color Rule.rule =
  Property_scrollbar_face_color.rule

module Property_scrollbar_highlight_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_highlight_color :
  property_scrollbar_highlight_color Rule.rule =
  Property_scrollbar_highlight_color.rule

module Property_scrollbar_shadow_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_shadow_color : property_scrollbar_shadow_color Rule.rule
    =
  Property_scrollbar_shadow_color.rule

module Property_scrollbar_track_color =
  [%spec_module
  "<color>", (module Css_types.Color)]

let property_scrollbar_track_color : property_scrollbar_track_color Rule.rule =
  Property_scrollbar_track_color.rule

module Property_scrollbar_color_legacy =
  [%spec_module
  "<color>", (module Css_types.ScrollbarColorLegacy)]

let property_scrollbar_color_legacy : property_scrollbar_color_legacy Rule.rule
    =
  Property_scrollbar_color_legacy.rule

let entries : (kind * packed_rule) list =
  [
    ( Property "-ms-content-zoom-chaining",
      pack_module (module Property__ms_content_zoom_chaining) );
    ( Property "-ms-content-zoom-limit",
      pack_module (module Property__ms_content_zoom_limit) );
    ( Property "-ms-content-zoom-limit-max",
      pack_module (module Property__ms_content_zoom_limit_max) );
    ( Property "-ms-content-zoom-limit-min",
      pack_module (module Property__ms_content_zoom_limit_min) );
    ( Property "-ms-content-zoom-snap",
      pack_module (module Property__ms_content_zoom_snap) );
    ( Property "-ms-content-zoom-snap-points",
      pack_module (module Property__ms_content_zoom_snap_points) );
    ( Property "-ms-content-zoom-snap-type",
      pack_module (module Property__ms_content_zoom_snap_type) );
    ( Property "-ms-content-zooming",
      pack_module (module Property__ms_content_zooming) );
    ( Property "-ms-scroll-chaining",
      pack_module (module Property__ms_scroll_chaining) );
    Property "-ms-scroll-limit", pack_module (module Property__ms_scroll_limit);
    ( Property "-ms-scroll-limit-x-max",
      pack_module (module Property__ms_scroll_limit_x_max) );
    ( Property "-ms-scroll-limit-x-min",
      pack_module (module Property__ms_scroll_limit_x_min) );
    ( Property "-ms-scroll-limit-y-max",
      pack_module (module Property__ms_scroll_limit_y_max) );
    ( Property "-ms-scroll-limit-y-min",
      pack_module (module Property__ms_scroll_limit_y_min) );
    Property "-ms-scroll-rails", pack_module (module Property__ms_scroll_rails);
    ( Property "-ms-scroll-snap-points-x",
      pack_module (module Property__ms_scroll_snap_points_x) );
    ( Property "-ms-scroll-snap-points-y",
      pack_module (module Property__ms_scroll_snap_points_y) );
    ( Property "-ms-scroll-snap-type",
      pack_module (module Property__ms_scroll_snap_type) );
    ( Property "-ms-scroll-snap-x",
      pack_module (module Property__ms_scroll_snap_x) );
    ( Property "-ms-scroll-snap-y",
      pack_module (module Property__ms_scroll_snap_y) );
    ( Property "-ms-scroll-translation",
      pack_module (module Property__ms_scroll_translation) );
    ( Property "-ms-scrollbar-3dlight-color",
      pack_module (module Property__ms_scrollbar_3dlight_color) );
    ( Property "-ms-scrollbar-arrow-color",
      pack_module (module Property__ms_scrollbar_arrow_color) );
    ( Property "-ms-scrollbar-base-color",
      pack_module (module Property__ms_scrollbar_base_color) );
    ( Property "-ms-scrollbar-darkshadow-color",
      pack_module (module Property__ms_scrollbar_darkshadow_color) );
    ( Property "-ms-scrollbar-face-color",
      pack_module (module Property__ms_scrollbar_face_color) );
    ( Property "-ms-scrollbar-highlight-color",
      pack_module (module Property__ms_scrollbar_highlight_color) );
    ( Property "-ms-scrollbar-shadow-color",
      pack_module (module Property__ms_scrollbar_shadow_color) );
    ( Property "-ms-scrollbar-track-color",
      pack_module (module Property__ms_scrollbar_track_color) );
    Property "scroll-behavior", pack_module (module Property_scroll_behavior);
    ( Property "scroll-initial-target",
      pack_module (module Property_scroll_initial_target) );
    Property "scroll-snap-stop", pack_module (module Property_scroll_snap_stop);
    Property "scroll-margin", pack_module (module Property_scroll_margin);
    ( Property "scroll-margin-block",
      pack_module (module Property_scroll_margin_block) );
    ( Property "scroll-margin-block-end",
      pack_module (module Property_scroll_margin_block_end) );
    ( Property "scroll-margin-block-start",
      pack_module (module Property_scroll_margin_block_start) );
    ( Property "scroll-margin-bottom",
      pack_module (module Property_scroll_margin_bottom) );
    ( Property "scroll-margin-inline",
      pack_module (module Property_scroll_margin_inline) );
    ( Property "scroll-margin-inline-end",
      pack_module (module Property_scroll_margin_inline_end) );
    ( Property "scroll-margin-inline-start",
      pack_module (module Property_scroll_margin_inline_start) );
    ( Property "scroll-margin-left",
      pack_module (module Property_scroll_margin_left) );
    ( Property "scroll-margin-right",
      pack_module (module Property_scroll_margin_right) );
    ( Property "scroll-margin-top",
      pack_module (module Property_scroll_margin_top) );
    ( Property "scroll-marker-group",
      pack_module (module Property_scroll_marker_group) );
    Property "scroll-padding", pack_module (module Property_scroll_padding);
    ( Property "scroll-padding-block",
      pack_module (module Property_scroll_padding_block) );
    ( Property "scroll-padding-block-end",
      pack_module (module Property_scroll_padding_block_end) );
    ( Property "scroll-padding-block-start",
      pack_module (module Property_scroll_padding_block_start) );
    ( Property "scroll-padding-bottom",
      pack_module (module Property_scroll_padding_bottom) );
    ( Property "scroll-padding-inline",
      pack_module (module Property_scroll_padding_inline) );
    ( Property "scroll-padding-inline-end",
      pack_module (module Property_scroll_padding_inline_end) );
    ( Property "scroll-padding-inline-start",
      pack_module (module Property_scroll_padding_inline_start) );
    ( Property "scroll-padding-left",
      pack_module (module Property_scroll_padding_left) );
    ( Property "scroll-padding-right",
      pack_module (module Property_scroll_padding_right) );
    ( Property "scroll-padding-top",
      pack_module (module Property_scroll_padding_top) );
    ( Property "scroll-snap-align",
      pack_module (module Property_scroll_snap_align) );
    ( Property "scroll-snap-coordinate",
      pack_module (module Property_scroll_snap_coordinate) );
    ( Property "scroll-snap-destination",
      pack_module (module Property_scroll_snap_destination) );
    ( Property "scroll-snap-points-x",
      pack_module (module Property_scroll_snap_points_x) );
    ( Property "scroll-snap-points-y",
      pack_module (module Property_scroll_snap_points_y) );
    Property "scroll-snap-type", pack_module (module Property_scroll_snap_type);
    ( Property "scroll-snap-type-x",
      pack_module (module Property_scroll_snap_type_x) );
    ( Property "scroll-snap-type-y",
      pack_module (module Property_scroll_snap_type_y) );
    Property "scroll-start", pack_module (module Property_scroll_start);
    ( Property "scroll-start-block",
      pack_module (module Property_scroll_start_block) );
    ( Property "scroll-start-inline",
      pack_module (module Property_scroll_start_inline) );
    ( Property "scroll-start-target",
      pack_module (module Property_scroll_start_target) );
    ( Property "scroll-start-target-block",
      pack_module (module Property_scroll_start_target_block) );
    ( Property "scroll-start-target-inline",
      pack_module (module Property_scroll_start_target_inline) );
    ( Property "scroll-start-target-x",
      pack_module (module Property_scroll_start_target_x) );
    ( Property "scroll-start-target-y",
      pack_module (module Property_scroll_start_target_y) );
    Property "scroll-start-x", pack_module (module Property_scroll_start_x);
    Property "scroll-start-y", pack_module (module Property_scroll_start_y);
    ( Property "scroll-target-group",
      pack_module (module Property_scroll_target_group) );
    Property "scroll-timeline", pack_module (module Property_scroll_timeline);
    ( Property "scroll-timeline-axis",
      pack_module (module Property_scroll_timeline_axis) );
    ( Property "scroll-timeline-name",
      pack_module (module Property_scroll_timeline_name) );
    Property "scrollbar-width", pack_module (module Property_scrollbar_width);
    ( Property "scrollbar-color-legacy",
      pack_module (module Property_scrollbar_color_legacy) );
    Property "scrollbar-gutter", pack_module (module Property_scrollbar_gutter);
    ( Property "scrollbar-3dlight-color",
      pack_module (module Property_scrollbar_3dlight_color) );
    ( Property "scrollbar-arrow-color",
      pack_module (module Property_scrollbar_arrow_color) );
    ( Property "scrollbar-base-color",
      pack_module (module Property_scrollbar_base_color) );
    Property "scrollbar-color", pack_module (module Property_scrollbar_color);
    ( Property "scrollbar-darkshadow-color",
      pack_module (module Property_scrollbar_darkshadow_color) );
    ( Property "scrollbar-face-color",
      pack_module (module Property_scrollbar_face_color) );
    ( Property "scrollbar-highlight-color",
      pack_module (module Property_scrollbar_highlight_color) );
    ( Property "scrollbar-shadow-color",
      pack_module (module Property_scrollbar_shadow_color) );
    ( Property "scrollbar-track-color",
      pack_module (module Property_scrollbar_track_color) );
  ]
