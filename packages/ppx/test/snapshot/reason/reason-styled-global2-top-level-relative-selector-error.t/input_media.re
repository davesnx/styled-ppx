module BrokenInMedia = [%styled.global
  {|
  @media print {
    > .a {
      color: red;
    }
  }
|}
];
