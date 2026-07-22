/* navigation only accepts 'auto' or 'none': any other keyword must be
   rejected at compile time. */

module Broken = [%styled.global
  {|
  @view-transition {
    navigation: sideways;
  }
|}
];
