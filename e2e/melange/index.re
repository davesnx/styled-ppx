let element = ReactDOM.querySelector("#root");
switch (element) {
| Some(root) =>
  let root = ReactDOM.Client.createRoot(root);
  ReactDOM.Client.render(root, <Ui.App />);
| None =>
  Js.Console.error("Failed to start React: couldn't find the #root element")
};
