let c = CSS.color(`var({js|--color-link|js}));

[%styled.global
  {|
  div {
    background-color: green;
  }

  @media (min-width: 400px) {
    div {
      background-color: red;
    }
  }
|}
];

let stack = [%cx "display: flex; flex-direction: column"];
let stackGap = gap => [%cx "gap: $(gap)"];

module Cositas = [%styled.div
  (~lola=CSS.px(0)) => {|
  display: flex;
  flex-direction: column;
  gap: $(lola);
  height: calc(1px * (2 + 3 / 3));
|}
];

let selectors = [%cx {|
  color: red;

  &:hover {
    color: blue;
  }
|}];

let bounce = [%keyframe
  {|
  40% {
    transform: translate3d(0, -30px, 0);
  }

  70% {
    transform: translate3d(0, -15px, 0);
  }

  90% {
    transform: translate3d(0,-4px,0);
  }
|}
];

let code = [| `custom("Menlo"), `custom("monospace") |];
let lola = `auto;

let clx = [%cx
  {|
  animation-name: $(bounce);
  font-family: $(code);
  cursor: $(lola);
|}
];

let post = [%cx {|
  border: 2px solid;
  container-type: inline-size;
|}];

let card = [%cx
  {|
  margin: 10px;
  border: 2px dotted;
  font-size: 1.5em;
  |}
];

let container = [%cx
  {|
  @container (width < 600px) {
    width: 50%;
    background-color: gray;
    font-size: 1em;

    .my-content {
      font-weight: bold;
    }
  }
|}
];

module App = {
  [@react.component]
  let make = () =>
    <>
      <div className=post>
        <div className={card ++ " " ++ container}>
          <h2> {React.string("Card title")} </h2>
          <p className="my-content"> {React.string("Card content")} </p>
        </div>
      </div>
      <Cositas as_="section" lola={CSS.px(10)}>
        <div className=clx> {React.string("code everywhere!")} </div>
        <div className=selectors> {React.string("Red text")} </div>
      </Cositas>
    </>;
};

let color = `hex("333");

let _ = [%css
  {|
    background-image:
      repeating-linear-gradient(
        45deg,
        $(color) 0px,
        $(color) 4px,
        $(color) 5px,
        $(color) 9px
      )
    |}
];

type calc_value = CSS.Types.Length.calc_value;

let rec modify =
        (
          fn_float,
          fn_int,
          fn_calc: calc_value => calc_value,
          value: CSS.length,
        )
        : CSS.length =>
  switch (value) {
  | `calc(c) => `calc(fn_calc(c))
  | `cqmax(f) => `cqmax(fn_float(f))
  | `cqh(f) => `cqmax(fn_float(f))
  | `cqw(f) => `cqmax(fn_float(f))
  | `cqmin(f) => `cqmax(fn_float(f))
  | `cqb(f) => `cqmax(fn_float(f))
  | `min(m) => `min(Array.map(modify(fn_float, fn_int, fn_calc), m))
  | `max(m) => `max(Array.map(modify(fn_float, fn_int, fn_calc), m))
  | `cqi(f) => `cqi(fn_float(f))
  | `ch(f) => `ch(fn_float(f))
  | `cm(f) => `cm(fn_float(f))
  | `em(f) => `em(fn_float(f))
  | `ex(f) => `ex(fn_float(f))
  | `inch(f) => `inch(fn_float(f))
  | `mm(f) => `mm(fn_float(f))
  | `pc(f) => `pc(fn_float(f))
  | `percent(f) => `percent(fn_float(f))
  | `pt(f) => `pt(fn_int(f))
  | `px(i) => `px(fn_int(i))
  | `pxFloat(i) => `pxFloat(fn_float(i))
  | `rem(f) => `rem(fn_float(f))
  | `vh(f) => `vh(fn_float(f))
  | `vmax(f) => `vmax(fn_float(f))
  | `vmin(f) => `vmin(fn_float(f))
  | `vw(f) => `vw(fn_float(f))
  | `zero => `zero
  | #CSS.Types.Var.t as v => v
  };

let negate_in_calc = (v: calc_value): calc_value =>
  `calc(`mult((v, `num(-1.))));
let half_in_calc = (v: calc_value): calc_value => `calc(`div((v, 2.)));

let negative = value => modify((~-.), (~-), negate_in_calc, value);
let half = value => modify(x => x /. 2., x => x / 2, half_in_calc, value);
