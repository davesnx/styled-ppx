let getColor = (x: int) => CSS.red;

let _styles = [%css {|
    color: $(getColor("wrong"));
  |}];
