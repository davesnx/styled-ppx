let invalid_keyword_value = [%css
  {|
  @media (overflow-block: banana) {
    color: red;
  }
|}
];
