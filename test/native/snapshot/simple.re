[%styled.global {|
  html, body {
    margin: 0;
  }
|}];

/* Shoudn't break other ppxs with similar APIs */
module StateLenses = [%lenses
  type state = {
    email: string,
    age: int,
  }
];

module Component = [%styled "display: block"];
module Component = [%styled.section
  {|
  display: flex;
  justify-content: center;
|}
];

let var = "#333333";
module Component = [%styled {j|
  color: $var;
  display: block;
|j}];

// TODO:
// module Component = [%styled
//   (~space: string) => {j|
//   margin: 10px $(space)px;
// |j}
// ];

[%css "display: block"];

module Component = [%styled
  (~var) => {j|
     color: $var;
     display: block;
   |j}
];

module Component = [%styled];
module Component = [%styled ""];

module NestedSelectors = [%styled.body
  {|
  display: flex;
  justify-content: center;
  & > a {
    background-color: green;
  }
  &:nth-child(even) {
    background-color: red;
  }
  & > div:nth-child(3n+1) {
    background-color: red;
  }

  & > div {
    padding: 20px;
  }
  & > div:nth-child(3n+1) {
    background-color: green;
  }
  & > div:nth-child(even) {
    background-color: green;
  }

  &::active {
    background-color: blue;
  }
  &:hover {
    background-color: pink;
  }
|}
];
