/* When the referenced [%css] binding mints multiple atoms (one per
   declaration), `.$(binding)` must fan out into a chain `.a.b.c`. */
let multi = [%css {|
  display: flex;
  color: red;
  margin: 10px;
|}];

module Globals = [%styled.global2
  {|
  body .$(multi) {
    font-weight: bold;
  }
|}
];
