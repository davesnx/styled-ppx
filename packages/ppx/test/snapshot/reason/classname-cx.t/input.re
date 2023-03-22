let className = [%cx "display: block;"];
let classNameWithMultiLine = [%cx {| display: block; |}];
let classNameWithArray = [%cx [|cssProperty|]];
let cssRule = [%css "color: blue;"];
let classNameWithCss = [%cx [|cssRule, [%css "background-color: green;"]|]];
