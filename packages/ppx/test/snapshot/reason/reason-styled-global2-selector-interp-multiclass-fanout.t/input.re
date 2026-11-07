/* When the referenced [%css] binding mints multiple atoms (one per
   declaration), `.$(binding)` must resolve to its binding id alone. */
let multi = [%css {|
  display: flex;
  color: red;
  margin: 10px;
|}];

module Globals = [%styled.global
  {|
  body .$(multi) {
    font-weight: bold;
  }
|}
];
