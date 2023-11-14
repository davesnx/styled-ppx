let element = ReactDOM.querySelector("#root");
switch (element) {
| Some(root) => ReactDOM.render(<Ui.App />, root)
| None =>
  Js.Console.error("Failed to start React: couldn't find the #root element")
};
