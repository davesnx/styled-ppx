(* @font-face under [%css] used to be atomized per-descriptor, emitting
   one @font-face per declaration — each missing required descriptors, so
   the font never loaded. It now errors like the runtime path. *)
let ff = [%css "@font-face { font-family: Foo; src: url(/foo.woff2); }"]
