let primaryColor = CSS.red;

let buttonStyles = [%cx2
  {|
  background-color: $(primaryColor);
  padding: 10px 20px;
  border: none;
  border-radius: 4px;
  color: white;
  cursor: pointer;
  font-size: 16px;
|}
];

let headerStyles = [%cx2
  {|
  background-color: #333;
  color: white;
  padding: 20px;
  text-align: center;
|}
];

let cardStyles = (~borderColor) => [%cx2
  {|
  border-width: 1px;
  border-style: solid;
  border-color: $(borderColor);
  padding: 15px;
  margin: 10px;
  background: white;
|}
];

let makeThemeStyles = (~primary, ~secondary) => {
  let container = [%cx2
    {|
    background-color: $(primary);
    color: $(secondary);
    padding: 30px;
  |}
  ];

  let title = [%cx2
    {|
    font-size: 24px;
    font-weight: bold;
    margin-bottom: 10px;
  |}
  ];

  (container, title);
};
