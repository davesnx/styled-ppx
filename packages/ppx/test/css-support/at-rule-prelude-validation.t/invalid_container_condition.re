let invalid_container_condition = [%css
  {|
  @container (min-width: 400px) or {
    color: red;
  }
|}
];
