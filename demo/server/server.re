let classname = [%cx2
  {|
    display: flex;
    flex-direction: column;
    gap: 10px;
  |}
];

print_endline("\n\n");
print_endline(ReactDOM.renderToStaticMarkup(<App />));

print_endline("\nStyle tag:");
print_endline(ReactDOM.renderToStaticMarkup(<CSS.style_tag />));
