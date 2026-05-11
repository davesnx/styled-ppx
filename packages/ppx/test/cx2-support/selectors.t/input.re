/* A non exhaustive test suite indeed.

   Bare leading pseudo selectors (`:hover`, `:nth-last-child`) are
   rejected by the PPX (see `bare-pseudo-class-error.t`); each one is
   written `&:hover` here to stay compound, which matches the original
   intent of styling the element itself when matching the pseudo. */

let _chart = [%cx2
  {|
  user-select: none;

  .recharts-cartesian-grid-horizontal {
    line {
      &:nth-last-child(1), &:nth-last-child(2) {
        stroke-opacity: 0;
      }
    }
  }

  .recharts-scatter .recharts-scatter-symbol .recharts-symbols {
    opacity: 0.8;

    &:hover {
      opacity: 1;
    }
  }
|}
];
