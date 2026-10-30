let mediaFirst = [%css {|
  @media (max-width: 600px) { color: pink; }
  color: black;
|}];

let familySpansMedia = [%css {|
  padding: 8px;
  @media (min-width: 768px) { padding: 16px; }
  padding-top: 0;
|}];

let card = c => [%css {|
  color: $(c);
  &:hover { color: red; }
  &:focus { color: $(c); }
|}];

let nested = [%css {|
  &:hover {
    @media (max-width: 600px) { margin: 4px; }
    margin: 8px;
  }
|}];

let _ = (mediaFirst, familySpansMedia, card, nested);
