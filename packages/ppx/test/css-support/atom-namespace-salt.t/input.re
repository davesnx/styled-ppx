let base = [%css {| margin: 10px; |}];

let withMedia = [%css {|
  margin: 10px;
  @media (min-width: 768px) {
    margin: 20px;
  }
|}];

let _ = (base, withMedia);
