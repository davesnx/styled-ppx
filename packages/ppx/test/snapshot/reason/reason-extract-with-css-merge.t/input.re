let one = [%cx2 {| color: red; display: flex; |}];

let two = [%cx2 {|
  display: block;
  |}];

let three = CSS.merge(one, two);
