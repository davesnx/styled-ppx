let element = ReactDOM.querySelector("#root");

let _css = [%cx2 {| color: #C33; |}];

switch (element) {
| Some(root) =>
  let root = ReactDOM.Client.createRoot(root);
  ReactDOM.Client.render(root, <App />);
| None =>
  Js.Console.error("Failed to start React: couldn't find the #root element")
};
