[%styled.global] flattens CSS-nesting at PPX time, lowering nested
rules to flat descendant selectors. Multi-selector preludes
Cartesian-product correctly; pseudo-classes splice onto the parent
without an intervening space.

  $ standalone --impl input.ml -o output.ml
  $ cat output.ml
  [@@@css "body{color:red;}"]
  [@@@css "body .child{color:blue;}"]
  [@@@css "body .child{color:red;}"]
  [@@@css "html .child{color:red;}"]
  [@@@css ".a .c{color:green;}"]
  [@@@css ".a .d{color:green;}"]
  [@@@css ".b .c{color:green;}"]
  [@@@css ".b .d{color:green;}"]
  [@@@css ".button{color:black;}"]
  [@@@css ".button:hover{color:white;}"]
  module Single =
    struct
      let to_string () = ""
      let to_buffer buf = Buffer.add_string buf (to_string ())
      let makeProps ?key () = ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  module Multi =
    struct
      let to_string () = ""
      let to_buffer buf = Buffer.add_string buf (to_string ())
      let makeProps ?key () = ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  module Cartesian =
    struct
      let to_string () = ""
      let to_buffer buf = Buffer.add_string buf (to_string ())
      let makeProps ?key () = ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
  module PseudoJoin =
    struct
      let to_string () = ""
      let to_buffer buf = Buffer.add_string buf (to_string ())
      let makeProps ?key () = ()[@@warning "-27-32"]
      let make _props = CSS.global_style_tag (to_string ())
    end
