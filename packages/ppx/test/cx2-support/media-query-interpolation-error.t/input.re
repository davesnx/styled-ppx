let query = "(max-width: 768px)";
let _responsive = [%cx2
  {|
  display: flex;
  @media $(query) {
    display: block;
  }
|}
];
