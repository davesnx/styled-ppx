/* Source order between style rules and at-rules is the cascade order.

   The old pipeline partitioned at-rules away from style rules and
   emitted all @media blocks last, so `body { color: blue }` written
   AFTER a media override would lose to it in print. Order (and with it
   the cascade) is now preserved.

   Also covered:
   - a trailing declaration after a nested @media stays after it;
   - `&:hover` inside a hoisted @media resolves instead of shipping
     literal nesting;
   - blockless at-rules (@import) pass through instead of vanishing. */

module Ordered = [%styled.global
  {|
  @import "theme.css";

  @media print {
    body { color: red; }
  }

  body {
    color: blue;
  }

  .card {
    color: green;
    @media print {
      color: black;
    }
    color: gray;
  }

  .link {
    @media print {
      &:hover { color: purple; }
    }
  }
|}
];
