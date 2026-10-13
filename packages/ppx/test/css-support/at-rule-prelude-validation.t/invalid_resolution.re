let invalid_resolution_value = [%css
  {|
  @media (resolution: 2px) {
    color: red;
  }
|}
];
