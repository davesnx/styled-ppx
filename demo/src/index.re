module App = [%styled {|

|}];

module Component = [%styled.a {|
  align-content: normal;
  align-items: center;
  align-self: auto;
  /* alignment-baseline: auto; */ /* bs-motion doesn't support it */
  animation-delay: 0s;
  animation-direction: normal;
  animation-duration: 0s;
  animation-fill-mode: none;
  /* animation-iteration-count: 1; */
  /* animation-name: none; */
  /* animation-play-state: running; */
  animation-timing-function: ease;
  /* backdrop-filter: none; */ /* bs-motion doesn't support it */
  /* backface-visibility: visible; */
  /* background-attachment: scroll; */
  background-blend-mode: normal;
  /* background-clip: border-box; */
  background-color: rgb(68, 68, 68);
  background-image: none;
  /* background-origin: padding-box; */
  /* background-position-x: 0%; */
  /* background-position-y: 0%; */
  background-size: auto;
  /* baseline-shift: 0px; */ /* bs-motion doesn't support it */
  /* block-size: 200px; */ /* bs-motion doesn't support it */
  /* border-block-end-color: rgb(255, 255, 255); */ /* bs-motion doesn't support it */
  /* border-block-end-style: none; */ /* bs-motion doesn't support it */
  /* border-block-end-width: 0px; */ /* bs-motion doesn't support it */
  /* border-block-start-color: rgb(255, 255, 255); */ /* bs-motion doesn't support it */
  /* border-block-start-style: none; */ /* bs-motion doesn't support it */
  /* border-block-start-width: 0px; */ /* bs-motion doesn't support it */
  border-bottom-color: rgb(255, 255, 255);
  border-bottom-left-radius: 2%;
  /* border-bottom-left-radius: 5px 2px; */
  border-bottom-right-radius: 2%;
  border-bottom-style: none;
  border-bottom-width: 0px;
  /* border-collapse: separate; */
  /* border-image-outset: 0px; */ /* bs-motion doesn't support it */
  /* border-image-repeat: stretch; */ /* bs-motion doesn't support it */
  /* border-image-slice: 100%; */ /* bs-motion doesn't support it */
  /* border-image-source: none; */ /* bs-motion doesn't support it */
  /* border-image-width: 1; */ /* bs-motion doesn't support it */
  /* border-inline-end-color: rgb(255, 255, 255); */ /* bs-motion doesn't support it */
  /* border-inline-end-style: none; */ /* bs-motion doesn't support it */
  /* border-inline-end-width: 0px; */ /* bs-motion doesn't support it */
  /* border-inline-start-color: rgb(255, 255, 255); */ /* bs-motion doesn't support it */
  /* border-inline-start-style: none; */ /* bs-motion doesn't support it */
  /* border-inline-start-width: 0px; */ /* bs-motion doesn't support it */
  border-left-color: rgb(255, 255, 255);
  border-left-style: none;
  border-left-width: 0px;
  border-right-color: rgb(255, 255, 255);
  border-right-style: none;
  border-right-width: 0px;
  border-top-color: rgb(255, 255, 255);
  border-top-left-radius: 2%;
  border-top-right-radius: 2%;
  border-top-style: none;
  border-top-width: 0px;
  bottom: auto;
  bottom: 20px;
  /* box-shadow: none; */
  /* box-sizing: content-box; */
  /* break-after: auto; */ /* bs-motion doesn't support it */
  /* break-before: auto; */ /* bs-motion doesn't support it */
  /* break-inside: auto; */ /* bs-motion doesn't support it */
  /* buffered-rendering: auto; */ /* bs-motion doesn't support it */
  /* caption-side: top; */ /* bs-motion doesn't support it */
  /* caret-color: rgb(255, 255, 255); */ /* bs-motion doesn't support it */
  /* clear: none; */
  /* clip: auto; */ /* bs-motion doesn't support it */
  clip-path: none;
  /* clip-rule: nonzero; */ /* bs-motion doesn't support it */
  /* color: white */
  color: rgb(255, 255, 255);
  /* color-interpolation: srgb; */ /* bs-motion doesn't support it */
  /* color-interpolation-filters: linearrgb; */ /* bs-motion doesn't support it */
  /* color-rendering: auto; */ /* bs-motion doesn't support it */
  /* column-count: auto; */ /* bs-motion doesn't support it */
  /* column-fill: balance; */ /* bs-motion doesn't support it */
  /* column-gap: normal; */ /* bs-motion doesn't support it */
  /* column-rule-color: rgb(255, 255, 255); */ /* bs-motion doesn't support it */
  /* column-rule-style: none; */ /* bs-motion doesn't support it */
  /* column-rule-width: 0px; */ /* bs-motion doesn't support it */
  /* column-span: none; */ /* bs-motion doesn't support it */
  /* column-width: auto; */ /* bs-motion doesn't support it */
  /* contain: none; */ /* bs-motion doesn't support it */
  /* content: normal; */
  /* counter-increment: none; */ /* bs-motion doesn't support it */
  /* counter-reset: none; */ /* bs-motion doesn't support it */
  cursor: auto;
  /* cx: 0px; */ /* bs-motion doesn't support it */
  /* cy: 0px; */ /* bs-motion doesn't support it */
  /* d: none; */ /* bs-motion doesn't support it */
  /* direction: ltr; */
  display: flex;
  /* dominant-baseline: auto; */ /* bs-motion doesn't support it */
  /* empty-cells: show; */ /* bs-motion doesn't support it */
  fill: rgb(0, 0, 0);
  fill-opacity: 1;
  /* fill-rule: nonzero; */ /* bs-motion doesn't support it */
  /* flex: 1; */
  /* flex: 1 1; */
  flex: 1 1 100px;
  filter: none;
  flex-basis: auto;
  flex-direction: column;
  flex-grow: 0;
  flex-shrink: 1;
  flex-wrap: nowrap;
  float: none;
  /* flood-color: rgb(0, 0, 0); */ /* bs-motion doesn't support it */
  flood-opacity: 1;
  /* font-family: Times; */
  /* font-feature-settings: normal; */ /* bs-motion doesn't support it */
  font-kerning: auto;
  /* font-optical-sizing: auto; */ /* bs-motion doesn't support it */
  font-size: 24px;
  /* font-stretch: 100%; */
  font-style: normal;
  /* font-variant-caps: normal; */ /* bs-motion doesn't support it */
  /* font-variant-east-asian: normal; */ /* bs-motion doesn't support it */
  /* font-variant-ligatures: normal; */ /* bs-motion doesn't support it */
  /* font-variant-numeric: normal; */ /* bs-motion doesn't support it */
  /* font-variation-settings: normal; */ /* bs-motion doesn't support it */
  font-weight: 400;
  /* font-weight: bold; */
  grid-auto-columns: auto;
  grid-auto-flow: row;
  grid-auto-rows: auto;
  grid-column-end: auto;
  grid-column-start: auto;
  grid-row-end: auto;
  grid-row-start: auto;
  grid-template-areas: none;
  grid-template-columns: none;
  grid-template-rows: none;
  height: auto;
  height: 500px;
  /* hyphens: manual; */
  /* image-rendering: auto; */ /* bs-motion doesn't support it */
  /* inline-size: 200px; */ /* bs-motion doesn't support it */
  /* isolation: auto; */ /* bs-motion doesn't support it */
  justify-content: center;
  justify-items: normal;
  justify-self: auto;
  left: auto;
  letter-spacing: normal;
  /* lighting-color: rgb(255, 255, 255); */ /* bs-motion doesn't support it */
  /* line-break: auto; */ /* bs-motion doesn't support it */
  line-height: normal;
  list-style-image: none;
  /* list-style-position: outside; */
  list-style-type: disc;
  /* margin-block-end: 5px; */ /* bs-motion doesn't support it */
  /* margin-block-start: 5px; */ /* bs-motion doesn't support it */
  margin-bottom: 5px;
  /* margin-inline-end: 5px; */ /* bs-motion doesn't support it */
  /* margin-inline-start: 5px; */ /* bs-motion doesn't support it */
  margin-left: 5px;
  margin-right: 5px;
  margin-top: 5px;
  margin-bottom: 5px;
  margin: 10px 5px;
  margin: 10px 5px 10px;
  margin: 5px;
  /* marker-end: none; */ /* bs-motion doesn't support it */
  /* marker-mid: none; */ /* bs-motion doesn't support it */
  /* marker-start: none; */ /* bs-motion doesn't support it */
  /* mask: none; */ /* bs-motion doesn't support it */
  /* mask-type: luminance; */ /* bs-motion doesn't support it */
  /* max-block-size: none; */ /* bs-motion doesn't support it */
  max-height: none;
  /* max-inline-size: none; */ /* bs-motion doesn't support it */
  max-width: none;
  /* min-block-size: 0px; */ /* bs-motion doesn't support it */
  min-height: 0px;
  /* min-inline-size: 0px; */ /* bs-motion doesn't support it */
  min-width: 0px;
  /* mix-blend-mode: normal; */ /* bs-motion doesn't support it */
  /* object-fit: fill; */ /* bs-motion doesn't support it */
  /* object-position: 50% 50%; */ /* bs-motion doesn't support it */
  /* offset-distance: 0px; */ /* bs-motion doesn't support it */
  /* offset-path: none; */ /* bs-motion doesn't support it */
  /* offset-rotate: auto 0deg; */ /* bs-motion doesn't support it */
  opacity: 1;
  /* order: 0; */
  /* orphans: 2; */ /* bs-motion doesn't support it */
  outline-color: rgb(255, 255, 255);
  outline-offset: 0px;
  outline-style: none;
  outline-width: 0px;
  /* overflow-anchor: auto; */ /* bs-motion doesn't support it */
  overflow-wrap: normal;
  /* overflow-x: visible; */
  /* overflow-y: visible; */
  /* overscroll-behavior-block: auto; */ /* bs-motion doesn't support it */
  /* overscroll-behavior-inline: auto; */ /* bs-motion doesn't support it */
  /* overscroll-behavior-x: auto; */ /* bs-motion doesn't support it */
  /* overscroll-behavior-y: auto; */ /* bs-motion doesn't support it */
  /* padding-block-end: 2px; */ /* bs-motion doesn't support it */
  /* padding-block-start: 2px; */ /* bs-motion doesn't support it */
  /* padding-inline-end: 5px; */ /* bs-motion doesn't support it */
  /* padding-inline-start: 5px; */ /* bs-motion doesn't support it */
  padding-left: 5px;
  padding-right: 5px;
  padding-top: 2px;
  padding-bottom: 2px;
  padding: 5px 10px;
  padding: 5px 10px 5px;
  padding: 5px 10px 5px 3px;
  padding: 5px;
  /* paint-order: normal; */ /* bs-motion doesn't support it */
  perspective: none;
  perspective-origin: 105px 102px;
  pointer-events: auto;
  position: static;
  /* r: 0px; */ /* bs-motion doesn't support it */
  /* resize: none; */ /* bs-motion doesn't support it */
  right: auto;
  /* row-gap: normal; */ /* bs-motion doesn't support it */
  /* rx: auto; */ /* bs-motion doesn't support it */
  /* ry: auto; */ /* bs-motion doesn't support it */
  /* scroll-behavior: auto; */ /* bs-motion doesn't support it */
  /* scroll-margin-block-end: 0px; */ /* bs-motion doesn't support it */
  /* scroll-margin-block-start: 0px; */ /* bs-motion doesn't support it */
  /* scroll-margin-bottom: 0px; */ /* bs-motion doesn't support it */
  /* scroll-margin-inline-end: 0px; */ /* bs-motion doesn't support it */
  /* scroll-margin-inline-start: 0px; */ /* bs-motion doesn't support it */
  /* scroll-margin-left: 0px; */ /* bs-motion doesn't support it */
  /* scroll-margin-right: 0px; */ /* bs-motion doesn't support it */
  /* scroll-margin-top: 0px; */ /* bs-motion doesn't support it */
  /* scroll-padding-block-end: auto; */ /* bs-motion doesn't support it */
  /* scroll-padding-block-start: auto; */ /* bs-motion doesn't support it */
  /* scroll-padding-bottom: auto; */ /* bs-motion doesn't support it */
  /* scroll-padding-inline-end: auto; */ /* bs-motion doesn't support it */
  /* scroll-padding-inline-start: auto; */ /* bs-motion doesn't support it */
  /* scroll-padding-left: auto; */ /* bs-motion doesn't support it */
  /* scroll-padding-right: auto; */ /* bs-motion doesn't support it */
  /* scroll-padding-top: auto; */ /* bs-motion doesn't support it */
  /* scroll-snap-align: none; */ /* bs-motion doesn't support it */
  /* scroll-snap-stop: normal; */ /* bs-motion doesn't support it */
  /* scroll-snap-type: none; */ /* bs-motion doesn't support it */
  /* shape-image-threshold: 0; */ /* bs-motion doesn't support it */
  /* shape-margin: 0px; */ /* bs-motion doesn't support it */
  /* shape-outside: none; */ /* bs-motion doesn't support it */
  /* shape-rendering: auto; */ /* bs-motion doesn't support it */
  /* speak: normal; */ /* bs-motion doesn't support it */
  stop-color: rgb(0, 0, 0);
  stop-opacity: 1;
  /* stroke: none; */
  /* stroke-dasharray: none; */ /* bs-motion doesn't support it */
  /* stroke-dashoffset: 0px; */ /* bs-motion doesn't support it */
  /* stroke-linecap: butt; */
  /* stroke-linejoin: miter; */ /* bs-motion doesn't support it */
  /* stroke-miterlimit: 4; */
  stroke-opacity: 1;
  stroke-width: 1px;
  /* tab-size: 8; */ /* bs-motion doesn't support it */
  table-layout: auto;
  /* text-align: start; */
  /* text-align-last: auto; */ /* bs-motion doesn't support it */
  /* text-anchor: start; */ /* bs-motion doesn't support it */
  /* text-combine-upright: none; */ /* bs-motion doesn't support it */
  text-decoration-color: rgb(255, 255, 255);
  /* text-decoration-line: none; */ /* bs-motion doesn't support it */
  /* text-decoration-skip-ink: auto; */ /* bs-motion doesn't support it */
  text-decoration-style: solid;
  text-indent: 0px;
  /* text-orientation: mixed; */ /* bs-motion doesn't support it */
  /* text-overflow: clip; */
  /* text-rendering: auto; */ /* bs-motion doesn't support it */
  /* text-shadow: none; */ /* bs-motion doesn't support it */
  /* text-size-adjust: auto; */ /* bs-motion doesn't support it */
  text-transform: none;
  /* text-underline-position: auto; */ /* bs-motion doesn't support it */
  top: auto;
  /* touch-action: auto; */ /* bs-motion doesn't support it */
  transform: none;
  /* transform-box: view-box; */ /* bs-motion doesn't support it */
  transform-origin: 105px 102px;
  /* transform-origin: left top; */
  transform-style: flat;
  transition-delay: 0s;
  transition-duration: 0s;
  /* transition-property: all; */
  transition-timing-function: ease-in-out;
  /* unicode-bidi: normal; */ /* bs-motion doesn't support it */
  user-select: auto;
  /* vector-effect: none; */ /* bs-motion doesn't support it */
  vertical-align: baseline;
  /* visibility: visible; */
  white-space: normal;
  /* widows: 2; */ /* bs-motion doesn't support it */
  width: 500px;
  /* will-change: auto; */ /* bs-motion doesn't support it */
  word-break: normal;
  word-spacing: 0px;
  /* writing-mode: horizontal-tb; */ /* bs-motion doesn't support it */
  /* x: 0px; */ /* bs-motion doesn't support it */
  /* y: 0px; */ /* bs-motion doesn't support it */
  /* z-index: auto; */ /* bs-motion doesn't support it */
  z-index: 100;
  /* zoom: 1; */ /* bs-motion doesn't support it */

  /* -webkit-app-region: none; */
  /* -webkit-appearance: none; */
  /* -webkit-border-horizontal-spacing: 0px; */
  /* -webkit-border-vertical-spacing: 0px; */
  /* -webkit-box-align: center; */
  /* -webkit-box-decoration-break: slice; */
  /* -webkit-box-direction: normal; */
  /* -webkit-box-flex: 0; */
  /* -webkit-box-ordinal-group: 1; */
  /* -webkit-box-orient: horizontal; */
  /* -webkit-box-pack: center; */
  /* -webkit-box-reflect: none; */
  /* -webkit-font-smoothing: auto; */
  /* -webkit-highlight: none; */
  /* -webkit-hyphenate-character: auto; */
  /* -webkit-line-clamp: none; */
  /* -webkit-locale: auto; */
  /* -webkit-margin-after-collapse: collapse; */
  /* -webkit-margin-before-collapse: collapse; */
  /* -webkit-margin-bottom-collapse: collapse; */
  /* -webkit-margin-top-collapse: collapse; */
  /* -webkit-mask-box-image-outset: 0px; */
  /* -webkit-mask-box-image-repeat: stretch; */
  /* -webkit-mask-box-image-slice: 0 fill; */
  /* -webkit-mask-box-image-source: none; */
  /* -webkit-mask-box-image-width: auto; */
  /* -webkit-mask-clip: border-box; */
  /* -webkit-mask-composite: source-over; */
  /* -webkit-mask-image: none; */
  /* -webkit-mask-origin: border-box; */
  /* -webkit-mask-position-x: 0%; */
  /* -webkit-mask-position-y: 0%; */
  /* -webkit-mask-size: auto; */
  /* -webkit-print-color-adjust: economy; */
  /* -webkit-rtl-ordering: logical; */
  /* -webkit-ruby-position: before; */
  /* -webkit-tap-highlight-color: rgba(0, 0, 0, 0.4); */
  /* -webkit-text-combine: none; */
  /* -webkit-text-decorations-in-effect: none; */
  /* -webkit-text-emphasis-color: rgb(255, 255, 255); */
  /* -webkit-text-emphasis-position: over right; */
  /* -webkit-text-emphasis-style: none; */
  /* -webkit-text-fill-color: rgb(255, 255, 255); */
  /* -webkit-text-security: none; */
  /* -webkit-text-stroke-color: rgb(255, 255, 255); */
  /* -webkit-text-stroke-width: 0px; */
  /* -webkit-user-drag: auto; */
  /* -webkit-user-modify: read-only; */
  /* -webkit-border-image: none; */
  /* -webkit-text-orientation: vertical-right; */

  /* &:hover {
    color: #000000;
  } */
|}];

ReactDOMRe.renderToElementWithId(
  <App>
    <Component href="https://sancho.dev">
      {React.string("- styled-ppx -")}
    </Component>
  </App>,
  "app"
);
