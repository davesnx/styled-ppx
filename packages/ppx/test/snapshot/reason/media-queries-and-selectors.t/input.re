module SelectorsMediaQueries = [%styled.div
  {j|
  @media (min-width: 600px) {
    background: blue;
  }
  &:hover {
    background: green;
  }
  & > p { color: pink; font-size: 24px; }
|j}
];
