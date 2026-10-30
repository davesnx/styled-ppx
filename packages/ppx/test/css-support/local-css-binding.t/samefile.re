let top = () => {
  let side = [%css {| margin-top: 4px; |}];
  side;
};
let row = [%css {| & .$(top) { color: red; } |}];
