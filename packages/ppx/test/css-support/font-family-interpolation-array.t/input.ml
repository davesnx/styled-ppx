module FontFamily = struct
  module Common = struct
    type t = CSS.Types.FontFamilyName.t array

    let base : t = [| `quoted "Helvetica"; `quoted "Arial"; `sans_serif |]
    let default : t = Array.append [| `quoted "Inter" |] base
  end
end

module GlobalStyles = [%styled.global {|
  body {
    font-family: $(FontFamily.Common.default);
  }
|}]
