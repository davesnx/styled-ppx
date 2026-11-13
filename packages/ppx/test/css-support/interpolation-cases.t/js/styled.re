let red = CSS.red;

module Static = [%styled.div {| color: $(red); padding: 4px; |}];

module Dynamic = [%styled.div
  (~c, ~w) => {|
  color: $(c);
  width: $(w);
  &:hover { border-color: $(c); }
|}
];

let _ = <Dynamic c=CSS.blue w={CSS.px(10)} />;
