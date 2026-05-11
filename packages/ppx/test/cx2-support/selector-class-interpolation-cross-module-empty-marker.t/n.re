/* Two cross-module refs to two different empty markers in the same
   module. Ensures the aggregator handles multiple distinct refs in
   one CU correctly. */
let modal = [%cx2 {|
  display: none;

  &.$(M.isOpen) { display: block; }
  &.$(M.isHovered) { background: rgba(0, 0, 0, 0.1); }
|}];
