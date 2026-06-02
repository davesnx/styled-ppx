module A = {
  [@react.component]
  let make = () =>
    <div styles=[%css "display: flex; flex-direction: column; flex: 1;"]>
      {React.string("ok")}
    </div>;
};

let _ = ReactDOM.renderToStaticMarkup(<A />);
