let x = bp => [%css {|
  @media (max-width: $(bp)) {
    color: red;
  }
|}];
