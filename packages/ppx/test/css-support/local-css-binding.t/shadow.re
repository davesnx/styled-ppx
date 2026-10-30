let side = [%css {| padding-top: 1px; |}];
let card = () => {
  let side = [%css {| margin-top: 4px; |}];
  let all = [%css {| margin: 0; |}];
  let plain = side;
  (all +++ side, CSS.merge(all, plain));
};
