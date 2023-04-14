let stilos =
  [%cx
    {|
  box-shadow: inset 10px 10px 0 0 #ff0000, 10px 10px 0 0 #ff0000;

  &:before {
    content: " ";
    position: absolute;
    top: -1px;
    width: 30px;
    height: 20px;
    background: blue;
  }
|}]
