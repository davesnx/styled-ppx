let invalid_second_range_operand = [%css
  {|
  @media (400px <= width <= 900) {
    color: red;
  }
|}
];
