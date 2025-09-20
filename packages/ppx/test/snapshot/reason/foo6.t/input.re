let _ = [%cx2
  {|
  display: flex;
  .lola { display: flex; }
  @media (max-width: 100px) { .lola { display: none; } }
  |}
];
