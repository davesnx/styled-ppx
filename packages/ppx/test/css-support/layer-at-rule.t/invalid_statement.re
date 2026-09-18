/* Statement-form @layer declares stylesheet-wide layer order; it is
   [%styled.global]-only and must error inside [%css]. */
let invalid = [%css {|
  @layer reset, base;
|}];

let _ = invalid;
