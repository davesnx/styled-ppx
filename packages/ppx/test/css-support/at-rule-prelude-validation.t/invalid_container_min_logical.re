let invalid_container_min_logical = [%css
  {|
  @container (min-inline-size: 10) {
    color: red;
  }
|}
];
