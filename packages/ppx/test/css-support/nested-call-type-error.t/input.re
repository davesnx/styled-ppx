let getColor = (x: int) => CSS.red;

let _styles = [%cx {|
    color: $(getColor("wrong"));
  |}];
