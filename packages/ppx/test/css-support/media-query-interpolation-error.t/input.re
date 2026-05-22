let query = "(max-width: 768px)";
let _responsive = [%css
  {|
  display: flex;
  @media $(query) {
    display: block;
  }
|}
];
