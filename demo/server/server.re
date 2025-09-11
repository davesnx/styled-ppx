let _css2 = [%cx {|
  color: red;
  padding: 10px;
|}];

let classname = [%cx2
  {|
    display: flex;
    flex-direction: column;
    gap: 10px;
  |}
];

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
