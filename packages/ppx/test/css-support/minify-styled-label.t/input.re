let stack = [%css {| display: flex; padding: 12px; |}];

module Card = [%styled.div {| display: flex; margin: 10px; |}];

module Badge = [%styled.span
  (~size=CSS.px(4)) => {| display: flex; gap: $(size); |}
];
