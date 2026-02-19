/* A non exhaustive test suite indeed */

let _chart = [%cx
  {|
  user-select: none;

  .recharts-cartesian-grid-horizontal {
    line {
      :nth-last-child(1), :nth-last-child(2) {
        stroke-opacity: 0;
      }
    }
  }

  .recharts-scatter .recharts-scatter-symbol .recharts-symbols {
    opacity: 0.8;

    :hover {
      opacity: 1;
    }
  }
|}
];
