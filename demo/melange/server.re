module AppContainer = {
  [@react.component]
  let make = () =>
    <div
      id="app-container"
      styles=[%css "display: flex; flex-direction: column; flex: 1;"]>
      <div> <App /> </div>
    </div>;
};

print_endline("\n\n");
print_endline(ReactDOM.renderToStaticMarkup(<AppContainer />));
