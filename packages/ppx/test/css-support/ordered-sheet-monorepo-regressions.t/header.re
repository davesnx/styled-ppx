let tableCell = [%css {|
  @media (max-width: 1279px) { padding-right: 16px; }
|}];

let header = [%css {|
  padding: 32px 40px 0;
  @media (min-width: 768px) and (max-width: 1279px) { padding: 16px 24px 0; }
|}];

let headerWithBanner = [%css {|
  padding: 24px 40px 0;
  @media (max-width: 1279px) { padding: 24px 16px 0; }
|}];

let _ = (tableCell, CSS.merge(header, headerWithBanner));
