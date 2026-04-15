open Types
open Support
open Shared

let entries : (kind * packed_rule) list =
  [
    Media_query "media-feature", pack_module (module Media_feature);
    Media_query "media-in-parens", pack_module (module Media_in_parens);
    Media_query "media-or", pack_module (module Media_or);
    Media_query "media-and", pack_module (module Media_and);
    Media_query "media-not", pack_module (module Media_not);
    ( Media_query "media-condition-without-or",
      pack_module (module Media_condition_without_or) );
    Media_query "media-condition", pack_module (module Media_condition);
    Media_query "media-query", pack_module (module Media_query);
    Media_query "media-query-list", pack_module (module Media_query_list);
  ]
