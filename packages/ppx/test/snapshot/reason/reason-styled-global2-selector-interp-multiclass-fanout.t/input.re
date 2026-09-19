/* When the referenced [%css] binding mints multiple atoms (one per
   declaration), `.$(binding)` still resolves to ONE class - the
   binding's identity - regardless of how many atoms it minted. */
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
