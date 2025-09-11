let css = main => [%cx2
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: fley;
|}
];

let classname = [%cx2
  {|
    display: flex;
    flex-direction: column;
    gap: 10px;
  |}
];

<div styles={css(CSS.red)} />;

print_endline("\n");
print_endline(
  ReactDOM.renderToStaticMarkup(
    <main styles=classname> <div styles=[%cx2 "color: red"] /> </main>,
  ),
);

print_endline("\n");
print_endline(ReactDOM.renderToStaticMarkup(<App />));

print_endline("\nStyle tag:");
print_endline(ReactDOM.renderToStaticMarkup(<CSS.style_tag />));
