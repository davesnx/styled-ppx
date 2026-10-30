/* MobileMenu_Css.ml: plain min-width atom, then a min+max range for the
   same property, same lower bound - tied on at-rule rank and pseudo rank
   alike (both plain @media, no pseudo), so DEFINITION ORDER decides: the
   later-defined rule sorts last and wins. */
let toggleButton = [%css {|
  @media (min-width: 768px) { display: none; }
|}];

let toggleButtonShowAtTablet = [%css {|
  @media (min-width: 768px) and (max-width: 1279px) { display: block; }
|}];

/* Header_Css.ml (Header.re:86-90): a min+max range, then a plain
   max-width atom for the same property - same tie, same rule.
   Interpolated (both declarations share one $(pad) path), so both rules
   are _in_ bundles, not _a_ atoms - stable order sorts a bundle exactly
   like a plain atom, since it only ever looks at declaration order, never
   the class prefix. */
let header = (~pad) => [%css {|
  @media (min-width: 768px) and (max-width: 1279px) { padding-top: $(pad); padding-left: $(pad); }
|}];

let headerWithBanner = (~pad) => [%css {|
  @media (max-width: 1279px) { padding-top: $(pad); padding-left: $(pad); }
|}];

/* Discoverable_Css.ml (Discoverable.re:261): the SAME range-then-max-width
   shape as header, plain _a_ atoms this time - confirms the bundle result
   above isn't an artifact of bundling. praiseViewportMobile (a THIRD,
   narrower max-width atom for the SAME property) is declared between
   praiseViewport and praiseViewportExpanded, checking that
   praiseViewportExpanded - the LAST-defined of the three - still sorts
   last and wins against BOTH earlier rules, not just the one declared
   immediately before it. */
let praiseViewport = [%css {|
  @media (min-width: 768px) and (max-width: 1279px) { max-height: 1200px; }
|}];

let praiseViewportMobile = [%css {|
  @media (max-width: 767px) { max-height: 2000px; }
|}];

let praiseViewportExpanded = [%css {|
  @media (max-width: 1279px) { max-height: 10000px; }
|}];

let _ = (toggleButton, toggleButtonShowAtTablet, header, headerWithBanner, praiseViewport, praiseViewportMobile, praiseViewportExpanded);
