let _test = [%css
  {|
  .\31 a { color: red; }
  .-\31 a { color: red; }
  #\31 a { color: red; }
  .a\.b { color: red; }
  .foo\:bar { color: red; }
  .a\/b { color: red; }
  .foo\ bar { color: red; }
  .héllo { color: red; }
  .foo:not(.a\.b) { color: red; }
|}
];

[%css {|--custom\ prop: red;|}];
