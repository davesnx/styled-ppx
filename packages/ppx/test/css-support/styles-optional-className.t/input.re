module A = {
  [@react.component]
  let make = (~className=?, ~style=?) =>
    <div ?className ?style styles=[%css "display: flex;"]>
      {React.string("ok")}
    </div>;
};

let () = print_endline(ReactDOM.renderToStaticMarkup(<A />));
let () = print_endline(ReactDOM.renderToStaticMarkup(<A className="base" />));
