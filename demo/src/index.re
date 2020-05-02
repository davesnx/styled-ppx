module App = [%styled.div (~background) => {j|
  position: absolute;
  top: 0;
  left: 0;
  bottom: 0;
  right: 0;

  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;

  background-color: $background;

  cursor: pointer;
|j}];

module Link = [%styled.div {|
  color: #FFFFFF;
  font-size: 36px;
  margin-top: 16px;
|}];

let space = "10px";

module Component = [%styled.div {j|
  border-radius: 20px;
|j}];

let styles = Emotion.(
  css([
    gridTemplateColumns(
      list(
        [
          repeat(
            autoFill,
            [
              minmax(
                px(200), fr(1.0)
              )
            ]
          )
        ]
      ),
    ),
  ])
);

ReactDOMRe.renderToElementWithId(
  <App onClick={Js.log} background="#443434">
    <Component>
      {React.string("Demo of...")}
    </Component>
    <Link href="https://github.com/davesnx/styled-ppx">
      {React.string("styled-ppx")}
    </Link>
  </App>,
  "app"
);
