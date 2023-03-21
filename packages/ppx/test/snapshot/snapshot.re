module Link = [%styled.a (~size=`Small) => [|
  [%css "color: #1A202C;"],
  [%css "margin-bottom: 1rem;"],
  switch (size) {
  | `Small  => [%css "font-size: 1.8rem;"]
  | `Medium => [%css "font-size: 2.2rem;"]
  | `Large  => [%css "font-size: 2.4rem;"]
  }
|]];
