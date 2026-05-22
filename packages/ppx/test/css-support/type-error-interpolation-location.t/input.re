let cosas = `bold;

[%css
  {|
    width: fit-content;
    grid-template-columns: fit-content(20px) fit-content(10%);
  |}
];

[%css {|
    text-decoration: $(cosas);
  |}];
