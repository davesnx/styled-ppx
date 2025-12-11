let element = ReactDOM.querySelector("#root");

let boo =
  CSS.boxShadow(
    CSS.Shadow.box(
      ~x=`zero,
      ~y=`zero,
      ~blur=`zero,
      ~spread=`pxFloat(4.),
      ~inset=false,
      CSS.red,
    ),
  );

switch (element) {
| Some(root) =>
  let root = ReactDOM.Client.createRoot(root);
  ReactDOM.Client.render(root, <App />);
| None =>
  Js.Console.error("Failed to start React: couldn't find the #root element")
};
