/* A statement-form conditional group rule is invalid CSS that browsers
   silently drop; [%styled.global] must reject it like [%css] does. */
module Broken = [%styled.global
  {|
  @media (min-width: 100px);
  .a { color: red; }
|}
];
