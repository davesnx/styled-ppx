open Css
let test = [%style {|
  padding: 1px 2px 3px 4px;
  padding: 1px 2px 3px;
  padding: 1px 2px;
  padding: 1px;
|}]

let equal = [
  padding4 ~top:(px 1) ~right:(px 2) ~bottom:(px 3) ~left:(px 4);
  padding3 ~top:(px 1) ~h:(px 2) ~bottom:(px 3);
  padding2 ~v:(px 1) ~h:(px 2);
  padding (px 1);
]
let _ = assert (test = equal)
