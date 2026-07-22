let invalid_container_value = [%css
  {|
  @container (block-size: 10) {
    color: red;
  }
|}
];
