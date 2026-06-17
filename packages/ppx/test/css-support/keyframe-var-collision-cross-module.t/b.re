let h0 = `px(0);
let h1 = `px(100);
let grow = [%keyframe {| 0% { height: $(h0); } 100% { height: $(h1); } |}];
let box = [%css {| animation-name: $(grow); padding: 8px; |}];
