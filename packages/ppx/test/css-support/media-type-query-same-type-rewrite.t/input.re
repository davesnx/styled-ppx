let screenPair = [%css {|
  @media screen and (max-width: 992px) { color: red; }
  @media screen and (max-width: 480px) { color: blue; }
|}];

let onlyPair = [%css {|
  @media only screen and (max-width: 992px) { font-size: 14px; }
  @media only screen and (max-width: 480px) { font-size: 12px; }
|}];

let notScreenPair = [%css {|
  @media not screen and (max-width: 992px) { width: 1px; }
  @media not screen and (max-width: 480px) { width: 2px; }
|}];

let commaMixedTypes = [%css {|
  @media screen, (min-width: 600px) { height: 1px; }
  @media (min-width: 900px) { height: 2px; }
|}];

let differentTypesPair = [%css {|
  @media screen and (max-width: 992px) { border-width: 1px; }
  @media print and (max-width: 480px) { border-width: 2px; }
|}];

let _ =
  (screenPair, onlyPair, notScreenPair, commaMixedTypes, differentTypesPair);
