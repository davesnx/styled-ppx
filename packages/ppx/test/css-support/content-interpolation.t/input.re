/* Test content-property interpolation support in cx2.
      Covers all the gaps:
      - Gap 1: Content.t array via `multi
      - Gap 2: Interpolation inside counter()/counters() arguments
      - Gap 3: counters() in content-list
      - Gap 4: counter() single-argument form
   */

/* === Whole-value interpolation (single Content.t token) === */
let singleCounter: CSS.Types.Content.t =
  `counterWithStyle(("list-item", `lowerAlpha));
let _ = [%css {|content: $(singleCounter)|}];

let singleCounterNoStyle: CSS.Types.Content.t = `counter("list-item");
let _ = [%css {|content: $(singleCounterNoStyle)|}];

let singleText: CSS.Types.Content.t = `text("hello");
let _ = [%css {|content: $(singleText)|}];

/* === Gap 1: multi-token content-list interpolation === */
let counterDot: CSS.Types.Content.t =
  `multi([|`counterWithStyle(("list-item", `lowerAlpha)), `text(".")|]);
let _ = [%css {|content: $(counterDot)|}];

let counterSpace: CSS.Types.Content.t =
  `multi([|`counter("list-item"), `text(" ")|]);
let _ = [%css {|content: $(counterSpace)|}];

let counterRoman: CSS.Types.Content.t =
  `multi([|`counterWithStyle(("list-item", `lowerRoman)), `text(".")|]);
let _ = [%css {|content: $(counterRoman)|}];

let bracketed: CSS.Types.Content.t =
  `multi([|
    `text("["),
    `counterWithStyle(("section", `upperRoman)),
    `text("]"),
  |]);
let _ = [%css {|content: $(bracketed)|}];

/* === User-facing reusable helper pattern === */
let getListItemDecorationContent = (content_value: CSS.Types.Content.t) => [%css
  {|content: $(content_value)|}
];

let _lowerAlpha =
  getListItemDecorationContent(
    `multi([|`counterWithStyle(("list-item", `lowerAlpha)), `text(".")|]),
  );
let _number =
  getListItemDecorationContent(
    `multi([|`counter("list-item"), `text(" ")|]),
  );
let _decimal =
  getListItemDecorationContent(
    `multi([|`counter("list-item"), `text(".")|]),
  );
let _romanDot =
  getListItemDecorationContent(
    `multi([|`counterWithStyle(("list-item", `lowerRoman)), `text(".")|]),
  );

/* === Gap 2: interpolation inside counter() / counters() arguments === */
let myCounterName = "chapter";
let myCounterStyle: CSS.Types.CounterStyle.t = `lowerAlpha;

let _ = [%css {|content: counter($(myCounterName), lower-alpha)|}];
let _ = [%css {|content: counter(chapter, $(myCounterStyle))|}];
let _ = [%css {|content: counter($(myCounterName), $(myCounterStyle))|}];
let _ = [%css {|content: counters($(myCounterName), '.', $(myCounterStyle))|}];

/* === Gap 4: single-arg counter() === */
let _ = [%css {|content: counter(ol)|}];
let _ = [%css {|content: counter(chapter)|}];

/* === Gap 3: counters() === */
let _ = [%css {|content: counters(section, '.')|}];
let _ = [%css {|content: counters(section, '.', decimal-leading-zero)|}];

/* === Counters with no style via runtime constructor === */
let countersNoStyle: CSS.Types.Content.t = `counters(("list-item", "."));
let _ = [%css {|content: $(countersNoStyle)|}];

let countersStyled: CSS.Types.Content.t =
  `countersWithStyle(("list-item", ".", `decimalLeadingZero));
let _ = [%css {|content: $(countersStyled)|}];
