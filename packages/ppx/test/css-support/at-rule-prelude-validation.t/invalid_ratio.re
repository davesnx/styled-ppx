let invalid_ratio_value = [%css
  {|
  @media (device-aspect-ratio: 16px) {
    color: red;
  }
|}
];
