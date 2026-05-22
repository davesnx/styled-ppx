let _case1 = [%css
  {|
  background-color: red

  &:nth-child(2n) {
    background-color: blue;
  }
|}
];

let _case2 = [%css
  {|
  transition: max-height 400ms ease-in-out 0ms & > * {
    opacity: 0;
    transition-duration: 400ms;
  }
|}
];

let _case3 = [%css
  {|
  margin-bottom: 24px @media (min-width: 1024px) {
    width: 50%;
  }
|}
];

let _case4 = [%css
  {|
  transition: transform 200ms ease-in-out 0ms /* Need to use selectSelf. */
    &.contentAfterOpen {
    transform: translateY(16px);
  }
|}
];

let _case5 = [%css
  {|
  border-bottom: 1px solid black

  &:last-child {
    padding-bottom: 0;
    border-bottom-width: 0;
  }
|}
];

let _case6 = [%css
  {|
  justify-content: space-between @media (min-width: 768px) {
    justify-content: center;
  }
|}
];

let _case7 = [%css
  {|
  width: min-content @media (min-width: 1200px) {
    padding-top: 8px;
  }
|}
];

let _case8 = [%css
  {|
  height: 100% & h4 {
    padding: 0;
  }
|}
];

let _case9 = [%css
  {|
  transition: all 200ms ease 0ms &.sidebarClosed {
    min-width: 0;
    max-width: 0;
    opacity: 0;
    overflow: hidden;
    padding-left: 0;
    padding-right: 0;
  }
|}
];

let _case10 = [%css
  {|
  color: red
  .child {
    color: blue;
  }
|}
];

let _case11 = [%css
  {|
  color: red
  div {
    color: blue;
  }
|}
];

let _case12 = [%css
  {|
  color: red
  #child {
    color: blue;
  }
|}
];

let _case13 = [%css
  {|
  color: red
  svg path {
    fill: blue;
  }
|}
];

let _case14 = borderColor => [%css
  {|
  border-bottom: 1px solid $(borderColor)
  &:last-child {
    padding-bottom: 0;
    border-bottom-width: 0;
  }
|}
];

let _case15 = (marginBottom, wide) => [%css
  {|
  margin-bottom: $(marginBottom) @media $(wide) {
    width: 50%;
  }
|}
];
