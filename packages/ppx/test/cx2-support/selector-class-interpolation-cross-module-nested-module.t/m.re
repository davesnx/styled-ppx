/* Nested submodule: cross-module ref `M.Css.marker` must traverse the
   nested-module structure when the aggregator builds its index. */
module Css = {
  let marker = [%cx2 {||}];
};
