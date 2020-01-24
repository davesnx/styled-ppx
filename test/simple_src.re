let styledComponentInline = [%styled "display: block;"];

let styledComponentMultiline = [%styled {|
  display: block;
|}];

let styledComponentWithProps = [%re_styled_ppx
  (~color) => {
    {j|
      display: block;
      color: $color;
    |j};
  }
];
