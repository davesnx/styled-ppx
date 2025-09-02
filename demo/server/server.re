module App = {
  let classname = [%cx2
    {|
    display: flex;
    flex-direction: column;
    gap: 10px;
  |}
  ];

  [@react.component]
  let make = () => {
    <div className={classname.className}>
      <h1> {React.string("Hello, world!")} </h1>
    </div>;
  };
};

print_endline("\n\n");
print_endline(ReactDOM.renderToStaticMarkup(<App />));

print_endline("\nStyle tag:");
print_endline(ReactDOM.renderToStaticMarkup(<CSS.style_tag />));
