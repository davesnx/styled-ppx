/* N references M.marker and M.card from a [%styled.global] block.
   Both selector references compile to NUL-delimited sentinels in the
   extracted [@@@css] strings; the aggregator resolves them against
   the index it builds from M.ml. */
module Globals = [%styled.global {|
  body .$(M.marker) {
    color: red;
  }

  .$(M.card):hover {
    cursor: pointer;
  }
|}];
