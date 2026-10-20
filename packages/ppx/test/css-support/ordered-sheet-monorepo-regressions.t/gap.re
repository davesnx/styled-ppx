let narrowGap = [%css {| @media (max-width: 767px) { gap: 16px; } |}];

let container = [%css {|
  grid-gap: 40px;
  @media (max-width: 767px) { gap: 16px; }
|}];

let _ = (narrowGap, container);
