let tableRowProgress = [%cx
  {|
  background-image: linear-gradient(180deg, black 50%, white 50%);
|}
];

[%styled.global
  {|
  body {
    font-size: 1em;
    -webkit-font-smoothing: antialiased;
    font-family:
      -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
    color: white;
    background-color: hsla(165, 80%, 15%, 0.03);
  }
|}
];

[%styled.global
  {|
  html, body, #root, .class {
    box-sizing: border-box;
  }
|}
];

module Link = [%styled.a {|
  font-size: 36px;
  margin-top: 16px;
|}];

module Input = [%styled.input "padding: 30px"];

[@send] external focus: Dom.element => unit = "focus";

module TextInput = {
  [@react.component]
  let make = () => {
    let textInput = React.useRef(Js.Nullable.null);
    let buttonInput = React.useRef(Js.Nullable.null);

    let focusInput = () =>
      switch (textInput.current->Js.Nullable.toOption) {
      | Some(dom) => dom->focus
      | None => ()
      };

    let onClick = _ => {
      Js.log(textInput);
      Js.log(buttonInput);
      focusInput();
    };

    <div>
      <Input type_="text" innerRef={ReactDOM.Ref.domRef(textInput)} />
      <input
        type_="button"
        ref={ReactDOM.Ref.domRef(buttonInput)}
        value="Focus the text input"
        onClick
      />
    </div>;
  };
};

module Component = [%styled.div
  {j|
  background-color: red;
  border-radius: 20px;
  box-sizing: border-box;

  @media (min-width: 600px) {
    background: blue;
  }

  &:hover {
    background: green;
  }

  & > p { color: pink; font-size: 24px; }
|j}
];

let stilos = [%cx
  "box-shadow: inset 10px 10px 0 0 #ff0000, 10px 10px 0 0 #ff0000"
];

let styles =
  CssJs.style(. [|
    CssJs.label("ComponentName"),
    CssJs.display(`block),
    [%css "flex-direction: row"],
  |]);

let inlineStyles: ReactDOM.Style.t =
  ReactDOM.Style.make(~color="#444444", ~fontSize="68px", ());

module Theme = {
  type kind =
    | Main
    | Ghost;
  let button = variant => {
    switch (variant) {
    | Main => `hex("333")
    | Ghost => `hex("000")
    };
  };
};

module Sequence = [%styled.button
  (~size, ~color) => {
    let buttonColor = Theme.button(color);

    [|
      [%css "width: $(size)"],
      [%css "color: $(buttonColor)"],
      [%css "display: block;"],
      [%css "width: 100%;"],
    |];
  }
];

module App = {
  [@react.component]
  let make = () => {
    <div className=Camel.stilos>
      <div className=styles>
        <div onClick=Js.log style=inlineStyles>
          <TextInput />
          <Component> {"test.." |> React.string} </Component>
          <Component> <p> {"Demo of..." |> React.string} </p> </Component>
          <Link href="https://github.com/davesnx/styled-ppx">
            {"styled-ppx" |> React.string}
          </Link>
        </div>
      </div>
    </div>;
  };
};

switch (ReactDOM.querySelector("#app")) {
| Some(el) => ReactDOM.render(<App />, el)
| None => ()
};
