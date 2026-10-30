let f = () => {
  let a = [%css {| color: red; |}];
  a;
};

let g = () => {
  let a = [%css {| color: red; |}];
  a;
};

let _ = (f, g);
