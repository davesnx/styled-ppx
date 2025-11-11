let element = ReactDOM.querySelector("#root");

let x = [%cx2 {| object-position: inherit; |}];

switch (element) {
| Some(root) =>
  let root = ReactDOM.Client.createRoot(root);
  ReactDOM.Client.render(root, <App />);
| None =>
  Js.Console.error("Failed to start React: couldn't find the #root element")
};
