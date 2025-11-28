module Display =
  [%spec_module
  "'block' | 'inline' | 'flex' | 'grid' | 'none' | 'contents' | 'flow-root' | \
   'table'",
  (module Css_types.Display : RUNTIME_TYPE)]
