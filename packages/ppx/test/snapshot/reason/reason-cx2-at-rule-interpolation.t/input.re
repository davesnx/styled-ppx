let x = bp => [%cx2 {|
  @media (max-width: $(bp)) {
    color: red;
  }
|}];
