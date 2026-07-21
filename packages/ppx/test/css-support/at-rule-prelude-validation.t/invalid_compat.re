let invalid_compat_value = [%css
  {|
  @media (-webkit-device-pixel-ratio: high) {
    color: red;
  }
|}
];
