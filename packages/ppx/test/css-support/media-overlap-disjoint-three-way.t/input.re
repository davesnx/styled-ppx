let block = [%css {|
  margin: 4px;
  @media (min-width: 768px) and (max-width: 1279px) { margin: 8px; }
  @media (min-width: 1280px) { margin: 16px; }
|}];

let _ = block;
