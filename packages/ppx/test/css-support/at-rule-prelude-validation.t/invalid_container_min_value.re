let invalid_container_min_value = [%css
  {|
  @container (min-width: portrait) {
    color: red;
  }
|}
];
