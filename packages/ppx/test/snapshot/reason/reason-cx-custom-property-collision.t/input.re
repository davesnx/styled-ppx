/* Two independently-owned [%css] expressions can reuse the same local
   interpolation name with different runtime values. Their extracted custom
   properties must not collide when callers merge the resulting styles. */

let common = backgroundColor => [%css
  {|
  background-color: $(backgroundColor);
|}
];

let clickable = backgroundColor => [%css
  {|
  &:hover {
    background-color: $(backgroundColor);
  }
|}
];
