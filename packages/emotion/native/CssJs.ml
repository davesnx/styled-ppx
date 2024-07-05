include Properties
include Alias
include Colors
include Rule
include Emotion

(* let fontFace ~fontFamily ~src ?fontStyle ?fontWeight ?fontDisplay ?sizeAdjust ()
     =
   let fontFace =
     Properties.fontFace_to_string ~fontFamily ~src ?fontStyle ?fontWeight
       ?fontDisplay ?sizeAdjust ()
   in
   Emotion.injectRaw fontFace;
   fontFamily *)
