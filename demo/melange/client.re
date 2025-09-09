let element = ReactDOM.querySelector("#root");

let only_one = [%cx2 {|
  color: transparent;
|}];

let cositas = <div styles=only_one />;

switch (element) {
| Some(root) =>
  let root = ReactDOM.Client.createRoot(root);
  ReactDOM.Client.render(root, <App />);
| None =>
  Js.Console.error("Failed to start React: couldn't find the #root element")
};
