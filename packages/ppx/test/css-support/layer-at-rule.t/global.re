/* [%styled.global] behavior for @layer is unchanged by issue #589:
   the statement form passes through verbatim (the aggregator hoists it),
   and the block form is flattened structurally. */
module Layers = [%styled.global
  {|
  @layer reset, base, components;

  @layer base {
    body {
      margin: 0;
    }

    .card {
      color: red;

      &:hover {
        color: blue;
      }
    }
  }
|}
];

let _ = Layers.make;
