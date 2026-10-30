let group = [%css {| display: flex; |}];

let carousel = [%css
  {|
  margin: 10px;
  @media (min-width: 768px) { margin: 20px; }
  & > .$(group) { flex: 0 1 100%; }
|}
];

let _ = (group, carousel);
