open TypedGlamor

let test = [%style {typed|
  border-top-right-radius: 1px;
  border-top-right-radius: 1px 2px;
  border-top-left-radius: 1px;
  border-top-left-radius: 1px 2px;
  border-bottom-right-radius: 1px;
  border-bottom-right-radius: 1px 2px;
  border-bottom-left-radius: 1px;
  border-bottom-left-radius: 1px 2px;

  background-position: initial;
  background-position: 1px 2px;

  transform-origin: initial;
  transform-origin: 1px 2px;

  flex: 1.0 2.0 100px;

  outline: solid 100px;
  border: red dotted;

  box-shadow: 0 1px 5px rgba(0, 0, 0, 0.3);
  box-shadow: 0 1px 5px rgba(0, 0, 0, 0.3), inset 0 1px 10px rgba(255, 255, 255, 0.5);
|typed}]

let equal = [
  borderTopRightRadius (px 1);
  borderTopRightRadius2 ~v:(px 1) ~h:(px 2);
  borderTopLeftRadius (px 1);
  borderTopLeftRadius2 ~v:(px 1) ~h:(px 2);
  borderBottomRightRadius (px 1);
  borderBottomRightRadius2 ~v:(px 1) ~h:(px 2);
  borderBottomLeftRadius (px 1);
  borderBottomLeftRadius2 ~v:(px 1) ~h:(px 2);

  backgroundPosition initial;
  backgroundPosition2 ~h:(px 1) ~v:(px 2);

  transformOrigin initial;
  transformOrigin2 ~h:(px 1) ~v:(px 2);

  flex3 ~grow:1.0 ~shrink:2.0 (px 100);

  outline2 ~width:(px 100) solid;
  border2 ~color:red dotted;

  boxShadows([
      shadow ~x:zero ~y:(px 1) ~blur:(px 5) (rgba 0 0 0 0.3);
    ]);
  boxShadows([
      shadow ~x:zero ~y:(px 1) ~blur:(px 5) (rgba 0 0 0 0.3);
      shadow ~x:zero ~y:(px 1) ~blur:(px 10) ~inset:true (rgba 255 255 255 0.5);
    ]);
]

let _ = assert (test = equal)
