module Box = [%styled.div
  (~big) =>
    switch (big) {
    | true => "width: 500px"
    | false => "width: 100%"
    }
];
