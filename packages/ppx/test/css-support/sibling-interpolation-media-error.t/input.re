let width = "120px";
let _column = [%css
  {|
  @media (max-width: 768px) {
    & + td {
      width: $(width);
    }
  }
|}
];
