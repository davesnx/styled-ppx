let x = [%css {| color: red; |}];
let y = [%css {| color: blue; |}];

let card = [%css {| & .$(x) { margin: 0; } |}];
let _ = CSS.merge(x, y);

let byParam = x => CSS.merge(x, y);
let byLet = () => {
  let x = y;
  CSS.merge(x, y);
};
let byCase = v =>
  switch (v) {
  | Some(x) => CSS.merge(x, y)
  | None => y
  };
let otherParam = z => (z, [%css {| & .$(x) { padding: 0; } |}], CSS.merge(x, y));
let _ = (card, byParam, byLet, byCase, otherParam);
