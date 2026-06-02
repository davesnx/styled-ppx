module GlobalStyles = [%styled.global {|
  body {
    font-family: "Arial";
  }
|}]

let _ = GlobalStyles.make ()
