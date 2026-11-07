let now_ms () = Sys.time () *. 1000.
let trim = String.trim
let merge = Css_merge.merge
let cached_merge = Css_merge_cache.merge
