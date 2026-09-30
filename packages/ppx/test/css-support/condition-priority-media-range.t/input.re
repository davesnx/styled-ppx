/* Core regression (MobileMenu_Css.ml): plain min-width atom vs a min+max
   range, same lower bound - both min-kind, tied, definition order decides. */
let toggleButton = [%css {|
  @media (min-width: 768px) { display: none; }
|}];

let toggleButtonShowAtTablet = [%css {|
  @media (min-width: 768px) and (max-width: 1279px) { display: block; }
|}];

/* [600,inf) vs [900,inf): min-width only, ascending. */
let minSix = [%css {|
  @media (min-width: 600px) { width: 50%; }
|}];

let minNine = [%css {|
  @media (min-width: 900px) { width: 33%; }
|}];

/* (-inf,992] vs (-inf,480]: max-width only, descending. */
let maxNineNineTwo = [%css {|
  @media (max-width: 992px) { height: 10px; }
|}];

let maxFourEighty = [%css {|
  @media (max-width: 480px) { height: 20px; }
|}];

/* [0,767] vs [768,1279]: two ranges, different lower bounds. */
let rangeLow = [%css {|
  @media (min-width: 0px) and (max-width: 767px) { color: red; }
|}];

let rangeHigh = [%css {|
  @media (min-width: 768px) and (max-width: 1279px) { color: blue; }
|}];

/* Header_Css.ml (Header.re:86-90): a min+max range vs a plain max-width
   atom - different kind, so the max-width rule always wins. Interpolated
   (both declarations share one $(pad) path), so both rules are _in_
   bundles, not _a_ atoms. */
let header = (~pad) => [%css {|
  @media (min-width: 768px) and (max-width: 1279px) { padding-top: $(pad); padding-left: $(pad); }
|}];

let headerWithBanner = (~pad) => [%css {|
  @media (max-width: 1279px) { padding-top: $(pad); padding-left: $(pad); }
|}];

/* Discoverable_Css.ml (Discoverable.re:261): the SAME range-vs-max-width
   shape as header, plain _a_ atoms this time. */
let praiseViewport = [%css {|
  @media (min-width: 768px) and (max-width: 1279px) { max-height: 1200px; }
|}];

let praiseViewportExpanded = [%css {|
  @media (max-width: 1279px) { max-height: 10000px; }
|}];

let _ = (toggleButton, toggleButtonShowAtTablet, minSix, minNine, maxNineNineTwo, maxFourEighty, rangeLow, rangeHigh, header, headerWithBanner, praiseViewport, praiseViewportExpanded);
